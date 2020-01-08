Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACDAC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821B320692
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3XyVkHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgAHNjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:39:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgAHNjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8voYYRD3ow6zUgiWMFghxszbyHmUx/DHG4PtgP4N+gg=; b=L3XyVkHfiAwLGl3JJ+LsTBWMB
        nnQAvtUF6ACrYIyTNxILfpNM1s6cAMNfmDBDH7qsBN/Bdiwjbzp5q9fii7O7NP84HIqm1d43v9+VS
        gwtz8Njb47UlB/E5IcRDPvVRhdU7UV3J3JzDbDmxzbaFKgpL3eNuATEzx/BF5HRMZ+1bbPffeT8/S
        IzAU2ZFDwTHdyHLXJIeciXPZcTwROl6BmLpE2VoF4zuF1Kn/iKzwJgAcQ8MFB4brIrIryA3rj4DWK
        PDyCSEzhwuoZgKJHr/y+Xkks8zgLu1CG32D3W9d9lpSTyXh+eEAmyvaGlErGpB2Ragkjo9VokwSMJ
        6K8mS0Uyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBYp-0004aZ-Ri; Wed, 08 Jan 2020 13:39:47 +0000
Date:   Wed, 8 Jan 2020 05:39:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Allow t10-pi to be modular
Message-ID: <20200108133947.GD4455@infradead.org>
References: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 04:13:51PM +0800, Herbert Xu wrote:
> Currently t10-pi can only be built into the block layer which via
> crc-t10dif pulls in a whole chunk of the Crypto API.  In fact all
> users of t10-pi work as modules and there is no reason for it to
> always be built-in.
> 
> This patch adds a new hidden option for t10-pi that is selected
> automatically based on BLK_DEV_INTEGRITY and whether the users
> of t10-pi are built-in or not.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
