Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31DC00140
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiHSBD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHSBD2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 21:03:28 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95102EE3D
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 18:03:27 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id p9so1947942pfq.13
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 18:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=THbMKVQ++d/XtPe8gCXA7BXrNLNHtSIzUlAL9lDbMek=;
        b=BLD+RTdvGmcC0wXpbE1EdMn3RPUYsFRbv/+iVq7DhUEhvrQNOewzizcNHZzCeYtsHH
         Ki9MFkyvoRmd9Lf/r0j2cC44Uqo90c96+PMvkjdBxryLZ8CSR926mik2vicLuHcjkFgd
         YBSoKTlauAHH/uOmYDs/eifU55A04p7yU5R+vcvuT+dz0U+FmyWy4eW3Ay0qzp8kAVxZ
         W8ktOSU01Mzl2H3FE/Ka5GJcsXhWDaMYHmRXeqkEYPKWDi1mwHY9zuzSRAzyNGimICFR
         oIhiXV9Amd5s63XCx2vTfNA86nsBigRBlCBJyM7SCt5JdTQEWP13sBOWT+NZwQ8vIhj7
         fkSw==
X-Gm-Message-State: ACgBeo3iNz7ASw9RBKTNoT/smdYCyxkttp8sp6NY1+HStlmVkWpU56cd
        KCSzW+ztZNGVtup9zLzBikd3XDtdTEY=
X-Google-Smtp-Source: AA6agR6HxhKT8+mkYgnYQ138rzrMue2mX8tJ10naTUt98XUJ108LWlXbvpW3iTie0ruTkftYzSuQtg==
X-Received: by 2002:a63:1ce:0:b0:41a:f362:8708 with SMTP id 197-20020a6301ce000000b0041af3628708mr4379602pgb.571.1660871006842;
        Thu, 18 Aug 2022 18:03:26 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u38-20020a632366000000b0041c30f78fa6sm1809845pgm.69.2022.08.18.18.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 18:03:26 -0700 (PDT)
Message-ID: <d810fd8e-6c49-1ef4-e84a-ee12f209d91b@acm.org>
Date:   Thu, 18 Aug 2022 18:03:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
 <e17212c6-d7dc-514e-e51d-ac818863a80c@gmail.com>
 <20220819003451.jqkmwbzdyqhw2t47@shindev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220819003451.jqkmwbzdyqhw2t47@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/22 17:34, Shinichiro Kawasaki wrote:
> On Aug 18, 2022 / 13:02, Bart Van Assche wrote:
>> On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
>>> The helper function _have_driver() checks availability of the specified
>>> driver, or module, regardless whether it is loadable or not. When the
>>> driver is loadable, it loads the module for checking, but does not
>>> unload it. This makes following test cases fail.
>>>
>>> Such failure happens when nvmeof-mp test group is executed after nvme
>>> test group with tcp transport. _have_driver() for tcp transport loads
>>> nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
>>> nvmet module but it fails because of dependency to the nvmet-tcp module.
>>>
>>> To avoid the failure, do not load module in _have_driver() using -n
>>> dry run option of the modprobe command. While at it, fix a minor problem
>>> of modname '-' replacement. Currently, only the first '-' in modname is
>>> replaced with '_'. Replace all '-'s.
>>>
>>> Fixes: e9645877fbf0 ("common: add a helper if a driver is available")
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    common/rc | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 01df6fa..8150fee 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -30,9 +30,10 @@ _have_root() {
>>>    _have_driver()
>>>    {
>>> -	local modname="${1/-/_}"
>>> +	local modname="${1//-/_}"
>>> -	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
>>> +	if [[ ! -d "/sys/module/${modname}" ]] &&
>>> +		   ! modprobe -qn "${modname}"; then
>>>    		SKIP_REASONS+=("driver ${modname} is not available")
>>>    		return 1
>>>    	fi
>>
>> There are two (unrelated?) changes in this patch but only one change has
>> been explained in the patch description :-(
> 
> Hi Bart, thanks for the review. Regarding the local modname="${1//-/_}" change,
> I explained it at the very end of the patch description with one sentence.
> However, I admit that it was unclear and confusing. Will separate it to another
> patch in v3.

Hi Shinichiro,

In my comment I was referring to the other change :-)

(changing [ ... ] into [[ ... ]]).

Best regards,

Bart.


