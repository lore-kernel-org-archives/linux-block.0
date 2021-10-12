Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB248C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A5260295
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJLQwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:52:16 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34637 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJLQwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:52:15 -0400
Received: by mail-pf1-f182.google.com with SMTP id g14so91336pfm.1
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyFv6DRp7mj/TLzrQIpVommdcoXtzdvra+rup/vPgR4=;
        b=YuTtsd16Mmc92E8dVHeXdUtp85Fp2KzkODATclVi98JKeLJMEiNQBeTP8kkiVNjhM6
         JrFiQxcpOvX1OiZ52K/MeMOfnnzlMJmloB/7SlnC1bs+E57z2NZBP8PPuzX8hsraw0fA
         lsP5HGe/zHYnKK6aZb2gPBZ4z+TVQk3VvI0Rv/KVdhf28t+rm5fQqpvdNjfDAWL1+HcZ
         Hzt8l8nFQAjaiS4zTYlrNjFpCrT/LxyfXcdS+BkVPuR3d7LIU/tfXMNjB4nMj/k8BfZc
         TJfikNZAQLF4+WGX4IY2lXHmSN92cfYUNJSVYLTrV86DNDMrbo34LbQKZoczCCR6C0sR
         LmHg==
X-Gm-Message-State: AOAM531qf9qPMac1LemuaCTiH7Ys7hgegWmVo7bPIQevJTuKxC3bFZho
        ESzHexHA+Unv5XZaOJ1TzKE=
X-Google-Smtp-Source: ABdhPJwTpBGjULlYiKlbOfc5N6o7DtsijNW+l2r5Ip5ZBV/isIjOmuv6AyEfJPmCNZ7NpziTdyvuTA==
X-Received: by 2002:a05:6a00:26dd:b0:44d:2531:9f46 with SMTP id p29-20020a056a0026dd00b0044d25319f46mr10473312pfw.46.1634057413516;
        Tue, 12 Oct 2021 09:50:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id k22sm3734836pji.2.2021.10.12.09.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 09:50:12 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 1/5] block: factor out a chunk_size_left helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>
References: <20211012163613.994933-1-hch@lst.de>
 <20211012163613.994933-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d5273d1f-dbf1-8921-b03d-0f61d08dbfdc@acm.org>
Date:   Tue, 12 Oct 2021 09:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012163613.994933-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 9:36 AM, Christoph Hellwig wrote:
> +/*
> + * Return how much of the chunk sectors is left to be used for an I/O at the
> + * given offset.
> + */
> +static inline unsigned int chunk_size_left(sector_t offset,
> +		unsigned int chunk_sectors)
> +{
> +	if (unlikely(!is_power_of_2(chunk_sectors)))
> +		return chunk_sectors - sector_div(offset, chunk_sectors);
> +	return chunk_sectors - (offset & (chunk_sectors - 1));
> +}

No "blk_" prefix for the function name? I think most other functions 
declared or defined in this header file have such a prefix.

Thanks,

Bart.
