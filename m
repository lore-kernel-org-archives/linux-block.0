Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1C13AC1
	for <linux-block@vger.kernel.org>; Sun,  8 Jun 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749420464; cv=none; b=Zz3qeBHK3XXdwUceDWnprsku4GFbT2/rF7o3a81/O5npub8haDJOsW+jaP9w6iNdx0nUn9EBMc1zccF1H24QsRYtSze5V1+hwD+ZQeGZBSCo0POL08J0Wj2DOAfPQtbYHLeeuG460k5XvyLb0xLqTfPKYifIBnC6dNAXibx0Bzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749420464; c=relaxed/simple;
	bh=ApCBHDOi5uabUqrItkPewtIBfjH1WW8Q0ONooTUPW1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFx7Apfx9THyrYtFtQ9qThCBQTW1v4RjAgIP0mX/6QFM9ORQMPk7HvaTPn7lK6zXkJb8fibRt8riDO1aDRxENqU4+MrhJXo7aaPvyuex0v2EZ1Wk7nv1HLV7b+2VO7PMPfpliepzLMx86hF3NAb6AhRgckX/kBVhevYiETainE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZmOug12s; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZmOug12s"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bFq186FhTzm0ySQ;
	Sun,  8 Jun 2025 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749420459; x=1752012460; bh=eo3H3cG/aWUnmDdd3CCQJg9u
	rkowT1nPqbkCEzSQZY0=; b=ZmOug12sn+NvIIOTG4NJCzl5Jf3S051+L6Mr5cu6
	sp8hy46132vWF856irHF4rn43ahrGbABUtmcDlUeYNvfCDQGUAIBxMt5az0FlVnn
	4i1yHKlzdJlCuuNK81Wxf8IJxWYaYgRhaJWW/Gt+MwKToHeK2N1O/PSDupJQKKfg
	ATzC+0I9iwPrbpGQeL66fF36uI3Fft9NLILCjUvnGHXm0ua/WUcgfldsW/5NEsvR
	hjFbITxFb7QEUvAPEx5OltFnssqK6JMKWTW5M5jjpJB7AWWdTBrQvgw4e2zgBieu
	Mc1En7lCsV1xKU8mOb7tb9pYTRCuyaaOtNTjhXum6bieHQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y25I-vIqORhh; Sun,  8 Jun 2025 22:07:39 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bFq116kxxzm0yTG;
	Sun,  8 Jun 2025 22:07:33 +0000 (UTC)
Message-ID: <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
Date: Sun, 8 Jun 2025 15:07:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250526052434.GA11639@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/25 10:24 PM, Christoph Hellwig wrote:
> Umm, Bart I really expected better from you.  You're ducking around
> providing a reproducer for over a week and waste multiple peoples
> time to tell us the only reproducer is your out of tree thingy
> reject upstream before?  That's not really how Linux developement
> works.

A reproducer for the blktests framework is available below. It took me
more time than I had expected to come up with a reproducer because I was
initially looking in the wrong direction (device mapper). As one can
see, the reproducer below does not involve any device mapper driver.

Do you plan to work on a fix or do you perhaps expect me to do this?

Thanks,

Bart.

$ cat tests/zbd/014
#!/bin/bash
# SPDX-License-Identifier: GPL-3.0+
# Copyright (C) 2025 Google LLC
#
# Trigger multiple splitting of a bio. About the values of the size 
parameters
# in this test:
# - The zone size is 4 MiB and is larger than max_sectors_kb.
# - The maximum bio size supported by the code in 
block/blk-crypto-fallback.c
#   is BIO_MAX_VECS * PAGE_SIZE or 1 MiB if the page size is 4 KiB.
# - max_sectors_kb has been set to 512 KiB to cause further bio splitting.

. tests/zbd/rc
. common/null_blk

DESCRIPTION="test multiple bio splitting"
QUICK=1

requires() {
	_have_driver f2fs
	_have_driver null_blk
	_have_program fscrypt
	_have_program getconf
	_have_program mkfs.f2fs
	for o in BLK_INLINE_ENCRYPTION_FALLBACK FS_ENCRYPTION_INLINE_CRYPT; do
		if ! _check_kernel_option "$o"; then
			SKIP_REASONS+=("Kernel option $o has not been enabled")
		fi
	done
}

