Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1060C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9457C6113A
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFS0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:26:45 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37588 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhJFS0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 14:26:44 -0400
Received: by mail-pf1-f177.google.com with SMTP id q19so2633024pfl.4
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LRcczqyoNgImBavLZ822epL9I5cMyTahTT7ML8sNUt0=;
        b=4bMu+D+b0LUmR0ca4O9t91Gic0HvvMUPbmFYEnOdftpOoOXcjhCwBuJ5GLh5PKUPaD
         fimflMsn7THZHB7h4VR9b4WDTOh1RQS08UsEaxOGO0OfgwDwu3Td0PZWt6uM1WebrNkR
         Z6GdGgYxa8W4kxotsQq5+QI7y2HcnOAhxQlxZfb0k6ZaGryliQuiGf3YIVhvMc/xBW4d
         JlQ6lILZ7V5ht+JbjCtEtw2gCClpVMcsekEMsQ+5D+6RL1VfUxhJ18fsYONLhnmrS1vW
         UKp244OPtR4hNaEW3xlW23Ky0/9gl03Zx57Ta0aMyZQRmUUfD1jHjPGviqQcHDQsXci6
         GWVw==
X-Gm-Message-State: AOAM532Jf+2qNCKipykSwiQIRCwS/wgaFtmtTyPrh0gqoNT6VVNsT1UG
        EfJswxS6XVdP3jDDG9X3KFV+PGNjlV0=
X-Google-Smtp-Source: ABdhPJzuOQhMfB08gt7ua7KxdH75WzVh8IblmsgqnoRyaoyBTjS0+pVGHAqs4uPtB3ZqxOkcFdPlvg==
X-Received: by 2002:a05:6a00:1801:b0:44c:aab8:a5ba with SMTP id y1-20020a056a00180100b0044caab8a5bamr3296528pfa.32.1633544691398;
        Wed, 06 Oct 2021 11:24:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6ad6:c36f:fdfb:9e74])
        by smtp.gmail.com with ESMTPSA id u1sm5738637pju.2.2021.10.06.11.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 11:24:48 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: pre-allocate requests if plug is started and
 is a batch
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211006163522.450882-1-axboe@kernel.dk>
 <20211006163522.450882-3-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bf1418a7-127d-dbd7-6fef-6351bfe2abe4@acm.org>
Date:   Wed, 6 Oct 2021 11:24:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211006163522.450882-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/21 9:35 AM, Jens Axboe wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 3b967053e9f5..4b2006ec8bf2 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -22,6 +22,7 @@ struct bio_crypt_ctx;
>   
>   struct block_device {
>   	sector_t		bd_start_sect;
> +	sector_t		bd_nr_sectors;
>   	struct disk_stats __percpu *bd_stats;
>   	unsigned long		bd_stamp;
>   	bool			bd_read_only;	/* read-only policy */

Hmm ... I can't find any code in this patch that sets bd_nr_sectors? Did 
I perhaps overlook something?

Thanks,

Bart.
