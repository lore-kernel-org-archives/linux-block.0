Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:39016 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdJBRXk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 13:23:40 -0400
Date: Mon, 2 Oct 2017 20:23:38 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] lightnvm: pblk: reduce arguments in
 __pblk_rb_update_l2p
Message-ID: <20171002172338.GC6008@hercules.tuxera.com>
References: <20171001132352.GA5697@hercules.tuxera.com>
 <0EF0B6C0-4335-43F8-85F3-3AF93225A01A@lightnvm.io>
 <5330486D-DD91-4980-B002-6BD9255835A4@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <5330486D-DD91-4980-B002-6BD9255835A4@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 05:16:57PM +0200, Javier Gonz�lez wrote:
> > On 2 Oct 2017, at 13.32, Javier Gonz�lez <jg@lightnvm.io> wrote:
> > 
> >> On 1 Oct 2017, at 15.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
[..]
> >> -static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
> >> -				unsigned int to_update)
> >> +static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
> >> {
> >> +	unsigned int l2p_update = rb->l2p_update;
> >> 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
> >> 	struct pblk_line *line;
> >> 	struct pblk_rb_entry *entry;
> >> @@ -213,7 +213,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
> >> 	int flags;
> >> 
> >> 	for (i = 0; i < to_update; i++) {
> >> -		entry = &rb->entries[*l2p_upd];
> >> +		entry = &rb->entries[l2p_update];
> >> 		w_ctx = &entry->w_ctx;
> >> 
> >> 		flags = READ_ONCE(entry->w_ctx.flags);
> >> @@ -230,7 +230,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int *l2p_upd,
> >> 		line = &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
> >> 		kref_put(&line->ref, pblk_line_put);
> >> 		clean_wctx(w_ctx);
> >> -		*l2p_upd = (*l2p_upd + 1) & (rb->nr_entries - 1);
> >> +		rb->l2p_update = (l2p_update + 1) & (rb->nr_entries - 1);
> 
> This is wrong. It should be rb->l2p_update when doing +1, otherwise you
> are not using the updated l2p_update value. The result is the pipeline
> stalling as the l2p pointer is left behind.
> 
> I'll fix it when picking it up.
> 
> Please test the patches before submitting.

Thanks for fixing it. I would be more careful. And will make sure
everything goes through testing before.

Regards,
