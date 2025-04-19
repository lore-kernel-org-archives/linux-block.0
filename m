Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561344690
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745072273; cv=none; b=mJIHpQswB0/qv0uObevgD5I2BzRlnXQQphFWWtQWXs6cuwaWFGC9pD5RN5pWmbQjM18zuSOs3wyVAu6WOFPHun8y6v5c8iEWZduqfGOffg79oDck2nR6vMlKONo5OR0+/P/S0BzIP80IPQvlpTnqPdi3TFYy0gsvmoq59402yl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745072273; c=relaxed/simple;
	bh=y/cws2E4rk42rFqhIDMPqUr1jNn23Q82SU83cEj+9+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJZqAnCT9XH5D2O1Ta8gERNH/ijgb0mb61hYmXVvy4ZgRTskhE9/Wzd/JW+CAF6FJEwv+nAbZMzrtS6Bg3juseX1bknD7WJ+WjOPpUF28RYTG22NEfdxR9bS4eEFbi1Dy1ThnTHbuDyY+/mBidcAdFhRV6uUs4lGDaJqPPaPMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trn3aRJl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trn3aRJl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAfXMt010328;
	Sat, 19 Apr 2025 14:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w9e3Q9
	ffSoZlNBsUOIdFi1Q5sjSLRkx75hXR/8pjmIw=; b=trn3aRJlNUhSdEFDLC7b0n
	zq6N/YzWUHbdp32v+Vfc0FqfSCRez6EQG0Zuo+axoZQDvQ78ItJ3h1Hd+CRaE1fE
	qKDId//DA9fo/5EsOvtDPVVdYN0hRpgJ0PcdH8/8yWahc5/OLgZ9CqjjE2P4Vm0T
	meMvrHlJ+sk0msEgexyW+Je99M/rcXkS3jAyLdne60fym4JoD6Xc+lB7NXoIuZ9x
	b0NC8h8OuNMbRZgRw/BFvj8nijlPLaa9DWD3846qdiYGCzQtIPY59g7T8ZW6Pq+v
	x2lDA4hWqQDCy8CyYgrCRys6PcCz7v/6IjUMvsCj30uzs3NcE9g5QQUJd5f7Hzog
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464a9rgfq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:17:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JEFERI031061;
	Sat, 19 Apr 2025 14:17:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gp7s5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:17:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JEHiSP7340564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 14:17:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7019C5805D;
	Sat, 19 Apr 2025 14:17:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86F3158058;
	Sat, 19 Apr 2025 14:17:42 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 14:17:42 +0000 (GMT)
Message-ID: <1136c00e-65df-4fa8-a6ce-f5e8b9453579@linux.ibm.com>
Date: Sat, 19 Apr 2025 19:47:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 18/20] block: remove several ->elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-19-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-19-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MjEC3HYE54PD1XK4S_XmDZ-kYMkjFMak
X-Authority-Analysis: v=2.4 cv=WJp/XmsR c=1 sm=1 tr=0 ts=6803b08a cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=D4HAyZWMwmOusC4sQ58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MjEC3HYE54PD1XK4S_XmDZ-kYMkjFMak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=805 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190115



On 4/18/25 10:06 PM, Ming Lei wrote:
> Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are called before
> the request queue is added to tagset list, so the two won't run concurrently
> with blk_mq_update_nr_hw_queues().
> 
> When the two functions are only called from queue initialization or
> blk_mq_update_nr_hw_queues(), elevator switch can't happen.
> 
> So remove these ->elevator_lock uses.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
