Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F72ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiH3HiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiH3HiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 03:38:02 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A8BCC1F
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 00:37:55 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso674634wmr.3
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 00:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZFPWfeE0yXbuggxT46Q1b3hKokdSGBesKVyjgo3kSI0=;
        b=p4GWIe3ClPnYwHU2JpaUC/ITUOGnIQL+8lqwpSDixEWVYByvJElbmy74bV/O9UGkSg
         hvtn4YAYBCagSU9lGo9hDmvdwRngam0S6cVWJa3uh/URN9lhjBV+0kY/S66gmT7CUBlx
         hZpEPHUF0SEA/Mk81tWRu6SQ41+HExRiRImlQ9DDVn9GT9qu3rACg09v2J0kV2Hc6apn
         jiu5pG+hjNUWOVHXCoMc9CNSV86VPzZub8zvtS7uLWNJbxqlxSqCCBuNUaOiZwoI/Vux
         WqmS18FRWtiO05Rt/xlgCOFI/bpOwd4CiOiK4lEOZV43F6dEZI2yKzPnmKxfmPcTJ3ba
         PVCA==
X-Gm-Message-State: ACgBeo3BdShkVcdEWhWI6PvyP0ndo9rZxmRMqPCxTPZpKqGRbvpBCMyn
        mzVUZMleOgzLbNpQX7+YBE8aKrtZouA=
X-Google-Smtp-Source: AA6agR7yr/iKDu9FRAb7cd/Ze89ntvZQiON0HT1xlo7cCAA880Gh1sOFpkqDauFDQFCGGJ71TPQlhw==
X-Received: by 2002:a1c:7518:0:b0:3a5:1681:b175 with SMTP id o24-20020a1c7518000000b003a51681b175mr8434130wmc.139.1661845073389;
        Tue, 30 Aug 2022 00:37:53 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003a845621c5bsm6474356wmq.34.2022.08.30.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:37:52 -0700 (PDT)
Message-ID: <9e623544-8954-4b62-e97c-d5917fb43937@grimberg.me>
Date:   Tue, 30 Aug 2022 10:37:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To:     Jackie Liu <liu.yun@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi.
> 
> 在 2022/8/30 15:05, Sagi Grimberg 写道:
>>
>>> Hi Sagi,
>>>
>>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>   tests/nvme/043 | 1 +
>>>>   tests/nvme/044 | 1 +
>>>>   tests/nvme/045 | 1 +
>>>>   3 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>>> index 381ae755f140..87273e5b414d 100755
>>>> --- a/tests/nvme/043
>>>> +++ b/tests/nvme/043
>>>> @@ -16,6 +16,7 @@ requires() {
>>>>       _have_kernel_option NVME_TARGET_AUTH
>>>>       _require_nvme_trtype_is_fabrics
>>>>       _require_nvme_cli_auth
>>>> +    _have_driver dh_generic
>>>>   }
>>>
>>> Do you see failure without this check?
>>
>> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).
> 
> Maybe I don't understand correctly, but I think when NVME_AUTH=y
> CONFIG_CRYPTO_DH can only be built in.
> 

No.

In my .config:
--
...
#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support
...
#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set
--
