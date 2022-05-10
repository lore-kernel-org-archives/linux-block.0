Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B502C433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 23:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiEJXse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 19:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiEJXsd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 19:48:33 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBD606DB
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 16:48:32 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id bo5so509291pfb.4
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 16:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3v+p0mkjcjVcYZsVzpz7K33Xoaqzsk12OmOvm8nvT6E=;
        b=pefuasflU7Th0lP8Hv4JbkGoDmnvnaoH6kl1ODGMuN0/vTWTx/XQKQaJsRaK5iZ7io
         BO4EOt/YzRfpgm09qFP2uSxrVN8xBDXtdHjijkntWJncxcbddOKtUP/lmGRT3GERcxSJ
         BBCvYQMCazGbGtValWgkBUYML30wqtxbzOJpCyzYKXfPqHPpJCPcHd+h26vkRZ4CNVBp
         yrr1p3lkH0NroPFd1Zks7y0ZZ1+Rni2KR15rAGM6Q5FnW5zYOIg0d2PF7F25dsaqX+yY
         /FX0KOuIxGqUXhPd7OTD+kTZVgk4DTSAwxfN7KkiXCd6q0EDgr86rQGWBFHQ4eHKmEKu
         ZUtg==
X-Gm-Message-State: AOAM532/JJDlEMEABB/LJdN1WklOAyM6ysuWLUg2Z/LVjaOuL3buHXAs
        IQM7+WW0sSgUJxx2tbumFoo=
X-Google-Smtp-Source: ABdhPJxBH3ZzFAMX8tmiVtXSkg7M8wADCwG50qATAXW/1EUPKFBzrhrpdaFwRg4hdHcUNRL//MbNtQ==
X-Received: by 2002:a05:6a00:174a:b0:4fd:ac35:6731 with SMTP id j10-20020a056a00174a00b004fdac356731mr22714238pfc.71.1652226511410;
        Tue, 10 May 2022 16:48:31 -0700 (PDT)
Received: from [10.69.0.118] ([131.107.8.246])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b0015e8d4eb206sm197883plp.80.2022.05.10.16.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 16:48:31 -0700 (PDT)
Message-ID: <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
Date:   Tue, 10 May 2022 16:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
 <20220510232919.xoxet3k7cxboixmt@shindev>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220510232919.xoxet3k7cxboixmt@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> On 5/10/22 19:43, Alan Adamson wrote:
>>> Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
>>> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
>>> run with or without NVME_VERBOSE_ERRORS configured.
>>>
>>> These test verify the functionality delivered by the follow:
>>> 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
>>>
>>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>>    tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/nvme/039.out |   7 ++
>>>    2 files changed, 192 insertions(+)
>>>    create mode 100755 tests/nvme/039
>>>    create mode 100644 tests/nvme/039.out
>>>
>>> diff --git a/tests/nvme/039 b/tests/nvme/039
>>> new file mode 100755
>>> index 000000000000..e6d45a6e3fe5
>>> --- /dev/null
>>> +++ b/tests/nvme/039
>>> @@ -0,0 +1,185 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2022 Oracle and/or its affiliates
>>> +#
>>> +# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
>>> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
>>> +# run with or without NVME_VERBOSE_ERRORS configured.
>>> +#
>>> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
>>> +
>>> +. tests/nvme/rc
>>> +DESCRIPTION="test error logging"
>>> +QUICK=1
>>> +
>>> +requires() {
>>> +	_nvme_requires
>>> +	_have_kernel_option FAULT_INJECTION && \
>>> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
>>> +}
>>> +
>>> +declare -A NS_DEV_FAULT_INJECT_SAVE
>>> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
>>> +
>>> +save_err_inject_attr()
>>> +{
>>> +	local a
>>> +
>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>> +		NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
>>> +	done
>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>> +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
>>> +	done
>>> +}
>>> +
>>> +restore_err_inject_attr()
>>> +{
>>> +	local a
>>> +
>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>> +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>> +	done
>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>> +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>> +	done
>>> +}
>>> +
>>> +set_verbose_prob_retry()
>>> +{
>>> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
>>> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
>>> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
>>> +}
>>> +
>>> +set_status_time()
>>> +{
>>> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
>>> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
>>> +}
>>> +
>>> +inject_unrec_read_err()
>>> +{
>>> +	# Inject a 'Unrecovered Read Error' error on a READ
>>> +	set_status_time 0x281 1 "$1"
>>> +
>>> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_invalid_read_err()
>>> +{
>>> +	# Inject a valid invalid error status (0x375) on a READ
>>> +	set_status_time 0x375 1 "$1"
>>> +
>>> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Unknown (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>> +		    sed 's/I\/O Error/Unknown/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_write_fault()
>>> +{
>>> +	# Inject a 'Write Fault' error on a WRITE
>>> +	set_status_time 0x280 1 "$1"
>>> +
>>> +	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Write Fault (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
>>> +		    sed 's/I\/O Error/Write Fault/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_id_admin()
>>> +{
>>> +	# Inject a valid (Identify) Admin command
>>> +	set_status_time 0x286 1000 "$1"
>>> +
>>> +	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
>>> +	    --cdw10=1 -r 2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -1 | grep "Access Denied (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>> +		    sed 's/Admin Cmd/Identify/g' | \
>>> +		    sed 's/I\/O Error/Access Denied/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_invalid_cmd()
>>> +{
>>> +	# Inject an invalid command (0x96)
>>> +	set_status_time 0x1 1 "$1"
>>> +
>>> +	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
>>> +	    --cdw10=1 -r 2> /dev/null 1>&2
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>> +		    sed 's/Admin Cmd/Unknown/g' | \
>>> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>
>> All of the above seems like they belong in common code...
> 
> So far, this nvme/039 is the only one user of the helper functions above. Do you
> foresee that future new test cases in nvmeof-mp or srp group will use them?
> 

I can absolutely see other tests inject errors. I meant that this code
should live in nvme/rc
