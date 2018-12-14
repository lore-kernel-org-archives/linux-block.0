Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F271EC65BAE
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 00:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85072086D
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 00:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeLNAbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:31:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbeLNAbU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 19:31:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73268A0903;
        Fri, 14 Dec 2018 00:31:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1C661D30;
        Fri, 14 Dec 2018 00:31:09 +0000 (UTC)
Date:   Fri, 14 Dec 2018 08:31:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 2/2] blktests: add Ming Lei's
 scsi-stress-remove
Message-ID: <20181214003103.GA26429@ming.t460p>
References: <20181212230959.69975-3-dennis@kernel.org>
 <20181213182844.97512-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213182844.97512-1-dennis@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Dec 2018 00:31:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 01:28:44PM -0500, Dennis Zhou wrote:
> This test exposed a race condition with shutting down a request_queue
> and the new blkg association. The issue ended up being that while the
> request_queue will just start failing requests, blkg destruction sets
> the q->root_blkg to %NULL. This caused a NPE when trying to reference
> it. So to help prevent this from happening again, integrate Ming's test
> into blktests so that it can more easily be ran.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
> v2:
> - Change scheduler retrieving logic based on Ming's comment
> 
>  tests/block/022     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/022.out |  2 +
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/block/022
>  create mode 100644 tests/block/022.out
> 
> diff --git a/tests/block/022 b/tests/block/022
> new file mode 100755
> index 0000000..84336e0
> --- /dev/null
> +++ b/tests/block/022
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Ming Lei
> +#
> +# Regression test for patch "blkcg: handle dying request_queue when associating
> +# a blkg"
> +#
> +# This tries to expose the race condition between blkg association and
> +# request_queue shutdown. When a request_queue is shutdown, the corresponding
> +# blkgs are destroyed. Any further associations should fail gracefully and not
> +# cause a kernel panic.
> +
> +. tests/block/rc
> +. common/scsi_debug
> +. common/cgroup
> +
> +DESCRIPTION="test graceful shutdown of scsi_debug devices with running fio jobs"
> +QUICK=1
> +
> +requires() {
> +	_have_cgroup2_controller io && _have_scsi_debug && _have_fio
> +}
> +
> +scsi_debug_stress_remove() {
> +	scsi_debug_path="/sys/bus/pseudo/drivers/scsi_debug"
> +	count=21
> +
> +	runtime=12
> +	nr_fio_jobs=8
> +	scsi_dbg_ndelay=10000
> +
> +	# set higher aio limit
> +	echo 524288 > /proc/sys/fs/aio-max-nr
> +
> +	#figure out the CAN_QUEUE
> +	can_queue=$(((count + 1) * (count / 2) / 2))
> +
> +	rmmod scsi_debug > /dev/null 2>&1
> +	modprobe scsi_debug virtual_gb=128 max_luns=$count \
> +		ndelay=$scsi_dbg_ndelay max_queue=$can_queue
> +
> +	# figure out scsi_debug disks
> +	hosts=$(ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter0/host*)
> +	hostname=$(basename "$hosts")
> +	host=$(echo "$hostname" | grep -o -E '[0-9]+')
> +
> +	sdisks=$(ls -d $scsi_debug_path/adapter*/"$hostname"/target*/*/block/*)
> +	disks=""
> +	for sd in $sdisks; do
> +		disks+="/dev/"$(basename "$sd")
> +		disks+=" "
> +	done
> +
> +	fio_jobs=""
> +	cnt=0
> +	for sd in $disks; do
> +		cnt=$((cnt+1))
> +		fio_jobs=$fio_jobs" --name=job1 --filename=$sd: "
> +		dev_name=$(basename "$sd")
> +		q_path=/sys/block/$dev_name/queue
> +
> +		scheds=($(sed 's/[][]//g' "$q_path/scheduler"))
> +		sched_idx=$((cnt % ${#scheds[@]}))
> +		echo "${scheds[$sched_idx]}" > "$q_path/scheduler"
> +		echo $cnt > "$q_path/../device/queue_depth"
> +	done
> +
> +	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
> +		--iodepth=2048 --numjobs=$nr_fio_jobs --bs=4k \
> +		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
> +		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
> +
> +	sleep 7
> +	for sd in $disks; do
> +		dev_name=$(basename "$sd")
> +		dpath=/sys/block/$dev_name/device
> +		[ -f "$dpath/delete" ] && echo 1 > "$dpath/delete"
> +	done
> +
> +	wait
> +}
> +
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	scsi_debug_stress_remove
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/022.out b/tests/block/022.out
> new file mode 100644
> index 0000000..14d43cb
> --- /dev/null
> +++ b/tests/block/022.out
> @@ -0,0 +1,2 @@
> +Running block/022
> +Test complete
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming
