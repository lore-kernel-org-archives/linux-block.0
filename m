Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E63C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 21:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiGOVcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGOVci (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 17:32:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C880480
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 14:32:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso7366150pjo.0
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ESan9JBmRokIZHcl3xO2oQu/yLuGmLntw5PPB729yuE=;
        b=noo704f8mSs/qVYaE8jN+WxPasbir+fSLLjfDYmjxXB3mRTjQciOhaNH0MLTATfQ3p
         tsz81HvqFoe1o/XZDn7JiMENk6vpsz9WSyGoBluR7G1G2j7rYvSjgnqxRDfKDcT9tNVv
         UR03bucAfDQQtEp963FnmZz0FVof5GdJsrSWo3NE8HLz7KkorM63SkEElyMYS3ogLeqh
         TCFJC7RwMAApK91x+Qai/1UjSh1RsT0SGTVnFABUf2TUrpDHyjvr8DuTZv7rNf7QFNuY
         jCCXRncwlWbm6KueNqteYwvzuV7WMcClXPA13fjv86zqKN2yzKTTbcJu7EJIOqP+EEJA
         tq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESan9JBmRokIZHcl3xO2oQu/yLuGmLntw5PPB729yuE=;
        b=6ymc6oNxwWW0/bq98cRD1jP8ettpBax3yT2nO80Hcuvk850375AkDpWi5EY95hZCFx
         tU5LJyebwFkFFz7LO1jCUUrBw7xRQQHh8/3GE0+LhFu4VHMcTnptUJgnXS3VUBnB2c/Z
         9mnbaaVXPgfScXxnCKIQs3uYBGSNu5IcmfVTLGKieJe0GbkxwwXGV5sKdksghiVvmydR
         kaGdnUNt8dm3mwdKwHX9U8IkH2GhKYNfn8r0oQ5cvGC6Bs5nV9X6FjeQoiySRFTXTT/n
         NxIQ1A2lurskKEc4p4X0SYVafd3Wch4BOgJRA5nAIAJxuov8+80Zy41J4GXv7y2uSZD0
         uIaQ==
X-Gm-Message-State: AJIora/Kjz6PbtOAu5KqLq2EJHuWb3StMR0Vg5hFavi4aV5n8FWFR3uV
        HnGOOqnPPOHC9zzWu2Xu+bnbbw==
X-Google-Smtp-Source: AGRyM1uazsESb2FdRADBB9x052XegnOHXqVck2P43LgHiqV6DSc2FTXLWWFTWvKwKAugfS1uHWw9lA==
X-Received: by 2002:a17:90b:1a8c:b0:1ef:c1b2:b2cd with SMTP id ng12-20020a17090b1a8c00b001efc1b2b2cdmr18265028pjb.190.1657920756898;
        Fri, 15 Jul 2022 14:32:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bd3-20020a656e03000000b00419a6f3c8f5sm3577260pgb.19.2022.07.15.14.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:32:36 -0700 (PDT)
Message-ID: <da03fb01-83e6-974e-d273-ce86c770e5b2@kernel.dk>
Date:   Fri, 15 Jul 2022 15:32:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
 <1b220ed8-c010-15f2-3bc2-6ec4b2e7532f@schaufler-ca.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1b220ed8-c010-15f2-3bc2-6ec4b2e7532f@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/22 3:16 PM, Casey Schaufler wrote:
> On 7/15/2022 1:00 PM, Jens Axboe wrote:
>> I agree that it should've been part of the initial series. As mentioned
>> above, I wasn't much apart of that earlier discussion in the series, and
>> hence missed that it was missing. And as also mentioned, LSM isn't much
>> on my radar as nobody I know uses it.
> 
> There are well over 6 Billion systems deployed in the wild that use LSM.
> Every Android device. Every Samsung TV, camera and watch. Chromebooks.
> Data centers. AWS. HPC. Statistically, a system that does not use LSM is
> extremely rare. The only systems that *don't* use LSM are the ones hand
> configured by Linux developers for their own use.

I'm not talking about systems that only I use, but I believe you that
it's in wide use. Didn't mean to imply that it isn't, just that since I
don't come across it in my work or the people/systems that I've worked
with, it hasn't been much on my radar and nobody has asked for it.

>>  This will cause oversights, even
>> if they are unfortunate. My point is just that no ill intent should be
>> assumed here.
> 
> I see no ill intent. And io_uring addresses an important issue.
> It just needs to work for the majority of Linux systems, not just
> the few that don't use LSM.

Agree, and hopefully we can make sure that it does, going forward as
well.

-- 
Jens Axboe

