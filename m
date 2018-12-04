Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B1CC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58062081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58062081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=willer.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLDW2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:28:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51598 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDW2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:28:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so11294880wmh.1
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=G2gCLCFigejAyt1b8/q/MnAb4G7evF2BKwgIvH5YuGE=;
        b=GvDcUTpnlUxHVCGtM4LzuaDAEK/rAd3wWvWWLARuL0AigbaEmGG1MUgD1avPFpn8xK
         VyYCU2YvetAOmednDsgBhfLw4exePrpFdTwZRI9Y03oBq0yi4VMXQoXSKfbw7aY5bHa+
         sTtjzQyWO+rBC/YSJeQAd4osodkd3PhpAdjbrJVbBJnES+QhJTWHDdIxBUoxFZYN+zZ6
         8zGZIxIzTxx3ZZMJYuVLt8VLf2ICQsUCT17jccsj6sA43GbRZMA4+OxVglMJJG30xuVX
         d3+GT2bbtCYK7bL6fwZQ8Ce1FrCEjM97MPIsKJvIR6RsyFiieA3loxvxeKUVFxAHnqCE
         sLng==
X-Gm-Message-State: AA+aEWZcvUpiZ5KElUU7QKGgDyO+WDihLttoTG+h7q8OTWG/1g+G4OL/
        DMAgeyngY/5ALExIic5afEA=
X-Google-Smtp-Source: AFSGD/UzyH4ns4ok8A30/aD/7KAhtbrgN750WCCL66jM/ut70JLiByt2R/j6f/lnSkLGfoEBfHm/qA==
X-Received: by 2002:a1c:48c2:: with SMTP id v185-v6mr14487131wma.1.1543962482284;
        Tue, 04 Dec 2018 14:28:02 -0800 (PST)
Received: from [192.168.1.8] (net-2-37-146-146.cust.vodafonedsl.it. [2.37.146.146])
        by smtp.gmail.com with ESMTPSA id y9sm17413094wrq.55.2018.12.04.14.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:28:01 -0800 (PST)
Subject: Re: [PATCH 3/3] blktests: block/025: an io.latency test
To:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-4-josef@toxicpanda.com>
From:   Federico Motta <federico@willer.it>
Openpgp: preference=signencrypt
Autocrypt: addr=federico@willer.it; keydata=
 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
Message-ID: <15635bdf-d42a-6bc8-0db2-b47979930d0f@willer.it>
Date:   Tue, 4 Dec 2018 23:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204174733.7423-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VbbrcKQtHmZYOCxtPjumZitofKuaW4wwl"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VbbrcKQtHmZYOCxtPjumZitofKuaW4wwl
Content-Type: multipart/mixed; boundary="cvImf3aeD28lMPKbUAqY2xut0JJy82h3x";
 protected-headers="v1"
From: Federico Motta <federico@willer.it>
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com, osandov@fb.com
Message-ID: <15635bdf-d42a-6bc8-0db2-b47979930d0f@willer.it>
Subject: Re: [PATCH 3/3] blktests: block/025: an io.latency test
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-4-josef@toxicpanda.com>
In-Reply-To: <20181204174733.7423-4-josef@toxicpanda.com>

--cvImf3aeD28lMPKbUAqY2xut0JJy82h3x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/4/18 6:47 PM, Josef Bacik wrote:
> This is a test to verify io.latency is working properly.  It does this
> by first running a fio job by itself to figure out how fast it runs.
> Then we calculate some thresholds, set up 2 cgroups, a fast and a slow
> cgroup, and then run the same job in both groups simultaneously.  We
> should see the slow group get throttled until the first cgroup is able
> to finish, and then the slow cgroup will be allowed to finish.
>=20
Hi,
two small typos below.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/block/025     | 133 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/block/025.out |   1 +
>  2 files changed, 134 insertions(+)
>  create mode 100644 tests/block/025
>  create mode 100644 tests/block/025.out
>=20
> diff --git a/tests/block/025 b/tests/block/025
> new file mode 100644
> index 000000000000..88ce7cca944e
> --- /dev/null
> +++ b/tests/block/025
> @@ -0,0 +1,133 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +#
> +# Test io.latency to make sure it's protecting the higher priority gro=
up
> +# properly.
> +
> +. tests/block/rc
> +
> +DESCRIPTION=3D"test the io.latency interface to make sure it's working=
 right"
