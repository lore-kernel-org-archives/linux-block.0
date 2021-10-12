Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D69C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A9E60EDF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJLS1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:27:11 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42527 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhJLS1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:27:10 -0400
Received: by mail-pg1-f171.google.com with SMTP id 66so14624921pgc.9
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/5mWNMNJSp+AOaNd9awH15+6MYhAsCJ8rcLuMhutfQ=;
        b=FkkPyIPWNTWmG9arOZbnky5xWqYpc/qaVfG0UpJ3v14fbPbC55RTCe0X2kAsO6HDdD
         xQjlTMyXeSS8xRbfrBA2XDyZ+HiTpoRr72UvIgz+Q/AebJC2qKlrWqtZxFSE2lyLa/1F
         UiJ2CaW2jTNAoMLYq8TRD4RjkeoMni+x1YtERXWPKD+1JLuo/ROXoqNQK4kmVDe2V4Xy
         Mfwf6xZcnJU8iuyfe3CrPOTougKPgHSPe1KJD80voRC5hlmJKEfJoy+W07+jFRkJ2xHP
         4ek9QrjQkE/4OLOkr9VyNXzV3OwzWRZwtftCdiojlRZcOEIGc0n6WkK6tz8/gpUhJf7t
         5HBw==
X-Gm-Message-State: AOAM530W7AE45AmMm8PRcu69IWLPGIdlKUDOelsBumoqxv4GH+0ogNkB
        mk2UbdMDUuDPDVpTRIlAjJyxdbnWOLk=
X-Google-Smtp-Source: ABdhPJw7mV2lTxX+4WpR0WrSYQZi0XBNDfFTe7h3yA3mya+XaQkMnLFm4sSY9fGLP2zMFYjm+ReVRg==
X-Received: by 2002:a63:e116:: with SMTP id z22mr23496308pgh.223.1634063105851;
        Tue, 12 Oct 2021 11:25:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id v12sm3627625pjs.0.2021.10.12.11.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:25:05 -0700 (PDT)
Subject: Re: [PATCH 1/9] block: add a struct io_batch argument to
 fops->iopoll()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-2-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e98ae0de-1e0b-7b69-09c5-ce1cc54866a8@acm.org>
Date:   Tue, 12 Oct 2021 11:25:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012181742.672391-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 11:17 AM, Jens Axboe wrote:
> -int bio_poll(struct bio *bio, unsigned int flags)
> +int bio_poll(struct bio *bio, struct io_batch *ib, unsigned int flags)
>   {

How about using the name 'iob' instead of 'ib' for the io_batch 
argument? When I saw the 'ib' argument name that name made me wonder for 
a second whether it is perhaps related to InfiniBand.

> +struct io_batch {
> +	struct request *req_list;
> +	void (*complete)(struct io_batch *);
> +};

Function pointers are not ideal in high-performance code. Is there 
another solution than introducing a new function pointer?

Thanks,

Bart.
