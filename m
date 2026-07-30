Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B103B892B;
	Thu, 30 Jul 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440263; cv=none; b=DMl/1sUOWO/srrXf9eyVQzS7D4pOUiYbmikiXWJynvco6aYDVzcBsI4ohx9hxItSqzw2PbRFPheoxibBe3c1skuP/BSMAT4a0302n4aP+ntlNMeicwsBbac9ArLYN1NN8D3gzhHKGu9GcCCoSZYhLNODryQwygVPW57uKG/fFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440263; c=relaxed/simple;
	bh=0YUQnzLRm3wS1CGWiEU81s9G8CU7vAZgo/sVpvLcmVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz7mUjOPfyRNktEPgVrHnmjuLzjKeFh+4QKlhHr5fXGIOZvHObGpaUMgRmUa8gdH96t7fYyXedx/Hs2SoJMkadgOOkNDsU48n1dNsfubxKLMF8B5OIsQB1hgGsQT1skVkTFsgE3pU6Drr8H1d9BuA0mYIkBun8TnU3UkoYhAAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fAMIev6s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fAMIev6s"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGlpF83485859;
	Thu, 30 Jul 2026 19:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X9gjsQ
	fxB46lKz4FCmE3Dwab7rgVBkqkYhDSL27hK0s=; b=fAMIev6szPn5WR/c0PuGdh
	hr7m/iZ6C7h5OpwgFNbQWnA1f7fCpIp+GRNTvWVcyROGhLv87PrWkUX1qi4Fejrc
	8H0DH2NutSJ1+MyRkrqv4rkHHrCDe5G2sboTmgf9Jih5ZTGVtwb74P1kzURH9vpC
	QCi6MJoN1bRbcUgDmv3cVMbxqcc9YExdmEj8fZHFZcQyIUisXSn3ssThG0vcKDhF
	7t8mQK6wccQidkgiCVRuCfSCp9DYQ+pnF9KQ85lf2AKJpV0CH2Y07DcVImoXOR+V
	9phNiCjdWqGJcgn+zGv6hYRPsLT5Y+AmAAIz3rq3NKiVaTPRXKSALUcVQmsoABDQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjgn04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 19:37:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJR9t9024476;
	Thu, 30 Jul 2026 19:37:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkcu9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 19:37:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UJbZ6S44695992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 19:37:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE17620040;
	Thu, 30 Jul 2026 19:37:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E88120043;
	Thu, 30 Jul 2026 19:37:35 +0000 (GMT)
Received: from [9.87.140.128] (unknown [9.87.140.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 19:37:35 +0000 (GMT)
Message-ID: <bd8ef96d-a072-4082-81b0-a5d751e5f5d2@linux.ibm.com>
Date: Thu, 30 Jul 2026 21:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: model nowait as trylock for non-blocking queue
 enter
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260730183005.444273-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260730183005.444273-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfX6yHc1p5WRIaX
 O7qOOoi6Rez6KeHXOU7NzZWWdvzpJ20DzoDGbNnkasYr07S3ut868eEHL+WRDlfIvsQNPPuUFvJ
 h3aobv/mF7xz2zyLzuZw5zTu2c6dd30=
X-Proofpoint-GUID: VLK8GjL1TWG91E9qsD7dPWcRJmMykhi6
X-Proofpoint-ORIG-GUID: VLK8GjL1TWG91E9qsD7dPWcRJmMykhi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0MSBTYWx0ZWRfXxp+JnTC3awBB
 RS6y69B9yA/wGCmxNwKYSqVFZCyCs7YMQpCv/A1DVmAS6mnn9TK06wtRFNGccGRm4uAeqqXGE5q
 R0LsAPfSihY3QXV2yg0yDkxsRwlgUWLBjEuyKHBVNPMN5yfWhwqgnRh7DJVecK6Wd8wSxijkThd
 pPAlITFLcVxWk2w3HCOk1zUQjsvw9sxQY5ZEuHo3wuYTFDl5mA88mlXXhSKLkpfc8CSeaQfhdj5
 XKC4q4mxovcTT40CRIxiqAw1+4Sbc4UjvydFsGJgXz4s4NV3wpa7aUAYb2eTLufJnNo0s2QU48S
 AvkQ4/b5XIQlr9xte++BtUQe6EM7DDHfPJXt0BQGOJckXQzZ5RhepZCNy1UsQNGEjXGaho9Hpxe
 6n+sv9ZqlY2XAA5F9h1yQvavHAlK/c5z9bQwxj7iSiV0PivInd4E7MRnQzaQ2ajf1dvk7OEO5Bj
 JcxsKizMdBYdc/b9VpQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6ba802 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SdYOVTMks7EqRTw1GucA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300141

> Will this actually fix the lockdep splat for REQ_NOWAIT bios?
> Looking at the fast-path for bio submissions, bio_queue_enter() in
> block/blk.h still unconditionally passes 0 for the trylock parameter:
> block/blk.h:bio_queue_enter() {
> 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> 	if (blk_try_enter_queue(q, false)) {
> 		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> 		rwsem_release(&q->io_lockdep_map, _RET_IP_);
> 		return 0;
> 	}
> 	return __bio_queue_enter(q, bio);
> }
> Any non-blocking bio submission to an unfrozen queue (the vast majority of
> submissions) will hit this fast-path, causing lockdep to still falsely
> record a blocking dependency and potentially trigger the splat.
> Furthermore, is the updated annotation in __bio_queue_enter() ever
> reachable for a NOWAIT bio? If the queue is frozen, blk_try_enter_queue()
> fails, and the preceding loop immediately returns -EAGAIN for NOWAIT:
> 		if (nowait) {
> 			if (test_bit(GD_DEAD, &disk->state))
> 				goto dead;
> 			bio_wouldblock_error(bio);
> 			return -EAGAIN;
> 		}
> Does this make the nowait parameter in rwsem_acquire_read() here
> essentially dead code for bios?


Looks like sashiko is right on both counts. bio_queue_enter() in block/blk.h is
the only caller of __bio_queue_enter() and carries its own trylock=0 annotation
on the ▎ fast path, which is where practically every REQ_NOWAIT bio goes — so the
__bio_queue_enter() hunk alone fixes nothing for bios.

We need to annotate the fast path as well. Will do a v2.


And yes, the __bio_queue_enter() annotation is near-unreachable for a NOWAIT
bio: we only get there after the fast-path tryget already failed, and a second
failure returns -EAGAIN. It is reachable only if the queue becomes enterable
between the two attempts.

For consistency we might want to keep it?

Note the reported splat itself is on q_usage_counter(queue), via
blk_queue_enter() from dm-mpath's blk_mq_alloc_request(BLK_MQ_REQ_NOWAIT).
That path has no inline fast path so the fix should fix the report.

