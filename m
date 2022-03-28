Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC40C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiC1SKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbiC1SKO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 14:10:14 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB625C5D
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 11:08:32 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Ytn3nPJkzuvBOYtn4nO2Vz; Mon, 28 Mar 2022 20:08:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 28 Mar 2022 20:08:30 +0200
X-ME-IP: 90.126.236.122
Message-ID: <ee7a2afd-f9ec-9ed2-1920-c1e605fbab39@wanadoo.fr>
Date:   Mon, 28 Mar 2022 20:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] null_blk: Update ida_simple_get()/ida_simple_remove()
 to the newer ida API
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <876904b8334049a3be89d8bd278b04a421601baa.1648406899.git.christophe.jaillet@wanadoo.fr>
 <0e758e026fae17eaaae7a5d918cce3490e476a2e.1648406899.git.christophe.jaillet@wanadoo.fr>
 <5AC28FBB-D03E-4C01-A2DD-AED52A403216@nvidia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <5AC28FBB-D03E-4C01-A2DD-AED52A403216@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Le 28/03/2022 à 05:00, Chaitanya Kulkarni a écrit :
> 
>> On Mar 27, 2022, at 11:48 AM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>>
>> ﻿ida_simple_get() and ida_simple_remove() are deprecated. Use ida_alloc()
>> and ida_free() instead. It is less verbose.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
> 
> I have alredy sent out patch for this....
> 
> 
Hi,

I was not aware of it...

Do you plan to send patches for all ida_xxx() changes that are needed 
all over the kernel or is it only limited to 
'drivers/block/null_blk/main.c'?

(read: should I spend time on it, or is the phasing out of this 
deprecated API is already on the todo list of someone)

CJ
