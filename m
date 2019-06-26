Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896FC48BD9
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9132085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhqib+yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFZUeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:34:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42220 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:34:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so1739367pgq.9
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtb3Zon/JQSSN+uJ4rgrW0ez0UkfCHPw99JY0M10Wy4=;
        b=Nhqib+yMOF3K1ysvftFuwksNZ3eRvRZ4LUmkgXp1p4+IKWyniT0JpfEQwxhTTv63Xa
         xqctyDPxd+zV3BZMgL6GpIC6uX5J37YqEadRbEfT/akf/CWgZCpBsslQrxqZ6RBtmMfI
         xbiPL2iPBcVMgQUgyzk4IsJvKeOn8Aj49wHGjitfxBNEo+avs1iQ0ztzWtF1F/09qET+
         KaeJojoKem4K96cF6gpW5DYICxo55VFJ/3xPyVxRsTKjYIS34O+hwA2GA8zqHK+0+wuf
         7KrqInNob7K8g8U3eLaRmAkGkoZkVNSixwqDzIO20aUUnQwbVOm0wsdI7j4atqwScown
         IKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtb3Zon/JQSSN+uJ4rgrW0ez0UkfCHPw99JY0M10Wy4=;
        b=C3wLuNnkCx+59AUUFYYK3IDB1RPoSo9QaN0H/w83m9Dvu1etwZHH/BHz+piYQcmXWE
         j5ix3AtfbLU711obqS3p1AL1lAvKLowEzt5ZwGagr/WoxsjjDDZ3WfdczdlD4E7uEr51
         1Dc+K6riu80e4L9DiSb1evHOrnUzwdOn+5nu9K2dmpRVe8+YTOTFIHsp8UYz5WQaxSEY
         MQO6VyvatMkuZVx/KVt7ZwLlvqJUYFT722zJi0p6g8HHv62jy5YU/wk4FIvgEpYbQChH
         JwPLkdxXkIuzvx1vxya9W/X8pqPNwz9ljvhIiDhiQU2K0Rm+mt5XMGmZLU0jlS8JoeJO
         WY1w==
X-Gm-Message-State: APjAAAWV7hLGgcwt8+WsvMWQKDRvEa7Wrc2vt2lC4twnZtxFx7mQ4Ziv
        +h26VFe11wvLl/qiBCQExviWTsy42uo=
X-Google-Smtp-Source: APXvYqwcB2SegJnRgBEiV+LpaifN2kNyjL/RBm1fqlKC5IYHrWLl/MBj6SinVx383qpGygFAUK2afQ==
X-Received: by 2002:a17:90a:2041:: with SMTP id n59mr1198312pjc.6.1561581256521;
        Wed, 26 Jun 2019 13:34:16 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e26sm103667pfn.94.2019.06.26.13.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:34:15 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:34:12 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 1/9] block: move the BIO_NO_PAGE_REF check into
 bio_release_pages
Message-ID: <20190626203412.GD4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-2-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-26 15:49:20, Christoph Hellwig wrote:
> Move the BIO_NO_PAGE_REF check into bio_release_pages instead of
> duplicating it in both callers.

This part looks good to me.

> Also make the function available outside of bio.c so that we can
> reuse it in other direct I/O implementations.

This is also for the next patches.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
