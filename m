Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D88FC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157062086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 14:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157062086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeKQAOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:14:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeKQAOe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 19:14:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66B633082E50;
        Fri, 16 Nov 2018 14:02:02 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 617555D75F;
        Fri, 16 Nov 2018 14:01:54 +0000 (UTC)
Date:   Fri, 16 Nov 2018 09:01:53 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, axboe@kernel.dk,
        Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, chengjike.cheng@huawei.com,
        shenhong09@huawei.com, dm-devel@redhat.com,
        wangzhoumengjian@huawei.com, christophe.varoqui@opensvc.com,
        bmarzins@redhat.com, sschremm@netapp.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: nvme: allow ANA support to be independent of native multipathing
Message-ID: <20181116140153.GB28870@redhat.com>
References: <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com>
 <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com>
 <f7fe5b65-d030-bc5d-233f-e5bc2f995efc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fe5b65-d030-bc5d-233f-e5bc2f995efc@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Nov 2018 14:02:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16 2018 at  2:25am -0500,
Hannes Reinecke <hare@suse.de> wrote:

> On 11/15/18 6:46 PM, Mike Snitzer wrote:
> >Whether or not ANA is present is a choice of the target implementation;
> >the host (and whether it supports multipathing) has _zero_ influence on
> >this.  If the target declares a path as 'inaccessible' the path _is_
> >inaccessible to the host.  As such, ANA support should be functional
> >even if native multipathing is not.
> >
> >Introduce ability to always re-read ANA log page as required due to ANA
> >error and make current ANA state available via sysfs -- even if native
> >multipathing is disabled on the host (e.g. nvme_core.multipath=N).
> >
> >This affords userspace access to the current ANA state independent of
> >which layer might be doing multipathing.  It also allows multipath-tools
> >to rely on the NVMe driver for ANA support while dm-multipath takes care
> >of multipathing.
> >
> >While implementing these changes care was taken to preserve the exact
> >ANA functionality and code sequence native multipathing has provided.
> >This manifests as native multipathing's nvme_failover_req() being
> >tweaked to call __nvme_update_ana() which was factored out to allow
> >nvme_update_ana() to be called independent of nvme_failover_req().
> >
> >And as always, if embedded NVMe users do not want any performance
> >overhead associated with ANA or native NVMe multipathing they can
> >disable CONFIG_NVME_MULTIPATH.
> >
> >Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >---
> >  drivers/nvme/host/core.c      | 10 +++++----
> >  drivers/nvme/host/multipath.c | 49 +++++++++++++++++++++++++++++++++----------
> >  drivers/nvme/host/nvme.h      |  4 ++++
> >  3 files changed, 48 insertions(+), 15 deletions(-)
> >
> >diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >index fe957166c4a9..3df607905628 100644
> >--- a/drivers/nvme/host/core.c
> >+++ b/drivers/nvme/host/core.c
> >@@ -255,10 +255,12 @@ void nvme_complete_rq(struct request *req)
> >  		nvme_req(req)->ctrl->comp_seen = true;
> >  	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> >-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
> >-		    blk_path_error(status)) {
> >-			nvme_failover_req(req);
> >-			return;
> >+		if (blk_path_error(status)) {
> >+			if (req->cmd_flags & REQ_NVME_MPATH) {
> >+				nvme_failover_req(req);
> >+				return;
> >+			}
> >+			nvme_update_ana(req);
> >  		}
> >  		if (!blk_queue_dying(req->q)) {

...

> >diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> >index 8e03cda770c5..0adbcff5fba2 100644
> >--- a/drivers/nvme/host/multipath.c
> >+++ b/drivers/nvme/host/multipath.c
> >@@ -58,25 +87,22 @@ void nvme_failover_req(struct request *req)
> >  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> >  	blk_mq_end_request(req, 0);
> >-	switch (status & 0x7ff) {
> >-	case NVME_SC_ANA_TRANSITION:
> >-	case NVME_SC_ANA_INACCESSIBLE:
> >-	case NVME_SC_ANA_PERSISTENT_LOSS:
> >+	if (nvme_ana_error(status)) {
> >  		/*
> >  		 * If we got back an ANA error we know the controller is alive,
> >  		 * but not ready to serve this namespaces.  The spec suggests
> >  		 * we should update our general state here, but due to the fact
> >  		 * that the admin and I/O queues are not serialized that is
> >  		 * fundamentally racy.  So instead just clear the current path,
> >-		 * mark the the path as pending and kick of a re-read of the ANA
> >+		 * mark the path as pending and kick off a re-read of the ANA
> >  		 * log page ASAP.
> >  		 */
> >  		nvme_mpath_clear_current_path(ns);
> >-		if (ns->ctrl->ana_log_buf) {
> >-			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> >-			queue_work(nvme_wq, &ns->ctrl->ana_work);
> >-		}
> >-		break;
> >+		__nvme_update_ana(ns);
> >+		goto kick_requeue;
> >+	}
> >+
> >+	switch (status & 0x7ff) {
> >  	case NVME_SC_HOST_PATH_ERROR:
> >  		/*
> >  		 * Temporary transport disruption in talking to the controller.
> >@@ -93,6 +119,7 @@ void nvme_failover_req(struct request *req)
> >  		break;
> >  	}
> >+kick_requeue:
> >  	kblockd_schedule_work(&ns->head->requeue_work);
> >  }
> Doesn't the need to be protected by 'if (ns->head->disk)' or somesuch?

No.  nvme_failover_req() is only ever called by native multipathing; see
nvme_complete_rq()'s check for req->cmd_flags & REQ_NVME_MPATH as the
condition for calling nvme_complete_rq().

The previos RFC-style patch I posted muddled ANA and multipathing in
nvme_update_ana() but this final patch submission was fixed because I
saw a cleaner way forward by having nvme_failover_req() also do ANA work
just like it always has -- albeit with new helpers that
nvme_update_ana() also calls.

Mike
