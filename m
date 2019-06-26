Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32279C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02261208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6FuAXeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZUl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:41:29 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39790 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:41:29 -0400
Received: by mail-pf1-f178.google.com with SMTP id j2so26815pfe.6
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S31JEDcLBxkf0+0leLRLwyNs8ezZI6yEuqCuLmcdqjU=;
        b=W6FuAXeA0u78+kdJo14zo218BNyzSBg9Ca8U09sAt2rqRySRRJLkodib0jQ1h6KvQ4
         /x9ZJDxiX2elXkhBKQ+cNCigv2/mQOb2OLmGQxnulu6C9jamdE3A6Jn1laFRMWswqP+d
         NIOE/i9qtvAH24xB6wJqKlpy1Z+bOaBjMoHQiC1FGgOvSg6RxuPA8/pW3aVo5e432lYg
         9/hsXe/sfyNDmTqKRRSg2bX6fB7hiQx1VhxNI2niEEGaVydlT7YYqhGSJ9E7ylWdrXcy
         5rwkihx4BOjzJzagzjPYoBBukOSJeXwzYVyFe+ZG1kO13Jf5wnyyh2uwIGPn4N5yojLy
         sx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S31JEDcLBxkf0+0leLRLwyNs8ezZI6yEuqCuLmcdqjU=;
        b=Ig5WZZUiCVk7pAedJPz7V1gVeFrq3XeSU3paNpTK7i6PXvBi2Jrmr+aNFXJgbeSrZ4
         AK3yCgLhxSY6QUbpx0VBnA6GsXf+0S6iNe0oxsCViw0L5UTegzCHDgENDAlOa7HWnE7p
         5d7/fbAJ/EFCQgyNITAj8uNKsrOnCzEiPlvrpsASdghTeH6I5PjhVgr6j1ITYkhyB/Wp
         NuCtyK7OLzpx9gQUZ8SF0cL9S4eii1GTJfrSiJ6jPz+hNfm6YzfWi9P5qclTxw9F0Z/t
         DBed4DqGM69xNY/RMtCcRULXJO3JsQrUQcY1TO5UAtpHLYXGvh+TIqGoW2m2DoudRvWt
         FIiQ==
X-Gm-Message-State: APjAAAW56jQH6YDib3TEd2Ih5YcWSPf3ghfWjboRqr3s3rhO4zfSoZs6
        Z+uzYs1a+dYqv55cSVL33ZSCQ8D5bQ0=
X-Google-Smtp-Source: APXvYqzKLhZRu1pTlXs66VNlSIAj7vJBZToXOyIwG/Zr7w2HyUqSKbEVa1m+dIRbqi23xg5usmUkCA==
X-Received: by 2002:a63:2020:: with SMTP id g32mr4838059pgg.90.1561581688504;
        Wed, 26 Jun 2019 13:41:28 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id f88sm3334257pjg.5.2019.06.26.13.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:41:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:41:25 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 4/9] block: use bio_release_pages in bio_map_user_iov
Message-ID: <20190626204125.GE4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-5-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
