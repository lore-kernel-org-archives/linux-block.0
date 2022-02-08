Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A90EC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 22:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354944AbiBHWnq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355496AbiBHWnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 17:43:41 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D28C03E920
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 14:26:41 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id y9so486683pjf.1
        for <linux-block@vger.kernel.org>; Tue, 08 Feb 2022 14:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6fPfiGd24JzmlajWvkJlznSEszSJCJjAYwLhn5BSKcE=;
        b=znI6IeBQSbRD/pbDdB1vSxfZpA5lKSC6dcI1QiInzq3KA5G9wRS9euJ+1PKIbCFZXG
         oy3q2KgcU7o+VMcMTJiCDKZquiyXh6RpYsghjOoQCdvKr9ry0Rr9ye+fJpAt/KcA2mJc
         TLfpe2BO4URM2OfzTNbVVAtDqHb9Ip8L+HRrif0eXXH0vS6D2C4DAUEOEFnAou7DA2BU
         0rhu4ENVyZexi0YzNAdV3L4XDZgW20UjHmgzuFDLoI1pL76qD+BJI+Jd44jKCKKOwVkm
         CES9i7URRrvhMiM6ASs6uuRPT+dqydmEmOfjHGfkhyAHcIbuBDBD7EAa4j8z2gdslY1l
         hD7w==
X-Gm-Message-State: AOAM530xKCrZzrZpoBRLsX/iL+gd6gdezjMammy7AyrDGfyBkcvt2HvL
        dxoMkj6MIxv6ToAOUoNi3Ko=
X-Google-Smtp-Source: ABdhPJyZntv91nr4i3SneFqdn2f5Z+mdFKG1SKEZoUaaJWjprCYFIr/SqpeZZZLRA9Mg7vo0qN05Mw==
X-Received: by 2002:a17:90b:3ec8:: with SMTP id rm8mr106046pjb.207.1644359201079;
        Tue, 08 Feb 2022 14:26:41 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y12sm17626548pfa.132.2022.02.08.14.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 14:26:40 -0800 (PST)
Message-ID: <d32088fb-2423-b7c7-9184-ebb184ec95e8@acm.org>
Date:   Tue, 8 Feb 2022 14:26:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dwagner@suse.de, osandov@fb.com, linux-block@vger.kernel.org
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <caa2ba82-b3e8-6d5a-d411-241eb147f697@acm.org>
 <YgLe2GXJW2vqFZc5@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YgLe2GXJW2vqFZc5@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/22 13:21, Luis Chamberlain wrote:
> On Mon, Feb 07, 2022 at 05:10:24PM -0800, Bart Van Assche wrote:
>> On 11/16/21 09:29, Luis Chamberlain wrote:
>>> +	if [[ -f /sys/module/$module/refcnt ]]; then
>>
>> Has this patch been analyzed with 'make check'? I expect checkpatch to
>> complain about missing double quotes for the above statement.
> 
> No, I was not aware this was a thing. I fixed all the stupid complaints
> however I should note at least tests/srp/rc has existing complaints
> before my changes. I won't address those.

Please consider opening a pull request for the 
https://github.com/osandov/blktests repository. That will cause the 
blktests presubmit tests to be run. See also .github/workflows/ci.yml in 
the blktests source code.

> I can't say I agree with the changes to remove checks for $?, but
> whatever. Consinstancy is better than not having one. Perhaps we should
> embrace this on fstests as well.

+1

> No, I'll clarify to this:
> 
> # Tries to wait patiently to remove a module by ensuring first
> # the refcnt is 0 and then trying to remove the module over and over
> # again within the time allowed

Looks better to me :-)

>>>    	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
>>>    			 target_core_file target_core_stgt target_core_user \
>>>    			 target_core_mod
>>> -	do
>>> -		unload_module $m 10 || return $?
>>> -	done
>>> +	_patient_rmmod $m || return $1
>>
>> Please proofread your changes and test your changes before posting these. I
>> think that both "do" and "done" should have been preserved above.
> 
> And the return value shoudl be $? not $1. I couldn't test srp so wanted
> someone who would to help review, but sure, I should have caught this.

Hmm ... the SRP tests can be run inside a virtual machine so it is not 
clear to me what prevents to run these tests?

Thanks,

Bart.
