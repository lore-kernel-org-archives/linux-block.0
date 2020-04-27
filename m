Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AEBC55199
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4912084D
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyIEPV2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgD0Fsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgD0Fsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 01:48:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB472C061A0F;
        Sun, 26 Apr 2020 22:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/PSqghsfGGjRQjfpqyIZ2MD77LzLmwVJtfCaOeG3/FQ=; b=jyIEPV2+/wssi7ISWw/r0t0N1R
        sj5CyFlWIw3mNp6OT31624TkVGkCgv8Jult3rcuBVn4Uf4UPxoRB1Tkivu+kuz3r7oMs4u/tjffbR
        9xPdlmUwxwI3Yi4QtAe5l5hpzGHZ/uYexepgnzfcuTy8W+y0MaE82hF2mWVpvcq1UrYxnfu7bYodD
        Yak8Jw2oOOXa4Y+eD0cZBoLJXV3wb/wGjJVGolkE3nxi+F1t6kPG1+8+Gjhee7Ozwbg8fKe0rTFdp
        YBZ787lQPdkYACsv7OinO5uc/HMjWxES8a3CPnSqaVxxJujTI1ErrZQhEst7LPV66iUZ45cWCIv+o
        UiXE+UIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwd0-0001Dj-Vx; Mon, 27 Apr 2020 05:48:26 +0000
Date:   Sun, 26 Apr 2020 22:48:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] floppy: add FD_AUTODETECT_SIZE define for struct
 floppy_drive_params
Message-ID: <20200427054826.GA4159@infradead.org>
References: <20200426130728.63399-1-efremov@linux.com>
 <20200426130728.63399-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426130728.63399-2-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 26, 2020 at 04:07:26PM +0300, Denis Efremov wrote:
> Use FD_AUTODETECT_SIZE for autodetect buffer size in struct
> floppy_drive_params instead of a magic number.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/block/floppy.c  | 9 +++++----
>  include/uapi/linux/fd.h | 5 ++++-
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 2817170dd403..ac2023c757e3 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2076,7 +2076,8 @@ static int next_valid_format(int drive)
>  
>  	probed_format = drive_state[drive].probed_format;
>  	while (1) {
> -		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
> +		if (probed_format >= FD_AUTODETECT_SIZE ||
> +			!drive_params[drive].autodetect[probed_format]) {
>  			drive_state[drive].probed_format = 0;
>  			return 1;
>  		}
> @@ -3445,13 +3446,13 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return 0;
>  }
>  
> -static bool valid_floppy_drive_params(const short autodetect[8],
> +static bool valid_floppy_drive_params(const short autodetect[FD_AUTODETECT_SIZE],

This adds an > 80 char line.  But then again passing array sizes to
functions is a bit pointless ayway.

Otherwise this looks fine to me.
