Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0BC64EC4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCFVt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFVt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 16:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705FE521C0
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678139354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KaYxCqFqTvU0Kk9LsLVgeP5Z4ZTK2X2NkTc3eghdxIU=;
        b=AfGOUEnXOk7Ug9BxMZyV7DTdqRJ38K9fJLGcCkfvAbJ14vEdn8DlhkE0SH/M03aeou4eot
        Z+zd2urP+9s/tmMgE2B5MQy6/YuvTClcM274jKGTvRhpS5qNauwY3ICqfK7P5NZKjOF/h2
        do2tNl4qVJh/JaVZ7kZnYAtMDARTJfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-nG2M55F1M9WyW0AfQR08Vw-1; Mon, 06 Mar 2023 16:49:11 -0500
X-MC-Unique: nG2M55F1M9WyW0AfQR08Vw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A05B8101A5BA;
        Mon,  6 Mar 2023 21:49:10 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F4B492B00;
        Mon,  6 Mar 2023 21:49:06 +0000 (UTC)
Date:   Tue, 7 Mar 2023 05:49:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
> 
> 
> On 3/4/23 01:13, Ming Lei wrote:
> > When investigating one customer report on warning in nvme_setup_discard,
> > we observed the controller(nvme/tcp) actually exposes
> > queue_max_discard_segments(req->q) == 1.
> > 
> > Obviously the current code can't handle this situation, since contiguity
> > merge like normal RW request is taken.
> > 
> > Fix the issue by building range from request sector/nr_sectors directly.
> > 
> > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
> >   1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c2730b116dc6..d4be525f8100 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> >   		range = page_address(ns->ctrl->discard_page);
> >   	}
> > -	__rq_for_each_bio(bio, req) {
> > -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > -
> > -		if (n < segments) {
> > -			range[n].cattr = cpu_to_le32(0);
> > -			range[n].nlb = cpu_to_le32(nlb);
> > -			range[n].slba = cpu_to_le64(slba);
> > +	if (queue_max_discard_segments(req->q) == 1) {
> > +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> > +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> > +
> > +		range[0].cattr = cpu_to_le32(0);
> > +		range[0].nlb = cpu_to_le32(nlb);
> > +		range[0].slba = cpu_to_le64(slba);
> > +		n = 1;
> > +	} else {
> > +		__rq_for_each_bio(bio, req) {
> > +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > +
> > +			if (n < segments) {
> > +				range[n].cattr = cpu_to_le32(0);
> > +				range[n].nlb = cpu_to_le32(nlb);
> > +				range[n].slba = cpu_to_le64(slba);
> > +			}
> > +			n++;
> >   		}
> > -		n++;
> >   	}
> >   	if (WARN_ON_ONCE(n != segments)) {
> 
> 
> Maybe just set segments to min(blk_rq_nr_discard_segments(req),
> queue_max_discard_segments(req->q)) and let the existing code do
> its thing?

What is the existing code for applying min()?

For block layer merge code, it has to cover two kinds of discard merge:

- the traditional single range discard for most of devices
- multi range discard merge for nvme and virtio-blk which takes same
fix

For driver side, it has to do similar handling if both single-range and
multi-range discard are supported:

- each bio is one discard range for multi-range discard
- the whole request(may include more than 1 bios) is the single discard
range for single-range discard


Thanks, 
Ming

