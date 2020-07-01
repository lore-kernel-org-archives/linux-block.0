Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE6C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFD920771
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uK7iH2hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgGARVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGARVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 13:21:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC31C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 10:21:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d194so8663562pga.13
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1vC3E+MLYsLNplhpDprmDKhQTnhrPn5rlIWFLB9TJE=;
        b=uK7iH2hmxR3/dcpQatFru7JoMk1Ge2su3ktrLG/PgToaVW8x7c4rymwOT8ILM05DRx
         Tn9qyfdRIt/KAiCL1CiVeXzg94+fnv9uYiRxeQlP/Vb4HcqJ1qIKlMaG3SN7Ja68rL0o
         yPZV9pik1dip7RkwMkUZmK9a/fgderF2vmbvPSH6aw2YJy7nKQ0NAmBdw8kBDv08D0rF
         JLkEIBb9NdvWDDrRUszsR5gRlbHtkH0ezlgeYBPOFfTe3YrmT7ECcMUOpvRlgnlaRXt8
         A+ZO4KMG7XiZhfUIw+qgX3p8QEYG/Z5fJjNK5hwtx1XIpAfe+uRBFK2lQBszLOYHMtIl
         rLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1vC3E+MLYsLNplhpDprmDKhQTnhrPn5rlIWFLB9TJE=;
        b=T0Hk+6CkfCr+YuSQVgQUhptwQWeCAYkOq+Ogi8ErEdC/jFtjZnt9pTzQ4CFAOoY9g5
         9HmOlefdfhkha3YzgKzV6fOg31B0WnudH4j0JbUzIk4KXDFFKpySh83SwJ/AhtapUQ/v
         +HEdCJSXojpdZX4W6yrgk2ca1gIYeQwVcyAHsMt4afynbIX8ZaitcQsM5BHFjfKiibBx
         D2ZclS7cq4aAC4yWNeUt6rU7r58w3Sn2IhVCBnQ/XpUqbAArATTMJQ2P0Bl9dpRc9ZMO
         OBt7TosgSvn/BhUvcMtbekQQhhmoDo3M1IIe6sBGy7OvwMLxvHPbdJI5jifrCGPa+Cgi
         l8NQ==
X-Gm-Message-State: AOAM532pwRIlcMRm47ilGHSR+8yaMUVmx8FWBBAogWFBRusI8wsmhRGX
        F3OximjIJwLFM54jTbB+VyN0Hg==
X-Google-Smtp-Source: ABdhPJyzM1c4Hj4uYoojYPNqHdrIu3VXSdDm13k3NvCbjfMh5cJ5EZJFCllBMgJeQ+Apv7/t17nsGw==
X-Received: by 2002:a63:af50:: with SMTP id s16mr21712160pgo.365.1593624097147;
        Wed, 01 Jul 2020 10:21:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ab5a:d4e:a03a:d89? ([2605:e000:100e:8c61:ab5a:d4e:a03a:d89])
        by smtp.gmail.com with ESMTPSA id az13sm4833248pjb.34.2020.07.01.10.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:21:36 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e8=2e0-rc2-c698ae9=2ecki_=28block=29?=
To:     Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
Cc:     Xiong Zhou <xzhou@redhat.com>
References: <cki.6F69C04B6D.Z70BF8WNV2@redhat.com>
 <8388a5c5-e5b9-e17b-1522-cf742bb23ad9@redhat.com>
 <a856bc99-eece-f56c-dc79-0ba37979f3dd@kernel.dk>
 <3248254e-ef26-7de1-c814-7cb23dd4fc55@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e16e3e9d-33b2-2b44-3c41-6b04db9b10e0@kernel.dk>
Date:   Wed, 1 Jul 2020 11:21:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3248254e-ef26-7de1-c814-7cb23dd4fc55@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 11:16 AM, Rachel Sibley wrote:
> 
> 
> On 7/1/20 12:42 PM, Jens Axboe wrote:
>> On 7/1/20 10:37 AM, Rachel Sibley wrote:
>>> Hi, we're seeing multiple panics across all arches, I included a snippet of the call trace for both
>>> xfstests and boot test.
>>>
>>> You should be able to inspect in more detail by viewing the console.log under each build/tests directory:
>>> https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/06/30/609250
>>
>> This was due to a bad patch series, which since got reverted and redone. Current
>> tree should be fine.
>>
>> Now it doesn't matter for this one since I guessed what this was and found it
>> before the bot did, but I do wish the reports were easier to look at. I should
>> not have to dig through directories (which were empty when the report went out,
> 
> Sorry about that we noticed this right after we sent the report and
> worked quickly to resolve it on our end, the logs are now accessible
> in the external artifacts location.

I was probably just too quick, but if we can fix the below, then it'd
work much nicer and the logs would just be a secondary resource.

>> btw) to find logs, then download logs and leaf through hundreds of kb of text
>> to find out why the bot thought the tree was broken. It should be readily
>> apparent and in the email. If there's an OOPS, include the oops.
> 
> Agreed, this is also something we'd like to do and we have an
> outstanding ticket to work on it.  I'll follow up and see if we can
> move this along quicker to make it easier to find it in the reports.

Thanks, that would be a massive improvement! The OOPS is really the key
thing here, and then I think it's fine to have to dig in
logs/directories to find other related information. Sometimes you just
know what it is just by seeing the OOPS.

-- 
Jens Axboe

