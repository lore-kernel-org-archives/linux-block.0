Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C1FA3744
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJaNuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJaNuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:50:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC11007D
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:50:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so2874531pjo.5
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzD007SepSnMiB+4oN3wChUsiGs5s/TJZks5gS7AgmU=;
        b=xQiqG/XcMzoS4vJxz+KJ4ukyr1ei4TWwIhSGdLN2yU2M/wnYLdrvNzgs9mTs8a+D2z
         7Hpsci/RdKoExg9PsSox3lK4LzyjgKFYNHVNMiua+ASXiEBIQE/6/NkEYmS4fR8DATnr
         9xaJJFF+60M4yrvRCszhJNwTdqqWrTegccJgQO3EtcIQYvr58Bo6CeQX9VoGkjSwEii5
         kkU4fdtevjgvroh6Ui02gk8kHtcUjruIq79w4XXTLtXcKbhrSoJJytYTlOee6x0wXAKz
         Ii/XrG3AqRTHnxRL9d87OWPwM2j1Gog8Wn3K6Gs3Zdk+4VIZINskBPsZX+Ean14VOVkd
         ymdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzD007SepSnMiB+4oN3wChUsiGs5s/TJZks5gS7AgmU=;
        b=y6zkTPSgBOFnRbaHd3+exj9OwRzG6TlCbfc/oS1Kzm86V4SjC4b1ZsuuyCsnFDscF0
         ygtMh97lan4MvMWZWfEAxxMjqtF12JbOQausE8aw460xcDOyj+LH+SZjsv/2woaZbt5Z
         eyM9uwimIc5v/lc/hStRsmuGkQm9MlpVqzGZ8Jiy+nvLnY67RFOqii3thBaX0jmhu78U
         ZfBl7xLj4RhIof3LqSOa7dTmweSlX2vBHL6Sju+X7JPois9X+SZ2rGPSBiEk2EN5v9Rj
         uO+qVf4OYpadwd99dvZhfTL0QcNm0so8zoPXwXzfJPOLySkz3r6qajXQANl0rKrwJnr7
         QBDg==
X-Gm-Message-State: ACrzQf0jMLRRJrFhlFUe/Xc4PQb0rDOqerAiXjocHhdHSAnAQQG7yGA9
        aNWeA7S6YBUrNHZ9Lnn6KNGuAK+UBIwtoBTA
X-Google-Smtp-Source: AMsMyM5zblZ29L2BqvMSd071VtOnhPva/SHomONGw1W4CvHvkPIdB9RgLQPSDpRnmt4IjR2D6I5vvg==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr14468961plx.157.1667224203978;
        Mon, 31 Oct 2022 06:50:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x13-20020aa79a4d000000b0056bcf0dd175sm4605974pfj.215.2022.10.31.06.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 06:50:03 -0700 (PDT)
Message-ID: <17887101-31f3-fc60-0971-4718c9f6f3b3@kernel.dk>
Date:   Mon, 31 Oct 2022 07:50:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/7] block: drop the duplicate check in elv_register
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20221030100714.876891-1-hch@lst.de>
 <20221030100714.876891-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221030100714.876891-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/22 4:07 AM, Christoph Hellwig wrote:
> We have less than a handful of elevators, and if someone adds a duplicate
> one it simply will never be found but other be harmless.

That isn't quite parseable...

> diff --git a/block/elevator.c b/block/elevator.c
> index d26aa787e29f0..ef9af17293ffb 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -545,13 +545,7 @@ int elv_register(struct elevator_type *e)
>  			return -ENOMEM;
>  	}
>  
> -	/* register, don't allow duplicate names */
>  	spin_lock(&elv_list_lock);
> -	if (elevator_find(e->elevator_name, 0)) {
> -		spin_unlock(&elv_list_lock);
> -		kmem_cache_destroy(e->icq_cache);
> -		return -EBUSY;
> -	}
>  	list_add_tail(&e->list, &elv_list);
>  	spin_unlock(&elv_list_lock);

What's the idea behind this? Yes it'll be harmless and list ordering
will dictate which one will be found, leaving the other(s) dead, but why
not catch this upfront? I agree likelihood of this ever happening to be
tiny, but seems like a good idea to catch and return BUSY for this case.

-- 
Jens Axboe
