Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E637C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 12:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1148122CEC
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 12:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KkX1YSy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393371AbfHWM6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:58:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389430AbfHWM6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 08:58:21 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so19896897iog.0
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I00VSte5pro9MFfzs2ZQvPdVMUipipTiKgGdaBQKoYg=;
        b=KkX1YSy1spowJhMf4nt0sS1GiG9wl1Q/GtwqzhvA+wzcUwnn6/e17yBU4MbSJcIHOy
         TOg41CBRFgHRWxFx277frT5pYUFsK/XSr0xG9rGNORnNA/A07aDh5EkfKjuI3nSTLVIm
         eEhrzj3JxNoyXWs1BsKM5lCoIPotLbRTAzIba93o9kNAjADe5iOrQ2uggSeyAMNjdUx4
         SreYR97yZnHYESaj9uH6IAFtPAb2x815/c9oxTRU55zQBpfuLSpiExPvHs3zyY0BKvH1
         er0APdcyCo1bbLQQRjIVLVSe66/dtfv+AbejchaNtpIn6e9R5a6Sqm31JnvKJG/k+Stk
         jErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I00VSte5pro9MFfzs2ZQvPdVMUipipTiKgGdaBQKoYg=;
        b=N+GnfY1484LfuqWvcH+Bxatf9T51k98ahEwEeUuDWHYQxEgBAA2dGKXlLym+g11TW4
         6kxZxJYXtmO/TMshg26PXlT+Vk+U/JB8fTZEWRVxKlqhCV2u/oPEpiQ21aZ9sgdNdbn0
         U51ZwpS+5akkAUv7DYqorkX5nmSxp/QvbVN2AdAVf+3S2i1VLpCtjP0gqk20O5RnmYDQ
         BnFnoVIaZh2CZ2MaSxryLOOdMwG3FNM8R4/ZBC8cqoJEZ+ThKANNihBCw2kpSn1vgUiR
         gvCHnmWkCxnPggE9muUdowSCmUu3JXNe+0pYttctgXY+IfrMkVMtt0auaKnBhlY5aPjf
         K0kA==
X-Gm-Message-State: APjAAAXs5X73jCsAy5Y9XEmdSMUBT6vB0yGvxAtluo0vd99Jgml9rzuX
        LnhGJOzG16DvBWLqqrsjkhjq9A==
X-Google-Smtp-Source: APXvYqzQQ287n5s/HXH6WQvjjD6bvAz1vCdp2m4qyBppgdxouyxbAymX4x1UAYbSB8TdilJWk20gJA==
X-Received: by 2002:a02:9988:: with SMTP id a8mr4809673jal.127.1566565100208;
        Fri, 23 Aug 2019 05:58:20 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d6sm3272892iod.17.2019.08.23.05.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 05:58:19 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] null_blk: simplify null_handle_cmd()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     hch@lst.de
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49e1b4d0-c5ef-8054-e387-b7c1cedf5070@kernel.dk>
Date:   Fri, 23 Aug 2019 06:58:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/22/19 10:45 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> The core function where we handle the request null_handle_cmd() in the
> null_blk does various things based on how null_blk is configured :-
> 
> 1. Handle throttling.
> 2. Handle badblocks.
> 3. Handle Memory backed device operations.
> 4. Handle Zoned Block device operations.
> 5. Completion of the requests.
> 
> With all the above functionality present in the one function,
> null_handle_cmd() is growing and becoming unreasonably lengthy when
> we want to add more features such as new Zone requests which is being
> worked on (See [1], [2]).
> 
> This is a cleanup patch-series which refactors the code in the
> null_handle_cmd(). We create a clear interface for each of the above
> mentioned functionality which leads to having null_handle_cmd() more
> clear and easy to manage with future changes. Please have a look at
> NVMe PCIe Driver (nvme_queue_rq()) (See [3]) which has a similar code
> structure and nicely structured code for doing various things such as
> setting up commands, mapping of the block layer requests, mapping
> PRPs/SGLs, handling integrity requests and finally submitting the
> NVMe Command etc.
> 
> With this patch-series we fix the following issues with the current
> code :-
> 
> 1. Get rid of the multiple nesting levels (> 2).
> 2. Easy to read, debug and extend the code for specific feature.
> 3. Get rid of the various line foldings which are there in the code
>     due to multiple level of nesting under if conditions.
> 4. Precise definition for the null_handle_cmd() and clear error
>     handling as helpers are responsible for handling errors.
> 
> Regards,
> Chaitanya
> 
> [1] https://www.spinics.net/lists/linux-block/msg41884.html
> [2] https://www.spinics.net/lists/linux-block/msg41883.html
> [3] https://github.com/torvalds/linux/blob/master/drivers/nvme/host/pci.c
> 
> * Changes from V3:-
> 1. Rename nullb_handle_cmd_completion () -> nullb_complete_cmd().
> 2. Move null_handle_zoned() to null_blk_zoned.c and adjust rest of the
>     code in null_blk_zoned.c.
> 3. Fixed the bug in null_handle_cmd() for REQ_OP_ZONE_RESET_ALL.
> 
> * Changes from V2:-
> 1. Adjust the code to latest upstream code.
> 
> * Changes from V1:-
> 1. Move bio vs req code into the callers for the null_handle_cmd() and
>     add required arguments to simplify the code in the same function.
> 2. Get rid of the extra braces for the null_handle_zoned().
> 3. Get rid of the multiple returns style and the goto.
> 4. For throttling, code keep the check in the caller.
> 5. Add uniform code format for setting the cmd->error in the
>     null_handle_cmd() and make required code changes so that each
>     feature specific function will return blk_status_t value.
> 
> Chaitanya Kulkarni (6):
>    null_blk: move duplicate code to callers
>    null_blk: create a helper for throttling
>    null_blk: create a helper for badblocks
>    null_blk: create a helper for mem-backed ops
>    null_blk: create a helper for zoned devices
>    null_blk: create a helper for req completion
> 
>   drivers/block/null_blk.h       |  13 +--
>   drivers/block/null_blk_main.c  | 162 +++++++++++++++++----------------
>   drivers/block/null_blk_zoned.c |  38 +++++---
>   3 files changed, 115 insertions(+), 98 deletions(-)

Applied, thanks.

-- 
Jens Axboe

