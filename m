Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F8C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF49204FD
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 15:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UDTuTei1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeLPPr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:47:26 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40200 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPPr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 10:47:26 -0500
Received: by mail-pl1-f170.google.com with SMTP id u18so4940899plq.7
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 07:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0JNy8Mp/2+Ntibqn1Yx9V4lOoJDzmsO5Q7/lD/kbgAM=;
        b=UDTuTei1KDNlvqhRawcDnEE4++dnImsh5Da5pFsV1l3h6rPC741ohmfr6Vbcs4TLKA
         Ig1L4d3ii6eu1mBI/N9UlJuO1pKtCQAkzX5fmHvWuN2dCTzXR2Zy5GX37MANe34z+dJ8
         24OfB8KCUfOxi2QahszoKrc6qxcgPXCAQuyNkl8JJlkO6fXd8PqVSpLsZGo3u+gwpX//
         hS1AGO0JsPiu7esdlw37G8o+kv6bSgQuMiDifrkMLjvhbeXYJms5fdZWTGwlS+3xmfO3
         k4sX2DekgjuW+6zy6dZqJewlBFDZ/yaclu8E60piQx6EDzJPcOwkTCU2z8jwE3KMoJ1z
         RbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0JNy8Mp/2+Ntibqn1Yx9V4lOoJDzmsO5Q7/lD/kbgAM=;
        b=dBwtgqLQ6dZWJIFQe61ekLW9EkpFT7iI8jxXBK8DNLjxmb4ro9KcAOPiABtDSaLFjU
         0taIzK1cZa77SgOQ7YQGRA1PPTL2lrVZazlFV/4W5622K/LiryXTPCKv0sttD43oF0SJ
         ND+ZRr/KOx2Bsj4naW+Z2OkqArJdxt86Du7RS+AZ5GYYD2dvxx20oLeQGAL5tPme0pZH
         2QgGlC+bbi8p9kSG9gio8JGwkjY/rp1AR2pRqscY7b8jch3cWsl5ifRkQ+jFcH6hFViy
         m6Wv9NvAxRd0WbTtxSqMtPJBY0uHHISjVa6YQ+rI204935oInCsGqFbsZjW1v35Pqfkz
         YBnw==
X-Gm-Message-State: AA+aEWYOYV47YSGQwK3eY+MVJQ+Ow2V/Ml08+BYrpFc+NST1b4NpdD/G
        iMnKX8lRBUduL89es3ivbwNMyKSbkScNMg==
X-Google-Smtp-Source: AFSGD/Vg3ERPVIGRNSJvhQ7fhL1I/kG493sTyZ8LTq3NWSRpjhuau60MKtSX9+2T8DLcmTc1ro7NOQ==
X-Received: by 2002:a17:902:b83:: with SMTP id 3mr9291248plr.42.1544975245285;
        Sun, 16 Dec 2018 07:47:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g2sm12988389pfi.95.2018.12.16.07.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 07:47:24 -0800 (PST)
Subject: Re: [PATCH] block: loop: check error using IS_ERR instead of
 IS_ERR_OR_NULL in loop_add()
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     linux-block@vger.kernel.org
References: <20181216093500.25023-1-cgxu519@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67d50785-aff6-5c7f-2ac5-e794d9495871@kernel.dk>
Date:   Sun, 16 Dec 2018 08:47:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216093500.25023-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 2:35 AM, Chengguang Xu wrote:
> blk_mq_init_queue() will not return NULL pointer to its caller,
> so it's better to replace IS_ERR_OR_NULL using IS_ERR in loop_add().
> 
> If in the future things change to check NULL pointer inside loop_add(),
> we should return -ENOMEM as return code instead of PTR_ERR(NULL).

That won't change, I really dislike functions that return NULL if
they also return an ERR_PTR.

Applied, thanks.

-- 
Jens Axboe

