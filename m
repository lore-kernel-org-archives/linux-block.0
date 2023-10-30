Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3738C4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjJ3OyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3OyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:54:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CAAC2
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF88C433C8;
        Mon, 30 Oct 2023 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698677650;
        bh=IGxZ3WXFE2g5LtHStC1maMx/25lkQzHmz4Iz8FrsjIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arfIcr1PLhx/XBZRkqc8eMahg/eKkqQyCDFGPdP6in7tfw5XcRfMMl8bfFUk2FOj1
         h8JVbT0koyb35oGfarOrJkvw2R6sMStxMzsy3ogdG41x2Q92IXU1HTdw7HgdM5nmeu
         wRp5iGcfJA55otgY73SSniYNAUCI8z6xnTR2lgiBYMv69zkQnT9G0Y7aXWoFJbmk0/
         gfOgUAEaBwQe90fG1ty89wyGgbw4M88i5rCaAikuwtuxNsQqvLwVD/a/VsNoQMdRtV
         iX73Ao8pJP8YCJ2ZMZ2bdw6vDlHRKSaTkzAz+QnrvivIR6FRgbZAGd3v853YOXXlHR
         39FuqgD23s7/Q==
Date:   Mon, 30 Oct 2023 08:54:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
        martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZT_Dj9Df07bCntQQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <CGME20231030144050eucas1p12ede963088687846d9b02a27d7da525e@eucas1p1.samsung.com>
 <20231030144047.yrwejvdyyi4vo62m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030144047.yrwejvdyyi4vo62m@localhost>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 30, 2023 at 03:40:47PM +0100, Pankaj Raghav wrote:
> > +	int ret;
> > +
> > +	/* if bvec is on the stack, we need to allocate a copy for the completion */
> > +	if (nr_vecs <= UIO_FASTIOV) {
> > +		copy_vec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
> > +		if (!copy_vec)
> > +			return -ENOMEM;
> > +		memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
> > +	}
> > +
> > +	buf = kmalloc(len, GFP_KERNEL);
> > +	if (!buf)
> > +		goto free_copy;
> 
> ret is not set to -ENOMEM here.

Indeed, thanks for pointing that out. I'll wait a bit longer before
posting a v3.
