Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A544C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 08:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjDGISJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbjDGIR4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 04:17:56 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 01:17:16 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1289BB9B
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 01:17:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 1A35F2B067F1;
        Fri,  7 Apr 2023 04:07:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 07 Apr 2023 04:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680854871; x=1680855471; bh=p8
        c67hXcovpHbKZG3xx5Jh4HtxuSfykJZRJQsxwNuDo=; b=bNvzGHKtRsfZl0Mzcb
        OOFD38RHu4upQde3jPkpBg6PR06seYCN/1oRKEhvNCKZ7O0Yn1lQIEuokBQklDQU
        RZEWY4UW1c7Sr6H2wbZAuf9zzUqDJu7/cXFJ2NCKmfue2a0a4ZdKFjnSQpxPAPI+
        1WHyPKdp/+Gsa3n6yiOKnHK79PIAmZzTXK6DrmM85eud/fVtUbqz4Bo8IpdK+eYQ
        rBtQqk2A2GyYZzf8Nxc9LfwIDlvs9lRDH5RqhgKG6h+sIt+SRUTJ3754/+ZiD/jw
        AkKCOw/L+kdBEU5wNRtTdmah1eeW+hhcmHxbPTNm+eZ2LcptN503io8s0H15FPIp
        oWDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1680854871; x=1680855471; bh=p8c
        67hXcovpHbKZG3xx5Jh4HtxuSfykJZRJQsxwNuDo=; b=Ua2Z3CZyuRI+6KwUxT5
        sP2xDjI2kh+ytD8caGfX1Low4T4K/jW9nYw26HjlE2nErSGEo83KFjfVdLA2Z9Sz
        jAxdMDx1fEjDzUnlEH+RV6AwX/vrSXKkwxjQmlpyiTiTaTL9vIimOCvgDJabSzUX
        czphGkRnRuzBo6XUqZa/ifwQpWZwPx6yjWKSSt4IKdANEvvFCQuI45TWZSdXgTSE
        SIU1t7r8MYj3qJnTTbmzA8+LLeJRcC4hF73QqX2kylq5CP0vNfKBK2ET9Z/8rtX1
        51ltMVqoVKvnl6mbGy/oFI3m2EdSJ7CFVEj44lkmSjY2Ml03mRSZv0TQYxgC9Lzn
        UVA==
X-ME-Sender: <xms:Vs8vZAzzdP-EacqOzq8LbAI5odeSXf4_CJJea6WVXrE6HtI2TMHIjw>
    <xme:Vs8vZERgLpbvaVrHf2153SLUSEctxd6pP2QJ2xtY3DRJ5F1dEoSQq8l3ubNL1j1TT
    PnpfsEkwpC4Sqb6KQE>
X-ME-Received: <xmr:Vs8vZCVtTErWkQW8jFoOpDmQ_PpS0-FhkNcxhu2BUxQXih2t0AjBdMa4nf97lzB7X1yi3ObqLwNrueM1oI8dQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefuhhhinhdkihgt
    hhhirhhoucfmrgifrghsrghkihcuoehshhhinhhitghhihhrohesfhgrshhtmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgvefgieekffelvddtjedttdeiudffleetleek
    iedtgeetueekueetjeekteffgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehshhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Vs8vZOgimUVG-i_SztwIo2tfE7ntiQbwRYJjFMEYqOtkOS_bybszLg>
    <xmx:Vs8vZCARtNFA61gDQ58Q3HVDYlTJuXIGEcva7oPkCV0jc7lmhNb_4A>
    <xmx:Vs8vZPKmdBusbbpWUQ-Eexaoc0BaQ1gDCLq1jfTmr7xpodmMbyR2EA>
    <xmx:V88vZNM4XFLv-tfPWGqr5h_2XD6WOf2r5sdIhAeCIyekNc0he2yhlqZE6igO8ksS>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Apr 2023 04:07:49 -0400 (EDT)
Date:   Fri, 7 Apr 2023 17:07:46 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH blktests 2/2] nvme/047: add test for uring-passthrough
Message-ID: <20230407080746.tx4sgperc6pvjsbu@shinhome>
References: <20230331034414.42024-1-joshi.k@samsung.com>
 <CGME20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c@epcas5p2.samsung.com>
 <20230331034414.42024-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331034414.42024-3-joshi.k@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the patch. I think it's good to have this test case to cover the
