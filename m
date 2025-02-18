Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2C1B21B7
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878029; cv=none; b=J02Yrvkvbc/GHZnrE6cX3wfwSGSZBlskfIThOPit3aScDlTAyKMXfk69M3Jxid3Ya2fKSvSXqCfqjFLAk8WJ5w6XinoAv1hbDGfsHtcLefnrm0NLHPDFZY3wEbNzrb4DUm0uTkKa9K4mhijApAV/ynMvqD9FePnsBV5A13tHgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878029; c=relaxed/simple;
	bh=V/PXLSUgrZtgr+WXTxTm0yg0XKUVSD50Y2x1AzaJNY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaFxnnjAT/zF9DgMYrUd9TvFMGoIT5MSJkbi3YtHey9plu+0ePgsoo7MG1DrmH45TlnFSZ1J1BaHx0Uznwu1uyf3pdHKR8TrDQpaFkxcfTrqadzUxVFNJRLrxqEyeqPrto71HqsmsVMlK5ioQg9tz7IlwQwdD9y7v7eGKOtNH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ciokHDKd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ciokHDKd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IAqNTq015281;
	Tue, 18 Feb 2025 11:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yaK6Pl
	h/ju9WMSTr0EFMCrWvD29q0e6DMUS00nk7sC0=; b=ciokHDKdHnQ6XW/OnBQcz7
	6o4f1L8hFTYmQLPm2Q/W5VGwiF5f6cKLdKiT7EbxWYkbPfz+5R/VieFixf3mSvlQ
	ASRzRG0MPp2Mv3qxkBEQkibX42mvkrf3y/Qvc0xqO65MbCdwGg2dSr+ykWno0tkm
	+dSCVTqw6Kqyp+dR/RGzWjXVghb6sp6iD+BFcB45Hafc0wQO6TLv9pWsk6DB/Eow
	SAxz4A4SOguzSvuztaMedtY89KPYuOutkdDHdyFhkdGMYFdCWDC5mpyplrVSnnE3
	y6iJ7Vp04kvd59aCQH+VUychBdDjekIODu89WjvSvT+ow+hiflkhfpMI9NMKNsMw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ve8aau5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:26:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IATkc9003957;
	Tue, 18 Feb 2025 11:26:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68ntu4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:26:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IBQwfL61931958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 11:26:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C1658063;
	Tue, 18 Feb 2025 11:26:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DAB58055;
	Tue, 18 Feb 2025 11:26:55 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 11:26:55 +0000 (GMT)
Message-ID: <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
Date: Tue, 18 Feb 2025 16:56:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250218084622.GA11405@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VrA-VgVcqqS6hYWWTta6TS43stzmmh_G
X-Proofpoint-ORIG-GUID: VrA-VgVcqqS6hYWWTta6TS43stzmmh_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=782 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180086



On 2/18/25 2:16 PM, Christoph Hellwig wrote:
> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
>> There're few sysfs attributes in block layer which don't really need
>> acquiring q->sysfs_lock while accessing it. The reason being, writing
>> a value to such attributes are either atomic or could be easily
>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
>> are inherently protected with sysfs/kernfs internal locking.
>>
>> So this change help segregate all existing sysfs attributes for which 
>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
>> method (show_nolock/store_nolock) is assigned to attributes using these 
>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
>> lock.
> 
> Can you add the analys why they don't need sysfs_lock to this commit
> message please?
Sure will do it in next patchset.
> 
> With that:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

