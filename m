Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E198AC677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 16:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjAPQ1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjAPQ0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 11:26:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFD92BF07
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:14:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7876857pjg.4
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jf8Sg2gHxOFWnuSxH+dO003oI/dzbWkr5TALiGHmR4=;
        b=v1i7y5c0CHp3UwsV64LsMRSW/8H+l5ykSrE1KA7zITKaYu6f214W60rdcdwkzKd0XZ
         nR6hgEj8UKwQD15PQNvf62+qjVHGU9A7H4xpyVOKKE6darQfAV1nt8K7q0tv4AaBZe6x
         HvsLqleMydoQKWxV4FmsRpYGvrAcWNT8bACL9fZ8K6Sk7TUbtlDGNqfiTVbP2UcRJUjL
         Ao6UMYXo77kDY+ejw40rDyHNxE9sk69a5voIy/9g7NSTIxCH5Go2W0qoNcHi6fbDr28z
         J83yxglcqMe4o0I6gBfNAT6GfctJvEajfBkhfD+salXqRnriEFLyPiUHy6CEBD92UOlV
         QsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jf8Sg2gHxOFWnuSxH+dO003oI/dzbWkr5TALiGHmR4=;
        b=wshyuOyaq1qVRtmQIanZBn8HsqtxFqL88j4c1KUcyWCMMLIHjOhzC+oH6uMjA/mmlG
         oNxnM99o4OiB1SPvJwstC2d6l7U5Oees36m6809pAoy1T9L6tYk5H5TyOrVEM8DkmFJl
         1+szusfbt3h6CMiCVgBaNCpxJLTERevfWnOVuwbtQ0pjyMof9OKEnpsA+9EmJF65lbKD
         AR1VrSLsbmV+vF1pSP23j1K2EfCFWYCY6BlkJPchTfxMuMSenvyzYZboJuSfepHJ4NNM
         15IsOpmr6WjLszBkMPtahPGVeMr8Lphn7ktf96l40kSNdYmJ7p71dRkVHufrVBXo9y+n
         rnng==
X-Gm-Message-State: AFqh2kqEc1ZnHpNdu4kN8D27R2SQqzcQ0ghbu10gcCLjC0Nzdd4ciuG6
        9W0xSAXGIJLCbkMi1foWglWu1JnZJThCYAy1
X-Google-Smtp-Source: AMrXdXt0Q/97/T2TkA30U+OajhlMV63TiuCawZyu8eEpa9a/jK78fxREAQLOmk6SiX/ZrnK1WTRbBQ==
X-Received: by 2002:a17:902:8209:b0:194:a374:31f3 with SMTP id x9-20020a170902820900b00194a37431f3mr72674pln.3.1673885696697;
        Mon, 16 Jan 2023 08:14:56 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b00174c1855cd9sm19467171plh.267.2023.01.16.08.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:14:56 -0800 (PST)
Message-ID: <05a28cc6-0070-9117-368e-ade7561f6727@kernel.dk>
Date:   Mon, 16 Jan 2023 09:14:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: check disk flag before setting scan bit
Content-Language: en-US
To:     wangjie <wangjie22@lixiang.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116083832.27305-1-wangjie22@lixiang.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230116083832.27305-1-wangjie22@lixiang.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/23 1:38?AM, wangjie wrote:
> No need to scan partitions for disk who has set flag GENHD_FL_NO_PART in
> driver code. In disk_scan_partitions function, the same checking is
> existing, so we believe this change is reasonable.
> 
> In our case, some virtual block devices are not managed by GPT, then scan
> partition operation is not a must. So we set GENHD_FL_NO_PART flag in
> driver intended to avoid partitions being dropped/added.
> But GD_NEED_PART_SCAN bit was still set by bdev_check_media_change, which
> causing problems here.
> 
> Signed-off-by: wangjie

Signed-off-by is in the wrong format, and the whole email is badly
mangled...

> ????????????????????????????????????????????????????
> ????????????????????????????????????????????????????
> ???????????????????????????????

This didn't quote well, but the original is also useless. You do realize
you send this email to a public list? Please get rid of it.

-- 
Jens Axboe

