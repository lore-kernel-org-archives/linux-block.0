Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D51FA14B
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937106; cv=none; b=THvw8kUaG1FbR8k5gayoXALJvmgrF1BwV/zVO5j8Fi00i8XbaxGowBXk7RzOt8HLNBFTzYGqP7j/l8APr4P0XS+e6+adf+pY2s6ry4IgY5QzWnpnIPFdlUTMoiHQCSc7Tl0PqqTcAlQuL5aDpVYU9EnKjELJo6W83KWqo1pOh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937106; c=relaxed/simple;
	bh=cPZV5jf6kklpOI9eSgk9jR0u507kk6E/yyL4qUcrZ60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNXcgCRsSkXVDZlefh6oYvi1+0b1+kR0HxK1GimDSHRxf+p4mN6cPa7TsLNONnQg/2q9151dNVaYul1hi8bbaP42sxjoBBk7nW19O2DLxjo+msZ7//62wASGCF++XPh8pNGquF7asDByLKMSGK9G99If/pYvFSUqyJRF6KbBf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUaozP8E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUaozP8E"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5177X1Tf028594;
	Fri, 7 Feb 2025 14:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XAw4tI
	ihSdAoTGRp0HWAmse7yWbFTF+FmxvWepb+g/0=; b=ZUaozP8EOJiRVIhXLfgVgl
	icro/gurWMKqcXRPztHvtnC/8RzQALjlMuCpKei34vgbRfNLmOzKVU7QZbX9Y5/s
	vd9gv626Axk508sMwr+QobzqDQMPGsPi/1jMJ0t0I3mCN2pQEU/tr2QRdzMoEjN5
	QlLJn21eeFFyPwuAXD5Wc2fcQju8V82gF1it0U1keXXf9G7Xt6LRTceb6waDnH3C
	jWovu7IEwPtz4YQxTLfs0rBC9Axgc0c89mpPXbK8PBld/BYEihonuSTFFiopU+bp
	d/MrobsggeHdC5n6jG22TPd0B41Ofik52fKnW/xd9L3kcBPme62cDY5fbGniEagw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ndvp1ta4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 14:04:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517B5XCb007150;
	Fri, 7 Feb 2025 14:04:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb03xpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 14:04:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517E4m8954591846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 14:04:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34120200F6;
	Fri,  7 Feb 2025 14:04:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADBF1200F5;
	Fri,  7 Feb 2025 14:04:45 +0000 (GMT)
Received: from [9.61.255.223] (unknown [9.61.255.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 14:04:45 +0000 (GMT)
Message-ID: <daf2113f-fe58-45f1-920c-56c0cfa80f83@linux.ibm.com>
Date: Fri, 7 Feb 2025 19:34:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
Content-Language: en-GB
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, bvanassche@acm.org, gjoyce@ibm.com
References: <20250205150429.665052-1-nilay@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20250205150429.665052-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zzB-j6dYxMz5JIlprtbQb0YSstLeGyX5
X-Proofpoint-ORIG-GUID: zzB-j6dYxMz5JIlprtbQb0YSstLeGyX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070107

On 05/02/25 8:34 pm, Nilay Shroff wrote:

> The srp/* tests requires exclusive access to scsi_transport_srp
> module. Running srp/* tests would definitely fail if the test can't
> get exclusive access of scsi_transport_srp module as shown below:
>
> $ lsmod | grep scsi_transport_srp
> scsi_transport_srp    327680  1 ibmvscsi
>
> $ ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>      runtime    ...  0.249s
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
> modprobe: FATAL: Module scsi_transport_srp is in use.
> error: Invalid argument
> error: Invalid argument
>
> So if the scsi_transport_srp module is loaded and in use then skip
> running srp/* tests.
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I have tested the patch on PowerPC machine, it works fine.

Tested-by: Disha Goel<disgoel@linux.ibm.com>

> ---
> Changes from v1:
>      - Fix formatting, replace white spaces with tabs (Shinichiro Kawasaki)
>      - Rename _have_module_not_in_use to _module_not_in_use (Bart Van Assche)
>
> ---
>   common/rc    | 13 +++++++++++++
>   tests/srp/rc |  1 +
>   2 files changed, 14 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index bcb215d..20579b0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -78,6 +78,19 @@ _have_module() {
>   	return 0
>   }
>   
> +_module_not_in_use() {
> +	local refcnt
> +
> +	_have_module "$1" || return
> +
> +	if [ -d "/sys/module/$1" ]; then
> +		   refcnt="$(cat /sys/module/$1/refcnt)"
> +		   if [ "$refcnt" -ne "0" ]; then
> +			   SKIP_REASONS+=("module $1 is in use")
> +		   fi
> +	fi
> +}
> +
>   _have_module_param() {
>   	 _have_driver "$1" || return
>   
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 85bd1dd..47b9546 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -61,6 +61,7 @@ group_requires() {
>   	_have_module scsi_debug
>   	_have_module target_core_iblock
>   	_have_module target_core_mod
> +	_module_not_in_use scsi_transport_srp
>   
>   	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
>   		 sg_reset fio; do
