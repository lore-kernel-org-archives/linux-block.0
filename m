Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AC1DDA31
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026557; cv=none; b=iihpVyDfDOW1sx6GltJll0EAiGT60507HnNl2vJUTVoep4TQg1y0uIQElPNybmI+RGBcMtlObnaQYBPW7JNlN0xnhBujVl/IEaNAwKu7cL/6875nAQMwExqi95DwzsyVpfk9RZfbIfrlmO1zKjTUGonF6yngFUK3eprjA5gRZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026557; c=relaxed/simple;
	bh=OWAs1gTLJN+Kj/+qFZDsKsFqESVullwJf9p4WeDj/uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rggTaCmiNWKLVTbiSfJ1jZ/+0XkcSNJG6eSPGqoAZ4PfzqKUo67nar/Rkz+e7ipkMoKu+HENmV5jasyYrQX6XWg8Lh9ftq7e5HkkeswajRm1b8zFx1mZRxNKc0UKgh3uKuVo1RctZdHC4iMhpRJX7pab3nZ24/J5bbJ2Q8xRUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tqWoX+c8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tqWoX+c8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G865Jp021162;
	Thu, 16 Jan 2025 11:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=upiXXp
	zW/o2vUWv4FXOH/EWlVFIMkPzLreLiZ7kX1hU=; b=tqWoX+c8Q1whCEEIuTGlfx
	zYCeTalG/KC7D/Sl3CPleHI02ZiM15eO4ZEnI1dfZ9ckyf+hoS76VVTwD2Oi/wnp
	kkWpx+ptLtjE7QFplZsVAK4QEwhyuVRNs8kClKNrj/9jfd3kl+06HGr2pXjkKgBm
	ucedyUBLFT0QreCIBo6JT3TCE5lpGw+v7fxB6kJ1IPgeQVtJ1/W2rxx1IAeW63Wu
	17QKy5Q8yUkfqoNyPRpno36ObbLEg6NOXaCI0ktCKwF1bmzgVpbrS0YdQiY+hX++
	toJGxkuBeizUmJvQZwkt11dyg/CXN6QLc9oWTBaJ1Hhg0Q/OzBSddGkhf3B2UiFg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa38wwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:22:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GA8rnF017359;
	Thu, 16 Jan 2025 11:22:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkdf2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:22:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GBMCWn19071504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:22:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4123358062;
	Thu, 16 Jan 2025 11:22:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E63A5805A;
	Thu, 16 Jan 2025 11:22:10 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 11:22:09 +0000 (GMT)
Message-ID: <5507bb17-b2aa-4df7-ac3b-73b7a8e4a096@linux.ibm.com>
Date: Thu, 16 Jan 2025 16:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while
 submitting IO
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gjoyce@ibm.com" <gjoyce@ibm.com>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
 <3bttr4zv2clzes6q4cuyy3l35ls7cm2r6ljzcgzc3cpvut7dmn@grxcm43s2yse>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3bttr4zv2clzes6q4cuyy3l35ls7cm2r6ljzcgzc3cpvut7dmn@grxcm43s2yse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qIHJZSbUttTHl_0Iu6ev9U_sP_uKhRXN
X-Proofpoint-ORIG-GUID: qIHJZSbUttTHl_0Iu6ev9U_sP_uKhRXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=867 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160082

Hi Shinichiro,

On 12/24/24 1:56 PM, Shinichiro Kawasaki wrote:
> On Dec 18, 2024 / 19:13, Nilay Shroff wrote:
>> Hi,
>>
>> The first patch fixes the IO block-size used for submitting IO depending
>> on the throttle device max-sectors settings.
>>
>> The second patch fixes the potential race condition between submitting IO
>> and setting PID of the background IO process to cgroup.procs.
>>
>> Changes from v1:
>>     - Use $BASHPID to write the child sub-shell PID into cgroup.procs
>>       (Shinichiro Kawasaki)
>>     - Link to v1: https://lore.kernel.org/all/20241217131440.1980151-1-nilay@linux.ibm.com/
> 
> Thanks for this v2 series. The patches looks good to me. In case anyone has
> some more comments after this vacation season, I will wait several days before
> applying them.

A gentle ping...

Just wanted to check with you whether did you get a chance to merge this change?

Thanks,
--Nilay
