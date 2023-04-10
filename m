Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2EC77B6E
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 00:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDJAoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Apr 2023 20:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJAoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Apr 2023 20:44:09 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E33596
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 17:44:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EC06D2B0671A;
        Sun,  9 Apr 2023 20:44:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 09 Apr 2023 20:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681087444; x=1681088044; bh=Z6
        icuaoDHHIsO5d4VfRrQbPiDw7J9fTP2H0bgGwHcnU=; b=R4hEEA6eoBFqpNR20p
        fL8F4Q7f8azzkWcnqc7RMdvWDBpbZJXuJW2ma9XENfVL40Cz+Qe1sAkdPFAUtAIp
        rJbLdr1HQ5Zld+ldeP9AdBgAdxpPWcXIu1gxw4rGWGNqiQoQPHLs4K6b3v1VAd4t
        FiCAdQz+f+VH2fXffebZcKoxOXyyH/fZ5hYI9iYa0sZVGiQeTc7J5P3+3Yeh2hu5
        2ZUPY5ypE9P7WmpLSVRRvGE80eKxO/BIm8NaKrnIczy5aLDX9frWAC3d3jeJ+87c
        JNpdSUKA+9CyTEhs+GNb3TpRk1q32lSEc6hupa8dm0n9Al32vrxPzTBkVKncpuMX
        EMYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1681087444; x=1681088044; bh=Z6i
        cuaoDHHIsO5d4VfRrQbPiDw7J9fTP2H0bgGwHcnU=; b=BIUtOI/bxs78GTs7w8G
        YztdY4DfFJq4kv4v0nQEFy64xOf+E1Ra4+I/Ok5+q87eVEOAbH96btokgCSpCU9k
        gqVhzKIXMbCQ6TrbaD0+vDpadxzj7oK7wjiodRwUtLOl0pJNOklH6gsxKqgm/him
        5bEIuchJksm8dULBYajj3cwCmvDjS6U7WJ4amWWpr+oNTgjFz2wEd2kvHW6CKt6/
        2k9W5vz2v73CGNJn1NkK6wpq4brMKUPAtVBDE9coaPV+SrnGVslWT8ux2Oin2fSr
        s1iPVkzcYu4wTLjRmt5Pz/VrTQl4Zcdi7Wj4x4XliSqAmJKbnS7YaAMLo52mcdbV
        chQ==
X-ME-Sender: <xms:01szZAQh1QcSfgVrnv7o8b5msLFk46ADQHAGvRtXacr3fmkkZBXGzQ>
    <xme:01szZNzCDgGhvguXY2qSAGiSRNh-8YOefYAsQOLcTtOMlWvTq5liyMek-BUsYKSDe
    fUAxAJxfDhaKxflvjg>
X-ME-Received: <xmr:01szZN33ihhVfny2VsVKBcrmr7ODkSlenOO2r87iQdW8MUi4B22frYRL8wbCF3fF1nbGVk4V-5BVbC7Mghzs_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:01szZECDe7jZVGm2Du1AZdYwzl_MSDzjtapZgRFjMPZX20jOhDDDnw>
    <xmx:01szZJgmxj_YGpFc_FCkPYm6CrVBewOjGZvg0KyPab9Sv7fpIs0KQw>
    <xmx:01szZAqbEROpcXZydHq1C8t5ckVQVgvtEuPT-lg5lV_pSUUF_VS8QA>
    <xmx:1FszZOuXquiD4L68G6T3Pe_OEjLbALahLJXOwssrrhknq64nH7Yfcu7H5VddhlLn>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Apr 2023 20:44:02 -0400 (EDT)
Date:   Mon, 10 Apr 2023 09:43:58 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH blktests 2/2] nvme/047: add test for uring-passthrough
Message-ID: <p7rz7dz6t2vdihusunblbw6tm4cqrq4vcfaupttjwqqj7jiwgc@6emzgswzmmeq>
References: <20230331034414.42024-1-joshi.k@samsung.com>
 <CGME20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c@epcas5p2.samsung.com>
 <20230331034414.42024-3-joshi.k@samsung.com>
 <20230407080746.tx4sgperc6pvjsbu@shinhome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407080746.tx4sgperc6pvjsbu@shinhome>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 07, 2023 / 17:07, Shin'ichiro Kawasaki wrote:
> Thanks for the patch. I think it's good to have this test case to cover the
> uring-passthrough codes in the nvme driver code. Please find my comments in
> line.
> 
> Also, I ran the new test case on my Fedora system using QEMU NVME device and
> found the test case fails with errors like,
> 
>     fio: io_u error on file /dev/ng0n1: Permission denied: read offset=266240, buflen=4096
> 
> I took a look in this and learned that SELinux on my system does not allow
> IORING_OP_URING_CMD by default. I needed to do "setenforce 0" or add a local
> policy to allow IORING_OP_URING_CMD so that the test case passes.
> 
> I think this test case should check this security requirement. I'm not sure what
> is the best way to do it. One idea is to just run fio with io_uring_cmd engine
> and check its error message. I created a patch below, and it looks working on my
> system. I suggest to add it, unless anyone knows other better way.
> 
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index a0cc8b2..30961ff 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -14,6 +14,22 @@ requires() {
>  	_have_fio_ver 3 33
>  }
>  
> +device_requires() {
> +	local ngdev=${TEST_DEV/nvme/ng}
> +	local fio_output
> +
> +	if fio_output=$(fio --name=check --size=4k --filename="$ngdev" \
> +			    --rw=read --ioengine=io_uring_cmd 2>&1); then
> +		return 0
> +	fi
> +	if grep -qe "Permission denied" <<< "$fio_output"; then
> +		SKIP_REASONS+=("IORING_OP_URING_CMD is not allowed for $ngdev")
> +	else
> +		SKIP_REASONS+=("IORING_OP_URING_CMD check for $ngdev failed")

I revisited the code I suggested and noticed this part is not good. The failures
other than "Permission denied" are the failures that this test case intended to
catch. It is not good to skip them.

> +	fi
> +	return 1
> +}
> +
>  test_device() {
>  	echo "Running ${TEST_NAME}"
>  	local ngdev=${TEST_DEV/nvme/ng}

As far as I read the kernel code related to security_uring_cmd(), calling uring
command is the only way to check its security permission. It means that we can
not separate the check for the security permission and the uring command test
itself. So it's the better to check the security permission not in
device_requires() but in test_device(), as follows:

diff --git a/tests/nvme/047 b/tests/nvme/047
index a0cc8b2..741ccd9 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -30,6 +30,16 @@ test_device() {
 		--time_based
 		--runtime=2
 	)
+	local fio_output
+
+	# check security permission
+	if ! fio_output=$(fio --name=check --size=4k --filename="$ngdev" \
+			    --rw=read --ioengine=io_uring_cmd 2>&1) &&
+			grep -qe "Permission denied" <<< "$fio_output"; then
+		SKIP_REASONS+=("IORING_OP_URING_CMD is not allowed for $ngdev")
+		return
+	fi
+
 	#plain read test
 	_run_fio "${common_args[@]}"
 

