Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832BC77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 12:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDJMoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 08:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDJMo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 08:44:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B36D61AC
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 05:44:24 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230410124420epoutp03c3e27af736f71ded3ae7d0207a3cff96~Uk22qhlS82195321953epoutp03Q
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 12:44:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230410124420epoutp03c3e27af736f71ded3ae7d0207a3cff96~Uk22qhlS82195321953epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681130660;
        bh=Oz6PkpanDJafi5z9bEJgTzlzMkL/dsMLOw2pkUzLNck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oYb4ZbxaoOkZRgUK+KhvWnThmYNizrh1pEfeKcedot3J+WWtnriUqJj6XU+1KehT9
         W98G43/CWvYU6evexXYRUI7hDCzEbNDx/kW3PCr28VFYODH2fB3u8XFjrdM6uL29OM
         zOY58n+7erir9UPmqOPk8liSt2qqCOQ0FK9IzVkA=
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230410124419epcas5p1f6311642816695e03607cec38de37ac0~Uk22Y1vUm1912219122epcas5p1o;
        Mon, 10 Apr 2023 12:44:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230410124419epsmtrp2f6eea08908ab1f081bb9165a27cd511d~Uk22YSc6i1301713017epsmtrp24;
        Mon, 10 Apr 2023 12:44:19 +0000 (GMT)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230410124417epsmtip1ea7bd4a86c4aca55e5d920eb8723f83d~Uk20e5nHr2932429324epsmtip1b;
        Mon, 10 Apr 2023 12:44:17 +0000 (GMT)
Date:   Mon, 10 Apr 2023 18:13:33 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH blktests 2/2] nvme/047: add test for uring-passthrough
Message-ID: <20230410124333.GC16047@green5>
MIME-Version: 1.0
In-Reply-To: <20230407080746.tx4sgperc6pvjsbu@shinhome>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMS-MailID: 20230410124419epcas5p1f6311642816695e03607cec38de37ac0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b83_"
CMS-TYPE: 105P
X-CMS-RootMailID: 20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c
References: <20230331034414.42024-1-joshi.k@samsung.com>
        <CGME20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c@epcas5p2.samsung.com>
        <20230331034414.42024-3-joshi.k@samsung.com>
        <20230407080746.tx4sgperc6pvjsbu@shinhome>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b83_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Apr 07, 2023 at 05:07:46PM +0900, Shin'ichiro Kawasaki wrote:
>Thanks for the patch. I think it's good to have this test case to cover the
>uring-passthrough codes in the nvme driver code. Please find my comments in
>line.
>
>Also, I ran the new test case on my Fedora system using QEMU NVME device and
>found the test case fails with errors like,
>
>    fio: io_u error on file /dev/ng0n1: Permission denied: read offset=266240, buflen=4096
>
>I took a look in this and learned that SELinux on my system does not allow
>IORING_OP_URING_CMD by default. I needed to do "setenforce 0" or add a local
>policy to allow IORING_OP_URING_CMD so that the test case passes.
>
>I think this test case should check this security requirement. I'm not sure what
>is the best way to do it. One idea is to just run fio with io_uring_cmd engine
>and check its error message. I created a patch below, and it looks working on my
>system. I suggest to add it, unless anyone knows other better way.

I will use the latest one you posted. Thanks for taking care of it.

>diff --git a/tests/nvme/047 b/tests/nvme/047
>index a0cc8b2..30961ff 100755
>--- a/tests/nvme/047
>+++ b/tests/nvme/047
>@@ -14,6 +14,22 @@ requires() {
> 	_have_fio_ver 3 33
> }
>
>+device_requires() {
>+	local ngdev=${TEST_DEV/nvme/ng}
>+	local fio_output
>+
>+	if fio_output=$(fio --name=check --size=4k --filename="$ngdev" \
>+			    --rw=read --ioengine=io_uring_cmd 2>&1); then
>+		return 0
>+	fi
>+	if grep -qe "Permission denied" <<< "$fio_output"; then
>+		SKIP_REASONS+=("IORING_OP_URING_CMD is not allowed for $ngdev")
>+	else
>+		SKIP_REASONS+=("IORING_OP_URING_CMD check for $ngdev failed")
>+	fi
>+	return 1
>+}
>+
> test_device() {
> 	echo "Running ${TEST_NAME}"
> 	local ngdev=${TEST_DEV/nvme/ng}
>
>
>On Mar 31, 2023 / 09:14, Kanchan Joshi wrote:
>> User can communicate to NVMe char device (/dev/ngXnY) using the
>> uring-passthrough interface. This test exercises some of these
>> communication pathways, using the 'io_uring_cmd' ioengine of fio.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>  tests/nvme/047     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/nvme/047.out |  2 ++
>>  2 files changed, 48 insertions(+)
>>  create mode 100755 tests/nvme/047
>>  create mode 100644 tests/nvme/047.out
>>
>> diff --git a/tests/nvme/047 b/tests/nvme/047
>> new file mode 100755
>> index 0000000..a0cc8b2
>> --- /dev/null
>> +++ b/tests/nvme/047
>> @@ -0,0 +1,46 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
>> +# Test exercising uring passthrough IO on nvme char device
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="basic test for uring-passthrough io on /dev/ngX"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_have_kver 6 1
>
>In general, it's the better not to depend on version number to check dependency.
>Is kernel version the only way to check the kernel dependency?

The tests checks for iopoll and fixed-buffer paths which are present
from 6.1 onwards, therefore this check. Hope that is ok?

>Also, I think this test case assumes that the kernel is built with
>CONFIG_IO_URING. I suggest to add "_have_kernel_option IO_URING" to ensure it.

Sure, will add.

>> +	_have_fio_ver 3 33
>
>Is io_uring_cmd engine the reason to check this fio version? If so, I suggest to
>check "fio --enghelp" output. We can add a new helper function with name like
>_have_fio_io_uring_cmd_engine. _have_fio_zbd_zonemode in common/fio can be a
>reference.

fixed-buffer support[1] went into this fio relese, therefore check for
the specific version.

[1]https://lore.kernel.org/fio/20221003033152.314763-1-anuj20.g@samsung.com/

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b83_
Content-Type: text/plain; charset="utf-8"


------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b83_--
