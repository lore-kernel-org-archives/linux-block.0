Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7571AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiEJWZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 18:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiEJWZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 18:25:43 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F6266C
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 15:25:41 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id eq14so533284qvb.4
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 15:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TaQMt8YSkLxLukBChiuaicxu+fwV4Fg8j47IpXG3DII=;
        b=qVwfFho1aD9n1xFBNwJqZKi+lHXkhaKI1E07UmBxZEaIlvra3gYJo0/NIDAfHnq7A8
         MCkWLk1bFB2IN78UWe9LRA2F1CSj7cwTJAuWf9KpaIYPorvTT0+plCT8MM2AWjHYwooQ
         kbJIpPty5VIhczlslxN0DQfZRT9QAlGms9aPn5J5lU7B0hsbyrx4iRswcpVh9R5SNBTa
         VeFE7e4gAJoRahOuUdvpc5KeOj8vAwwhZCZ47wtHQg506ewMsVpNe1waH3GwrpkFSStN
         Ja9zjUcgeiFQDTQdmtPrlIoMSUV3E2IEMchBrP2OdE4b5jPgxkF9U1ADoA1uIKNRzuT1
         KEvg==
X-Gm-Message-State: AOAM531QLV8VxHEssbPG0bfmgQTB4XMklQP23GSPilwSK9wc24OIA0Cb
        /ubTz0Ili8/QXdAYFNMcKVM=
X-Google-Smtp-Source: ABdhPJwtzL6OQq4WcyRJBx5dsQ3g7oA+1FMYStvpjSCvMZ3rvBpU8wxlNLUx+mW9jGmw1EKqOmupgQ==
X-Received: by 2002:a0c:cb88:0:b0:45a:8207:9343 with SMTP id p8-20020a0ccb88000000b0045a82079343mr20005891qvk.98.1652221540039;
        Tue, 10 May 2022 15:25:40 -0700 (PDT)
Received: from [10.20.15.217] ([50.226.69.182])
        by smtp.gmail.com with ESMTPSA id y30-20020a05620a0e1e00b0069fd9de088esm104249qkm.93.2022.05.10.15.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:25:39 -0700 (PDT)
Message-ID: <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
Date:   Tue, 10 May 2022 15:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Content-Language: en-US
To:     Alan Adamson <alan.adamson@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, osandov@fb.com
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220510164304.86178-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/10/22 19:43, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
> run with or without NVME_VERBOSE_ERRORS configured.
> 
> These test verify the functionality delivered by the follow:
> 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/039.out |   7 ++
>   2 files changed, 192 insertions(+)
>   create mode 100755 tests/nvme/039
>   create mode 100644 tests/nvme/039.out
> 
> diff --git a/tests/nvme/039 b/tests/nvme/039
> new file mode 100755
> index 000000000000..e6d45a6e3fe5
> --- /dev/null
> +++ b/tests/nvme/039
> @@ -0,0 +1,185 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Oracle and/or its affiliates
> +#
> +# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
> +# run with or without NVME_VERBOSE_ERRORS configured.
> +#
> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
> +
> +. tests/nvme/rc
> +DESCRIPTION="test error logging"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_kernel_option FAULT_INJECTION && \
> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> +}
> +
> +declare -A NS_DEV_FAULT_INJECT_SAVE
> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
> +
> +save_err_inject_attr()
> +{
> +	local a
> +
> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> +		NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
> +	done
> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
> +	done
> +}
> +
> +restore_err_inject_attr()
> +{
> +	local a
> +
> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> +	done
> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> +	done
> +}
> +
> +set_verbose_prob_retry()
> +{
> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> +}
> +
> +set_status_time()
> +{
> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
> +}
> +
> +inject_unrec_read_err()
> +{
> +	# Inject a 'Unrecovered Read Error' error on a READ
> +	set_status_time 0x281 1 "$1"
> +
> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
> +	    2> /dev/null 1>&2
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_read_err()
> +{
> +	# Inject a valid invalid error status (0x375) on a READ
> +	set_status_time 0x375 1 "$1"
> +
> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
> +	    2> /dev/null 1>&2
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unknown (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unknown/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_write_fault()
> +{
> +	# Inject a 'Write Fault' error on a WRITE
> +	set_status_time 0x280 1 "$1"
> +
> +	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
> +	    2> /dev/null 1>&2
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Write Fault (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> +		    sed 's/I\/O Error/Write Fault/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_id_admin()
> +{
> +	# Inject a valid (Identify) Admin command
> +	set_status_time 0x286 1000 "$1"
> +
> +	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
> +	    --cdw10=1 -r 2> /dev/null 1>&2
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Access Denied (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> +		    sed 's/Admin Cmd/Identify/g' | \
> +		    sed 's/I\/O Error/Access Denied/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_cmd()
> +{
> +	# Inject an invalid command (0x96)
> +	set_status_time 0x1 1 "$1"
> +
> +	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
> +	    --cdw10=1 -r 2> /dev/null 1>&2
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> +		    sed 's/Admin Cmd/Unknown/g' | \
> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +

All of the above seems like they belong in common code...

> +test_device() {
> +	local nvme_verbose_errors
> +	local ns_dev
> +	local ctrl_dev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if _have_kernel_option NVME_VERBOSE_ERRORS; then
> +		nvme_verbose_errors=true
> +	else
> +		unset SKIP_REASON
> +		nvme_verbose_errors=false
> +	fi
> +
> +	ns_dev=${TEST_DEV##*/}
> +	ctrl_dev=${ns_dev%n*}
> +
> +	save_err_inject_attr
> +
> +	set_verbose_prob_retry "${ns_dev}"
> +
> +	inject_unrec_read_err "${ns_dev}"
> +	inject_invalid_read_err "${ns_dev}"
> +	inject_write_fault "${ns_dev}"
> +
> +	set_verbose_prob_retry "${ctrl_dev}"
> +
> +	inject_id_admin "${ctrl_dev}"
> +	inject_invalid_cmd "${ctrl_dev}"
> +
> +	restore_err_inject_attr
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/039.out b/tests/nvme/039.out
> new file mode 100644
> index 000000000000..162935eb1d7b
> --- /dev/null
> +++ b/tests/nvme/039.out
> @@ -0,0 +1,7 @@
> +Running nvme/039
> + Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
> + Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
> + Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
> + Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR
> + Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> +Test complete
