Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C256C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A36860F6E
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhJIQfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJIQfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 12:35:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DADC061570
        for <linux-block@vger.kernel.org>; Sat,  9 Oct 2021 09:33:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w10so13336751ilc.13
        for <linux-block@vger.kernel.org>; Sat, 09 Oct 2021 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NOsRu7Gl5frflQDzwyqruKASxPNHzdSSKCi/MZwdyAY=;
        b=SvCLButW0E32uzvmfP52sqIX/ovO93QEo5xC7076+7uon2m3OPBnBNCafcs8RfT7Ju
         X3MeJ/RKl8DegGr9vANlrCgGuQdSjZp1gnRfFcOUsU5/HpoZi+Z8ovb3g6CHj1B6zjSR
         bWnXggRNmz1QTbjPFpbB2vgXO3Rt/HHaKfZhmfSHDVTs7PDSiAut4pnMxQSjSdW6JpyV
         L42IivM6Hw5VfJJLPGDfNI/fA5qDgZlCNhObLnz0Ci3vaf7HqVuRI3r256XJPlL4vf5S
         x4k0+PBAA3vsZmmKxzSWfTfSdcxH1v2RalA8blzd7GsH4zG5RcyfIsrT9c5pAghtNFdl
         F32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NOsRu7Gl5frflQDzwyqruKASxPNHzdSSKCi/MZwdyAY=;
        b=aHtpWRYnTIlhzxvYA3ximp5QUKOE1M6U0SVF/SkRqa2pECLo8mZDB+jAWajtbmgywT
         81Ul5RdM8zGExcKTOl9YHq9y+BkEEBg1ghEhS4z0M4BxifaWFcF7WMBbUB0AJ1sedq7Z
         OHrhg+MTlhZB5aPgWFvHA9FGrs9DsfW+XeocKiO4zYr2g28KtL945VXcoGETbatWllg6
         snCUDY8NR1liFpE+CXYa2fKnltC6CErUQYcMJoTR+Qm8b33VKMTS6JnnT2T/P9MfLGFp
         v+UVIw3Mg77eLMlXgDIPDodA1xPdO08m3ALFwzHuTnTApTCKzNK041cuzFU+rSwt8Uc/
         jtAA==
X-Gm-Message-State: AOAM532kiljLlos/isg3X6+fbzWaRLr+r3Xjod+7KoHmpT3zIh4IL8yT
        C1fIwAvh3pnpcgCx9viltWOeTw==
X-Google-Smtp-Source: ABdhPJx1NjG6/F1SHb0HuayQrLS9FpxxBkrKxeYOOAbQVOqZHtuzyuzO0Xs0nUIDDf/8WBZRkUaXyQ==
X-Received: by 2002:a05:6e02:1b07:: with SMTP id i7mr12989533ilv.63.1633797199110;
        Sat, 09 Oct 2021 09:33:19 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w11sm1268567iom.23.2021.10.09.09.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 09:33:18 -0700 (PDT)
Subject: Re: [PATCH 1/6] block: cache bdev in struct file for raw bdev IO
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1633781740.git.asml.silence@gmail.com>
 <cfc66d9946422fa1778504f976621c91be2befb5.1633781740.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0785c707-ba82-1e46-5d4d-63ccacdb471f@kernel.dk>
Date:   Sat, 9 Oct 2021 10:33:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cfc66d9946422fa1778504f976621c91be2befb5.1633781740.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/21 6:25 AM, Pavel Begunkov wrote:
> bdev = &BDEV_I(file->f_mapping->host)->bdev
> 
> Getting struct block_device from a file requires 2 memory dereferences
> as illustrated above, that takes a toll on performance, so cache it in
> yet unused file->private_data. That gives a noticeable peak performance
> improvement.

It's hilariously bad right now, so I really welcome this change. One
comment:

> +static inline struct block_device *blkdev_get_bdev(struct file *file)
> +{
> +	return file->private_data;
> +}

Get rid of this and just use bdev = file->private_data where
appropriate. Easier to read, we don't need to hide this in a function.

-- 
Jens Axboe

