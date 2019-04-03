Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1810C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C25206BA
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDCQ1j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDCQ1j (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 12:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D36C3084024;
        Wed,  3 Apr 2019 16:27:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA52608A5;
        Wed,  3 Apr 2019 16:27:31 +0000 (UTC)
Date:   Thu, 4 Apr 2019 00:27:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 1/6] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190403162726.GB22741@ming.t460p>
References: <20190403102609.18707-1-ming.lei@redhat.com>
 <20190403102609.18707-2-ming.lei@redhat.com>
 <1554304871.118779.185.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554304871.118779.185.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 03 Apr 2019 16:27:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 08:21:11AM -0700, Bart Van Assche wrote:
> On Wed, 2019-04-03 at 18:26 +0800, Ming Lei wrote:
> > However, if request is staggered into plug list, and finally queued
> > from plug code path, the refcount in submission side is actually missed.
> > And we may start to run queue after queue is removed, then kernel oops
> > is triggered.
> 
> I don't think that this patch is necessary. blk_mq_get_request() increases
> q_usage_counter. In other words, as long as at least one request has been
> allocated that has not finished it is guaranteed that q_usage_counter > 0.
> So there is no need for additional protection in blk_mq_flush_plug_list().

blk_mq_flush_plug_list():
	blk_mq_sched_insert_requests()
		insert requests to sw queue or scheduler queue 
		blk_mq_run_hw_queue

Because of concurrent run queue, all requests inserted above may be completed
before calling the above blk_mq_run_hw_queue. Then queue can be freed
during the above blk_mq_run_hw_queue().

Thanks,
Ming
