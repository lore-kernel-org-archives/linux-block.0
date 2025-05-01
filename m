Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CD213E9C
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746082787; cv=none; b=PS39eXg8kGP4kW9Nn3PmSarBhb9nRAEEJn3uCzPJZUrGKCLLA3vkvyi/Jrd/KzfyEzBQq/tlK+OKkQfdE7NwqEQIADrUJ2HUlS61HTZPR2LXLy+FPJSl61tqCYR58TxKu6dr6ZuVrCLiA9+IkiALWqm+bkskNYO/cBk/paUyFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746082787; c=relaxed/simple;
	bh=zokR7w77bUowhUiX2VKbg5EHN5jzIb6p3z8/Uzb6gIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJY6C4ldxjASVj0AsYSHQ9yaqWyjvXMeW8M6I5JNUkse3qk0r/Rwsg3N9p77/KbXjMkM7BreaJCWa1QmLxKNEhosQye+tCi6bW52OLBAejAsCAguyLBBER1X9UIp4OocGY05U8gzyADGUaucPwUwVEhq9vrgZZQ9eCVo7r+W5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ory6HMpc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ory6HMpc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UL3mCp022931;
	Thu, 1 May 2025 06:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YYM/S1
	BjxzMpr5JGEI31If8VrsBQV9SVXhOtYOJ/duA=; b=Ory6HMpcCuhZyN6jKq/MuH
	7bdplVYF/8QOXTeQwk/O0eW+DN3+YxB5f/sVCss2rylE9aYOK8OhMZPW6Ok83z3e
	sE4XtRTRunxHBbUR7Uez0gtXv3qtzkOvNt/s9MdVEacYTymfBzurkiOh8k9sK/d1
	OfZrTE/LCQ59v72wgfgQ968jVGLLoS07G9YX+w9YmmG/JvoSeWewIaA3t3CwaHHk
	uyOq59ymlxIL7to8Fwnb28QsyeNqKcMe8AbfR8cwjCk4gx+54y8FivfZiFWLDqHn
	YFe6kibQbk5lKdFmtsgnLvAwvUg0WZms/RlHaGC/UxtKqE0qQbEmPLLNiF2tZ2vQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekhuqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 06:59:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5414tatG031662;
	Thu, 1 May 2025 06:59:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tubwdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 06:59:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5416xbHW21496570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 06:59:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D355805D;
	Thu,  1 May 2025 06:59:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D5858052;
	Thu,  1 May 2025 06:59:34 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 06:59:33 +0000 (GMT)
Message-ID: <576dd88f-4e56-4080-9e54-e1258ff67401@linux.ibm.com>
Date: Thu, 1 May 2025 12:29:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/24] block: fold elevator_disable into
 elevator_switch
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-11-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA0OCBTYWx0ZWRfX3h/5ghDqKK0U VJ4cKra0WdbT3jNzSPh58VuDxTAx/15oVF3LkHUmU/GHBpMhSJ0Nl4Pwksl5++R/U8pmNp8Rvv7 JpbV4wxklXMNMX675zGzXgB7WOXOIsNhPSZCseqxBooN615dyY2QUoGhkFR5vEzVLfDWl/n7Hrj
 1AVKweSWpechnY8MzooCzQ9+AWKkFFr39pAGrxkRi8que2BilSRx3IekvclCKwbhTAAK3sb1grl W1lrvJhdZDws04OTXY92EaPb6XqUeCOm4tyB7cwFc1qsTsUxlLfmOGwm9zfQJ1PhR6Zm9joBSBB j8GZbZ4DFrb/+LPu2J8KCxLw5T7OTucgCR5RNtSKvRYhNn9DHwOYKjUG3F2zGeKvRHdESkAkWoA
 RP44p1uPgCUKBd2L/CfgDKGwH3n+bzBDTMjLVTFezQFaVzaOS3RZ3EbIN9AzhytVQYwix7k8
X-Authority-Analysis: v=2.4 cv=Io0ecK/g c=1 sm=1 tr=0 ts=68131bdb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=8uDfyGt4XYERhb7PZvQA:9 a=QEXdDO2ut3YA:10
 a=oOt8LVSLndi7zlzjSLJE:22
X-Proofpoint-ORIG-GUID: QYMPJn1aHhry19uHe3T36KCVn6cSWsrp
X-Proofpoint-GUID: QYMPJn1aHhry19uHe3T36KCVn6cSWsrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=588
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505010048



On 4/30/25 10:05 AM, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This removes duplicate code, and keeps the callers tidy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