uring-passthrough codes in the nvme driver code. Please find my comments in
line.

Also, I ran the new test case on my Fedora system using QEMU NVME device and
found the test case fails with errors like,

    fio: io_u error on file /dev/ng0n1: Permission denied: read offset=266240, buflen=4096

I took a look in this and learned that SELinux on my system does not allow
IORING_OP_URING_CMD by default. I needed to do "setenforce 0" or add a local
policy to allow IORING_OP_URING_CMD so that the test case passes.

I think this test case should check this security requirement. I'm not sure what
is the best way to do it. One idea is to just run fio with io_uring_cmd engine
and check its error message. I created a patch below, and it looks working on my
system. I suggest to add it, unless anyone knows other better way.

diff --git a/tests/nvme/047 b/tests/nvme/047
index a0cc8b2..30961ff 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -14,6 +14,22 @@ requires() {
 	_have_fio_ver 3 33
 }
 
+device_requires() {
+	local ngdev=${TEST_DEV/nvme/ng}
+	local fio_output
+
+	if fio_output=$(fio --name=check --size=4k --filename="$ngdev" \
+			    --rw=read --ioengine=io_uring_cmd 2>&1); then
+		return 0
+	fi
+	if grep -qe "Permission denied" <<< "$fio_output"; then
+		SKIP_REASONS+=("IORING_OP_URING_CMD is not allowed for $ngdev")
+	else
+		SKIP_REASONS+=("IORING_OP_URING_CMD check for $ngdev failed")
+	fi
+	return 1
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 	local ngdev=${TEST_DEV/nvme/ng}


On Mar 31, 2023 / 09:14, Kanchan Joshi wrote:
> User can communicate to NVMe char device (/dev/ngXnY) using the
> uring-passthrough interface. This test exercises some of these
> communication pathways, using the 'io_uring_cmd' ioengine of fio.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  tests/nvme/047     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/047.out |  2 ++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/nvme/047
>  create mode 100644 tests/nvme/047.out
> 
> diff --git a/tests/nvme/047 b/tests/nvme/047
> new file mode 100755
> index 0000000..a0cc8b2
> --- /dev/null
> +++ b/tests/nvme/047
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
> +# Test exercising uring passthrough IO on nvme char device
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="basic test for uring-passthrough io on /dev/ngX"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_kver 6 1

In general, it's the better not to depend on version number to check dependency.
Is kernel version the only way to check the kernel dependency?

Also, I think this test case assumes that the kernel is built with
CONFIG_IO_URING. I suggest to add "_have_kernel_option IO_URING" to ensure it.

> +	_have_fio_ver 3 33

Is io_uring_cmd engine the reason to check this fio version? If so, I suggest to
check "fio --enghelp" output. We can add a new helper function with name like
_have_fio_io_uring_cmd_engine. _have_fio_zbd_zonemode in common/fio can be a
reference.

> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +	local ngdev=${TEST_DEV/nvme/ng}
> +	local common_args=(
> +		--size=1M
> +		--filename="$ngdev"
> +		--bs=4k
> +		--rw=randread
> +		--numjobs=2
> +		--iodepth=8
> +		--name=randread
> +		--ioengine=io_uring_cmd
> +		--cmd_type=nvme
> +		--time_based
> +		--runtime=2
> +	)
> +	#plain read test
> +	_run_fio "${common_args[@]}"
> +
> +	#read with iopoll
> +	_run_fio "${common_args[@]}" --hipri
> +
> +	#read with fixedbufs
> +	_run_fio "${common_args[@]}" --fixedbufs
> +
> +	#if ! _run_fio "${common_args[@]}" >> "${FULL}" 2>&1; then
> +	#	echo "Error: uring-passthru read failed"
> +	#fi

I think you are aware of the comment lines :)

> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/047.out b/tests/nvme/047.out
> new file mode 100644
> index 0000000..915d0a2
> --- /dev/null
> +++ b/tests/nvme/047.out
> @@ -0,0 +1,2 @@
> +Running nvme/047
> +Test complete
> -- 
> 2.25.1
> 
