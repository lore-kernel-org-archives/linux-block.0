Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6EAEE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 02:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjHUCYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 22:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjHUCYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 22:24:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B3A0
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:24:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf095e1becso4906165ad.1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692584650; x=1693189450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IivehogIoi9Md/FylLzljxApwR9pYjJ92eLhkXeG5a8=;
        b=d0oTDzXljdb9JvWFIpyGQP/rR/1Qyvz0u0MaHe2o8xYyojoIXPjxhmhCX6+g1ccxDI
         ILdcvewDMD/WbHL8jfAL9i6PEtu730TxK3zmzjZ83465fJbzqmoeh5nsw2kB7fKglmJj
         n1sBeg+UriEROrAmRk4KlcnlKdK7rP0Xbq/FLXtHAz+DEFLZXSUZQm+JckAN9Zw0lpKT
         JO1haw2L9t3h3DVHpUWeLBmgdJk6nedW9sSkJ/zMaNnzdCkhdG6P6fCDeKSNFdsRZD1d
         DhWYM2V5ZZBLxO5LBeRWyEfePLxzs5Y9MSaEr4NgnQnS8uNIRWc/AFCRmbIEa+mnPNRM
         6trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692584650; x=1693189450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IivehogIoi9Md/FylLzljxApwR9pYjJ92eLhkXeG5a8=;
        b=SKJQUL6wiyXfi43OClXVKZZNuzHmqxsw2W6WWUo1UTLGYuRGBXtozBahTZ5cruHNU9
         7kcP7TEpVF7vWMutZOWh+jFe1sE7ya+Xr0x7/VQZqyvykNx0r/sNTEqWJWfXEZzcrqW7
         uZw0cxiQ8m3cidXzSbQi2p8bC1FsjUmnyY5iUxOLeFeepwlq/qmclH/j44mlE6DGt9o1
         z0UXgHMC7kwhOiQ3oq7xPQsWQmnCxyHs77n5GfyKkspP364VqADoGG89kF3sGejEwbiH
         o2BD8knjkEBii/UmheqwbeEkP+lJX98ub+bhKMlmC3ZcIxSdUlhrZbxQKOOnYo07cAR1
         C4vw==
X-Gm-Message-State: AOJu0Yy+v1qQm11siWzPWdfehHU4vPJPAKBLBbjTiKplf/JJWBh4VBwA
        xc4J6/W2C8Y1EbeqxWrCECHKJA==
X-Google-Smtp-Source: AGHT+IFdNH/nGlfnM++czpUjJJE0JVU7t2pvLOqWx/YO0OksF6nVyt3uJ2BIPyoK8JPZKL4rQZu6AA==
X-Received: by 2002:a05:6a00:f0f:b0:687:95ad:d8dd with SMTP id cr15-20020a056a000f0f00b0068795add8ddmr6678769pfb.0.1692584650671;
        Sun, 20 Aug 2023 19:24:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w19-20020aa78593000000b006828e49c04csm5014938pfn.75.2023.08.20.19.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 19:24:10 -0700 (PDT)
Message-ID: <de877c10-6f39-46c8-a2f5-8b3076a18b78@kernel.dk>
Date:   Sun, 20 Aug 2023 20:24:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at
 block/mq-deadline.c:679 dd_exit_sched+0xd5/0xe0
Content-Language: en-US
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
 <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk>
 <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/23 8:17 PM, Changhui Zhong wrote:
> On Mon, Aug 21, 2023 at 9:56?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/20/23 7:43 PM, Changhui Zhong wrote:
>>> Hello,
>>>
>>> triggered below warning issue with branch 'block-6.5',
>>
>> What sha? Please always include that in bug reports, people don't know
>> when you pulled it.
>>
> 
> ok,I pulled the whole branch of block-6.5, I don't know which patch
> caused the issue?the HEAD is?
> "
> INFO: HEAD of cloned kernel
> /mnt/tests/kernel/distribution/upstream-kernel/install/kernel
> /mnt/tests/kernel/distribution/upstream-kernel/install
> /mnt/tests/kernel/distribution/upstream-kernel/install
> commit cc7de17e2fe6b778a836032e7e5f9991dec40a25

That's what I suspected, I think you'll have better luck with the
current branch (or 6.5-rc7, which has it included). This was an issue
with an earlier version of a patch in block-6.5, which is why the sha is
important. The sha is always important...

-- 
Jens Axboe

