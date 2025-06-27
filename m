Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6152989A4
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017817; cv=none; b=lGk9VPqnoG36Uapa2kyNG5f4NX+Chdkklrlw9wNDGQLuqcNCXQFmRegzXWDMFwWKhDoUVQ50NKkCkBu9kDty9hZbzOwPM2uZjaTrYBqTEGnOm7BilxMDka+uvXBrOs17WaIWfnaDzvRrF6rgQYGKZgjUMNIj1wF4ZBeq/N73nqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017817; c=relaxed/simple;
	bh=fw7pMgH+rEiJ9MWBX7eEttomw+iC+Qr0PEYlNpOXY60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITLHdgBdzfWaqAeOYxZ2zRf5XM69e7tx5lqNGsS0djS9NIvjqOqFJ2/NfPL1Wf7Ns9o16IKlSOiQwd3tPD2crWimt2NI7Gyps973QB5KjOcjn9/RHaeAtUch2Q1vhilXQ8iSUIkD0WcVO9Aedy7F+5a0PWb537UqxkoD6ntxmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZTqxgIw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZTqxgIw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R0C26L024076;
	Fri, 27 Jun 2025 09:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=veUQD7
	YTqF6vSVNJBKvIgcR6wx6T6nlpGba+UA0+9JI=; b=rZTqxgIwSN5x/qRwkFWxFk
	zmyqp+UqtFUSyy82mMI0rSRiXYPefl7c5iRmx0Ypt/2CRxsQdnlfKm4+sBFPZOsA
	zsanHoc9qIre5CWYNS0iS319jarQbo2Gl6LSpuOughzQ8PMcYryMnm1MfQVHO5zS
	pEnw1u546c6Xz1BRurmaayA0kJ3azuDc76RlrwPFpyQDUMoxaJW4emd1GIH6BTtd
	PfCsZDLWzANgRMxOBZWFITKdK2vKKN1joD0xsXenxF6UFyDr4wJj2vEMsKeNbYkr
	hduNFldja8KQlhdpIp5GFkkUO4q+rXydYVU64xGAWRt7QSUe7pIjaY3adFVJ+1DQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47h73k5qtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 09:50:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R8ZSXL006414;
	Fri, 27 Jun 2025 09:50:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pkj36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 09:50:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R9o5DY17236648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 09:50:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38FD5803F;
	Fri, 27 Jun 2025 09:50:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7352F5804E;
	Fri, 27 Jun 2025 09:50:03 +0000 (GMT)
Received: from [9.61.89.181] (unknown [9.61.89.181])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 09:50:03 +0000 (GMT)
Message-ID: <f68b7120-c344-45b9-bab6-426ecadb3350@linux.ibm.com>
Date: Fri, 27 Jun 2025 15:20:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250624131716.630465-1-nilay@linux.ibm.com>
 <20250624131716.630465-3-nilay@linux.ibm.com> <aF1cdHXunW5aqaci@fedora>
 <e0e4ffc2-413b-448f-8e62-5f745123e4fc@linux.ibm.com>
 <aF5PN1gAHrKW3jG1@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aF5PN1gAHrKW3jG1@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s-dX8-jX2LnN9InKvW8g0NiSKzWDxeKn
X-Proofpoint-GUID: s-dX8-jX2LnN9InKvW8g0NiSKzWDxeKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4MCBTYWx0ZWRfX0ZFDvD8firuu eUGYT67DFczLWA3kB9eP+sMHBNBN33IR2iP7U+1n0tLVHa5pEGU7afZYSXlJEPVQbKwz1ovLpuM vYYdB59dgG118PqRIJHA68yq588G7h3/Rhk7jWt5eUA4HZQ5s8rx9HcwPjBGTJCimqfmkGBh/rK
 +b+W25V+ViuLot8hfhRM5YzFRMZBY8txRlTumn9/0csGw9LbSHGMfygWSGMpNKjJf9mywvptGGy Ox+LX7hZ/DESwEQWwp96teAUajmP6OY3J0z0KIpMVqqwDjZOrWQi1ORHZOOPNTop1LzhWoaNf7W zckNqJb/odZ1fPO2GINcu9EwPiSC0ocJYwtprBvNkZNh6YhVki9vqZfIkcWzA+CAvMik9KpiZO4
 UWpvemi5kZ++4eZAom5oqURKYqrM7lkMlB0YmggsXy20ImKykbuv/p7wAQbBTD8dQcLpF6Zy
X-Authority-Analysis: v=2.4 cv=Aovu3P9P c=1 sm=1 tr=0 ts=685e6950 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=69BkSvAbNq6DjQjgjnMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=725 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270080



On 6/27/25 1:28 PM, Ming Lei wrote:
> On Fri, Jun 27, 2025 at 09:43:29AM +0530, Nilay Shroff wrote:
>>
>>
>> On 6/26/25 8:13 PM, Ming Lei wrote:

>> struct elevator_tags {
>> 	/* num. of hardware queues for which tags are allocated */
>> 	unsigned int nr_hw_queues;
>> 	/* depth used while allocating tags */
>> 	unsigned int nr_requests;
>>         /* The index 0 in @tags is used to store shared sched tags */
>> 	struct blk_mq_tags **tags;	
> 
> s/struct blk_mq_tags **tags/struct blk_mq_tags *tags[];	
> 
> Then we can save one extra failure handling.
Yeah I think that's the advantage with the flex array!
> 
>>
>> This seems like a clean and straightforward solution that should be easy to implement
>> without much hassle. Please let me know if this still needs adjustment.
> 
> I think we are in same page now.
>
Great!
 
Thanks,
--Nilay
