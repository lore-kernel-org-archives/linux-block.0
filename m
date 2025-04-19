Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408B4690
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745072469; cv=none; b=M8q+pacFRMiuOo70yXdxdXNkFt5MtYqFTCWT/UwbQh78oKirPKliijVaMNJ5aPKgppaD4l5f/V4h5TIT+qMqMLfqqasylDVz9n5y0oHfjyywU3R3egLFBNKgpC+oNg1Agj6pR2mbSSS6i2Szn3BltxiX+9KIGUIVwAb5gT+6xRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745072469; c=relaxed/simple;
	bh=1q0HUVN2/qAvChdBtVyHfENVOZ4IZnIXpdRuYJ2mr+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEJjM2ngUESrwLiyMnc44ruASzW9c/puGMPZmCKl/X5jHLJiKY1YFndhCLb7AWCfqQn9YSf8EDA/6ErYPDkGIqJ4rxXdAJx/SNsrjnk6lJi7lqv3ysDNJnDa3QHwZj5e4gi0TR0FV+00/RuW2Ek4Gx+ffIPj/1OxuBVMJ0ivQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MA3jIaZy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MA3jIaZy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J7quKo007537;
	Sat, 19 Apr 2025 14:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3mbNGw
	n26smJkKrLA8DFGBhZQONDFICKhBlD8V0ZgFI=; b=MA3jIaZybFAUtlm2cHEJuR
	dPVR3PMeYfNMfYjNI5OdSRh5jXpGapyeZ3Wjy3Dj5Ocjn2xhLSoZBuD3LxjjMCPD
	poQUNTFcmiCJQoejbEk8qXk2ZQ1j/Njy2xyIjiJVH5ivHwY0x7vOIKSMWlSM0BXj
	+tkUrHe0aJsOpNh16mi6rXVEB6XDnl//XUkySsl27qa8BexODvBjrxjX3d28Nji2
	dEQlDuGmNcSmxC+50adp4veKle+fIXVHl6pSSfuTX1ZcrBBFY/mlAimE2i7n0jn2
	sNhuiZkIk2+ismQZvdzyCFd0eHZohJaydxeOb4sJCBV2J2NUJmIahCtZd1aMvNcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643g09geq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:20:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JDV5RA001255;
	Sat, 19 Apr 2025 14:20:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0fvp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:20:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JEKugx19464936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 14:20:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E5C858059;
	Sat, 19 Apr 2025 14:20:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F7958058;
	Sat, 19 Apr 2025 14:20:54 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 14:20:53 +0000 (GMT)
Message-ID: <78c247df-43c6-4e72-a256-4994ddc33e3a@linux.ibm.com>
Date: Sat, 19 Apr 2025 19:50:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 19/20] block: move hctx cpuhp add/del out of queue
 freezing
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-20-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-20-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1GYpwT_78Ya1uCTdBcnzH-ageECY2-7i
X-Proofpoint-GUID: 1GYpwT_78Ya1uCTdBcnzH-ageECY2-7i
X-Authority-Analysis: v=2.4 cv=cPHgskeN c=1 sm=1 tr=0 ts=6803b149 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=YIm1nm-yB6ElaVZh-vEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=922 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190115



On 4/18/25 10:07 PM, Ming Lei wrote:
> Move hctx cpuhp add/del out of queue freezing for not connecting freeze
> lock with cpuhp locks, then lockdep warning can be avoided.
> 
> This way is safe because both needn't queue to be frozen and scheduler
> switch isn't allowed.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
