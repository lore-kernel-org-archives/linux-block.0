Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821C283FD6
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544912; cv=none; b=Ii2QTcfkA5zxIrRL+PrlEXr5WM1a9QKiOz/GZQ5XX93YH0Q0RsTJSfx8ZYBXRDtsyDjrGJx/GCJa+XNh7icKb3qnSAgmST3rRs5I+3Y2fGO3n6b0de3c/iyTnu6popekVObh4peXaBsA+53553aiTiUMF4pJIzl7urAE3Ll4N8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544912; c=relaxed/simple;
	bh=/9WrmsF5asiwCzC4/TbMcgcF8h45ZhSX12AiOvVcQew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uBVRoDEdz/wv3EV+Q2NzN3QlHpMS7KD5QsnYMPZqOdqfRiw/v2KWZ/vt3+rZ/CZiuk7ZAtsa0mOw57PiXCwXKy0Rkd08ZE6w/pnc/G09C5n4tQfwhY9SeUMnmq9Py0rlcLG3Ces/UCH4N9gjvqHo1lwTe75FETa8VtnTLfyoF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KEC9Yqsf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KEC9Yqsf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604EgeoU028927;
	Sun, 4 Jan 2026 16:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ePnrmV
	GZFl/KXzQSV8Jm/E91RZ9jMb3ePIixMkBFJac=; b=KEC9YqsfSMmONGFcRT2woW
	cB3gxbd9jXAUKJG2HouVXDiR38c7MZfchWw4lfE+4SaCfI/dsl4zuel2hKKUKKsd
	YfmwMJTHps7munDJgZahGsid6fIofC/ZoKyFYwj62dvQlAhRAyHSHBhcBTLfKRz4
	mxogSfcJBbU4ZoK2YwrFoGgZCCfHCzlgrg7HtNazt6F17aKlf+Bnlquqalgj9lLC
	CeWIc4bs9mpi1RPm6wA63sRy++ZXWSmdLbwpFYS+8Uhkj+/QX9oz96PrQDoQPhik
	1yvMXI+z6tvdnREv+A3SyvVXNx9hjuYPYh7bqx9Awk5j9O6kvljt2qERjAPfc1jQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshektgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:41:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604FgVO7012590;
	Sun, 4 Jan 2026 16:41:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj1vhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:41:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GfbGi33096436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:41:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D1C458053;
	Sun,  4 Jan 2026 16:41:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5DEC58043;
	Sun,  4 Jan 2026 16:41:34 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:41:34 +0000 (GMT)
Message-ID: <093daf4f-3ebe-4487-b922-1de0578cf054@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:11:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/16] blk-cgroup: remove queue frozen from
 blkcg_activate_policy()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-17-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-17-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX+WpsrpAV0Xfp
 ud3IGE/BqUYsdcwk+fD9JfH73bzO5UWA+zCOS7wTOC1FCXSaKRtAxwsScVOqtt1q3MjA3FmQmh5
 w0RyHd8mzkwDwIIm9DoxXhB7O6SluYdijZM23Vf9CgLM1hEMvyrOtLRINuJqz0tDPmb9c5kv/qa
 OvbwbhJQRDUzUNUYCho4onppW9t6y6V28UhnfsY/7psRhrJww6tiUukUsy06axDoo5TvBHsb/m9
 BciDbnc6dR66KN3FOAgJHo9qK2+9u1uWLfnHulyn3p1R+f5/E8ZRGKYVk2nkLHp5A8WeSJ6si31
 MYzcMQd+UpByPyHejWfTk7WTlQI1W8hktY/pP8h74lz/01pdH+PMopbNyGk5I0Bo8DhIwWN7DbA
 4VCDAxNGI0pNlx0Neo04bjXOfQ9+gcnYwxhFtiuny+zFAW7Cdkag1yhFUijor6jaM8FnE7H1Rgp
 zSJup1+H8WCuhNaJK5g==
X-Proofpoint-GUID: yGHNN-mE-2i16MvzbjPhQBEVhBEu1vwC
X-Proofpoint-ORIG-GUID: yGHNN-mE-2i16MvzbjPhQBEVhBEu1vwC
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695a9842 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=dCVqPiDxyPADKUYh4gYA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> On the one hand, nest q_usage_counter under rq_qos_mutex is wrong;
> 
> On the other hand, policy activation is now all under queue frozen:
>  - for bfq queue is frozen from elevator_change();
>  - for blk-throttle, iocost, iolatency, queue is frozen from
>  blkg_conf_open_bdev_frozen(&ctx);
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
