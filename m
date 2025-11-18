Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84A248F4E;
	Tue, 18 Nov 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449000; cv=none; b=XvesV+KraL+HnuivQnazklaDuBf5aJw7L/RYPMDwFslT3ggPuoRTCzmyHfr3FTdi1iejnrfX4r+iv+l/EX6h05SiPsnopsbwPt5w/W1ZwWFsEC6sBSUuUuI94EMEDe42NPL/Hg/Ujdi6nnqm3aZqWrOGeucYdTk99QXN5OF2zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449000; c=relaxed/simple;
	bh=XGNztXWtVCDT/KN42Fn+k381ARcgZrst4qjuZyuZ0OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeHwJ1F+tP5GOxC2obLLkBcTWs5X1pH9KRGZS3dVH2oMTM9AM1lzm07kwf8b0cXgjTZdftvwiUsg0qOApUBWHVYLkuAtX3cUUQPTH63l/hlTTTQpQgKJRlhkd8UFnjK6jSpZH6WSRN0kFQL7fl3x/qODzpiUq2Nh4aIExOAo7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nj9UjIEj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nj9UjIEj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI63Fk0001320;
	Tue, 18 Nov 2025 06:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6f19JB
	xA+L/OAJetoUmpW6JDTUcxqNoaz0GmqlV/bXo=; b=nj9UjIEjmm89qFxoV7ysS7
	f/GK05rflXG5wrbmKQ6KVILhTmcxPDl9z0mRn7MPC9yjie4Sbr9IoRJzrOFZ2Try
	4Haf8pS2MLsYFcUAss++vzTao26+MJjnzAB+9mMEedt5r/JER/JjEUxLVeShI7Nt
	k8Y/MG8VZwTmUDf9+SYFQajuYlWIET6X/ArbbuMt/XsEcBTz2Q4U/X6/IfFS0DCR
	7h48euasI0adCC9kahJnsZUQoxnqtAfyDinH65EY1B3HQJIKuLtNqGHcuoV+T2MG
	C2k194uBzGZEicMJ3+NA5d1+vb1/En76+7QOrHr6Ch2B3CtbxBnezjpk+XrKJhog
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgws866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:56:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI3kblj006964;
	Tue, 18 Nov 2025 06:56:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62j9m0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:56:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI6uGAN21299812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 06:56:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7044258065;
	Tue, 18 Nov 2025 06:56:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE6AB58052;
	Tue, 18 Nov 2025 06:56:11 +0000 (GMT)
Received: from [9.109.198.217] (unknown [9.109.198.217])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 06:56:11 +0000 (GMT)
Message-ID: <d35a4c76-cb9c-4fda-9d5c-c9ff8514c4c5@linux.ibm.com>
Date: Tue, 18 Nov 2025 12:26:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] block: Remove queue freezing from several sysfs
 store callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20251114210409.3123309-1-bvanassche@acm.org>
 <20251114210409.3123309-3-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251114210409.3123309-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ANkC8AGbR9Jrdq8Nu-uTe-ou9HwPZqAv
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=691c1891 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SmKCfEfQzWduBHVzYMUA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ANkC8AGbR9Jrdq8Nu-uTe-ou9HwPZqAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8EJrYltZs013
 KbwG6hrl3bhmLU777j3A9y4GMZXoXJKeXqT7SoviOV5uQtWZxnauIiBlqWTj6r7e6YOUzAKrO82
 4ASUAkQHqadzBpLS+OuMEDa70MaVI8S7+ZDd5Pe6MANCRSoYY22DeGt0/CEDDX5NGd/0rkpW8FZ
 SR82Sd3uPzj/UFyprXNWjxv0fS3vbfFsxZyB3XKcpt4HIBjJjzKhCoFECeHobv+kkxQhK5NwrDX
 TcGcpE22OpM+dUHwB3gOszU2hsD6nYTn45Kqfc93XEDZe/UbZWtMpkcitfUO+pWJigTu3DE/Rb2
 G2l4LEoVLC4lwkAZkGacFaW7jwzewex37H16mj7wIWeTO8nl9tfjPmIVRqMNe8VmaTuYXTKfWQp
 70OXojv1Gb4IUB0nhCD6Fhne4yu1jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/15/25 2:34 AM, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> Add the __data_racy annotation to request_queue.rq_timeout to suppress
> KCSAN data race reports about the rq_timeout reads.
> 
> This patch may cause a small delay in applying the new settings.
> 
> For all the attributes affected by this patch, I/O will complete
> correctly whether the old or the new value of the attribute is used.
> 
> This patch affects the following sysfs attributes:
> * io_poll_delay
> * io_timeout
> * nomerges
> * read_ahead_kb
> * rq_affinity

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
