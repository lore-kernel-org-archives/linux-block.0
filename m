Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA91CB53C
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297352; cv=none; b=OA3cRsg0XOgWsFzV3cA/DTfqhPrL3l3UNcT/FnPZ4L18a5f+MVGxykHccmcKGIuu1U5rwDpc9F/7wXOrvS3RUuXrmksvUqcfZD402BWlLAcBC4u/08nAnc2UNpc9kBUV5F9jfvvW/i4H5Vv6kF5go9FiVbbBHZTlAP/4PUQ65Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297352; c=relaxed/simple;
	bh=MGongDwj7BxZTuGuRzW33syylu+0eqCymT3X/JHcN+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLwM/MxBspOqyISGEpe9NO6XKBjsrQaUGba1M4Swow4S3Zl4Wzk6IANPMIqezl07XhUArY/ePqU+9deNAhTZTMfxjYfm7Q5IwrlSO36gZAjBEI/zdaxDzDJ+kH0bAoypSIeSKtFenjfItPZ1x8ggegzi/twXf8nwDlpP3pUPK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hCG8FSkF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hCG8FSkF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482BIljk010282;
	Mon, 2 Sep 2024 17:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Zi4WNyojJlupZtpSMihsyhwIywBkvt0sNSVa5lyIR2Q=; b=hCG8FSkFe/J0242O
	eZOLUH9ZThaZehZFOX0BKFAjgcBXBHh+iGeyYy0AOqvLxcuux+5tOifgGhDevCec
	f/BWaJSU74eS3SQwC0dWkxhQZXpSiDj5UJ9k8SFEbfIZcObF+BjMxSzqNbDtRC41
	Sux9bB4OZ2BfiuVP7E5IGXR0G127AW/e+wjaRFrTnntupeZ71xDyCb9Kt3R2H777
	APsa4TiBmEIwCz/h/9GO9dXxitAnJXjiFGz1goVABXqInI3EX61VEt05jvdfAfxH
	LWO+58PxC2eRgftXfRJrwd8IS+Aj3pwY3hbHdUpLs45DWpwlxpCwWItEo/BHYu6L
	pawFaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp99ye3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 17:15:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 482HFeP3019225;
	Mon, 2 Sep 2024 17:15:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp99ydy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 17:15:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 482D1QYa000930;
	Mon, 2 Sep 2024 17:15:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cf0mpyst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 17:15:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 482HFckt25231982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 17:15:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78B158058;
	Mon,  2 Sep 2024 17:15:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A32858057;
	Mon,  2 Sep 2024 17:15:37 +0000 (GMT)
Received: from [9.171.86.213] (unknown [9.171.86.213])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Sep 2024 17:15:36 +0000 (GMT)
Message-ID: <b9005d25-5fc0-49e0-b196-5d504d58d8c5@linux.ibm.com>
Date: Mon, 2 Sep 2024 22:45:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>
References: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aeQ5Y8mdy2u2URkSp52NJQ_OXIDlD1fn
X-Proofpoint-ORIG-GUID: PCKWWkjkIvnMogODghWgqiAUy5a4CQFr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020136



On 9/2/24 16:24, Shin'ichiro Kawasaki wrote:
> The CKI project reported that the test case nvme/052 fails occasionally
> with the errors below:
> 
>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>       runtime    ...  22.209s
>       --- tests/nvme/052.out    2024-07-30 18:38:29.041716566 -0400
>       +++
> +/mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-t\
> ests-production.zip/storage/blktests/nvme/nvme-loop/blktests
> +/results/nodev_tr_loop/nvme/052.out.bad        2024-07-30 18:45:35.438067452 -0400
>       @@ -1,2 +1,4 @@
>        Running nvme/052
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>        Test complete
> 
> The test case repeats creating and removing namespaces. When the test
> case removes the namespace by echoing 0 to the sysfs enable file, this
> echo write does not wait for the completion of the namespace removal.
> Before the removal completes, the test case recreates the namespace.
> At this point, the sysfs uuid file for the old namespace still exists.
> The test case misunderstands that the the sysfs uuid file would be for
> the recreated namespace, and tries to read it. However, the removal
> process for the old namespace deletes the sysfs uuid file at this point.
> Then the read attempt fails and results in the errors.
> 
> To avoid the failure, wait for the namespace removal before recreating
> the namespace. Modify nvmf_wait_for_ns() so that it can wait for
> namespace creation and removal. Call nvmf_wait_for_ns() for removal
> after _remove_nvmet_ns() call. While at it, reduce the wait time unit
> from 1 second to 0.1 second to shorten test time.
> 
> The test case intends to catch the regression fixed by the kernel commit
> ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
> from the kernel v6.11-rc4, then confirmed that the test case still can
> catch the regression with this change.
> 
> Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
> Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v2:
> * Avoided conditional stderr redirect of _find_nvme_ns
> 
> Changes from v1:
> * Reused nvmf_wait_for_ns() instead of introuducing nvmf_wait_for_ns_removal()
> * Added check of nvme_wait_for_ns() return value
> 
>  tests/nvme/052 | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/nvme/052 b/tests/nvme/052
> index cf6061a..401f043 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -20,23 +20,27 @@ set_conditions() {
>  	_set_nvme_trtype "$@"
>  }
>  
> +# Wait for the namespace with specified uuid to fulfill the specified condtion,
> +# "created" or "removed".
>  nvmf_wait_for_ns() {
>  	local ns
>  	local timeout="5"
>  	local uuid="$1"
> +	local condition="$2"
>  
> -	ns=$(_find_nvme_ns "${uuid}")
> +	ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
>  
>  	start_time=$(date +%s)
> -	while [[ -z "$ns" ]]; do
> -		sleep 1
> +	while [[ -z "$ns" && "$condition" == created ]] ||
> +		      [[ -n "$ns" && "$condition" == removed ]]; do
> +		sleep .1
>  		end_time=$(date +%s)
>  		if (( end_time - start_time > timeout )); then
>  			echo "namespace with uuid \"${uuid}\" not " \
> -				"found within ${timeout} seconds"
> +				"${condition} within ${timeout} seconds"
>  			return 1
>  		fi
> -		ns=$(_find_nvme_ns "${uuid}")
> +		ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
>  	done
>  
>  	return 0
> @@ -63,14 +67,21 @@ test() {
>  		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
>  
>  		# wait until async request is processed and ns is created
> -		nvmf_wait_for_ns "${uuid}"
> -		if [ $? -eq 1 ]; then
> +		if ! nvmf_wait_for_ns "${uuid}" created; then
>  			echo "FAIL"
>  			rm "$(_nvme_def_file_path).$i"
>  			break
>  		fi
>  
>  		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> +
> +		# wait until async request is processed and ns is removed
> +		if ! nvmf_wait_for_ns "${uuid}" removed; then
> +			echo "FAIL"
> +			rm "$(_nvme_def_file_path).$i"
> +			break
> +		fi
> +
>  		rm "$(_nvme_def_file_path).$i"
>  	}
>  	done

Looks good.
Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)
