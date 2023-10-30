Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C11C4167B
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjJ3VZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjJ3VZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 17:25:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046A8E
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 14:25:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAFAC433C8;
        Mon, 30 Oct 2023 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698701114;
        bh=hzofDKiGjd6jXy/PnVdRPIXYvHmctTDMe4RQrG3lL0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPQ2cNx+nf0zldx6hUWvHXnWXeCuEJx441hauvRDRt6MKXThszkTf4gfrU24nSrC0
         p4X/Fn1v7pt+ROyfx1qK3h1Xoc57kH8H2v7mjdspHNYECqapBIYHd2W2PlZCEVYXd1
         a4NNOXfbDLuoaU8GNVFEP0VkkMOdVkzZHbZxprwXo03QKG7U7TX4gtI9AuFYwlVIdk
         2y3+7oa+de7PNNY1moaag5IXcmd4NkY3BUQftK15qsJe7c2dPRhoBjUzoO5UYMH4QJ
         0Nq7H0uJN0pw62hfnQ/MDPzt4tT0xppeN8rIt1A6a98g8k7nnzaapP1V82PS3q+6zE
         ds3aYJGO2K5ng==
Date:   Mon, 30 Oct 2023 15:25:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUAfNzhvp9KGysT2@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182017epcas5p1fb1f91bc876d9bc1b1229c012bcd1ea2@epcas5p1.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <c3a946f4-b2f8-c800-1573-1f87c9d637d7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a946f4-b2f8-c800-1573-1f87c9d637d7@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 31, 2023 at 02:32:48AM +0530, Kanchan Joshi wrote:
> On 10/27/2023 11:49 PM, Keith Busch wrote:
> > +
> > +	bip_for_each_vec(bv, bip, iter) {
> > +		if (dirty && !PageCompound(bv.bv_page))
> > +			set_page_dirty_lock(bv.bv_page);
> > +		unpin_user_page(bv.bv_page);
> > +	}
> > +}
> 
> Leak here, page-unpinning loop will not execute for the common (i.e., 
> no-copy) case...
> 
> > +	bip = bio_integrity_alloc(bio, GFP_KERNEL, folios);
> > +	if (IS_ERR(bip)) {
> > +		ret = PTR_ERR(bip);
> > +		goto release_pages;
> > +	}
> > +
> > +	memcpy(bip->bip_vec, bvec, folios * sizeof(*bvec));
> 
> Because with this way of copying, bip->bip_iter.bi_size will remain zero.

Good catch.
 
> Second, is it fine not to have those virt-alignment checks that are done 
> by bvec_gap_to_prev() when the pages are added using 
> bio_integrity_add_page()?

We're mapping a single user buffer. It's guaranteed to be virtually
congiguous, so no gaps.
