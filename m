Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26298338918
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722451; cv=none; b=Pq5TTliY7rpv0Wto/ij3xXZQ8OF6wyLR7rjYXRlJVRC3xaX2gaC+kAAUYtZ/5MVfxvdQZzBIS5r18CBTQknUgICw4X+IP1U1Fa8thNtiWnwX59FwtrAVGjrKwFy3RQ3Uw9XwJUIAOTTh2Q+OBKSQfUGuAQ8/aSEpmPgU9K0DC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722451; c=relaxed/simple;
	bh=PJHdRSqPRMWwvm9psJHmYpnOs1pwZAtPIiS5o9ve83o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=tErckupwS4pkKf22/t3UiMFvFmgcBHs2k7x4yyw2WzHvQjCYnTJ9pYxIMgY3y4hejXjaEhQy85+Wsovf9wMyjgbYs5toxsilU0B2i6pycICToBweSXioKtVxwY3iORdx5GmZe3vsr1nb75uAGC/XGjYMJ7zA2TstGrH1AHKFtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IIRYMt1k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IIRYMt1k"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKNP8NO008180;
	Fri, 21 Nov 2025 10:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=An0RNv
	UBa/VKxLl35GncxWvYRQNB5svBxLlbFqG7Bpo=; b=IIRYMt1kduX3+c+JELbkOw
	8SB24tefGb/zV09WVFcPBf4aeSHrI/walzlePY7lc6cyf2nFAAe3nBmSehiBMP+2
	3r5g0oI0vvX2XsXp7XaGW9RblzmvYfEyHEox1yM78UEkR1+4ft5gZmuY5jF4DNNB
	GTbjFDGDUA1/V0UgL1mwlupRXRhkiUAWEM3YqHAUViX2oatPuuYMH8CjCEGtvo/X
	nJYfJo4K8jrNH9h5zZNinvPpoUjOC2Gi9Fcgk9nrVIMwgbsHRj0ApCikNW54b5ha
	C7zaZuqvlbjRsn8oB+fZ7q5AVLCSePbaSZ1ENHGNS9R4fGDC1llCD3WvV47aDd5w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt1ysy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:53:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL7vIcA010399;
	Fri, 21 Nov 2025 10:53:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3uskw7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:53:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALArqw022217324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 10:53:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B3658059;
	Fri, 21 Nov 2025 10:53:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28ADC5805C;
	Fri, 21 Nov 2025 10:53:50 +0000 (GMT)
Received: from [9.61.88.15] (unknown [9.61.88.15])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 10:53:49 +0000 (GMT)
Message-ID: <400cb68d-6137-4618-9b85-6b43a3732827@linux.ibm.com>
Date: Fri, 21 Nov 2025 16:23:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] blk-iolatency: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
 <20251121062829.1433332-9-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251121062829.1433332-9-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BioskYnqCfOZwGzebZ2OIMzqEHmDkVLq
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=692044c1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=vWzy9drrMdHGQuv-iF4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: BioskYnqCfOZwGzebZ2OIMzqEHmDkVLq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX98zVvsvwn+pB
 nz0R+sVHd8mRW4GK8hQB6OOkExWsijHOKnR+sApmFXZqVqQJwsw1wuKs6hG0WOOz+ZLJri2VBMC
 19HcM2MTHbi8LzhycqSoW7OwziXlGs4izPArnvL6dVM2RHxmIqOFTnzIOlyZMH3CnjjR8m3FBpI
 aBucpLC+bLb+E0RTAbjNDn3Alio8qntld6dy1ua6aScFBOw4PgYHXy5HxXr9q/FPm0HM0oeBF8M
 qEJtkvmuPyhj4ZIMOYXlTNQBEdIE7QkHs3dt4e6hJ2ioW1QxiJ6KakNbom8xKtr+bGz+t0OD0/u
 YJ7+FzZrLPL2Aol3DdUbjUaiMjzFSEaC5d+7PAxVDOo694VxOG1NV8oKfm/Qnhr+x5OR3ATvR3O
 6dyF6srYjnrTnPcnrv6zDOdL1fSAPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/21/25 11:58 AM, Yu Kuai wrote:
> Currently blk-iolatency will hold rq_qos_mutex first and then call
> rq_qos_add() to freeze queue.
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from iolatency_set_limit(), and convert to use rq_qos_add_frozen().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---

So with this patchset, we have fixed locking order of ->freeze_lock
and ->rq_qos_mutex for blk-iolatency, blk-iocost and wbt. But I still
find following code paths where we still need to fix the locking 
order:

tg_set_limit:
blkg_conf_open_bdev  => acquires ->rq_qos_mutex
  blk_throtl_init    => acquires ->freeze_lock

tg_set_conf:
blkg_conf_open_bdev  => acquires ->rq_qos_mutex
  blk_throtl_init    => acquires ->freeze_lock

Thanks,
--Nilay
