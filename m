Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4380FECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 13:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiHaNiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiHaNiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 09:38:00 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEABD2B5
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 06:37:57 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id h1so7379674wmd.3
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 06:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JbpcG0pFac/dIKIt2+psRiQAYsJAMXYfnXL802Il8TU=;
        b=RXvq43rc7YPwHl855COyY0G5lEf1L8dxI31vQatjCp1owhqTSmDpZCQuRQV+/TLGoX
         dcR3Ah+k1S6XOWKs3ckdrD2v5YUExvhUL1jgvLPRZBVe9fTTQjf9Yu5nv1CzaDBVT7o6
         aaBKom5d8fQ9VzcEXDGDnT/51E/E6KWQvVobn/2kQjLPkVzlr/OSxySgsyVZ54MkQNEi
         qbMExzKGRVebVH1hyqpfeNDuoDCkTJiRpLN3H2nkMivEJA3lZI169E3/bIdSFuYm31na
         KQNp016CXFRBmxRytBQwMB7RxinP3HNWb54PAEua2iswmxqC11O1Qq4icGRj/Z1KKiGs
         GrXA==
X-Gm-Message-State: ACgBeo1QFy7nApGHRYIPnHQqU2rlx+ow+YqF+I05iwBglBGJxeEPQzbm
        26C/pR7qtwl4Wnd/GwoeVxXjNEsWck0=
X-Google-Smtp-Source: AA6agR7iKvfpMfy1pedaKAsrCEt8n5Nc/L2FICfpMiRFgtMLT11fEstkPzyVc7v2qgFzrWLkncjwTw==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id j25-20020a05600c1c1900b003a5a3c73800mr2106827wms.69.1661953075624;
        Wed, 31 Aug 2022 06:37:55 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b0021efc75914esm12328211wrr.79.2022.08.31.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:37:54 -0700 (PDT)
Message-ID: <89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me>
Date:   Wed, 31 Aug 2022 16:37:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Hannes Reinecke <hare@suse.de>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
 <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
In-Reply-To: <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/31/22 16:32, Sagi Grimberg wrote:
> 
>> Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
>> module. When the module is built as a loadable module, the test cases
>> fail since the module is not loaded at test case runs.
>>
>> To avoid the failures, load the dh_generic module at the preparation
>> step of the test cases. Also unload it at test end for clean up.
>>
>> Reported-by: Sagi Grimberg <sagi@grimberg.me>
>> Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for 
>> authenticated connections")
>> Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
>> Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Link: 
>> https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/ 
>>
>> ---
>>   tests/nvme/043 | 4 ++++
>>   tests/nvme/044 | 4 ++++
>>   tests/nvme/045 | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/tests/nvme/043 b/tests/nvme/043
>> index 381ae75..dbe9d3f 100755
>> --- a/tests/nvme/043
>> +++ b/tests/nvme/043
>> @@ -40,6 +40,8 @@ test() {
>>       _setup_nvmet
>> +    modprobe -q dh_generic
>> +
>>       truncate -s 512M "${file_path}"
>>       _create_nvmet_subsystem "${subsys_name}" "${file_path}"
>> @@ -88,5 +90,7 @@ test() {
>>       rm "${file_path}"
>> +    modprobe -qr dh_generic
> 
> You should not do this, dh_generic might have been
> loaded unrelated to this test, you shouldn't just
> blindly unload it.

btw, even failing with a reasonable error message is fine rather
than loading dh_generic, the problem is that now it will fail the test
in a way that. requires to open the code in order to understand what 
happened.

Perhaps the original commit is better...
