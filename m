Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1384C4332F
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 23:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiKOXHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 18:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKOXHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 18:07:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1D2C674
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 15:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2AEECE19A7
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 23:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA20C433C1;
        Tue, 15 Nov 2022 23:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668553648;
        bh=saQ8CFN9k/04GT3jsFLnu9AakHqfR/AzeQx3kPTzKak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJouLVJ32LVDu3T9KZlr/41Nt4HS3j624ZKHFjROQOpGiaUGk5GxydTzduoGaLbZs
         syJZQD7wXutOQgdrByh9P7x9sIulAql34UBj0Jkc+xAHTrWrRmoqL1xfWAXBHyljOV
         EEbOsTLGFGgJZhErD/42F6BAq1WzNoIImgLovSsYZPomatFY5VHRYSHaPvZ15vR9Zh
         gHMLQwYuGDyZ/kEl0GFv7t7PXBnOSXoIyl9B6ONaLfz2KdQL6D6HkbJHHLftN0bXvX
         cmBpKqlG27mm+BCuqj6R7QH67Gl4aPL2AgCOU0h19h0grH9xGHY2dWpKkXCdiJQMbK
         Xq4sbM9DK+y7g==
Date:   Tue, 15 Nov 2022 16:07:24 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3QbrKaQdffR/HcX@kbusch-mbp.dhcp.thefacebook.com>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 01:34:12PM -0700, Jonathan Derrick wrote:
> +	echo "Running ${TEST_NAME}"
> +
> +	local sysfs
> +	local attr
> +	local m
> +
> +	sysfs="$TEST_DEV_SYSFS/device"

That's not the correct directory when the device is using native
nvme-multipath.

> +	timeout=$(($(cat /proc/sys/kernel/hung_task_timeout_secs) / 2))
> +
> +	sleep 5
> +
> +	if [[ ! -d "$sysfs" ]]; then
> +		echo "$sysfs doesn't exist"
> +	fi
> +
> +	# do reset controller/format loops
> +	# don't check status now because a timing race is desired
> +	i=0
> +	start=0
> +	timing_out=false
> +	while [[ $i -le 1000 ]]; do
> +		start=$SECONDS
> +		if [[ -f "$sysfs/reset_controller" ]]; then
> +			echo 1 > "$sysfs/reset_controller" 2>/dev/null &
> +			i=$((i+1))
> +		fi
> +		nvme format -l 0 -f $TEST_DEV 2>/dev/null &
> +
> +		#Assume the controller is hung and unrecoverable
> +		if [[ $(($SECONDS - $start)) -gt $timeout ]]; then
> +			echo "nvme controller timing out"
> +			timing_out=true
> +			break
> +		fi
> +	done

If the controller is already undergoing a reset, then writing to the
reset_controller file becomes a no-op. Unless your "reset_controller"
completes near instantaneously, I find that this loop tears through 1000
iterations, forks 1000 formats, and only 1 reset_controller actually
gets through.

If I remove the upper limit, then I can also see the stalled task, but
it is only temporary and gets itself out of it after the admin timeout
(1 minute). Is that also your observation, or is it stuck forever?
