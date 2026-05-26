Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF221638D
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809308; cv=none; b=p4kQlZQacpMB4fGinLlgtwdL8VLAnIPAaecdbpIB0cakuNzcywITtHbeExW+u2pfhxkb7UhiCrf/SafL13DsySgEJqYlSw15Vk+sWF6JA8/Zy+2L5m1zNoiASHKp/+w3P69hYBCBFLj+aS0JFDhFbq9ogVDZhSVGAK78Vpt8XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809308; c=relaxed/simple;
	bh=xcCQ8gxaQLHAWukbfwN+urF3SG2cfYhZtL5JJPE0tXE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z4x/EQE2acJMRWDJJaDlN4ykC2GnHaS1Uvv6Qszya7B1rR/Ys8/NnmFxpF3jHRM9jWUAr3XIZbmUN9+Aib74suEMHJ1Qy1q+5eWA/ILpSz1osVyMDgK9dWFH5sMLmZmVX/pfi66BQ3FZWC1Nv9A2ISKsr5lBN19supUfcSePDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QyXS9GMT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QyXS9GMT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8j7pa2497908;
	Tue, 26 May 2026 15:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1olhyF
	k3DQXag9mO6pHhpq3tJzVWf/cbDwuDM1WNMYw=; b=QyXS9GMTNaQON3icqRx1np
	3pYTg5V3spQMDZ9kfbcvxEUKnWLQ8cHBSjXGa7OJzTwnJmdm7JnVmDQkT3CJSzBm
	g2ZjOSSBWt9uZwEyreKqNPBLO/4ubAeB9Z/ZXqKJqQKSiHUWPGuscl5Wi857L1UW
	sN56hWFtGmZTXDxY9a/ie8L0zAXGpeEe9ShAmqLP0h7GN3M39NidMfN4n+OgwcK3
	gD8gHFt3u7/9ViMM0vGU0GSSXsPGQ8yqWPX0pk0P34ZCki9VvAAFuuTkDkIhsC0X
	kFmfIIrGDs9McbTtLL1d1p71U6+Iffsj1jYjFzUPV/8N6aozjZ24Q8WwQkFUtkwA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq3xjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:28:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QFOC3G018038;
	Tue, 26 May 2026 15:28:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg9t7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 15:28:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QFSDAX32637628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 15:28:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B036E58052;
	Tue, 26 May 2026 15:28:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5111658056;
	Tue, 26 May 2026 15:28:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 15:28:13 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 10:28:13 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: yukuai@fygo.io
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        tom.leiming@gmail.com, jmoyer@redhat.com,
        Gjoyce <gjoyce@linux.ibm.com>, wenxiong@us.ibm.com
Subject: Re: Observing higher CPU utilization during random IO fio testing
In-Reply-To: <043e357f-5b37-4e05-9433-271504fc1d30@fygo.io>
References: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
 <1cb74987-34e2-422f-93cf-9174fe913538@kernel.dk>
 <043e357f-5b37-4e05-9433-271504fc1d30@fygo.io>
Message-ID: <4ce7323fc4b02cdabc96c8443d373091@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LVr-jCd-xKC084MO8zQ-KAT51Iz7y2WP
X-Proofpoint-ORIG-GUID: Y1aoA-GO9ZffEfyUmOdrSuMlEbb6foBv
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a15bc10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=lQJ2ouIgk1iEnd2pObUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMCBTYWx0ZWRfX3ZHrNUYSKLmc
 mB6xu5Go26AKWweXCMGADZp0ICvSDs4Xo34bZTZgQ2Xgqqz72+u32n4txGWM3kZYySHzY3LrsdI
 qkjNmsoSfLGRY7iyvpHu29n055R62jSgYZCUNtBbbYuRTlTFAAxG1bDyLRnCVmrDR0SSc4k+A57
 2x37NEZU4oWIYwIWFb0pzrJAIzlaQXZIngY+JJHckA5Q2F51uGFcAZJBGYGYUqv8WIKPdawrOC0
 opQgCz5KXGxHJGmRXbFl3jQNKhfxB08vz/cUpnfq9t54TGn3zwbHvv091ooFANQUj/ubwXM6UOx
 F4saz/uP986l3pQHl3Tk7VAfz1z2+5WfJp2PDLIAaXzVCNBOGZXvtZwc1OxFjC99ESOVOj7ZaFt
 b79WhH2My7Tu5TuAxPkvMqeXk3TIe04jyXYFkXmKJ4GMavcLflWnOQRYtL6g2uz1OeF6vdmQ7Sm
 jFlHsJ/JFCR8/riSLNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260130

On 2026-05-25 00:28, Yu Kuai wrote:
> Hi,
> 
> 在 2026/5/22 5:52, Jens Axboe 写道:
>>> - More IO scheduler interaction, forces requests through scheduler 
>>> instead of direct dispatch(direct dispatch to hardware queue)
> I don't understand this point. Can you explain more? I think plug
> should not matter if request go through scheduler or not.

My understanding is:
Random IO tests are more CPU intensive.
Plug delays the dispatch IOs to hardware queue(quick way) directly.
Plug submits multiple IO requests in a batch to defer submitting IO 
until calling blk_flush_plug(dispatch to hardware queue) or task gets 
scheduling.
> 

> And I assume you're testing raw disk, because filesystems should
> always enable plug.
> 
Yes. FIO random IO tests over raw disks.

> Yes, perf data will be helpful. And please show your test in details 
> and I'll
> check if I can reproduce it.

System config:
47 dedicate cores
120 GB memory
PCIe4 2-Port 64Gb FC Adapter
64Gb FC switch
FlashSystem: FS9500, 12 LUNs/FC port

Below is fio config for rwmixread=100:
[global]
randrepeat=0
buffered=0
direct=1
norandommap=1
group_reporting=1
size=80g
ioengine=libaio
rw=randrw
bs=4k
iodepth=1
rwmixread=100
runtime=600
ramp_time=5
time_based=1
numjobs=20

[job1]
filename=/dev/dm-2

[job2]
filename=/dev/dm-3
...
24 jobs in total.

We collected some perf data. What kind of perf data you want? Let me 
know.
Thanks,
Wendy


