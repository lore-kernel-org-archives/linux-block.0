Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E23A8FE1
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192580; cv=none; b=PG47VLBoUUPnveTGiurBpT2bhVFuLFLkj8VM+9u1dJBvtkygXmMKjTe5MwheXbs6kDILi40KSevbPxXrfR8HFAVaCtYNh/Uf4wQZ5a6mtCUsqwVxU//sIBlhnZ+1HpXYhcP56BKz76tT9U2+o3qY/egbpouYet2hYM5W6/qNWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192580; c=relaxed/simple;
	bh=ptRJkoqN2LjFqXRwA7BSe4UszxQijsV08dR5610Fsjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDsEKl+FqRNga/Dy68+nAAt+0DJRatmRXmYdf0gJZvRXely8jkrXt2FwFBcrYeVdJa7j8iKA8fPer+/LBfZNjzAzvHb+ZyxElPPzyE++aY7VcjM5PDisYdrFf0qkrJ/py23DPmbQPKn3+x5/aovba6aZM7HTLM+H89FAoDlMFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E03EeB9i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E03EeB9i"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mXwG408490;
	Tue, 23 Jun 2026 05:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DoC4me
	LsGc6fzsTvezQ6ByaatUDOkhhCR0ePCnxx0Vk=; b=E03EeB9ivenZgE+apZvgYI
	RaSJJi6Wboz1PJtg9CIhasNqB46kgdpdyL2/0VQ/qx7gn+gU/ic43IYnZ0/R05+z
	YOGoi20arso5Wrb/DPikHPUGoiKeIeNxs1OTxyoLF79fWlCkvISobNbzIXlvlZ27
	q+TeMvHMRYAygfElmGrkSoytg5ERrlBXFrdfgkQGYSwgH8eY5ONYlBfRc+175HAA
	Cgr+q49l/hLMFq0LSasFXwO6REZxCSmR/UVCxqjJ47xLLj3feTfKSEduACvAJQNd
	lue6ZL4lYF/KoBEPhukFZyccd780cgIvGaflq4ZWk1WK/O0nlFk2UfUw42dIguaw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3cstj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 05:29:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N5JfUA032284;
	Tue, 23 Jun 2026 05:29:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph9m1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 05:29:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N5TU4q19464714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 05:29:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 136C158054;
	Tue, 23 Jun 2026 05:29:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A85558045;
	Tue, 23 Jun 2026 05:29:28 +0000 (GMT)
Received: from [9.43.75.139] (unknown [9.43.75.139])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 05:29:27 +0000 (GMT)
Message-ID: <712b698f-c67b-4d90-bf50-055fe7a09e96@linux.ibm.com>
Date: Tue, 23 Jun 2026 10:59:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a19bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=_xGJq85ICNxIfZ7E:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8 a=eR4HSyMmvT6AvjxFh_YA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0MCBTYWx0ZWRfX15fJ6ljHcNeK
 aoPrE0ZGT9LOOhEmkzuyQX1zJmgsz/brPALsGkYTQZTHbdkmjj/oEbTm1g3TNZsBZjvbGpvltT4
 IF09PMOlZ594qP519oqU4NVJLrZDo8g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0MCBTYWx0ZWRfX2QpwrjunKPd0
 ELf5R5Xjl/XdsbsdGESRSZWzu88gewWBKdJfPwzge05fiHLWdICAba0JH6yHwT1auJ0lduIRzlK
 BXFCnePA0wFZMYoLwGS8iu5e2eyzmkG+6shbbzyvhWPV8p0UAWdaCMFRTZir4sy/8hbbdUq6HUH
 hqtg5xhusNxAM9K+bPOdWvXDgc99wsqvfCE94CjfkmbwxVa5zytjfCT2rIv9SmAHuw/2Nf9/gwL
 C0mCsziiKHCIrJABSmdv359nfjp1GAz3GtSly6WIsRnVKgSs1p1yGHmvdfIVzOSN5iuzX8wfuol
 C15ShJFPQ/WpYe6MwxBYafKwpHsWpvS4h5NXpgvJTP+hcorFQDOhMkjDlRZkJ3beP5VfPiY5Nmy
 +poqYd4AH9LYUWLSy3A2ZRefMc9/Nxx6VByLYSeV0qyJ9v0JEjJ9CSzJ/XyqWM2f6UzpJAd8EKy
 kPD0EFn9iZYDVv1e7CA==
X-Proofpoint-ORIG-GUID: EgscFcdd6QAkQvKsGNJkxcU7pGmnwR3c
X-Proofpoint-GUID: tRkeqGJnmQi5CIFbG_0_yPNZT_iRjHIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230040

On 6/23/26 7:02 AM, Shin'ichiro Kawasaki wrote:
> When elevator_change() is called concurrently for the same queue, the
> elevator_change_done() function runs concurrently as well. This function
> adds or deletes kobjects for the debugfs entry of the queue. Then the
> concurrent calls cause memory corruption of the kobjects and result in a
> process hang. The core part of the elevator switch is protected by queue
> freeze and q->elevator_lock. However, since the commit 559dc11143eb
> ("block: move elv_register[unregister]_queue out of elevator_lock"), the
> elevator_change_done() is not serialized. Hence the memory corruption
> and the hang.
> 
> The failures are observed when udev-worker writes to a sysfs
> queue/scheduler attribute file while the blktests test case block/005
> writes to the same attribute file. The failure also can be recreated by
> running two processes that write to the same queue/scheduler file
> concurrently. The failure is observed since another commit 370ac285f23a
> ("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
> changed the behavior of queue freeze and it unveiled the failure.
> 
> Fix the failure by changing elv_iosched_store() to acquire
> update_nr_hwq_lock as the writer lock instead of the reader lock. This
> serializes the whole elevator switch steps, including the
> elevator_change_done() call.
> 
> Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

