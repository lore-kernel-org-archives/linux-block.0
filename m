Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0806C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB35D61205
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJUMhp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhJUMhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 08:37:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F0C06161C;
        Thu, 21 Oct 2021 05:35:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x192so384297lff.12;
        Thu, 21 Oct 2021 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=djL1u8g2d1mzvxl7mcP/d2ka8TxkLu44HSU+KH0/+KU=;
        b=BGwQzsa/KoBGHlx9Q4qeFljfwXl3n9uXuSL18M8XNihfPAi5f3K9F+KhymS9lf/XfK
         gx+8a3geIEylLBS8Vh6Oze2MWGp1Y6ALa0QDFB2Zmg90IO8WLGiThm2KgVlNpGScGIQr
         +OqftyNs2Rc0k0cVXtMXEpBRYQc+lDeWkZZIdqICgRF6BvwJMCvA3UvduWwEqJbZsNop
         Xodl5pEUeh7q4eu1akP9q5138DD59hf2Xj27X9yMRu37xbewq0BiZYmV+Dra8UUTwM9W
         Sx5HFBt0hJJpFwxsYPMYXTS0yYlvpuV1eBzQK6t8toUjtq2Ob1R4zMighq+Dpca/KB/n
         e98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=djL1u8g2d1mzvxl7mcP/d2ka8TxkLu44HSU+KH0/+KU=;
        b=YPpfHiLqP5CrK581aztzC6k01rnqPbf1Aa10MInsbFkYVcdgDE8A6Wu/FLJl4GyvZV
         9xS7SEwvUTChn1YZzW9jAlb8VUfS9g6mZ2I2aP34ug6dDt6r5pUrzKKCsOBxwZCaLwl4
         1BIgqRioTHuE/nKkLqKM+LL269ZGfdl50aRzg1hr1QpbxSuzhKzOcOZPj/mDtokyWp1u
         ROb3KLE79pzQGbNe5WaUpCzAJ25Qu9tSGilC4nz64+TmC+IfNne0SEC4PAXov9wtu2nt
         umL67prEjEFdAakOsvUn3E0L6tmzagDnqvEC7flOicymyZ5bbjBBVYHwvjk7HkfZMENA
         3vOw==
X-Gm-Message-State: AOAM530MvJO0IKYmWqvviRquokCjHEjJkA4HrTLgYOG8+3pMEFC+Db92
        OLvJgM9/RKeH43Tv9sr3c0g=
X-Google-Smtp-Source: ABdhPJwT4vVVC8Giu0b7GadMQnCCCvxsfpCJxfvQ942Xcd//Y/8HTezqBL6s9POmO8LRNuN8p26zzQ==
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr5329525lfu.524.1634819727348;
        Thu, 21 Oct 2021 05:35:27 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.181])
        by smtp.gmail.com with ESMTPSA id b10sm545150ljo.14.2021.10.21.05.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 05:35:26 -0700 (PDT)
Message-ID: <72fb140d-609b-c035-bdd6-d2b8639c116b@gmail.com>
Date:   Thu, 21 Oct 2021 15:35:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/2] nbd: fix sanity check for first_minor
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        luomeng12@huawei.com, Christoph Hellwig <hch@lst.de>
References: <20211021122936.758221-1-yukuai3@huawei.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211021122936.758221-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 15:29, Yu Kuai wrote:
> Yu Kuai (2):
>    nbd: fix max value for 'first_minor'
>    nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
> 
>   drivers/block/nbd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Hi, Yu!

Thank you for the fix, but this wrong check should be just removed, 
since root case of wrong sysfs file creation was fixed, as Christoph 
said [1]




[1] https://lore.kernel.org/lkml/20211011073556.GA10735@lst.de/



With regards,
Pavel Skripkin