trace_block_io() {
	(
		set -e
		cd /sys/kernel/tracing
		lsof -t trace_pipe | xargs -r kill
		echo 1024 > buffer_size_kb
		echo nop > current_tracer
		echo 0 > tracing_on
		echo > trace
		echo 0 > events/enable
		echo 1 > events/block/enable
		echo 0 > events/block/block_dirty_buffer/enable
		echo 0 > events/block/block_plug/enable
		echo 0 > events/block/block_touch_buffer/enable
		echo 0 > events/block/block_unplug/enable
		grep -lw 1 events/block/*/enable | while read -r event_path; do
			filter_path="${event_path%enable}filter"
			echo "$1" > "$filter_path"
		done
		echo 1 > tracing_on
		echo "Tracing has been enabled" >>"$FULL"
		cat trace_pipe > "${FULL%.full}-block-trace.txt"
	)
}

stop_tracing() {
	kill "$1"
	(
		set -e
		cd /sys/kernel/tracing
		echo 0 > tracing_on
		echo 0 > events/enable
	)
}

report_stats() {
	local pfx=$1 before after
	read -r -a before <<<"$2"
	read -r -a after <<<"$3"
	local reads=$((after[0]-before[0]))
	local rmerge=$((after[1]-before[1]))
	local writes=$((after[4]-before[4]))
	local wmerge=$((after[5]-before[5]))
	echo "$pfx reads: $reads rmerge: $rmerge writes: $writes wmerge: $wmerge"
}

devno() {
	IFS=: read -r maj min <"/sys/class/block/$(basename "$1")/dev"
	# From <linux/kdev_t.h> MINORBITS = 20
	echo $(((maj << 20) + min))
}

test() {
	echo "Running ${TEST_NAME}"

	local page_size
	page_size=$(getconf PAGE_SIZE) || return $?

	local mount_dir="$TMPDIR/mnt"

	umount /dev/nullb1 >>"$FULL" 2>&1
	_remove_null_blk_devices

	# A small conventional block device for the F2FS metadata.
	local null_blk_params=(
		blocksize=4096
		discard=1
		max_sectors=$(((1 << 32) - 1))
		memory_backed=1
		size=64           # MiB
		submit_queues=1
		power=1
	)
	_configure_null_blk nullb1 "${null_blk_params[@]}"
	local cdev=/dev/nullb1

	# A larger zoned block device for the data.
	local null_blk_params=(
		blocksize=4096
		completion_nsec=10000000 # 10 ms
		irqmode=2
		max_sectors=$(((1 << 32) - 1))
		memory_backed=1
		hw_queue_depth=1
		size=1024         # MiB
		submit_queues=1
		zone_size="$((page_size >> 10))" # 1024 times the page size.
		zoned=1
		power=1
	)
	_configure_null_blk nullb2 "${null_blk_params[@]}" || return $?
	local zdev_basename=nullb2
	local zdev=/dev/${zdev_basename}
	local zdev_devno
	zdev_devno=$(devno "$zdev")

	{
		local 
max_sectors_zdev=/sys/class/block/"${zdev_basename}"/queue/max_sectors_kb
		echo $((128 * page_size)) > "${max_sectors_zdev}"
		echo "${zdev_basename}: max_sectors_kb=$(<"${max_sectors_zdev}")"

		ls -ld "${cdev}" "${zdev}"
		echo "${zdev_basename} settings:"
		(cd "/sys/class/block/$zdev_basename/queue" && grep -vw 0 ./*)
	} >>"${FULL}" 2>&1

	trace_block_io "dev == ${zdev_devno}" &
	local trace_pid=$!
	while ! grep -q 'Tracing has been enabled' "$FULL"; do
		sleep .1
	done

	{
		mkfs.f2fs -q -O encrypt -m "${cdev}" -c "${zdev}" &&
		mkdir -p "${mount_dir}" &&
		mount -o inlinecrypt -t f2fs "${cdev}" "${mount_dir}" &&
		local encrypted_dir="${mount_dir}/encrypted" &&
		mkdir -p "${encrypted_dir}"
		fscrypt setup "${mount_dir}" </dev/null
		local keyfile=$TMPDIR/keyfile &&
		dd if=/dev/zero of="$keyfile" bs=32 count=1 status=none &&
		fscrypt encrypt "${encrypted_dir}" --source=raw_key \
			--name=protector --key="$keyfile" &&
		fscrypt status "${encrypted_dir}" &&

		local before after &&
		read -r -a before <"/sys/class/block/${zdev_basename}/stat" &&
		echo "Starting IO" &&
		local cmd="dd if=/dev/zero of=${encrypted_dir}/file bs=64M count=15 
conv=fdatasync" &&
		echo "$cmd" &&
		eval "$cmd" &&
		ls -ld "${mount_dir}/encrypted/file" &&
		read -r -a after <"/sys/class/block/${zdev_basename}/stat" &&
		report_stats "zdev:" "${before[*]}" "${after[*]}"
	} >>"$FULL" 2>&1 || fail=true

	umount "${mount_dir}" >>"${FULL}" 2>&1
	[ -n "${trace_pid}" ] && kill "${trace_pid}"
	_exit_null_blk

	if [ -z "$fail" ]; then
		echo "Test complete"
	else
		echo "Test failed"
		return 1
	fi
}

