Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27379139D07
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620375; cv=none; b=nhWK8zJ5rABCBBDCCrvFoRa7swSYOhTJf6RJyWKmSfM4kmaVswqaNQkPcNI86371YIFEAOPm6hu0K/cgh2yzmyri+pzJKvhMzHn9bm6+OfrPjMaAmzQ8rv6hSJVqABxsWCeUvbY4MCqCbQcTcrLHG+YFZgJGiTQEmncBWU+veqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620375; c=relaxed/simple;
	bh=2uPFKntty9yAqlswKATDZ/036+Gt9NO0knS5lsoR6cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLNGL3j3oAMAGyhtyUyzWhMQAEQxZ+v+5jU8XQKiCcBqzuIK+A0p1kr/AFrM6a9/mbAwn21L0x5fqLq+JZu2YZpE7mabjg6BIQcMmUZuwAw+s1EuTHmQY8ydt7ku3aa9nPKI+nSnJynsXE4Q7m6wWTLS9+sAYuzkObnfk+Tv/+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVAWuzll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVAWuzll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51255C4CECF;
	Tue, 26 Nov 2024 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732620374;
	bh=2uPFKntty9yAqlswKATDZ/036+Gt9NO0knS5lsoR6cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EVAWuzlloDlR3+FsAOQfMK5+AIxe5on1rszlXiJUeRLiLQMnDlOBVA9VR0vIhXjy5
	 tuVv6inpVftAB7lkiVugk+e3EpC15zrHiLX6e9xYUM2eJTFn4vKR9vVeChbnkPcajg
	 vebpEhzcYnzXJvntCBFSxIBP9VZWdOAZmT70dpCC2WL7MmORSwTUwjO01GWx1olwv0
	 Ucw7kv8D9rjbWjhuJY2yEhToqWLXIFu/PbOw1fuzYxXlOjWzpM9FsIlIqkhDbVqlyg
	 wZQ6V5pva04rLdUFfPPbyIT/J3UOgi8OmqPZfNDh7TFuXmWWOJyOXN+07jE2Vy4i3w
	 2Zc3zsETik0cQ==
Message-ID: <1e5a1594-a945-4302-bdf9-1a57cc140b9d@kernel.org>
Date: Tue, 26 Nov 2024 20:26:13 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241125211048.1694246-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 06:10, Bart Van Assche wrote:
> Test concurrent requeuing of zoned writes and request queue freezing. While
> test test passes with kernel 6.9, it triggers a hang with kernels 6.10 and
> later. This shows that this hang is a regression introduced by the zone
> write plugging code.
> 
> sysrq: Show Blocked State
> task:(udev-worker)   state:D stack:0     pid:75392 tgid:75392 ppid:2178   flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x3e8/0x1410
>  schedule+0x27/0xf0
>  blk_mq_freeze_queue_wait+0x6f/0xa0
>  queue_attr_store+0x60/0xc0
>  kernfs_fop_write_iter+0x13e/0x1f0
>  vfs_write+0x25b/0x420
>  ksys_write+0x65/0xe0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/zbd/012     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/012.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 tests/zbd/012
>  create mode 100644 tests/zbd/012.out
> 
> diff --git a/tests/zbd/012 b/tests/zbd/012
> new file mode 100644
> index 000000000000..0551d01011af
> --- /dev/null
> +++ b/tests/zbd/012
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Google LLC
> +
> +. tests/scsi/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="test requeuing of zoned writes and queue freezing"
> +QUICK=1
> +
> +requires() {
> +	_have_fio_zbd_zonemode
> +}
> +
> +toggle_iosched() {
> +	while true; do
> +		for iosched in none mq-deadline; do
> +			echo "${iosched}" > "/sys/class/block/$(basename "$zdev")/queue/scheduler"
> +			sleep .1
> +		done
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local qd=1
> +	local scsi_debug_params=(
> +		delay=0
> +		dev_size_mb=1024
> +		every_nth=$((2 * qd))
> +		max_queue="${qd}"
> +		opts=0x8000          # SDEBUG_OPT_HOST_BUSY
> +		sector_size=4096
> +		statistics=1
> +		zbc=host-managed
> +		zone_nr_conv=0
> +		zone_size_mb=4
> +	)
> +	_init_scsi_debug "${scsi_debug_params[@]}" &&
> +	local zdev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
> +	ls -ld "${zdev}" >>"${FULL}" &&
> +	{ toggle_iosched & } &&
> +	toggle_iosched_pid=$! &&
> +	local fio_args=(
> +		--direct=1
> +		--filename="${zdev}"
> +		--iodepth="${qd}"
> +		--ioengine=io_uring

Something very odd is going on here: this fio run is supposed to be qd=1 but
when I get the hang, I see plugged BIOs (at least always 1, and very often more
than 1 in different zones). But with a QD=1 workload, this should *NEVER*
happen. No write command should ever enter a zone write plug (as long as the
write BIO does not get split). So it looks to me like fio, or io_uring
submission context, is sending weird writes...

If I change --ioengine=io_uring to --ioengine=libaio, then the test passes, always.

I am not sure what is going on.

But I do think there is a potential deadlock anyway: if a write command fails,
zone write plug error recovery will be triggered. If that zone write plug has
BIOs plugged and the call to queue freeze when changing the scheduler happens
before the report zone command is issued for the zone write plug error recovery,
then we will deadlock on the queue freeze.
So this is a definitive bug, even though this test does not create this
situation. As already discussed, given the need to properly recover errors for
emulated zone append commands, I am not sure how to fix this yet...

If you can also look into why io_uring IO engine does not respect the iodepth=1
argument, that would be great.

Note that I tried qd > 1 with libaio and everything works just fine: the test
passes. Things are strange only with io_uring.

> +		--ioscheduler=none
> +		--name=pipeline-zoned-writes
> +		--output="${RESULTS_DIR}/fio-output-zbd-092.txt"
> +		--runtime="${TIMEOUT:-30}"
> +		--rw=randwrite
> +		--time_based
> +		--zonemode=zbd
> +	) &&
> +	_run_fio "${fio_args[@]}" >>"${FULL}" 2>&1 ||
> +	fail=true
> +
> +	kill "${toggle_iosched_pid}" 2>&1
> +	_exit_scsi_debug
> +
> +	if [ -z "$fail" ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +		return 1
> +	fi
> +}
> diff --git a/tests/zbd/012.out b/tests/zbd/012.out
> new file mode 100644
> index 000000000000..8ff654950c5f
> --- /dev/null
> +++ b/tests/zbd/012.out
> @@ -0,0 +1,2 @@
> +Running zbd/012
> +Test complete


-- 
Damien Le Moal
Western Digital Research
