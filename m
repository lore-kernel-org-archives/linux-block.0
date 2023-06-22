Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1178BEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFVXdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFVXdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 19:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6192A2103
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 16:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D4061901
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 23:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3423C433C0;
        Thu, 22 Jun 2023 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687476789;
        bh=aa/fLV44+3j80+G0RvSf5PqukVEsR32UVg23rerXGmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oyMEWdh3GfmPIRKKB+0lgE5B5Hvze8/R1tQUc9tw8WD6zDwgxFGkgprnA0Ewc/Qq7
         in9TDhuzRKYVJFunygOOsMXlw0keyIwvWh2EDYS19MkvBmTXYia+hErfaQlnPkgQxC
         XdCy01L/NF90vtjLNekUwEHm+x1RktYtjin83oWbbpXtezYu5V4lYUzX0h7NT4Q1qA
         5GD6fRlaN91quk/BkIB/R68AaMmcIMqSiIP0xaeJXVc7iozKtvdAFmsMFJbtY3KZIC
         hhyzp1eDRYam7wHpKo8a+06hbCJPzYOUw6DYhFGcx6QG51napvZjDIGoLKV5AYWhVY
         IovTP0raNbhzQ==
Message-ID: <a092280f-964a-3ee8-a591-e01dcce5eef3@kernel.org>
Date:   Fri, 23 Jun 2023 08:33:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: virtio-blk: Fix handling of zone append command
 completion
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sam Li <faithilikerun@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <20230620083857.611153-1-dlemoal@kernel.org>
 <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
 <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
 <20230622181558-mutt-send-email-mst@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230622181558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/23 07:19, Michael S. Tsirkin wrote:
> On Fri, Jun 23, 2023 at 06:55:24AM +0900, Damien Le Moal wrote:
>> On 6/22/23 23:32, Suwan Kim wrote:
>>> On Tue, Jun 20, 2023 at 5:39 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>>>
>>>> The introduction of completion batching with commit 07b679f70d73
>>>> ("virtio-blk: support completion batching for the IRQ path") overlloked
>>>> handling correctly the completion of zone append operations, which
>>>> require an update of the request __sector field, as is done in
>>>> virtblk_request_done(): the function virtblk_complete_batch() only
>>>> executes virtblk_unmap_data() and virtblk_cleanup_cmd() without doing
>>>> this update. This causes problems with zone append operations, e.g.
>>>> zonefs complains about invalid zone append locations.
>>>>
>>>
>>> Hi Damien Le Moal,
>>>
>>> Unfortunately, this commit was reverted due to io hang.
>>> (afd384f0dbea2229fd11159efb86a5b41051c4a9)
>>> You can see the mail thread at the block layer mailing list.
>>
>> There is no commit afd384f0dbea2229fd11159efb86a5b41051c4a9 in Linus tree. What
>> patch are you talking about ? Where is it ?
> 
> Either you didn't check recently enough, or  there's some
> breakage and your CDN's not updating. If the later try
> poking kernel.org admins.
> 
> This is the commit:
> 
> commit afd384f0dbea2229fd11159efb86a5b41051c4a9
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Thu Jun 8 17:42:53 2023 -0400
> 
>     Revert "virtio-blk: support completion batching for the IRQ path"
> 
> you can get the patch from lore too:
>     Message-Id: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>

Yep. Got it after pulling from Linus master. Should have done that first :)

>>> We don't have a solution about io hang yet..
>>> So I have one question.
>>> Is there any possibility of virtblk-driver io hang on zoned devices
>>> without this patch?
>>
>> If you are talking about the batch completion support being reverted, then my
>> fix patch is not necessary. The issue I fixed is not about IO hang but the fact
>> that completion processing was not identical for batch case vs non batch. That
>> led to breakage of the zone append command completion. The original support for
>> zone append without batch completion is fine.
> 
> Yes that's great! I expect we'll reapply the batch completion
> down the road and then your patch would help!

OK, Thanks !

-- 
Damien Le Moal
Western Digital Research

