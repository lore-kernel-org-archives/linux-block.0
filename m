Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3723AC433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 08:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B460F23
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 08:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhJIIs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhJIIs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 04:48:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFAC061570;
        Sat,  9 Oct 2021 01:46:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so47919527lfd.1;
        Sat, 09 Oct 2021 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PQFex+l6mJ2QM53cZRA8HH/CoNAzt5qU9JaEKGvExmQ=;
        b=moYkKOSpR9qN+SuM1iPN1Z54f86fPY+fu70JLUTtwZE+0otm1zYLcqer4hd7C1wGfB
         OVW1KHz73QHkuNjwDLdZk4awVlF0XrlRhNHFylbuN+W21yicJDQa0MSNbfAdxvOVp++r
         9TR3Z060tpb6FK7o3ryzL3zp8RJ0kP3p4TtH+k554f/b94FVJm/684eHJHQA+HRjNvMD
         RngSGqaN5spZy+gcgOYpGHKmHGgd5Rnz2sA5/doauHEEndi8ixjf0NgRuS3gNTLtCml4
         jn++uYsLP+6+Vu2tvgQfndfLmf44DxWKekg6RsFd0CxQXw0inEDC7GqTKjuJooJiMWYr
         aXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PQFex+l6mJ2QM53cZRA8HH/CoNAzt5qU9JaEKGvExmQ=;
        b=fRZHiAwg7lNpzsevUrgy6eFY1FvXKWihO8Erg1D8z2xsIJ/DT/iNdOLVRcOZARbR36
         7B3ftxJRYAqOtyfK0bfc7z4TnjbW0g1le0qF3rW90PyMEMFWMTU1/hSylL8wT3vR8aHQ
         7kFWY4uP9S6EyI/GWqAEMtUoE5/GYSL6aYeOK0ZY+Rv2Qj1ZGYP49cmYDZEb6WElhyP3
         DTGZld7jkLEff+h8/lEKuZpDNbovPFR8VyvPCPFrA310wzbmSz/LXZZjf7mBKfTAEU5+
         GSS4l9BWKIl0duq/LYKxJtiBeEeRtrrZakH8QXdgwX4G5ArM8wvmFsC5UOV5ly8tG/Du
         SrGg==
X-Gm-Message-State: AOAM5302WaNzAceX8yfZ98FNe2z+KKrrqO1w4gdaYg48qL7P3idosHSn
        yXFX6blg7Tzoc/tovwqwsck=
X-Google-Smtp-Source: ABdhPJw2GB9YllD74fx6MhU3AijPxn1PR9GBk4Wkod3ySgjMBLW8mYDiC+9/Af5NNZ3OGL1sLtuMYw==
X-Received: by 2002:a2e:7504:: with SMTP id q4mr9074100ljc.422.1633769188020;
        Sat, 09 Oct 2021 01:46:28 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.120])
        by smtp.gmail.com with ESMTPSA id w11sm153795lfn.93.2021.10.09.01.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 01:46:27 -0700 (PDT)
Message-ID: <ac132dff-ccde-bb14-9590-50f5b9f076e5@gmail.com>
Date:   Sat, 9 Oct 2021 11:46:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] block: nbd: fix sanity check for first_minor
Content-Language: en-US
To:     "Yan, Zheng" <ukernel@gmail.com>, axboe@kernel.dk,
        Christoph Hellwig <hch@lst.de>
Cc:     "Yan, Zheng" <yanzheng03@kuaishou.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211009053540.95100-1-ukernel@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211009053540.95100-1-ukernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/21 08:35, Yan, Zheng wrote:

+CC Christoph

> From: "Yan, Zheng" <yanzheng03@kuaishou.com>
> 
> Device's minor is a 20-bits number, max value is 0xfffff.
> 
> Fixes: b1a811633f ("block: nbd: add sanity check for first_minor").
> Signed-off-by: "Yan, Zheng" <yanzheng03@kuaishou.com>
> ---
>   drivers/block/nbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 1183f7872b71..53cd038c96e9 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1753,7 +1753,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
>   	 * byte in __device_add_disk().
>   	 */
>   	disk->first_minor = index << part_shift;
> -	if (disk->first_minor > 0xff) {
> +	if (disk->first_minor > MINORMASK) {
>   		err = -EINVAL;
>   		goto out_free_idr;
>   	}
> 

I've looked into what confused me with 0xff and I found that uapi's 
kdev_t.h has following MINOR definition:

#define MINOR(dev)	((dev) & 0xff)


But kernel's kdev_t.h is really allows 20 bit minor number :)

Also, can you, please, fix up comment above this check, since it 
contains info about max minor 0xff and it can confuse readers.




With regards,
Pavel Skripkin
