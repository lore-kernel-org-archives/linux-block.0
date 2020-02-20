Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42688C11D0C
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156AF20801
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6FB721H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBTUrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:47:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728618AbgBTUrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 15:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582231652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aK0yEI9Rar14XcDftw8pchmWTs8uUSdp4e+KIXjLxZc=;
        b=h6FB721HsRMMke6AXPE9+mLtzA42cY8SRHQ2pWjCnO35TgRJUHq+95Hnzn+gYGImPX5qEp
        ps6PguKT9bCWGK7E6KqVx6ezNBZyTvUFl6WQuPUJe8wIOPFsgrPkIxfulk5HVnrJOf3kAc
        w7NxqnL3FYhNrs9Gdlgt5dxUKfj72XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-hd5FeaT1O3WS2VPoQovfcA-1; Thu, 20 Feb 2020 15:47:27 -0500
X-MC-Unique: hd5FeaT1O3WS2VPoQovfcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8230801E74;
        Thu, 20 Feb 2020 20:47:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B96A487B34;
        Thu, 20 Feb 2020 20:47:18 +0000 (UTC)
Date:   Fri, 21 Feb 2020 04:47:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Message-ID: <20200220204713.GB28199@ming.t460p>
References: <20200220024441.11558-1-bvanassche@acm.org>
 <20200220024441.11558-3-bvanassche@acm.org>
 <20200220100524.GA31206@ming.t460p>
 <37505ee7-fba6-1b25-64c4-f632280e8b70@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37505ee7-fba6-1b25-64c4-f632280e8b70@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 20, 2020 at 08:14:11AM -0800, Bart Van Assche wrote:
> On 2/20/20 2:05 AM, Ming Lei wrote:
> > On Wed, Feb 19, 2020 at 06:44:35PM -0800, Bart Van Assche wrote:
> > > blk_mq_map_queues() and multiple .map_queues() implementations expect that
> > > set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
> > 
> > Only single queue mapping expects set->map[HCTX_TYPE_DEFAULT].nr_queues
> > to be set->nr_hw_queues. For multiple mapping, set->nr_hw_queues should
> > be sum of each mapping's nr_queue.
> 
> That's how it should work but that doesn't match what I found in the kernel
> tree. Here is an example of a .map_queues() implementation that depends on
> .nr_queues being set before it is called:
> 
> static int scsi_map_queues(struct blk_mq_tag_set *set)
> {
> 	struct Scsi_Host *shost = container_of(set, struct Scsi_Host,
> 					       tag_set);
> 
> 	if (shost->hostt->map_queues)
> 		return shost->hostt->map_queues(shost);
> 	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> }
> 
> If shost->hostt->map_queues == NULL, the above function only works correctly
> if .nr_queues is set before this function is called. Additionally,
> scsi_map_queues() may call e.g. the following function:
> 
> static int qla2xxx_map_queues(struct Scsi_Host *shost)
> {
> 	int rc;
> 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
> 	struct blk_mq_queue_map *qmap =
> 		&shost->tag_set.map[HCTX_TYPE_DEFAULT];
> 
> 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
> 		rc = blk_mq_map_queues(qmap);
> 	else
> 		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev,
> 			vha->irq_offset);
> 	return rc;
> }
> 
> Both blk_mq_map_queues() and blk_mq_pci_map_queues() assume that
> blk_mq_queue_map.nr_queues is set before these functions are called.

Actually, I suggested to do the following way:

if (set->nr_maps == 1)
	set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;

then people won't be confused wrt. relation between set->nr_hw_queues
and .nr_queues of each mapping.

Thanks, 
Ming

