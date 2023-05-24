Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E53C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 08:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjEXImN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbjEXIln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 04:41:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D371998
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 01:40:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjNR92W_1684917633;
Received: from 30.97.56.246(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VjNR92W_1684917633)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 16:40:34 +0800
Message-ID: <3859c73a-a390-86d9-0101-969bbf2ace11@linux.alibaba.com>
Date:   Wed, 24 May 2023 16:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH V2 blktests 2/2] tests: Add ublk tests
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
 <ktb4tdaag6xr7p6bu5dfdgpzanrrg4lnunf33yby5mklhe45eb@kxuwcvhhyjpb>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <ktb4tdaag6xr7p6bu5dfdgpzanrrg4lnunf33yby5mklhe45eb@kxuwcvhhyjpb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/5/16 16:47, Shinichiro Kawasaki wrote:
> On May 05, 2023 / 11:28, Ziyang Zhang wrote:
>> It is very important to test ublk crash handling since the userspace
>> part is not reliable. Especially we should test removing device, killing
>> ublk daemons and user recovery feature.
>>
>> Add five new tests for ublk to cover these cases.
>>
>> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
>> ---

[...]

>> diff --git a/tests/ublk/004 b/tests/ublk/004
>> new file mode 100755
>> index 0000000..84e01d1
>> --- /dev/null
>> +++ b/tests/ublk/004
>> @@ -0,0 +1,50 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2023 Ziyang Zhang
>> +#
>> +# Test ublk crash with delete just after daemon kill
>> +
>> +. tests/ublk/rc
>> +
>> +DESCRIPTION="test ublk crash with delete just after daemon kill"

[1]

