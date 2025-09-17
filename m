Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C434F46C
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104963; cv=none; b=bXKw2EKJXbVtLQ0rGVgEGsnuP8my2W5rePTSt1WpAtEN5kACw6ZWVxTHyBNM6BfEfuTWIY2K7iW0gYvnKWTJYCgIu4nz6D8+UOhao6AnNFPRwtcpZgQvJJxKHPw9isRF42pgA6ndvQ0b8eGQr/78IM+tO1HG7OXa9aywacFKw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104963; c=relaxed/simple;
	bh=TgaGxRYgSWzrP6onNMNh7+C9kqBvx974QZzyGiN4jJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWh428gMMSvU9Kv4VTlVCkJR4mHBsMXYQvpnlSBatH1RvN6EfjLbNGH1qVfxC3gx6i1A3DseMgDvS6+hLhOKfgskCAmsH6s1z+VDKO3TrqRPDNFt3lU5wlBftrplCQj8it7J0X6nL00RU2ttdOx7J0R8dZGLkfh/KlXZCdBbQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIj6hxLY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIj6hxLY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9xdE5027213;
	Wed, 17 Sep 2025 10:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fooYRw
	i4F5iq6BamO9HXxVxIRgPzhqYOe0IcR0uNjiA=; b=XIj6hxLYmlI+g07YW5CcqO
	OLHfNf0cNX5Nsyov6jpzkLLmQhcaICmc7BXxuZDdepVGJSZHwcmYf62HRfyHJA3d
	w3+8JzgA5YVb/BbHpB5RFzPQWDbrEWWdE2jqLtxfECupLiKZBQChzheR2tKgr3o1
	0uH6RIDLj3TkIc9lL3br9nnDmpk/2AAt0bbuCyH2GB1QnBzJ37KwpF88k5mvRIjr
	jMWx1mbCvHYPRxOA4drywc8KR7Az/4L/7q+47MESZUwDavH8kO8qTIyEndf671RA
	yjNIKEGG+YgCmdrEV+Mu7gux0x5tPzo66UksUNQChKJJ6TS3EON8e2VTH9DJiKXw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p31uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 10:29:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9m75f029484;
	Wed, 17 Sep 2025 10:29:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb10x4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 10:29:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HATFNp25821848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 10:29:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C2D58059;
	Wed, 17 Sep 2025 10:29:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1436E58058;
	Wed, 17 Sep 2025 10:29:14 +0000 (GMT)
Received: from [9.43.76.13] (unknown [9.43.76.13])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 10:29:13 +0000 (GMT)
Message-ID: <442d0ed5-22d9-4eb8-940b-428636b49a8d@linux.ibm.com>
Date: Wed, 17 Sep 2025 15:59:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] block stacked devices atomic writes fixes and
 improvement
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1K2ee/NBm28F
 8YbqV8/tNHPRuYnmZXQ9DAtfje8ekY2J9DBNO5rTBPag4T5ILuI1IrkKCkBLgrK2GqJpAGHjGRx
 TBchcuDYXC121xAii7Peuqb7weWPp9q8x97G8erbTN5S5TdCvRJyvqplJpclO5c9rdwqybQ2ejH
 wLMGoj8fnGsa8qL4LiUkuRpOsykUHKKNUp1s9JmM4KLfZ44BBgUH/Ye2BI3JdfqZuyc5zrQfAV6
 jwUpFnBQJ/kFbBMD7tT8PuyJ/yz3wa0P9cBmBL17uz3P4CvayA/d8W0TJpiTezqXwOrNInb1WLz
 xY5n54uvpnh68A5mKgAHxyJljLUN1pGWONmkncJ22KIn/Z/qG5aRxy+43sOmmOdtooPzpGKa71D
 RhuFZ2QQ
X-Proofpoint-ORIG-GUID: ppNBm5ltwsVPa1D9vg31CIjBsdsEBCey
X-Proofpoint-GUID: ppNBm5ltwsVPa1D9vg31CIjBsdsEBCey
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68ca8d7d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=Y7LfGanKoOrE7isaxJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204



On 9/15/25 4:04 PM, John Garry wrote:
> This series contains a couple of fixes and a small improvement for
> supporting atomic writes on stacked devices.
> 
> To catch any other issues, I have sent a separate series to improve
> blktests testing for the same in https://lore.kernel.org/linux-block/20250912095729.2281934-1-john.g.garry@oracle.com/
> 
> Based on 7935b843ce218 (block/for-6.18/block) md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T
> 
> John Garry (3):
>   block: update validation of atomic writes boundary for stacked devices
>   block: fix stacking of atomic writes when atomics are not supported
>   block: relax atomic write boundary vs chunk size check
> 
>  block/blk-settings.c | 81 ++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 44 deletions(-)
> 

Changes look good to me. I have also tested it against my NVMe disk supporting 
atomic writes, and all seems good, so:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
