Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20389C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0503060E08
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJYPhk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhJYPhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 11:37:39 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875CC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 08:35:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so15426626otl.11
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=quJ6z0klqcE1F4iwPCMpVhkIsicWuzlD6pey4xATdYY=;
        b=2lwKnUBzJbr8old9qoFjRXMSu967SRav3jDkWwdNJ6HluBSM8FwVHZ2HYCDZ9Bd1Jn
         RRwi2ABlXZpYVRsBBcTXs2NOtjdwS2mhd3gJ+SouQg5Hvh94ZWez+eQMCR43HZ8fZ7Zs
         1I33M7WW3KCM9Qmp3Oq/sbGsws93vBmLI8P5UYTNDh/qBgY1FJhcyqr3ztV2h0YM1HOT
         zjKomY30OvAzxDN8bEW9UgRd8JYE3LLMweTk0UVBgu0jIke8QoD4O5Bk9FQCsceYvj/Y
         2VYr/et/Z1rUlRwYeDrZnsfcZoouUV7wNRIT5wAx5w86LNvLHQuVdGjITmPADDs7YOre
         6qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quJ6z0klqcE1F4iwPCMpVhkIsicWuzlD6pey4xATdYY=;
        b=Q2RK4h3SVJlfKp5BarhCFWYn9rx50PUqCCRTykz4jLQuDWG2NCs1017SZvpj6hfcRd
         OH27SE0Ak9vl7p7CarRsPjKyLofl4h9GMdrKCreGilKJ6cy8DG09Dn4+jnnwW7XJk8qT
         oduA17JB4yo0RKBcwnZp4dvlJ3W8vy+jbImkbnf8MpP76gMbCFcg/e/63mHMV7eXBqsm
         jr2y+CfO05C7EjYv391Ku6HlOmZTRlhdOQOce0rdvNOldQtWikYVepqqC4nkeeuIl/hA
         7bMlatjvcQAjPpT7EBJlJtbEG7nkJGVPlpsnD+qAyGgHRi50dwXNrh1Ld2Zv81BklI0/
         V3lQ==
X-Gm-Message-State: AOAM533ChLTQWI4qesUlal8lWaj2D96tLIiQCDNBEhCY+zDfPLs9cVJV
        MO/vCHP25JBS88F0IVo94/wG9A==
X-Google-Smtp-Source: ABdhPJwPQgvpAEs23u2Zaeves8Mm8qJQLAU96dq2aYo4Ahu2K6FQwjTqBDJj4a+zXr5QiCzFnlopWw==
X-Received: by 2002:a9d:3e0e:: with SMTP id a14mr13495939otd.277.1635176117017;
        Mon, 25 Oct 2021 08:35:17 -0700 (PDT)
Received: from ?IPv6:2600:380:602d:d087:5bee:e9ee:c67d:4ccf? ([2600:380:602d:d087:5bee:e9ee:c67d:4ccf])
        by smtp.gmail.com with ESMTPSA id o21sm3060078oou.21.2021.10.25.08.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:35:16 -0700 (PDT)
Subject: Re: [bug report] Compiling failed on latest linux-block/for-next
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     asml.silence@gmail.com
References: <CAHj4cs-Q7eLbrch63sQozd5p6jt2CaJLy2wywDNWA0=fUGHREQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9dc8ed7-2097-14d5-ab5d-9a5fb59fc0b3@kernel.dk>
Date:   Mon, 25 Oct 2021 09:35:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-Q7eLbrch63sQozd5p6jt2CaJLy2wywDNWA0=fUGHREQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 9:26 AM, Yi Zhang wrote:
> Hi Jens
> Compiling the latest linux-block/for-next failed, pls check below log:
> 
> ca20d946ed42 (HEAD, origin/for-next, for-next) Merge branch
> 'for-5.16/block' into for-next
> fa5fa8ec6077 block: refactor bio_iov_bvec_set()
> 54a88eb838d3 block: add single bio async direct IO helper
> 
> [root@fedora kernel]# make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   CHK     kernel/kheaders_data.tar.xz
>   CC      block/fops.o
> block/fops.c: In function ‘blkdev_bio_end_io_async’:
> block/fops.c:321:9: error: too many arguments to function ‘iocb->ki_complete’
>   321 |         iocb->ki_complete(iocb, ret, 0);
>       |         ^~~~
> make[1]: *** [scripts/Makefile.build:277: block/fops.o] Error 1
> make: *** [Makefile:1869: block] Error 2

Fixed, thanks.

-- 
Jens Axboe

