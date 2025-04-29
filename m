Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5D1D6AA
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907996; cv=none; b=UGO0Fp6XqNAcH0vy1J2+9eKEZuk2YAare5dO/8v6IpgwzJERQVVEe2DJsltvtmsWxL0328X0156L0cp/c1zPslk6cZ4DZl9CqHNAVL7D8ESYg/RHep1tF8s9NVtIJwoHrx25nPyC7HSvlDjP+bX2E0HsxVT9VRpoX6ogoKChnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907996; c=relaxed/simple;
	bh=w5xmDrnv+yRAYk+8SLEfOxgC7M2f5UCClkgMAHF3J+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJutY5osyrAweKrDpUKQEWnVbG79gsZdXI9mJYXdpxYLr76LHtaDFcIhgKonqQvmQaPFqaiH/skoBZ8lpxwTWUP7/FcDc7IFja/v1wbCobv26wT/TvKHjJnUuyAZqoQfFXDY85O4ugkKbhB1RlKUGPQ2NCFdUskWlREi+lsaMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMEvcfX7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMEvcfX7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EPYS029711;
	Tue, 29 Apr 2025 06:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t2f/Jk
	ZToUzJH7eA3ipwspXv3VhrZyo1pxPEv1R9nj0=; b=CMEvcfX7qmtNMa19osy3um
	BuuUoO3efRKkEgpWlD1B7AP6hyPnwFWEyOMFWnygL1wbW0m9Y2eoUPZQFMhJS/iO
	weZ/eussS/4FdVZ0oktNWQlvoTfx2hE/a58SqtqaRFpXYNehDpGh8zuVh1PuyHaz
	O8h3JI0l0pBkBROAE48rBHwoejoinODZU6XtU1us3Un1UIfU2Keb7ZLgrFtJfVe+
	4Idz7H2NbvfDjFoTnBEkehN7RgoRf8ArboxGgIl6ngkSqOKOBWpXPKCNWTTf3GM0
	hx15Jn+PlPXKJt8MkkSuGc1+MjezomGlN4sy7LYtbkIvfTGZp1Hrvek6BQLw2AMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a84s4eay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:26:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T3qfYD016174;
	Tue, 29 Apr 2025 06:26:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70a3d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:26:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T6QAFb32834082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 06:26:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BEE358056;
	Tue, 29 Apr 2025 06:26:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE1C58062;
	Tue, 29 Apr 2025 06:26:07 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 06:26:06 +0000 (GMT)
Message-ID: <9a4245ed-bd5d-4a42-b8ef-3d4e557c69c8@linux.ibm.com>
Date: Tue, 29 Apr 2025 11:56:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
 <20250425144540.GB12179@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250425144540.GB12179@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mchsu4/f c=1 sm=1 tr=0 ts=68107103 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yCh3Tjrm5dVL9IxFuOcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0NSBTYWx0ZWRfX0hgqJxtWUuDx D5OPMEvkHaqzjTmHjeW7ZqIMAQWi2P2L29SR5myrFiJ5aJOTfYVSXpbRnAfNuKHkYYIMoARrPnp GAZA6EBaPi5CjhjjzlJJwkG+TtOZCvsFj/S3Nq7tlxbAW9BoY3BwxrHQqL+OkZTkJclNlT5ihWG
 xmWQeBTJvLcD+KLk3piyXB4hU7QmoywnB+wl/HVhrUwOigpCl5xolonRFMUxo09T9a/6cSTyen2 UeQAyaZtprtoRfQ7r8hPsiXopMKs+KrRBnFgbiE/wBPqFD88qiI4yxv2mcuygdb5z3pESHjrNUp +I9ykOy4E8i1QKlOFpGsAxAk7URanVW3jP2q6rrhzkUqdBMZPtO0EfYI8W39zXphrzfZN9tqSbM
 QVO1tzeEMCPETlbt2GBNNdbQ/+whdNT6/w2k8AQ2fE/bFfHJWkdUNcZ/hXYuQ/P8drNvUebG
X-Proofpoint-ORIG-GUID: SOEuAPuWgIZZS8Nnh7dz_B_69vKvyCq8
X-Proofpoint-GUID: SOEuAPuWgIZZS8Nnh7dz_B_69vKvyCq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=870 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290045



On 4/25/25 8:15 PM, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 04:03:09PM +0530, Nilay Shroff wrote:
>> +static int multipath_param_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	int ret;
>> +
>> +	ret = param_set_bool(val, kp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (multipath_head_always && !*(bool *)kp->arg) {
>> +		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
>> +		*(bool *)kp->arg = true;
> 
> This reads much nicer if you add a local bool * variable and avoid
> all the casting, i.e.
> 
> 	bool *arg = kp->arg;
> 
> 	...
> 
> 	if (multipath_head_always && !*kp->arg) {
> 		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
> 		*arg = true;
> 
>> +static int multipath_head_always_set(const char *val,
>> +		const struct kernel_param *kp)
>> +{
>> +	int ret;
>> +
>> +	ret = param_set_bool(val, kp);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (*(bool *)kp->arg)
>> +		multipath = true;
> 
> Same here.
> 
Agreed, will change in the next patch.

Thanks,
--Nilay
