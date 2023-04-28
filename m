Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A847C77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 03:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjD1DMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 23:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344841AbjD1DLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 23:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DC468F
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682651455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyIhVxRaOBSkPCzGKFD1FqY9N89AuxAfNW4ZchoPZeU=;
        b=ODgkd6LzV3/gTPMn3Qto+qNBSJNnx5kf/14k7YiTf2fgNikZO7W3vGe+x/nvGOKRWrq6n1
        BeQ63je4vmsjpmJUYwUXxCrm+HKHg9ewfcsj9KryMz7KinH0XRT0Ec45G9v2mzk3XmLzqh
        wdc4Kknw3QqwFD7tJWNybJG3iSL90WQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-epA2HTb1OSG3X6gvK4ViTw-1; Thu, 27 Apr 2023 23:10:49 -0400
X-MC-Unique: epA2HTb1OSG3X6gvK4ViTw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A3D2280AA25;
        Fri, 28 Apr 2023 03:10:49 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B451B492C13;
        Fri, 28 Apr 2023 03:10:45 +0000 (UTC)
Date:   Fri, 28 Apr 2023 11:10:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH blktests 2/2] tests: Add ublk tests
Message-ID: <ZEs5MDBYUHk+8pO0@ovpn-8-24.pek2.redhat.com>
References: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
 <20230427103242.31361-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427103242.31361-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 27, 2023 at 06:32:42PM +0800, Ziyang Zhang wrote:
> It is very important to test ublk crash handling since the userspace
> part is not reliable. Especially we should test removing device, killing
> ublk daemons and user recovery feature.

Indeed, good job!

> 
> Add five new test for ublk to cover these cases.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> ---
>  tests/ublk/001     | 39 +++++++++++++++++++++++++++
>  tests/ublk/001.out |  2 ++
>  tests/ublk/002     | 53 +++++++++++++++++++++++++++++++++++++
>  tests/ublk/002.out |  2 ++
>  tests/ublk/003     | 43 ++++++++++++++++++++++++++++++
>  tests/ublk/003.out |  2 ++
>  tests/ublk/004     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/004.out |  2 ++
>  tests/ublk/005     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/005.out |  2 ++
>  10 files changed, 274 insertions(+)
>  create mode 100644 tests/ublk/001
>  create mode 100644 tests/ublk/001.out
>  create mode 100644 tests/ublk/002
>  create mode 100644 tests/ublk/002.out
>  create mode 100644 tests/ublk/003
>  create mode 100644 tests/ublk/003.out
>  create mode 100644 tests/ublk/004
>  create mode 100644 tests/ublk/004.out
>  create mode 100644 tests/ublk/005
>  create mode 100644 tests/ublk/005.out

Please run 'make check' and fix the following warning:

tests/ublk/002:35:13: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/002:36:17: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/ublk/002:41:23: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/002:44:3: note: Instead of 'let expr', prefer (( expr )) . [SC2219]
tests/ublk/003:35:13: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/003:36:17: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/ublk/004:35:13: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/004:36:17: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/ublk/004:41:23: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/004:44:3: note: Instead of 'let expr', prefer (( expr )) . [SC2219]
tests/ublk/004:51:19: note: Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
tests/ublk/004:53:17: note: Instead of 'let expr', prefer (( expr )) . [SC2219]
tests/ublk/004:55:15: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/005:35:13: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/005:36:17: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/ublk/005:41:23: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/005:44:3: note: Instead of 'let expr', prefer (( expr )) . [SC2219]
tests/ublk/005:51:19: note: Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
tests/ublk/005:53:17: note: Instead of 'let expr', prefer (( expr )) . [SC2219]
tests/ublk/005:55:15: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/005:58:13: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
tests/ublk/005:59:17: note: Double quote to prevent globbing and word splitting. [SC2086]

> 
> diff --git a/tests/ublk/001 b/tests/ublk/001
> new file mode 100644
> index 0000000..fe158ba
> --- /dev/null
> +++ b/tests/ublk/001
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by deleting ublk device while running fio
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION="test ublk deletion"
> +QUICK=1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog="src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"

Indent.

Also probably, add one small delay before deleting device, then we can
make sure there are enough in-flight IOs before starting to delete.

> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/001.out b/tests/ublk/001.out
> new file mode 100644
> index 0000000..0d070b3
> --- /dev/null
> +++ b/tests/ublk/001.out
> @@ -0,0 +1,2 @@
> +Running ublk/001
> +Test complete
> diff --git a/tests/ublk/002 b/tests/ublk/002
> new file mode 100644
> index 0000000..25cad13
> --- /dev/null
> +++ b/tests/ublk/002
> @@ -0,0 +1,53 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by killing ublk daemon while running fio
> +# Delete the device after it is dead
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION="test ublk crash(1)"
> +QUICK=1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog="src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
> +
> +        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=0
> +        while [ $secs -lt 10 ]; do
> +                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`

It could be cleaner to add one function for retrieving ublk state, given
the func is needed in many tests.

> +                [ "$state" == "DEAD" ] && break
> +		sleep 1
> +		let secs++
> +        done

Indent.

> +        [ "$state" != "DEAD" ] && echo "device isn't dead after killing queue daemon"
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/002.out b/tests/ublk/002.out
> new file mode 100644
> index 0000000..93039b7
> --- /dev/null
> +++ b/tests/ublk/002.out
> @@ -0,0 +1,2 @@
> +Running ublk/002
> +Test complete
> diff --git a/tests/ublk/003 b/tests/ublk/003
> new file mode 100644
> index 0000000..34bce74
> --- /dev/null
> +++ b/tests/ublk/003
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by killing ublk daemon while running fio
> +# Delete the device immediately
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION="test ublk crash(2)"
> +QUICK=1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog="src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
> +
> +        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"

Indent.

> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/003.out b/tests/ublk/003.out
> new file mode 100644
> index 0000000..90a3bfa
> --- /dev/null
> +++ b/tests/ublk/003.out
> @@ -0,0 +1,2 @@
> +Running ublk/003
> +Test complete
> diff --git a/tests/ublk/004 b/tests/ublk/004
> new file mode 100644
> index 0000000..c5d0694
> --- /dev/null
> +++ b/tests/ublk/004
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk user recovery by run fio with dev recovery:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)delete dev
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION="test ublk recovery(1)"
> +QUICK=1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog="src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
> +        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=0
> +        while [ $secs -lt 10 ]; do
> +                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
> +                [ "$state" == "QUIESCED" ] && break
> +		sleep 1
> +		let secs++
> +        done

Indent.

> +        [ "$state" != "QUIESCED" ] && echo "device isn't quiesced after killing queue daemon"
> + 
> +        secs=0
> +        while [ $secs -lt 10 ]; do
> +                ${ublk_prog} recover -t null -n 0 >> "$FULL"
> +                [ $? -eq 0 ] && break 
> +                sleep 1
> +                let secs++
> +        done

Do we need to send multiple recover commands?

> +        state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
> +        [ "$state" == "QUIESCED" ] && echo "failed to recover dev"
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/004.out b/tests/ublk/004.out
> new file mode 100644
> index 0000000..a92cd50
> --- /dev/null
> +++ b/tests/ublk/004.out
> @@ -0,0 +1,2 @@
> +Running ublk/004
> +Test complete
> diff --git a/tests/ublk/005 b/tests/ublk/005
> new file mode 100644
> index 0000000..23c0555
> --- /dev/null
> +++ b/tests/ublk/005
> @@ -0,0 +1,66 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk user recovery by run fio with dev recovery:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)kill all ubq_deamon, (4)delete dev
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION="test ublk recovery(2)"
> +QUICK=1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog="src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
> +        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=0
> +        while [ $secs -lt 10 ]; do
> +                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
> +                [ "$state" == "QUIESCED" ] && break
> +		sleep 1
> +		let secs++
> +        done
> +        [ "$state" != "QUIESCED" ] && echo "device isn't quiesced after killing queue daemon"

Indent.

> +
> +        secs=0
> +        while [ $secs -lt 10 ]; do
> +                ${ublk_prog} recover -t null -n 0 >> "$FULL"
> +                [ $? -eq 0 ] && break 
> +                sleep 1
> +                let secs++
> +        done

Same question with above.


Thanks, 
Ming

