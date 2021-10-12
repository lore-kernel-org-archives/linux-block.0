Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB76C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6A60EDF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhJLSfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:35:00 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:45585 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhJLSe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:34:59 -0400
Received: by mail-pj1-f41.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so320752pjb.4
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1dkrn+QuOTA/8+ORPIR4vBF+qmk/S3ZZmrtZJVJlFlA=;
        b=eUFd6yx19Bdv3/mytL5G/u/4PPCo2sF2zsAijSwUGRKIQSgXjBP9PqNsqIwaPacrPj
         qEYhDjet0y+gmGfivR9RFbgtwQqbiGSQplvgFySijIsZxkWmqZj+nZ/VydEbZWEYM9f8
         q4bWS9drfXk9hsWv9gO3ZSXibyi1eUo0UjI8T8odsAvDxIkxALezunTKBhY/A7IV92CM
         A1jYa5RFuKDh63ckWtWOdHXnCdmn4yFhly3D5oYdkYxe+AQoNfn6PFC/v1YH7bVODb/K
         jU39W2PwsomHARrLRWTt2l0+4MG2aMmwxrp2ev2Eh4GIqg0PmPbN/H434pUZjZyyMPSa
         1ezg==
X-Gm-Message-State: AOAM531XSUSwDF0UYcGNXUSEd1HzZJnkehIboQo3lN6J8XiEDCR++5cY
        GGmDmaB4cxuDGlEVC8m/dCHR2ai4E/c=
X-Google-Smtp-Source: ABdhPJziUE9JALVyXUQ4n0vcdDP67Hzzu3EHaAoLJ2SefHTqKswDK+B9OG8H8QOUwsfp/WMiuSF/Yw==
X-Received: by 2002:a17:90b:354a:: with SMTP id lt10mr8029111pjb.3.1634063563603;
        Tue, 12 Oct 2021 11:32:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id t126sm3668530pfc.80.2021.10.12.11.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:32:43 -0700 (PDT)
Subject: Re: [PATCH 4/9] block: add support for blk_mq_end_request_batch()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-5-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7bba1955-75e9-0146-7556-2e5c50dad7d1@acm.org>
Date:   Tue, 12 Oct 2021 11:32:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012181742.672391-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 11:17 AM, Jens Axboe wrote:
> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *array, int nr_tags)
> +{
> +	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
> +					array, nr_tags);
> +}

How about changing the name of the 'array' argument into 'tag_array' to 
make it more clear what the argument represents?

Thanks,

Bart.
