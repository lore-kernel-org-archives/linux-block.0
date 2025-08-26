Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265A32142F;
	Tue, 26 Aug 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202179; cv=none; b=rhqRUhzbzotp6Nz9DuZX30TbrJzMSqtPsfdi5d9+Vt/GwKbL35m0jldjQ8XsObiWB3aBcdC0Tg2m5FrfbEFADzI2OOtP8fRtXffwRYJir1MCvbnYVKHSHjvwB9o+zHklW2Dyt5ipDCQJ9ysNs9258m7MfFsDYEXx8it8i5vF2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202179; c=relaxed/simple;
	bh=BeJNyWZ1Fie4kRLOY57azxsF0Sg2itRwuOuGejwWzZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIoA0gqXRkq4tEcqSJIa6cP/KjbVnwCsX0j8Lk4UWRhaYTX9WBh2fxdoa6y7xTVB2YNKURqYpTUItT2yaAFBHVcxJjbiIPmdwGrizWkuT8aOV93Pkik0zvTMtKIzsh9JaXOrclBE0hxEsWVvcueDhWughrFUxKhY8paJk2mJ888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KOWT7ppA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KOWT7ppA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6Xm9G030141;
	Tue, 26 Aug 2025 09:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7RtZYH
	nVw6eX3lNU4nryADRyNuIKrw/WbNMfCfPtBU0=; b=KOWT7ppASrdtjsxjS7aJ0q
	n+1HtY04sD5BdZn2PGVKhF2RnDEwA6NOaLjfT+Ck4rXtwkpNGFXzhh2iKvCErSEG
	IVtfSemENLmcAVx4zTkOeVp1IVWgqlpe+1FvUY37CKKkaYXOnsXwhPfZQb3gRYtC
	s43o13hBZih5j8DetmcFbbi4tAk20+scLTM+0uq0rWtzHAYzHnKMYF31+5JvQFx4
	QbDyvTjH2fg6+tKZHnxfbxZUwIOseFMW9CE3otx04gvCvKPzbwXXVQ/ygvQgvdp0
	DfBEPsGVgCfcqLebzbf4nNLm2jd6izIEflVZSj6xVcP9ic8YUeagfktcaGgtLftw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvru8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:56:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6aa3u007459;
	Tue, 26 Aug 2025 09:56:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuac0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:56:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q9u71I18154228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 09:56:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D301E58063;
	Tue, 26 Aug 2025 09:56:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB6258055;
	Tue, 26 Aug 2025 09:56:05 +0000 (GMT)
Received: from [9.43.46.213] (unknown [9.43.46.213])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 09:56:05 +0000 (GMT)
Message-ID: <b877e779-5395-4162-ba87-2a0e07932eb4@linux.ibm.com>
Date: Tue, 26 Aug 2025 15:26:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktest/nvme/058] Kernel OOPs while running nvme/058 tests
To: Ming Lei <ming.lei@redhat.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
 <aK15dbUiEyr0O2Ka@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aK15dbUiEyr0O2Ka@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i88LFnnQn_h0R8a2H-pHaSAqRmajHcgd
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68ad84b9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=CtkdCJSX4R_F1qFop-kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i88LFnnQn_h0R8a2H-pHaSAqRmajHcgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfXyLQG3xQ+rKOS
 1+ScGmGy8RRDozs/oY0nqPO6WloYOX/pVidR04LeNixUHG8R0xsPyQ7J3GNlRcIiysv0KdxkHcE
 H2ePzI+BhhZdo7+1L5Ncqsd/A7+suKjUCFVkns2H2uFKHcdUS1eEpIguCgM7GqVhBmXqJdZXLtn
 AuJ4FoTpxERbnDZYStpaxdo3IDR26hYTK56+HxqyocT6iOLdqlMk7hzJXeORG5Gyr8Kt709S9/g
 yOdTYCySf1UX5+hnUSLg7m/nViq8PdJGzTxPfI7N+AKtMwfFwIbVv6kKOxZbZ/JsuoZf2KYz3+l
 aIohW3+N5KsoLcRUG2pYztEyXwoUv69vThLM0OD48+aAIoydEPGlRgtD7kVMKMpqRBCFpTL5ufd
 U/K9pU80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055



On 8/26/25 2:38 PM, Ming Lei wrote:
> On Tue, Aug 26, 2025 at 02:00:56PM +0530, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>>
>> IBM CI has reported a kernel OOPs, while running blktest suite(nvme/058
>> test).
>>
>>
>> Kernel Repo:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>
>>
>> Traces:
>>
>>
>> [37496.800225] BUG: Kernel NULL pointer dereference at 0x00000000
>> [37496.800230] Faulting instruction address: 0xc0000000008a34b0
>> [37496.800235] Oops: Kernel access of bad area, sig: 11 [#1]
> 
> ...
> 
>> [37496.800365] GPR28: 0000000000000001 0000000000000001 c0000000b005c400
>> 0000000000000000
>> [37496.800424] NIP [c0000000008a34b0] __rq_qos_done_bio+0x3c/0x88
> 
> It looks regression from 370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock"),
> For nvme mpath, same bio crosses two drivers, so QUEUE_FLAG_QOS_ENABLED & q->rq_qos check can't
> be skipped.
> 
Thanks Ming for looking at it. And yes you were correct, we can't skip
QUEUE_FLAG_QOS_ENABLED & q->rq_qos for NVMe, However this issue only
manifests with NVMe multipath enabled, as that would create the stacked
NVMe devices. So shall I send the fix or are you going to send the patch
with fix?

Thanks,
--Nilay
