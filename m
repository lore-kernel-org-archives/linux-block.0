Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFDECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiH3N1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiH3N1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:27:00 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE618A6AD1
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:26:46 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso6141275wmb.2
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zQxbCXG01Qvb3BtvrymBoUiMedeZJvELFPv8dZYnP74=;
        b=0pcVhzxsjOl7easdgA1RZfYcnqq8GEthBvwOrAO0cmgWHain50u5RQaO8qFTRjnoXk
         IIJV/l5DqyrJzfscJd/j0se7cgCGSW2911XICK/stwjCwNoJO7hluJWbhn45kBQMYHSV
         DTNXwAX0xcle7B4WjIXrfJoEGXY0WnTltUD/T6wQd6FYekoEMyrB6DTgwI/Js+C42UjF
         TfCtSTR9D8vf802HKUGMrNXH3BhpgWNAk8HO8fJ+j9ewEdXiCvAso+ygRaPpOlWyGNEl
         sC0owBuuLgOw60+CG1xj68wYXUcw6MHrEZte5OnHxWOTncFRZgLNUCrrGLfg4jU4eVrs
         LChg==
X-Gm-Message-State: ACgBeo08aOQu68UMQ+03eTe7qGXHia4aVxkbcNpSrlI55inuOaOQsqBw
        1RkLVt2HCXneqMncHtGSgu2hNePs3Gc=
X-Google-Smtp-Source: AA6agR6X4HcsJAi+hUWO7TTyNoO6Mk1pXCbji4Sk2MXQOwBLni+N5wBknafR+02LYgIr8Oj8YB8ZgQ==
X-Received: by 2002:a1c:4c03:0:b0:3a5:d65c:c1e7 with SMTP id z3-20020a1c4c03000000b003a5d65cc1e7mr10054436wmf.4.1661865977761;
        Tue, 30 Aug 2022 06:26:17 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c510600b003a5de95b105sm10696248wms.41.2022.08.30.06.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:26:09 -0700 (PDT)
Message-ID: <a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me>
Date:   Tue, 30 Aug 2022 16:26:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <20220830102357.yahkv5qfr2ewa7uh@shindev>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830102357.yahkv5qfr2ewa7uh@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>
>>> Hi Sagi,
>>>
>>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>    tests/nvme/043 | 1 +
>>>>    tests/nvme/044 | 1 +
>>>>    tests/nvme/045 | 1 +
>>>>    3 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>>> index 381ae755f140..87273e5b414d 100755
>>>> --- a/tests/nvme/043
>>>> +++ b/tests/nvme/043
>>>> @@ -16,6 +16,7 @@ requires() {
>>>>    	_have_kernel_option NVME_TARGET_AUTH
>>>>    	_require_nvme_trtype_is_fabrics
>>>>    	_require_nvme_cli_auth
>>>> +	_have_driver dh_generic
>>>>    }
>>>
>>> Do you see failure without this check?
>>
>> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).
> 
> Thanks. I was able to recreate the failure setting CONFIG_CRYPTO_DH=m.
> 
> Unfortunately, your patch does not avoid the failure after the recent commit
> 06a0ba866d90 ("common/rc: avoid module load in _have_driver()"). As the commit
> title says, _have_driver no longer has the side-effect to leave the dh_generic
> module loaded. Instead, I suggest to load dh_generic in the test() function:
> 
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 381ae75..dbe9d3f 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -40,6 +40,8 @@ test() {
> 
>          _setup_nvmet
> 
> +       modprobe -q dh_generic
> +
>          truncate -s 512M "${file_path}"
> 
>          _create_nvmet_subsystem "${subsys_name}" "${file_path}"
> @@ -88,5 +90,7 @@ test() {
> 
>          rm "${file_path}"
> 
> +       modprobe -qr dh_generic
> +
>          echo "Test complete"
>   }
> 

That's fine with me, can you prepare an alternative patch for it?
