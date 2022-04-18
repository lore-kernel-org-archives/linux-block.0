Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0970C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 16:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiDRQly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbiDRQlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 12:41:49 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369A32075
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 09:39:09 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id s17so1931046plg.9
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 09:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pGo9sy2WfBMcvwYS15AcY4wsEQghRrO+9A8algaK7ss=;
        b=wfanEBkF9CGf1TWIG1uHXACfH4kEdmJuaY8ksKQ3i43xRGXwG0AWMBvBLqC5G1surP
         vXh3RGvVZQXGB3QD49d3h80p16JY5L2rXn3vXjAvd4SHsiHNrQgYqGho3XGSUUh7dO+s
         FNgbW2j+qi0+zhMDarMTlhkhr2MG0qbWa0VTSBhTXHikoY8ujxs8YJQLsuDXcEsmCQ4D
         eHKfiv698mDw5NpbwqB6fYFvqT3o/8v4kOY281i7cFa+hqDr4scepeNsp3wyTWZ8diB9
         AODhJjWKiLp7YU40H5zmMIBIFd1JVDQ82YzlHxfhCUhvaKEPBWS67vyZNbVKoAPRwFUJ
         NVwQ==
X-Gm-Message-State: AOAM533cYekqluSH/v+JhdAG1b36N50/NMTx8mjPHDXOZE+qrJFJi6XY
        HqhBF79z6C4zssvmhKDzu8g=
X-Google-Smtp-Source: ABdhPJwlIZY73JCEJ1JxS6dl3uWAHAwMpGs1Ol5ypl2yq2ifrpxsOiitVVsQsxli/+haGqAhykW8Ow==
X-Received: by 2002:a17:902:9881:b0:158:f258:c3c3 with SMTP id s1-20020a170902988100b00158f258c3c3mr9084182plp.7.1650299949186;
        Mon, 18 Apr 2022 09:39:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:713b:40eb:c240:d568? ([2620:15c:211:201:713b:40eb:c240:d568])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a294600b001cba3274bd0sm17065502pjf.28.2022.04.18.09.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:39:08 -0700 (PDT)
Message-ID: <1293a7e7-71d0-117e-1a4f-8ccfc609bc43@acm.org>
Date:   Mon, 18 Apr 2022 09:39:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
 <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
 <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 08:57, Luis Chamberlain wrote:
> On Fri, Apr 15, 2022 at 09:01:03PM -0700, Bart Van Assche wrote:
>> On 4/15/22 18:49, Luis Chamberlain wrote:
>>> -	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
>>> -	if [[ "${nvme_trtype}" != "loop" ]]; then
>>> -		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
>>> -	fi
>>> -	modprobe -r nvmet 2>/dev/null
>>> +	if [[ "${nvme_trtype}" == "loop" ]]; then
>>> +		_patient_rmmod nvme_"${nvme_trtype}"
>>> +        else
>>> +                _patient_rmmod nvme-"${nvme_trtype}"
>>> +                _patient_rmmod nvmet-"${nvme_trtype}"
>>> +        fi
>>> +	_patient_rmmod nvmet 2>/dev/null
>>
>> The statement _patient_rmmod nvme-"${nvme_trtype}" occurs twice in the above
>> code. How about preserving the structure of the existing code such that that
>> statement only occurs once?
> 
> There is one call for nvme-"${nvme_trtype}", the other is for the
> underscore version, so there are no two calls.
> 
> Did I miss something?

It's only now that I see the underscore/hyphen difference in the if and else
branches. It is not clear to me why this behavior change has been introduced?
The following command produces no output on my test setup:

find /lib/modules -name 'nvme_*'

>>>    # Unload the SRP initiator driver.
>>>    stop_srp_ini() {
>>> -	local i
>>> -
>>>    	log_out
>>> -	for ((i=40;i>=0;i--)); do
>>> -		remove_mpath_devs || return $?
>>> -		unload_module ib_srp >/dev/null 2>&1 && break
>>> -		sleep 1
>>> -	done
>>> -	if [ -e /sys/module/ib_srp ]; then
>>> -		echo "Error: unloading kernel module ib_srp failed"
>>> -		return 1
>>> -	fi
>>> -	unload_module scsi_transport_srp || return $?
>>> +	remove_mpath_devs || return $?
>>> +	_patient_rmmod ib_srp || return 1
>>> +	_patient_rmmod scsi_transport_srp || return $?
>>>    }
>>
>> Removing the loop from around remove_mpath_devs is wrong. It is important
>> that that loop is preserved.
> 
> Why ? Can you test and verify?

If I remember correctly I put remove_mpath_devs call inside the loop because
multipathd keeps running while the loop is ongoing and hence can modify paths
while the loop is running.

Thanks,

Bart.
