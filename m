Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293A1C7019
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581082; cv=none; b=XdqL8I92agIuWFWILvs0K6en4Pjab3KG9iI6E9jAdN3W263iMtnjdA2GKKRAMbSSE8LZobXDnJDG33n3oHXAHKhssXvbJNgpQsIon+Md/Vmc5wKN7mLO6PfAlsvXoiPTAJrKz/+kv76UGKXNgksW+OnjJjrNfPtlAR7BKP/0frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581082; c=relaxed/simple;
	bh=pCrn7hjqX9b6/D+8aHiHAlrFzhmc3gVwcnPY4CcDcEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi0h5CEiHRWP8nrUfRI/t18V9rmj6uRFTixbBnKtAs9BV3KAdHj7yNkh8D///qLhISd/+Emk0X/saiDRFjJX87D6qbGNz3CdQa/a2v/RT3ECUhzrgTYPzH6DIcVhocI94wYmrAhSGfAOy92qWrc9qyrQir6MaJpJr6UEpx41MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PabWbZ5r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PabWbZ5r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ONkXmS025731;
	Fri, 25 Apr 2025 11:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wEb0yo
	aMvx+9KWpi1JleMPRXxha2koWekHFStISwi14=; b=PabWbZ5rjPLY2W2SBvd1T+
	i5ecDkNhbELCrNZvzQ91ohpVpq2PIB4yNuVJ2Tx1jIpJCEs/2DKwC/UKdm5bfHT8
	ymUniuVooQ5sS9RgyJ4sqzLNJmpYak+2qvg8SPE33Lg4AghsQxREd4R/DHMExZzT
	djkeKxyd2VqIfLZpb4UgtMty7XpXok1PdgDQwVole4cIFrynrxlXskxff8jvqU47
	QoNjKh77duGEnsQ9JiRyW4nMrSv7p+NJK7fK4GxDEIIbgHm8WKVhI0M/wnbnXDWC
	aTulIEd+4m5kZG+40iCR4Xf1Fi36vHohpAReaBRnTb17zMsjrnyXIMaXLO2tMekQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467y90thny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:37:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8EEeR004062;
	Fri, 25 Apr 2025 11:37:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg050sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:37:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PBbpcU29033144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:37:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D202358057;
	Fri, 25 Apr 2025 11:37:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E04A58058;
	Fri, 25 Apr 2025 11:37:49 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 11:37:49 +0000 (GMT)
Message-ID: <fefaddc6-7514-4c95-8776-13c11523b1b2@linux.ibm.com>
Date: Fri, 25 Apr 2025 17:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-8-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aZRhnQot c=1 sm=1 tr=0 ts=680b7411 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=kX_2TdKB0JYBegB2mQQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y03q8mds2lRrD0ZUym-QRlOBAtsoyEnz
X-Proofpoint-ORIG-GUID: Y03q8mds2lRrD0ZUym-QRlOBAtsoyEnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NCBTYWx0ZWRfX1q1cs6GRJKPu GXD6WaDzGx4Qo6d03vWQAc/z0POE+ZQBjkD/1kBJzd6MtmAOpjgk07G24R+D0BM32IpXxaTNTwG jEsFP3eZaeS8kA6K6wOpqwqaSJ0bbKczhMwajn9EAr3p7DrVqVgk1sh+V5PeDj8Qx+LH7Txtokt
 xm52YssPFi+fNgJU1KVrDJhfaoLnicesBmH+0JRigCMlekLyHdV4U5LOeiqwTQ3r0+n9OwI2lnS 8mFJDceHNQBMN6+w3X11hFQIVHAqnYgkMPRuCKMBsb9ecIbaVlzUNpA7Jxk6ySflNfqQJNAFmrO 0hALB4nly9/r/hONraNE10kUXjUVsy0RhIE2jLAvv37qv/5RMFRoiNuGuuuJC8tCdEBES+tARAd
 IBLxnqJxt9nyd0wjs3SctcAxOhWYkKP31VvMCaqyFGoyOfGIuxdgoLcyvykbC3AVuLw5b7P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=910 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250084



On 4/24/25 8:51 PM, Ming Lei wrote:
> Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
> allow them in-progress when updating nr_hw_queues, kernel panic and
> kasan has been reported in [1].
> 
> Prevent adding/deleting disk during updating nr_hw_queues by adding
> rw_semaphore to tagset, write lock is grabbed in blk_mq_update_nr_hw_queues(),
> and read lock is acquired when adding/deleting disk.
> 
> Also mark GFP_NOIO allocation scope for adding/deleting disk because
> blk_mq_update_nr_hw_queues() is part of some driver's error handler.
> 
> This way avoids lot of trouble.
> 
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
