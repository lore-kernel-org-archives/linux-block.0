Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC22EC48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC48C2086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6IyOrwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZU5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:57:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZU5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:57:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so1758203pgr.13
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DElaeHzaRKU1gwyCTIn1ixkk0zY05Ir+4pnV7Q83a1Y=;
        b=b6IyOrwd/EOy4VIa0TG6JUYFsZ5s0+C0BX6ROpFPte/pvxbd8OG0RX2pYw7fBZo3BD
         DZXD4weVZlNFFgMxuWYpwlbjRvy4Uz90AGEJMbGDkWHCU/q4hOyqTjqM/TA7wz8xtHqo
         FK66egc/fwywApbJZ5bdRX5+mdWt+XBr6Zn6drZRLoBetZ9r0du3SBZW5Fy0UlQw/na/
         8rGqWEOLjGmkLnjXNPeaHouI5CaqrhleiFN9FfFTjEfWh/2qJQDZYM9qUp6WM2E6vgf+
         c/WNv+8i3N+1m8qUB2iwZ4HJ6ZnwRMG+izL3BR70/869M8gf0a8jpEKJSaiwvCioiX4u
         yWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DElaeHzaRKU1gwyCTIn1ixkk0zY05Ir+4pnV7Q83a1Y=;
        b=TTAc5NSTOc3XcIqqkRNZ8dIK3Lp7MwRBOLwX6tK/VWkH2RhLYh0AODd6SdOUUXNtUP
         6OuJOQFTePrFI9FFcfxBmA8QL2TReSkwqbBCIHbR3cVxFAGKRNKyWyubOnZEqRLDbvy+
         cdrZFOXZAPNB7736tTV/9F8CdSXIilK5YPOqEjP40j4WL0v7XS50I2P8Uj7SS9DNCmpJ
         6p5AWkh4E/GaTz2N+UvPkcZAi0200G6WEG8BcRq5hzH1OFSBvpwcqw1Onb1GpJnt6j6o
         9wk+ogoOhf1iFphPe3vk3ZZMPMq/PIBvOE2PhkdflGMOpy7hNWXfsuvm3PPGEyvsTrx9
         bEWw==
X-Gm-Message-State: APjAAAX0mr2gdpmN9CihB5XHLtql/m05prS6QewDqUlr+byJx5K/j11x
        9vSB6DNxQN0j75BEbFDL9CA=
X-Google-Smtp-Source: APXvYqya1k+LB6sCL6e/Nv709OIlEFHDnFGrZB5UOgNMvg1fXx+IqZSjeCgtTtIf9G/MDgVZSkWL6g==
X-Received: by 2002:a65:6686:: with SMTP id b6mr4883470pgw.125.1561582634216;
        Wed, 26 Jun 2019 13:57:14 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id u23sm132621pfn.140.2019.06.26.13.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:57:13 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:57:11 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 9/9] block: never take page references for ITER_BVEC
Message-ID: <20190626205711.GI4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-10-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-26 15:49:28, Christoph Hellwig wrote:
> If we pass pages through an iov_iter we always already have a reference
> in the caller.  Thus remove the ITER_BVEC_FLAG_NO_REF and don't take
> reference to pages by default for bvec backed iov_iters.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
