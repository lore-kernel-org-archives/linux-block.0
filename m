Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ABC64EC4
	for <linux-block@archiver.kernel.org>; Sat,  4 Mar 2023 12:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCDMDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Mar 2023 07:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDMDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Mar 2023 07:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96656199B
        for <linux-block@vger.kernel.org>; Sat,  4 Mar 2023 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677931371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TuHjYmFdVDsbhtJNcUwKA9wF/BKPJriXVa+cGWWXDSo=;
        b=XHhYifNUXUUZ1Ixi87kcApA+LPqMq9N3N+Uhh/K6KVilFHEhjVtzKDqDf2Z1Rw4n/xHHt2
        X+WoBYvy8Udi9wMfSWKozW7QDcHI3qthMrFS004+ATGIdlTHbPrDYju14RtpDdghBWmsvW
        bTBhixF8o1JyzBDCqLTzezHE67ooweg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-ncVSSfIVPw2mve83XRFw0A-1; Sat, 04 Mar 2023 07:02:47 -0500
X-MC-Unique: ncVSSfIVPw2mve83XRFw0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5066299E753;
        Sat,  4 Mar 2023 12:02:46 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AE7240C6EC4;
        Sat,  4 Mar 2023 12:02:42 +0000 (UTC)
Date:   Sat, 4 Mar 2023 20:02:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <ZAMzXjfzEKWeBPUR@ovpn-8-18.pek2.redhat.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
 <ZAMb+x/hKPjoFHS5@ovpn-8-18.pek2.redhat.com>
 <238bd934-1355-8eb8-c897-2f79f9f54c21@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238bd934-1355-8eb8-c897-2f79f9f54c21@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 04, 2023 at 12:14:30PM +0100, Hannes Reinecke wrote:
> On 3/4/23 11:22, Ming Lei wrote:
> > On Sat, Mar 04, 2023 at 09:00:28AM +0100, Hannes Reinecke wrote:
> > > On 3/4/23 00:13, Ming Lei wrote:
> > > > When investigating one customer report on warning in nvme_setup_discard,
> > > > we observed the controller(nvme/tcp) actually exposes
> > > > queue_max_discard_segments(req->q) == 1.
> > > > 
> > > > Obviously the current code can't handle this situation, since contiguity
> > > > merge like normal RW request is taken.
> > > > 
> > > > Fix the issue by building range from request sector/nr_sectors directly.
> > > > 
> > > > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
> > > >    1 file changed, 19 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index c2730b116dc6..d4be525f8100 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> > > >    		range = page_address(ns->ctrl->discard_page);
> > > >    	}
> > > > -	__rq_for_each_bio(bio, req) {
> > > > -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > -
> > > > -		if (n < segments) {
> > > > -			range[n].cattr = cpu_to_le32(0);
> > > > -			range[n].nlb = cpu_to_le32(nlb);
> > > > -			range[n].slba = cpu_to_le64(slba);
> > > > +	if (queue_max_discard_segments(req->q) == 1) {
> > > > +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> > > > +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> > > > +
> > > > +		range[0].cattr = cpu_to_le32(0);
> > > > +		range[0].nlb = cpu_to_le32(nlb);
> > > > +		range[0].slba = cpu_to_le64(slba);
> > > > +		n = 1;
> > > > +	} else { > +		__rq_for_each_bio(bio, req) {
> > > > +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > +
> > > > +			if (n < segments) {
> > > > +				range[n].cattr = cpu_to_le32(0);
> > > > +				range[n].nlb = cpu_to_le32(nlb);
> > > > +				range[n].slba = cpu_to_le64(slba);
> > > > +			}
> > > > +			n++;
> > > >    		}
> > > > -		n++;
> > > >    	}
> > > >    	if (WARN_ON_ONCE(n != segments)) {
> > > Now _that_ is odd.
> > > Looks like 'req' is not formatted according to the 'max_discard_sectors'
> > > setting.
> > > But if that's the case, then this 'fix' would fail whenever
> > > 'max_discard_sectors' < 'max_hw_sectors', right?
> > 
> > No, it isn't the case.
> > 
> > > Shouldn't we rather modify the merge algorithm to check for
> > > max_discard_sectors for DISCARD requests, such that we never _have_
> > > mis-matched requests and this patch would be pointless?
> > 
> > But it is related with discard merge.
> > 
> > If queue_max_discard_segments() is 1, block layer merges discard
> > request/bios just like normal RW IO.
> > 
> > However, if queue_max_discard_segments() is > 1, block layer simply
> > 'merges' all bios into one request, no matter if the LBA is adjacent
> > or not, and treat each bio as one discard segment, that is called
> > multi range discard too.
> > 
> But wouldn't the number of bios be subject to 'queue_max_discard_segment',
> too?
> What guarantees we're not overflowing that for multi-segment discard merge?

block layer merge code makes sure that the max discard segment limit
is respected, please see:

	req_attempt_discard_merge()
	bio_attempt_discard_merge()
	blk_recalc_rq_segments()

Thanks,
Ming

