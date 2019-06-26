Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE8FC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1D2086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chviKWcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZUwv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:52:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34241 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:52:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so250plt.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EValKUfaHbwPl8I7wkHK3qlNXLuTFLSTo32lca29h8Y=;
        b=chviKWcy77iZYppPFBlCGoLMXUiYfrxQobkCPRsnFaHiWGefhbnp8nPKDO7XZOG841
         QXdJsyMV4A/AnEbf8+NGPsLqNdV/oc+B6N3TWFfwfHSjefK+/q7dP33nHtAmYBxp8Mu0
         KTS2U6vLAMqFXZvSiLAXFCBmuNY1VSimqmH+H3UgAY1Vp63cjLz2pPwSBcwuBzRujttB
         yQxCg9ZUOC/zi+zaVR/aE1sf3uKfGffWfo9hKslZ3HkuZtK4NbuZ56FcZGAVHmt3fwAu
         wI6kw4Eq6FVo+Xbz3EnrZErNOvJ5fXX2WjamNwthPk0oQp5eXjGzia2BOod0j5jBxVhs
         6uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EValKUfaHbwPl8I7wkHK3qlNXLuTFLSTo32lca29h8Y=;
        b=HoLjeqkR2Vzl8fyNfM81SnAotQxQkWO97E5GH+teUPT/5G5W4rfBxHXcb5wShtY5cK
         i0oM1xedrEe24XQn43LiXw8a/weRr7kEBR5eRKSEV3T/zQIkMs0rCLNP3a+g2FMysMGA
         kPd3ScvVl+jEP+FOBfZ5yls4MuGC+EB6fC7mI7tGzuHrpW3Mk+iKvT6ZKOj7Ywl10u5c
         vdFxCHTc7w3yXRI65dJwSjbHCHfEeyug+rIEi3eindSyAowj4Akq+h5NkVGrwV+PEL/Q
         6CZ0HgOujvBRiU3Sl4oRFr+YXTzrp97+mKrk87ioMXPgffFkSbhfybFFU4fm+XNfaaRr
         SBwA==
X-Gm-Message-State: APjAAAVGkk2ZDgRGCCds+SKHaHWrGTQdwb2qhEwhl+EXZvZ9+t2aEjzN
        1cduhge/DLo5zXNHKGSp6lY=
X-Google-Smtp-Source: APXvYqzBxvBl0vYh2FSlBXMCLyi1G5kKwS94XhCDAgBX00MpcS7L2kbs7CwgyXlP8fUps+Gvd6eNIQ==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr45083plc.311.1561582370446;
        Wed, 26 Jun 2019 13:52:50 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y68sm115238pfy.164.2019.06.26.13.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:52:49 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:52:47 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Message-ID: <20190626205247.GH4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-3-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-26 15:49:21, Christoph Hellwig wrote:
> A lot of callers of bio_release_pages also want to mark the released
> pages as dirty.  Add a mark_dirty parameter to avoid a second
> relatively expensive bio_for_each_segment_all loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 12 +++++++-----
>  include/linux/bio.h |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 9bc7d28ae997..7f3920b6baca 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -845,7 +845,7 @@ static void bio_get_pages(struct bio *bio)
>  		get_page(bvec->bv_page);
>  }
>  
> -void bio_release_pages(struct bio *bio)
> +void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct bvec_iter_all iter_all;
>  	struct bio_vec *bvec;
> @@ -853,8 +853,11 @@ void bio_release_pages(struct bio *bio)
>  	if (bio_flagged(bio, BIO_NO_PAGE_REF))
>  		return;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all)
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		if (mark_dirty && !PageCompound(bvec->bv_page))
> +			set_page_dirty_lock(bvec->bv_page);

Christoph,

Could you please explain a bit why we should not make it dirty in case
of compound page?
