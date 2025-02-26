Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D288221562
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571850; cv=none; b=Qdihivr8/Cnwg3bcG7g+73wc7Auoc6G1OfOi1PPV4mhpFyDg+wjlJbv3IP9CaCF68zkyZO/8mhZKmyJim8JR7HhPD9McJYaPCInNISrEC7Itv+wmIebySiB6u86Dgar6+azUNHUVdEAxPj/uSsCi/1ak8oxyrbynSb7EdYRADp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571850; c=relaxed/simple;
	bh=+EqQaOeQQEg95/msGx6rFG6D+dI0yDatAgLYqIC/fPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUfdYf9fPzeBysgdle3t2xCyeZsJTsWuwANdUNqzbkQ2ycJY9KNyBZp6/vmCISgeE8VbHg4ryjf3rKjC7lncU1wipDmJ3hm96jcqIiGRGmOyH9a3YnKaz19iKw6B8hJ45UxPtNL5utkRK1VbOT2ckSxQdz6ezSI1QPCGNai9sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BT0fV2ff; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BT0fV2ff"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7WvIR006037;
	Wed, 26 Feb 2025 12:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RxEXVs
	n62bf23EiHimiCBSHxzAaQIi+ts8U4quJTTbQ=; b=BT0fV2ffHCedpUV+MwS2ZA
	EQ9mMHekiLZTnOHmVLrkOZszTcii4KgHIqlrsqv9Iop7xASrjFlFeZZLMRPzsSTR
	sdatGAdZl9Fu8XWiK65FvAL2FpawR7gSQqEUa0xEMa4iLRKm3WUZ5frXlzOQ2Som
	puZZ9BmiheAheuBL8jTBGgYlEO8UccAFxo7oNM2CqEi4uIM2keoyzBmP7GKDFTrd
	+wO7fUkurYCDHVNpQFsxme0ZaCEVpO/xFzKFKrjy4N02LOHdwMLb7RxCxVrGVjci
	17eukCCZB2NPHZOZewFQLSEILuT0OZstiFg8znFPBEW4D+NR2dOes+0sIy7dwFrA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp15u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:10:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9hCRH027340;
	Wed, 26 Feb 2025 12:10:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum22352-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:10:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCAdPv24445256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:10:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E27C858059;
	Wed, 26 Feb 2025 12:10:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF7758053;
	Wed, 26 Feb 2025 12:10:37 +0000 (GMT)
Received: from [9.61.110.139] (unknown [9.61.110.139])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:10:37 +0000 (GMT)
Message-ID: <138fb809-a307-4178-a126-b5a63bc87255@linux.ibm.com>
Date: Wed, 26 Feb 2025 17:40:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 7/7] block: protect read_ahead_kb using q->limits_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
 <20250225133110.1441035-8-nilay@linux.ibm.com> <20250225151410.GC6455@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250225151410.GC6455@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OBzbE16m_T9DV32vxuVkcC5LOr5bhRsv
X-Proofpoint-GUID: OBzbE16m_T9DV32vxuVkcC5LOr5bhRsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=638 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260096



On 2/25/25 8:44 PM, Christoph Hellwig wrote:
> On Tue, Feb 25, 2025 at 07:00:42PM +0530, Nilay Shroff wrote:
>> The bdi->ra_pages could be updated under q->limits_lock because it's
>> usually calculated from the queue limits by queue_limits_commit_update.
>> So protect reading/writing the sysfs attribute read_ahead_kb using
>> q->limits_lock instead of q->sysfs_lock.
> 
> Please add a comment near limits_lock that mentions that the lock
> protects the limits and read_ahead_kb field.  I should have probably
> done the former myself when adding it, but now that it also protects
> a non-obvious field we really need it.
> 
Okay this will be addressed in the next patchset.

Thanks,
--Nilay
