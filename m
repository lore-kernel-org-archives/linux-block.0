Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDBC2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 12:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335AF21531
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601295091;
	bh=tB9hfGPjvJwP/CgUTzf9UD+Q6oFlInFk9oxc9qyVBlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hoeJq26uL71SNLifxvOdj0FmlYkfDJJ8Xchy1RMysZAY2dy8KCpaT0K5c2FaFC8EG
	 lnLCBUzJ6j6/1z1CHEBWxDNDtWBUrQ6WxT8HOIUk1G45DR+iK0huKh+ekfa1Yge5/N
	 PuuLCKskj3snGbVGkHmuLX5mVY/GkF1kt1TPXgp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1MLa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 08:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgI1MLa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 08:11:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312D62083B;
        Mon, 28 Sep 2020 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295089;
        bh=tB9hfGPjvJwP/CgUTzf9UD+Q6oFlInFk9oxc9qyVBlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dO+CZraVjmjBjQtPPvVKGsBLrifLH9LkWTOnQaaoiOUq/t527NS0VGbQi0EAxcqms
         KgSjfwdQlkE1Sm8Xmw0qhe38UOnvQmp0XsTAcGApF1VPzwjcscO87UMEQtiaQFJmtP
         +9SzUW7C8VvjKSKPiPOF76afF0HlHMq6w8g0Bj+s=
Date:   Mon, 28 Sep 2020 14:11:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, Damien.LeMoal@wdc.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v2 0/1] concurrency handling for zoned null-blk
Message-ID: <20200928121136.GA661041@kroah.com>
References: <CGME20200928095910epcas5p2226ab95a8e4fbd3cfe3f48afb1a58c40@epcas5p2.samsung.com>
 <20200928095549.184510-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928095549.184510-1-joshi.k@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28, 2020 at 03:25:48PM +0530, Kanchan Joshi wrote:
> Changes since v1:
> - applied the refactoring suggested by Damien
> 
> Kanchan Joshi (1):
>   null_blk: synchronization fix for zoned device
> 
>  drivers/block/null_blk.h       |  1 +
>  drivers/block/null_blk_zoned.c | 22 ++++++++++++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
