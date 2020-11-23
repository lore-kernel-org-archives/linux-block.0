Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C24C388F9
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 22:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253BE206D8
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 22:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd8DEuKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgKWWxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgKWWxq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 17:53:46 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DFC206D8;
        Mon, 23 Nov 2020 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172025;
        bh=Y754Uxsb+oRdteJzxeLGJZ0Nr6qJ2w8yPhIjK1E9ygw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hd8DEuKDlU/OBnXmphx1Bjt66POq5VZAkAJuwm05bXMWgCP0KNMsZhuX1pGccgVAQ
         CuJqNVszqNMvfApMAr7ZRwkEnkR59sOEF5TtNw+vX34N/EMP+A/lHmONMXhkr1ttvy
         rNUTWmbmeyjT6VfheHX8QTYB5CtlRKh4XbeKEb9c=
Date:   Mon, 23 Nov 2020 16:53:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     boris.ostrovsky@oracle.com
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 058/141] xen-blkfront: Fix fall-through warnings for Clang
Message-ID: <20201123225359.GP21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <33057688012c34dd60315ad765ff63f070e98c0c.1605896059.git.gustavoars@kernel.org>
 <e8d67ea1-3d0d-509a-a2f1-cf1758bb373f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d67ea1-3d0d-509a-a2f1-cf1758bb373f@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 20, 2020 at 04:36:26PM -0500, boris.ostrovsky@oracle.com wrote:
> 
> On 11/20/20 1:32 PM, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/block/xen-blkfront.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index 48629d3433b4..34b028be78ab 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -2462,6 +2462,7 @@ static void blkback_changed(struct xenbus_device *dev,
> >  			break;
> >  		if (talk_to_blkback(dev, info))
> >  			break;
> > +		break;
> >  	case XenbusStateInitialising:
> >  	case XenbusStateInitialised:
> >  	case XenbusStateReconfiguring:
> 
> 
> Reviewed-by Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
> (for patch 138 as well)

Thank you for both reviews, Boris.

> Although I thought using 'fallthrough' attribute was the more common approach.

I've got it. I will consider that for a future patch.

Thanks
--
Gustavo
