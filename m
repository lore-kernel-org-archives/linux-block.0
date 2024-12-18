Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CF165EF8
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515453; cv=none; b=TTJROlEastj/Dg6b8kYc20y0DdboE4PokI4HVse6s0CUFj8CD1/+w47IrVgYBlOaZlBq81mlg3ySJ3sGBHFTHUflMEdow3ARNRxgJj9RnHAJuXcuKRxZ4oh+ved9RTHo0mPIYVEcrjfJwT7uCh2XGaA+/5gbuxZ0+fEnu8QU9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515453; c=relaxed/simple;
	bh=ZtjHIqnzsxcg7q7va7C3xHXDcsr5dK8WT7Gvzwpq3nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3iBGBaFXJEy/rVtgZRu24h+yljXgElLhShwAVEQf97XW0osBIG5dyzU/CEC2N3uarG9kQ8xkAa3QVBiMFaTt5xnGrA8lvgHbgo/v32/UUrVbnaWBp2JvOxbmiB/PEnTXLvoYuOc/l4xtK7baJhqEtHWRHxjkc/Y333opJdfLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ewdOAAfI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ewdOAAfI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNvxTa031145;
	Wed, 18 Dec 2024 09:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KsI0LD
	HIBe3noXm615UUAGPUzfHD5hfryn8VpinGrHM=; b=ewdOAAfIR21hIblCAWjcDX
	CWEkl6rZbDaX6rSpmVFbinpl1Kb9bNL6Cck1KKhPiHPvJv4daytwySQjjPGKMJ1q
	p14yAn1CKBvmPEec0Q9D+2uLjmp3XRy6sA0uMgfibzVwmustocSRYtQpnd41w09E
	Vgco8hE5awPby4HvdQ2pC1jVpp3P2e6SS0gK74CVf9uOMlv5C2x3eyezIed/kAW0
	uyrKhZPrwy0F9MOgcqd8eN2M69xKjNi9JCZpBKs2wHTYlwLmDrXmXnW3DZ8WfKjk
	tsmCkacPLfoGfHh8xxhp4e44oe/GhEsc/JJ2ENOIS/UG01iqZvl0rNdsdZE+ndcA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkeha5pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:50:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6xdiD029728;
	Wed, 18 Dec 2024 09:50:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsqf9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:50:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BI9oaUT32899738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 09:50:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D19758063;
	Wed, 18 Dec 2024 09:50:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B79558056;
	Wed, 18 Dec 2024 09:50:34 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 09:50:34 +0000 (GMT)
Message-ID: <1cf36d9b-235e-4747-9c1d-ba2363800369@linux.ibm.com>
Date: Wed, 18 Dec 2024 15:20:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
        "yukuai (C)" <yukuai3@huawei.com>, Gregory Joyce <gjoyce@ibm.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-3-nilay@linux.ibm.com>
 <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-GcjuSPFl6Gs0-vNN7QPtIz8LFlrCB5
X-Proofpoint-ORIG-GUID: F-GcjuSPFl6Gs0-vNN7QPtIz8LFlrCB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180076



On 12/18/24 07:54, Yu Kuai wrote:
> Hi,
> 
> 在 2024/12/17 21:14, Nilay Shroff 写道:
>> This commit helps fix the above race condition by touching a temp file. The
>> the existence of the temp file is then polled by the background process at
>> regular interval. Until the temp file is created, the background process
>> would not forward progress and starts submitting IO and from the main
>> thread we'd touch temp file only after we write PID of the background
>> process into cgroup.procs.
> 
> It's right sleep 0.1 is not appropriate here, and this can work.
> However, I think reading cgroup.procs directly is better, something
> like following:
> 
>  _throtl_test_io() {
> -       local pid
> +       local pid="none"
> 
>         {
>                 local rw=$1
>                 local bs=$2
>                 local count=$3
> 
> -               sleep 0.1
> +               while ! cat $CGROUP2_DIR/$THROTL_DIR/cgroup.procs | grep $pid; do
> +                       sleep 0.1
>                 _throtl_issue_io "$rw" "$bs" "$count"
>         } &

Thank you for your review and suggestion!

However, IMO this may not work always because the issue here's that the @pid is local 
variable and when the shell starts the background job/process, typically, all local 
variables are copied to the new job. Henceforth, any update made to @pid in the parent 
shell would not be visible to the background job. 
I think, for IPC between parent shell and background job, we may use temp file,
named pipe or signals. As file is the easiest and simplest mechanism, for this 
simple test I preferred using file. 

Thanks,
--Nilay