>> +
>> +__run() {
>> +	local type=$1
>> +
>> +	if [ "$type" == "null" ]; then
>> +		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
>> +	else
>> +		truncate -s 1G "$TMPDIR/img"
>> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
>> +	fi
>> +
>> +	udevadm settle
>> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
>> +		echo "fail to list dev"
>> +	fi
>> +
>> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
> 
> Nit: long line
> 
>> +	sleep 2
>> +
>> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> 
> I think it would be the better to wait for the pid, to ensure that the ublk
> daemon process completed.

Hi Shinichiro,

As the description[1] says, this test wants to delete ublk device just after killing
the daemon. So we should not wait for the pid here.

> 
>> +
>> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
>> +}
>> +
>> +test() {
>> +	local ublk_prog="src/miniublk"
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! _init_ublk; then
>> +		return 1
>> +	fi
>> +
>> +	for type in "null" "loop"; do
>> +		__run "$type"
>> +	done
>> +
>> +	_exit_ublk
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/ublk/004.out b/tests/ublk/004.out
>> new file mode 100644
>> index 0000000..a92cd50
>> --- /dev/null
>> +++ b/tests/ublk/004.out
>> @@ -0,0 +1,2 @@
>> +Running ublk/004
>> +Test complete
>> diff --git a/tests/ublk/005 b/tests/ublk/005
>> new file mode 100755
>> index 0000000..f365fd6
>> --- /dev/null
>> +++ b/tests/ublk/005
>> @@ -0,0 +1,79 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2023 Ziyang Zhang
>> +#
>> +# Test ublk recovery with one time daemon kill:
>> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
>> +# (3)delete dev
>> +
>> +. tests/ublk/rc
>> +
>> +DESCRIPTION="test ublk recovery with one time daemon kill"
>> +
>> +__run() {
>> +	local type=$1
>> +
>> +	if [ "$type" == "null" ]; then
>> +		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
>> +	else
>> +		truncate -s 1G "$TMPDIR/img"
>> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
>> +	fi
>> +
>> +	udevadm settle
>> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
>> +		echo "fail to list dev"
>> +	fi
>> +
>> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
> 
> Nit: long line
> 
>> +	sleep 2
>> +
>> +	kill -9 "$(__get_ublk_daemon_pid 0)"
>> +	sleep 2
>> +
>> +	local secs=0
>> +	local state=""
>> +	while [ $secs -lt 20 ]; do
>> +		state="$(__get_ublk_dev_state 0)"
>> +		[ "$state" == "QUIESCED" ] && break
>> +		sleep 1
>> +		(( secs++ ))
>> +	done
>> +
>> +	state="$(__get_ublk_dev_state 0)"
>> +	[ "$state" != "QUIESCED" ] && echo "device is $state after killing queue daemon"
> 
> Nit: long line
> 
>> +
>> +	if [ "$type" == "null" ]; then
>> +		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
>> +	else
>> +		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1
> 
> Nit: long line
> 
>> +	fi
>> +
>> +	while [ $secs -lt 20 ]; do
>> +		state="$(__get_ublk_dev_state 0)"
>> +		[ "$state" == "LIVE" ] && break
>> +		sleep 1
>> +		(( secs++ ))
>> +	done
>> +	[ "$state" != "LIVE" ] && echo "device is $state after recovery"
>> +
>> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
>> +}
>> +
>> +test() {
>> +	local ublk_prog="src/miniublk"
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! _init_ublk; then
>> +		return 1
>> +	fi
>> +
>> +	for type in "null" "loop"; do
>> +		__run "$type"
>> +	done
>> +
>> +	_exit_ublk
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/ublk/005.out b/tests/ublk/005.out
>> new file mode 100644
>> index 0000000..20d7b38
>> --- /dev/null
>> +++ b/tests/ublk/005.out
>> @@ -0,0 +1,2 @@
>> +Running ublk/005
>> +Test complete
>> diff --git a/tests/ublk/006 b/tests/ublk/006
>> new file mode 100755
>> index 0000000..0848939
>> --- /dev/null
>> +++ b/tests/ublk/006
>> @@ -0,0 +1,83 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2023 Ziyang Zhang
>> +#
>> +# Test ublk recovery with two times daemon kill:
>> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
>> +# (3)kill all ubq_deamon, (4)delete dev
>> +
>> +. tests/ublk/rc
>> +
>> +DESCRIPTION="test ublk recovery with two times daemon kill"
>> +
>> +__run() {
>> +	local type=$1
>> +
>> +	if [ "$type" == "null" ]; then
>> +		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
>> +	else
>> +		truncate -s 1G "$TMPDIR/img"
>> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
>> +	fi
>> +
>> +	udevadm settle
>> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
>> +		echo "fail to list dev"
>> +	fi
>> +
>> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
> 
> Nit: long line
> 
>> +	sleep 2
>> +
>> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> 
> Same comment as ublk/005. How about to have the helper function
> "_kill_ublk_daemon" in tests/ublk/rc which does both kill and wait?


This test wants to make sure ublk is quiesced after killing daemon.
And the daemon must exit before ublk is quiesced. So we do not wait
for the daemon pid here.

> 
>> +	sleep 2
>> +
>> +	local secs=0
>> +	local state=""
>> +	while [ $secs -lt 20 ]; do
>> +		state="$(__get_ublk_dev_state 0)"
>> +		[ "$state" == "QUIESCED" ] && break
>> +		sleep 1
>> +		(( secs++ ))
>> +	done
>> +
>> +	state="$(__get_ublk_dev_state 0)"
>> +	[ "$state" != "QUIESCED" ] && echo "device is $state after killing queue daemon"
> 
> Nit: long line
> 
>> +
>> +	if [ "$type" == "null" ]; then
>> +		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
>> +	else
>> +		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1
> 
> Nit: long line
> 
>> +	fi
>> +
>> +	secs=0
>> +	while [ $secs -lt 20 ]; do
>> +		state="$(__get_ublk_dev_state 0)"
>> +		[ "$state" == "LIVE" ] && break
>> +		sleep 1
>> +		(( secs++ ))
>> +	done
>> +	[ "$state" != "LIVE" ] && echo "device is $state after recovery"
>> +
>> +	kill -9 "$(__get_ublk_daemon_pid 0)"
>> +
>> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
>> +}
>> +
>> +test() {
>> +	local ublk_prog="src/miniublk"
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	if ! _init_ublk; then
>> +		return 1
>> +	fi
>> +
>> +	for type in "null" "loop"; do
>> +		__run "$type"
>> +	done
>> +
>> +	_exit_ublk
>> +
>> +	echo "Test complete"
>> +}
>> +

