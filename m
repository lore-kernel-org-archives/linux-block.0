Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F30C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F2E61A18
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhCXWLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhCXWKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 18:10:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B157C06174A
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 15:10:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so89027wmf.5
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l5hiPcILc59My4uy+f5n0afhsWZ4TICl3w8e8gkfUxw=;
        b=YzCyeqfv3tnIIRCKNERKVmWRyqZ7LDLWtuM4xwolho0wj1cr4SW1MpO2Tff88US8Qf
         ChEYg2AFXEMMi3+L+c3sylSI+Nt6Y9NPu7sDYbgzetYe9KAdFe0czq9+SmMLbxT+3/jt
         9ftWNRcmSqnGa2+WU2wsMPIT50GDdKLitH6kFPOBPacY7sZDhsFKNU1o+pSV5icynx/E
         CLdp5VtuuiRpdH5xa18OA2+qDiiG4J9MQncVYaD8jf9h7gCO1qdHBLvJ1JAohGvk5EOo
         cr37KHdKWthc/iM2sTLc5ov5rqSSfcJliCS455gV2EBeV4Tvl2wRa7V0Zo8b7A9pqAl4
         0WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l5hiPcILc59My4uy+f5n0afhsWZ4TICl3w8e8gkfUxw=;
        b=Y4EO0KHMEiYShJqtDtoJkWm6b9onxIlWyaKqtpHfQTxh1A7yASnT2qjmFvNk7p1MaK
         de/rbOOD/uZVcUSwpLY6p53w6v79rwS9HaFLPa5iNkebUYX8oqg+6KyJ6PpelcHy0+Xs
         w0YdwhPO/eLa8E4N6xR2i4QCM4BmRfiK9SWFJEWEhTyQzdQlvXyeRfe5yqhX99HVtnT9
         E6hMJYKcncCNgGGU+giv68bCniC5XB+W5tTib+PPhIuRiGvw6VZwUHAA8AH8JITeLx62
         g/KizCcaSOXrFvw0CurWGo+OVg+dPE4AmPQuWyJhnc/qyCgLdxWcs4pTlGEbgZHgkxsw
         SIuA==
X-Gm-Message-State: AOAM532JkKvfC7TulB9RGhYe5eDF4wpahN4M2kdudRIS30easfDkm8ML
        4wh1FeZSK93EB55Yz/QpVg==
X-Google-Smtp-Source: ABdhPJz/TYNqK9m5ZB4v15gn9YLQWUq+SqLsQXpi0E0JXzD8UIqA+TjJf9BDxd8K/FNg4hIYjrVEKg==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr5011450wmb.12.1616623849227;
        Wed, 24 Mar 2021 15:10:49 -0700 (PDT)
Received: from localhost (220.red-83-38-250.dynamicip.rima-tde.net. [83.38.250.220])
        by smtp.gmail.com with ESMTPSA id x13sm4825873wrt.75.2021.03.24.15.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:10:48 -0700 (PDT)
Subject: Re: [RFC] iosched: add cfq -> bfq alias
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        BLOCK ML <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <7962131d-12c5-0862-483f-e8873cac8ba0@gmail.com>
 <20210307192634.xdq52ntb2sxc34mh@spock.localdomain>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Message-ID: <6dc9784e-9eb3-6f99-9200-7f39a91fc180@gmail.com>
Date:   Wed, 24 Mar 2021 23:10:47 +0100
MIME-Version: 1.0
In-Reply-To: <20210307192634.xdq52ntb2sxc34mh@spock.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/21 8:26 PM, Oleksandr Natalenko wrote:

> Hmmm NACK.
> 
> CFQ and BFQ are completely different beasts.
> 
> If you are going to tune BFQ to match old CFQ behaviour (somehow; I
> don't know why one would do this, how one would do this and whether it
> is possible at all), you for sure have enough time to fix your old udev
> rules and scripts.
> 
> If you are just tolerating default BFQ behaviour, you should explicitly
> acknowledge it by amending your rules and scripts. For personal systems
> this is not a big deal. For enterprise systems you better do it NOW so
> that another person that comes to work on those systems in 10 years
> after you resign knows what and why was done.
> 
> If you are just lazy (no offence! I don't know your real intention
> here), I'm not sure we are going to hide such an indifference behind
> another aliasing kludge.
> 
> Thanks.
> 

You are writing a lot, and say nothing.

bfq is the natural choice coming from cfq. There is NO other option.

Still waiting... for a valid *technical* response against my change.

Or do you prefer to apply the below patch?.


---cortamorena---
 From 714f04d823085a1aebbdc66dad2344c2aee9fdf3 Mon Sep 17 00:00:00 2001
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Date: Wed, 24 Mar 2021 22:30:46 +0100
Subject: [PATCH] Revert "mq-deadline: add 'deadline' as a name alias"
X-Patchwork-Bot: notify

This reverts commit 4d740bc9f0319229410d11e445017f47e425dbe0.

_commit 4d740bc9f0319229410d11e445017f47e425dbe0
_Author: Jens Axboe <axboe@kernel.dk>
_Date:   Wed Oct 25 09:47:20 2017 -0600

     _mq-deadline: add 'deadline' as a name alias

     _The scheduler framework now supports looking up the appropriate
     _scheduler with the {name,mq} tupple. We can register mq-deadline
     _with the alias of 'deadline', so that switching to 'deadline'
     _will do the right thing based on the type of driver attached to
     _it.

     _Reviewed-by: Omar Sandoval <osandov@fb.com>
     _Signed-off-by: Jens Axboe <axboe@kernel.dk>

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: BLOCK ML <linux-block@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
  block/mq-deadline.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f3631a287466..91c9757451b3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -795,7 +795,6 @@ static struct elevator_type mq_deadline = {
  #endif
  	.elevator_attrs = deadline_attrs,
  	.elevator_name = "mq-deadline",
-	.elevator_alias = "deadline",
  	.elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
  	.elevator_owner = THIS_MODULE,
  };
-- 
2.30.2
---fin---


Thank you.
