Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B23BD643
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271660; cv=none; b=RshkbTJ+owEcvl85WlhPMF28NfJCuSbc9Zt3OCcGX8QrQVMOkEp0pJF0w8SrvkJDk35+m6rZ39/dI6SnTgcCpqheEtW0lr5qGLou7hxV+te5EvdjAGmikvSoRp1gucuwbrdmjqGMOOXjvUTR1V+CN7uR6w0v4QFf4E5pRhGWEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271660; c=relaxed/simple;
	bh=bvjUOr1JqDjOm5qctrvZ/jJfMRrFYjtl8yYg02/NPX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZctZoZY4pwPDeItQpjU0BZbBFKkAC1T4DwUH4ov5X/80t0xXM8ZwHxuHol/xS5RI6fUZCpK2WCJjN4QrocsuQitxaTlJ1wyG7RYPyVab3XC5UQbXcsFaK2Ct2tjNRq+ha+T+7kVLz24zIq7I6CVEG6H9f+e7ZQKPOxMhbXR09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XTDtqkrZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XTDtqkrZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6frMT1214125;
	Fri, 17 Jul 2026 07:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wekmSp
	Y76ZGeQ3GRi1RwFJyqFBnlhahEx8tk78CzdJc=; b=XTDtqkrZAnBOhAou24I/oB
	xj2Qgtw5zijp2+xREg7SsyFIVUkSvUtNrHwEO36dru9Vj7PwxemDl207bSky183m
	2FwJuOxC7CzyQjrcHDJFxYJEolMBYW86eZ83mrnemvFJrWn1KDdhL0mKx6yxl3mr
	FindLGd9oxC26bHCJj3daxHg55gmoKNIee+RV+Ja7vsxsD4MakQ0Guds8LnDa1CJ
	uLf1WMG+utQL0HBSQHmxGXXEUqmBOq3G+eFePkqYi6cADkQAU8S8/AJYNANEZ1Zs
	aekN8jR76jFxUck668ZVvf2iqtZ51wfFqiugSpz1BbVeihh1euuqjb8kjjq6NpFQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2am5qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 07:00:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H6nw6L026791;
	Fri, 17 Jul 2026 07:00:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k8hk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 07:00:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H709Ke25690870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 07:00:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619C358059;
	Fri, 17 Jul 2026 07:00:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8D958043;
	Fri, 17 Jul 2026 07:00:41 +0000 (GMT)
Received: from [9.43.55.154] (unknown [9.43.55.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 07:00:41 +0000 (GMT)
Message-ID: <99842431-3ffa-412a-af57-e284888342a7@linux.ibm.com>
Date: Fri, 17 Jul 2026 12:30:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260716082927.4053505-1-john.g.garry@oracle.com>
 <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
 <ae3a2f44-b26d-4040-b9a4-cd6122dca29a@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ae3a2f44-b26d-4040-b9a4-cd6122dca29a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA2NSBTYWx0ZWRfXzWR/9hIM8wIm
 xz4N4vGxrO95sZ3CLi39RKPOdb3xFnH71UIpU8bAfZ4rJMzdUHe+/KqTzwuWeiu6kKd8tTMLBPC
 QComt+NsjnPHSa58MTJ9qGR+Vxq7HPU=
X-Proofpoint-GUID: joJUlGFG6buRTMDBOUAVxQcUz0O5aV_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA2NSBTYWx0ZWRfX7DpxViFgd5EQ
 joRA8zKPQdAloh7ZpyPw4N6DMdPncW0yLBf+IuBV9i/U+6WIPCtSK/IdsDPnkpqbN6u/UADKUc8
 QxMtoWgIC+TkV7AElLwZO1Bx4REsok4WuMFuYhOkweJq832a06IdcSc4v6MXN2vBsl0V3KSm0au
 ur8+geG60/JlO+lMw18fslCSKK8Ir2XDGLaXNjSErFFjLu730YSQUreXauE7qo7UeHWhljcdphm
 Jsmtbi4ITUWdjnfG1sJi0HmgMNtafEjIN6KSGeYF86cF+/hvGc6Lwq45P/HJnIff20Qjit1O5vr
 yvLs2QuTCJbsLLNweuJSCOembwSUd+Z3RBsQB4ThLjPciUVuTZ4W/bZC4WCHw0PZuWuzgyuCTnm
 QCAsJEEfzKvGVQix78opKHQtSEMBwjFNAW5+UkYT7PFPOjyfa1QEguZS3pc+qc4u7QjkeVvLayU
 y4kj1Niu46adLKO3Gjg==
X-Proofpoint-ORIG-GUID: joJUlGFG6buRTMDBOUAVxQcUz0O5aV_H
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a59d31d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=qsI_BOAfeoVEvRxSC0wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170065

On 7/16/26 10:06 PM, John Garry wrote:
> On 16/07/2026 16:16, Nilay Shroff wrote:
>>> +    kill(getppid(), SIGUSR2);
>>> +    count = 0;
>>> +    for (;;) {
>>> +        fd1 = open(argv[1], O_RDONLY);
>>> +        usleep(500000);
>>> +        if (fd1 < 0)
>>> +            break;
>>
>> Does it make sense to check for errno set to ENODEV or ENOENT
>> before breaking out here?
> 
> ehh, if the errno is not ENODEV or ENOENT, then how to handle? Would it to fail the test due to unexpected errno?

I think yes, something like below:

for (;;) {
         fd1 = open(argv[1], O_RDONLY);
         if (fd1 < 0) {
                 if (errno == EINTR)
                         continue;

                 if (errno == ENOENT || errno == ENODEV)
                         break;

                 perror("open");
                 return EINVAL;
         }

         close(fd1);
         usleep(500000);

         if (++count > 10) {
                 fprintf(stderr, "%s still present\n", argv[0]);
                 return EINVAL;
         }
}

Thanks,
--Nilay
