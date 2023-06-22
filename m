Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248BEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 21:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjFVVz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFVVz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 17:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3AFC3
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 14:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6616C61917
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFCDC433C0;
        Thu, 22 Jun 2023 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470925;
        bh=ROJhyty9eG5kw3hs7ycxjkiOrD4fN70TwutJ+pvh9UA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a8nO6tujIZWcHUPXspmX6Q2Y9TRwyopWqye6B/x4i8No1HUd4YBfunNtcq4E8RnP6
         pcbYsnz4z3TCJBZVUulAn0vYNfuK5s0OkrBgiFPQynKHmGawWVEhpX+ev/wXKJiq2F
         tsuRPwDOe0gK4j/PW5srSqVCIkWVtnNiUodeHjsABlvi3HxPTmzwMQdjJ8azatlfrr
         W1AFbXGRMSmLko4rUuRJ5yW0xW77DxykWYlH9OEUTh9W6w2klB68z8AEzOF9WuVw8z
         AjL3hNzgwyHfUza1BqqLNxzmeu5jB03NhsF8Nxxti+iuj1agRjULcefNzrknn/D2XS
         2imFqBSl+W0WQ==
Message-ID: <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
Date:   Fri, 23 Jun 2023 06:55:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: virtio-blk: Fix handling of zone append command
 completion
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sam Li <faithilikerun@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <20230620083857.611153-1-dlemoal@kernel.org>
 <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 23:32, Suwan Kim wrote:
> On Tue, Jun 20, 2023 at 5:39 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> The introduction of completion batching with commit 07b679f70d73
>> ("virtio-blk: support completion batching for the IRQ path") overlloked
>> handling correctly the completion of zone append operations, which
>> require an update of the request __sector field, as is done in
>> virtblk_request_done(): the function virtblk_complete_batch() only
>> executes virtblk_unmap_data() and virtblk_cleanup_cmd() without doing
>> this update. This causes problems with zone append operations, e.g.
>> zonefs complains about invalid zone append locations.
>>
> 
> Hi Damien Le Moal,
> 
> Unfortunately, this commit was reverted due to io hang.
> (afd384f0dbea2229fd11159efb86a5b41051c4a9)
> You can see the mail thread at the block layer mailing list.

There is no commit afd384f0dbea2229fd11159efb86a5b41051c4a9 in Linus tree. What
patch are you talking about ? Where is it ?

> We don't have a solution about io hang yet..
> So I have one question.
> Is there any possibility of virtblk-driver io hang on zoned devices
> without this patch?

If you are talking about the batch completion support being reverted, then my
fix patch is not necessary. The issue I fixed is not about IO hang but the fact
that completion processing was not identical for batch case vs non batch. That
led to breakage of the zone append command completion. The original support for
zone append without batch completion is fine.

> 
> Regards,
> Suwan Kim

-- 
Damien Le Moal
Western Digital Research

