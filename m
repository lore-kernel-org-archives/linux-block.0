Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235AAC678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCGOak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjCGOaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 09:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F18898F9
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678199085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llKKNKuvfK/m+pa2EAZRL9gIyPFDk2zTTzAuWEJgf/M=;
        b=esVT4tOKK3JyCVNf9nizKnqvanwwOC2IefjjDjUzitWDKlY187OqegL0ZVZpROmQX/wGX8
        SvPY74/g9i+t96qT8t6LCmyHQkJsHeYrKuqT2IoRf1z/qUaHbAxXynUnbNW4nEtnr4PKRI
        TwCzWmp9be6KzZSePlp+Nd6hbAMyu/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-GOXamBoqNaWafLYTKsVFeg-1; Tue, 07 Mar 2023 09:24:42 -0500
X-MC-Unique: GOXamBoqNaWafLYTKsVFeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6D0885A588;
        Tue,  7 Mar 2023 14:24:41 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02CE72026D4B;
        Tue,  7 Mar 2023 14:24:38 +0000 (UTC)
Date:   Tue, 7 Mar 2023 22:24:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <ZAdJIXT4AxuYB3Do@ovpn-8-16.pek2.redhat.com>
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
 <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
 <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 07, 2023 at 02:31:48PM +0200, Sagi Grimberg wrote:
> 
> 
> On 3/7/23 14:14, Ming Lei wrote:
> > On Tue, Mar 07, 2023 at 01:39:27PM +0200, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 3/6/23 23:49, Ming Lei wrote:
> > > > On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
> > > > > 
> > > > > 
> > > > > On 3/4/23 01:13, Ming Lei wrote:
> > > > > > When investigating one customer report on warning in nvme_setup_discard,
> > > > > > we observed the controller(nvme/tcp) actually exposes
> > > > > > queue_max_discard_segments(req->q) == 1.
> > > > > > 
> > > > > > Obviously the current code can't handle this situation, since contiguity
> > > > > > merge like normal RW request is taken.
> > > > > > 
> > > > > > Fix the issue by building range from request sector/nr_sectors directly.
> > > > > > 
> > > > > > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > ---
> > > > > >     drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
> > > > > >     1 file changed, 19 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > > > index c2730b116dc6..d4be525f8100 100644
> > > > > > --- a/drivers/nvme/host/core.c
> > > > > > +++ b/drivers/nvme/host/core.c
> > > > > > @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> > > > > >     		range = page_address(ns->ctrl->discard_page);
> > > > > >     	}
> > > > > > -	__rq_for_each_bio(bio, req) {
> > > > > > -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > > > -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > > > -
> > > > > > -		if (n < segments) {
> > > > > > -			range[n].cattr = cpu_to_le32(0);
> > > > > > -			range[n].nlb = cpu_to_le32(nlb);
> > > > > > -			range[n].slba = cpu_to_le64(slba);
> > > > > > +	if (queue_max_discard_segments(req->q) == 1) {
> > > > > > +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> > > > > > +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> > > > > > +
> > > > > > +		range[0].cattr = cpu_to_le32(0);
> > > > > > +		range[0].nlb = cpu_to_le32(nlb);
> > > > > > +		range[0].slba = cpu_to_le64(slba);
> > > > > > +		n = 1;
> > > > > > +	} else {
> > > > > > +		__rq_for_each_bio(bio, req) {
> > > > > > +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> > > > > > +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> > > > > > +
> > > > > > +			if (n < segments) {
> > > > > > +				range[n].cattr = cpu_to_le32(0);
> > > > > > +				range[n].nlb = cpu_to_le32(nlb);
> > > > > > +				range[n].slba = cpu_to_le64(slba);
> > > > > > +			}
> > > > > > +			n++;
> > > > > >     		}
> > > > > > -		n++;
> > > > > >     	}
> > > > > >     	if (WARN_ON_ONCE(n != segments)) {
> > > > > 
> > > > > 
> > > > > Maybe just set segments to min(blk_rq_nr_discard_segments(req),
> > > > > queue_max_discard_segments(req->q)) and let the existing code do
> > > > > its thing?
> > > > 
> > > > What is the existing code for applying min()?
> > > 
> > > Was referring to this:
> > > --
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 3345f866178e..dbc402587431 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
> > > *ns, struct request *req,
> > >                  range = page_address(ns->ctrl->discard_page);
> > >          }
> > > 
> > > +       segments = min(segments, queue_max_discard_segments(req->q));
> > 
> > That can't work.
> > 
> > In case of queue_max_discard_segments(req->q) == 1, the request still
> > can have more than one bios since the normal merge is taken for discard
> > IOs.
> 
> Ah, I see, the bios are contiguous though right?

Yes, the merge is just like normal RW.

> We could add a contiguity check in the loop and conditionally
> increment n, but maybe that would probably be more complicated...

That is more complicated than this patch, and the same pattern
has been applied on virtio-blk.


Thanks,
Ming

