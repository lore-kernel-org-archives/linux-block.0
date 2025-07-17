Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824012F85D7
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762167; cv=none; b=YmZusl5tBW+AdPnRXDb8SpizSDRHuZm/KfG+FeFYuOHm7stTVmBAJYzn07lnw68lfzPF8dg2jg/UHMZYm0gnf0w4LbgDc+DqeFNYxRa9aS9Df2H//tMQbGHvkBJzE08ogp3L1G/nD356XQ8b8AFQ3jULOQ2XnIIyZUxsXSUn6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762167; c=relaxed/simple;
	bh=An0pFdgpuHjT2xlaz1aO/B26hRt8Sn/6KAkx4byKjSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKl1H2sz5RIJ9aA3wVQ8/NGYRBc+xMIZdbMhycTrtyLZaD8zkLb+SkrNmoKO5CEVOR+m21cs00IegLvCTkjUjguZ6oLtbuBp20q6ruAm4/V1thdgG/kfzRne+o1J7cPMJEFDZ0WspgR33gUiXDV+r+IyyKeViHosgHZY7RynfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dePpLtgs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dePpLtgs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBJ3Zf027402;
	Thu, 17 Jul 2025 14:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=huxOp1
	Dlm2fcDr2K1SY7BcpEyj+J+/qJraT5rXRA+fk=; b=dePpLtgsMbJnMVijtSQZeo
	FKwYTjfK3kdbJXXonzwm1V7R/VMH3Rk5GrnbLjc8jzJ2eV21ooiCYz0JNY/OBI6N
	NZ/XyfzE0WuDTTHaljIhGb2hsmbTpTPZds5615WQgxk5sRdVCL0mWnD/RDuaOCvi
	4YOhwtaWHkQZkd2U48KzwgM3GKz50ks/cLXBAXS3CQZDkbjhQWIvlFjrl6WKxJy4
	Lc/QF6DFXaTFCLwFaqLqs9PlrxC4ZDbwjvtIhy+t5lileIrNPJGs24aU3I20ecQi
	aXcGZO3gcu3O9LHUzam3uIT+X+knVhdOhNyaMlDdTP/k1V0nB4s9V15Ce7DcwjMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7b8qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:22:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HDiS2e000733;
	Thu, 17 Jul 2025 14:22:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48mcavp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:22:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HEMOHm31457912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:22:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B77A58055;
	Thu, 17 Jul 2025 14:22:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DB058043;
	Thu, 17 Jul 2025 14:22:22 +0000 (GMT)
Received: from [9.79.196.226] (unknown [9.79.196.226])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 14:22:21 +0000 (GMT)
Message-ID: <23039b02-2595-4a6c-962b-fbfa7ae4736d@linux.ibm.com>
Date: Thu, 17 Jul 2025 19:52:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
 <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
 <aHg9oRFYjSsNvY0_@fedora>
 <CAHj4cs-WTU0Y2VbgtKL24Wxe+1CGJoPP+je_w=Xg1bu+JizHMA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs-WTU0Y2VbgtKL24Wxe+1CGJoPP+je_w=Xg1bu+JizHMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68790722 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=lYAvP-sluYjmnx_0C4YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNiBTYWx0ZWRfX6ONgkhZVgw1C gDNoXVlRQexmsIBRDY477r0KQXHTh78Su//oKbKftiClD7rSnFFCSpK+xjXJLqIYUhzFtcLxnp/ 4LccRhGYXevxr50E2yBWOYsSakNpNfA0mCPpz486lGdCfPrE7aoWbEng905lUdLIIvbAd7C9reZ
 bHMPgor7WO/eSNUobtoAfNumwiAZgV2iJdTWDjU9fxqUe/3I93tFTzYWgTmhWFEXus4jyOTYW8s 7KLNH78qWCty0BMtXmz/RKjNIwy+u3ZIMXQsg73LZg2Lsn47kOr41VLk91f8oCgxCV6I1ldwwgE hzVXCmSkG+I0X0LlpZLGWqBLFpAywbJiVOnyYVrU7XWdcNf6dLttKRKrF2HcOETlnHggOsJOY7B
 XEfrTe/WpKSSZgX/jzGOr/gmpe8D9XH8RutPA+2hsZXVnYtIs3gLgxr7Qqkbzl1z2wz5/gLB
X-Proofpoint-GUID: Fq4fS4gYvQGDIr7sQQoEsd84BSEkGfnM
X-Proofpoint-ORIG-GUID: Fq4fS4gYvQGDIr7sQQoEsd84BSEkGfnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170126



On 7/17/25 6:16 AM, Yi Zhang wrote:
> 
> Sorry for the late response, it takes me some time to find which case
> triggered the kmemleak.
> It turns out that block/040[1] triggered the kmemleak, and just
> running [2] after block/040 can not trigger the kmemleak immediately.
> We have to wait for more time.
> [1]
> [  458.175983] null_blk: disk nullb0 created
> [  458.180035] null_blk: module loaded
> [  458.397994] run blktests block/040 at 2025-07-16 20:31:20
> [  458.571488] null_blk: disk nullb1 created
> [  874.620574] kmemleak: 522 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [2]
> echo scan >/sys/kernel/debug/kmemleak
> 
This brings to mind a potential improvement: why don’t we enable
kmemleak checks in blktests? We could clear the kmemleak state at
the beginning of each test, run the test, and then scan for any
reported memory leaks.

If kmemleak reports a leak, we could:
- Mark the test as failed.
- Append the leak details to the test log for later review.

This would help catch resource leaks more proactively during 
automated testing. If all agrees, then I could workout a patch
to blktests for the above improvement.

Thanks,
--Nilay
