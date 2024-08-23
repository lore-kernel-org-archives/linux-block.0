Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2514B084
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408332; cv=none; b=GYSF1Fc5HDC4bvIjLBOZgWIBhX1OF9WOipIA2o7bHajBiT3JQtunM2rif4EfMadt3U6cWxgmlZuXZifQGLGVgreoLKRaNRtRS5/sYuWZbJZYs7j38fRuPE8MpmgZWc4BF01AoZbACFocdSwbBJekjdtmKlovlOEg1LLGL+wq7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408332; c=relaxed/simple;
	bh=xCBbAoU4hSXzjELAjOth1qldOnPViAlTYpFt7JWYNBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEikx01vyb9dmGtXxEE0KJcK+O43jcqcGoVtQtsttN8Edt/oz22BdYQH95tuqxGw2VK7YKNq5H8MKkFSYD/Hc5koA6McDZl2fngDZVIJGAMqtqWKc3P080zYWV6+OHe3+sI3I6/z0TlSf2UoGc9eZM9ojKI9dKnlXI35K+9E/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DjzvgUN6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DjzvgUN6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NA9khv016917;
	Fri, 23 Aug 2024 10:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Y
	nX/CYPg46ufwMFBeJik/ByRTw1OMorfiS4qpoaUxHM=; b=DjzvgUN6/xe9p+SRD
	W4SuZqxZfQIfTBICvRmhYBToyWsxxbG7x4ZCfKCy8KhcAAwfqar2nWwKTxp6tV1h
	pv4iVTE5tfBfIRftR/HsFdxiZ5CqiO1EXdIopg+T5WN/+/J/otAH2d+ng/ao2ROP
	2CtzaToyFXL3vCy9gxITa/50RCI7jfR64TSXYUTpT5JQisONgd+kAclCeVA0gD0q
	WGRv+VDOhsTvYjsnfmsOgFUl32qbbpqIMAtXFbsyrpsqWldDtMs9OHZEGl/jvPmH
	180kzKEDCCd3XkyPz6lMeMxL+PsKak+31Jawb/HFocSGIrX0yx8r3+Zoqf6Np3Cf
	3awIA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma0mcwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 10:18:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAEsHk013097;
	Fri, 23 Aug 2024 10:18:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366uhkv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 10:18:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NAIbKo28836514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 10:18:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA67458055;
	Fri, 23 Aug 2024 10:18:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 702BE58065;
	Fri, 23 Aug 2024 10:18:34 +0000 (GMT)
Received: from [9.171.23.201] (unknown [9.171.23.201])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 10:18:34 +0000 (GMT)
Message-ID: <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Date: Fri, 23 Aug 2024 15:48:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
To: Martin Wilck <martin.wilck@suse.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Martin Wilck <mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-3-mwilck@suse.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240822193814.106111-3-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZlWBhoi2H-1KPVNyEE0fDhtKXCw0OZgR
X-Proofpoint-ORIG-GUID: ZlWBhoi2H-1KPVNyEE0fDhtKXCw0OZgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_06,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230073



On 8/23/24 01:08, Martin Wilck wrote:
> Add a test that repeatedly rescans nvme controllers while doing IO
> on an nvme namespace connected to these controllers. The purpose
> of the test is to make sure that no I/O errors or data corruption
> occurs because of the rescan operations.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  tests/nvme/053 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/rc  | 18 ++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100755 tests/nvme/053
> 
> diff --git a/tests/nvme/053 b/tests/nvme/053
> new file mode 100755
> index 0000000..41dc8f2
> --- /dev/null
> +++ b/tests/nvme/053
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Martin Wilck, SUSE LLC
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test controller rescan under I/O load"
> +TIMED=1
> +: "${TIMEOUT:=60}"
> +
> +rescan_controller() {
> +	local finish
> +
> +	[[ -f "$1/rescan_controller" ]] || {
> +		echo "cannot rescan $1"
> +		return 1
> +	}
> +
> +	finish=$(($(date +%s) + TIMEOUT))
> +	while [[ $(date +%s) -le $finish ]]; do
> +		# sleep interval between 0.1 and 5s
> +		usleep "$(((RANDOM%50 + 1)*100000))"
> +		echo 1 >"$1/rescan_controller"
> +	done
> +}
I think here usleep may not be available by default on all systems.
For instance, on fedora/rhel I don't have usleep installed in the 
defualt configuration and so I have to first install it. So you may
want to add "usleep" as per-requisite for this test. Moreover, after 
I installed usleep on fedora and ran the above test I see this warning:

warning: usleep is deprecated, and will be removed in near future!

Due to above warning the test fails. So is it possible to replace 
usleep with sleep?
 
> +
> +test_device() {
> +	local -a ctrls
> +	local c
> +
> +	echo "Running ${TEST_NAME}"
> +	ctrls=($(_nvme_get_ctrl_list))
> +
> +	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
> +
> +	for c in "${ctrls[@]}"; do
> +		rescan_controller "$c" &
> +	done
> +
> +	while true; do
> +		wait -n &>/dev/null
> +		st=$?
> +		case $st in
> +			127)
> +				break
> +				;;
> +			0)
> +				;;
> +			*)
> +				echo "child process exited with $st!"
> +				;;
> +		esac
> +	done
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index e7d2ab1..93b0571 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -192,6 +192,24 @@ _test_dev_nvme_nsid() {
>  	cat "${TEST_DEV_SYSFS}/nsid"
>  }
>  
> +_nvme_get_ctrl_list() {
> +	local subsys
> +	local c
> +
> +	subsys=$(readlink  "${TEST_DEV_SYSFS}/device/subsystem")
> +	case $subsys in
> +		*/nvme)
> +			readlink -f "${TEST_DEV_SYSFS}/device"
> +			;;
> +		*/nvme-subsystem)
> +			for c in "${TEST_DEV_SYSFS}"/device/nvme*; do
> +				[[ -L "$c" ]] || continue
> +				[[ -f "$c/dev" ]] && readlink -f "$c"
> +			done
> +			;;
> +	esac
> +}
> +
I don't know if I am missing anything here but just curious to know 
for which case $subsys would point to link ending in */nvme?
I think that for all cases $subsys shall point to link which ends 
in */nvme-subsystem, isn't it? I assume here that $TEST_DEV_SYSFS would 
always resolve to a nvme block device.

And the last point: I don't see 053.out file in your patchset. Did you forget
to add this file?

Thanks,
--Nilay