> +
> +requires() {
> +	_have_cgroup2_controller_file io io.latency && _have_fio && \
> +		_have_program python
> +}
> +
> +_fio_results_key() {
> +	_job=3D$1
> +	_key=3D$2
> +	_resultfile=3D$3
> +
> +	python src/fio-key-value.py -k $_key -j $_job $_resultfile
> +}
> +
> +test_device() {
> +	local fio_config_single fio_config_double fio_results fio_args qd
> +
> +	fio_config_single=3D${TMPDIR}/single.fio
> +	fio_config_double=3D${TMPDIR}/double.fio
> +	fio_results=3D${TMPDIR}/025.json
> +	fio_args=3D"--output-format=3Djson --output=3D${fio_results}"
> +	qd=3D$(cat ${TEST_DEV_SYSFS}/queue/nr_requests)
> +
> +	cat << EOF > "${fio_config_single}"
> +	[fast]
> +	filename=3D${TEST_DEV}
> +	direct=3D1
> +	allrandrepeat=3D1
> +	readwrite=3Drandrw
> +	size=3D4G
> +	ioengine=3Dlibaio
> +	iodepth=3D${qd}
> +	fallocate=3Dnone
> +	randseed=3D12345
> +EOF
> +
> +	cat << EOF > "${fio_config_double}"
> +	[global]
> +	filename=3D${TEST_DEV}
> +	direct=3D1
> +	allrandrepeat=3D1
> +	readwrite=3Drandrw
> +	size=3D4G
> +	ioengine=3Dlibaio
> +	iodepth=3D${qd}
> +	fallocate=3Dnone
> +	randseed=3D12345
> +
> +	[fast]
> +	cgroup=3Dblktests/fast
> +
> +	[slow]
> +	cgroup=3Dblktests/slow
> +EOF
> +	# We run the test once so we have an idea of how fast this workload w=
ill
> +	# go with nobody else doing IO on the device.
> +	if ! fio ${fio_args} ${fio_config_single}; then
> +		echo "fio exited with status $?"
> +		return 1
> +	fi
> +
> +	_time_taken=3D$(_fio_results_key fast job_runtime ${fio_results})
> +	if [ "${_time_taken}" =3D "" ]; then
> +		echo "fio doesn't report job_runtime"
> +		return 1
> +	fi
> +
> +	echo "normal time taken ${_time_taken}" >> $FULL
> +
> +	# There's no way to predict how the two workloads are going to affect=

> +	# each other, so we weant to set thresholds to something reasonable s=
o
> +	# we can verify io.latency is doing something.  This means we set 15%=

> +	# for the fast cgroup, just to give us enough wiggle room as throttli=
ng
> +	# doesn't happen immediately.  But if we have a super fast disk we co=
uld
> +	# run both groups really fast and make it under our fast threshold, s=
o
> +	# we need to set a threshold for the slow group at 50%.  We assume th=
at
> +	# if it was faster than 50% of the fast threshold then we probably
> +	# didn't throttle and we can assume io.latency is broken.
> +	_fast_thresh=3D$((${_time_taken} + ${_time_taken} * 15 / 100))
> +	_slow_thresh=3D$((${_time_taken} + ${_time_taken} * 50 / 100))
> +	echo "fast threshold time is ${_fast_thresh}" >> $FULL
> +	echo "slow threshold time is ${_slow_thresh}" >> $FULL
> +
> +	# Create teh cgroup files
Typo, "the".      ^

> +	_dir=3D$(_cgroup2_base_dir)/blktests
> +	echo "+io" > ${_dir}/cgroup.subtree_control
> +	mkdir ${_dir}/fast
> +	mkdir ${_dir}/slow
> +
> +	# We set teh target to 1usec because we could have a fast device that=
 is
Also here, "the". ^

> +	# capable of remarkable IO latencies that would skew the test.  It ne=
eds
> +	# to be low enough that we do actually throttle the slow group,
> +	# otherwise the test will fail when there's nothing wrong.
> +	_major=3D$((0x$(stat -c "%t" ${TEST_DEV})))
> +	_minor=3D$((0x$(stat -c "%T" ${TEST_DEV})))
> +	echo "${_major}:${_minor} is our device" >> $FULL
> +	if ! echo "${_major}:${_minor} target=3D1" > ${_dir}/fast/io.latency;=
 then
> +		echo "Failed to set our latency target"
> +		return 1
> +	fi
> +
> +	if ! fio ${fio_args} ${fio_config_double}; then
> +		echo "fio exited with status $?"
> +		return 1
> +	fi
> +
> +	_fast_time=3D$(_fio_results_key fast job_runtime ${fio_results})
> +	echo "Fast time ${_fast_time}" >> $FULL
> +	_slow_time=3D$(_fio_results_key slow job_runtime ${fio_results})
> +	echo "Slow time ${_slow_time}" >> $FULL
> +=09
There is a trailing whitespace in the above line.

> +	if [ ${_fast_thresh} -lt ${_fast_time} ]; then
> +		echo "Too much of a performance drop for the protected workload"
> +		return 1
> +	fi
> +
> +	if [ ${_slow_thresh} -gt ${_slow_time} ]; then
> +		echo "The slow group does not appear to have been throttled"
> +		return 1
> +	fi
> +
> +	echo "Silence is golden"
> +	return 0
> +}
> diff --git a/tests/block/025.out b/tests/block/025.out
> new file mode 100644
> index 000000000000..c19ff631b9b5
> --- /dev/null
> +++ b/tests/block/025.out
> @@ -0,0 +1 @@
> +Silence is golden
>=20

Thank you,
Federico


--cvImf3aeD28lMPKbUAqY2xut0JJy82h3x--

--VbbrcKQtHmZYOCxtPjumZitofKuaW4wwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREKAB0WIQQjpLt31k10FTLpDwzdnkSUycSdYAUCXAb/bgAKCRDdnkSUycSd
YCRqAP0YcPqIMAZdBZL62khwkROIz2DMT33tUgeYuesZMXj75AEAj6ox0nKoi6nr
V56CzN0fzIpk6/W4+HfH2djII+5GaVk=
=3MPw
-----END PGP SIGNATURE-----

--VbbrcKQtHmZYOCxtPjumZitofKuaW4wwl--
