Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B335950
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850416; cv=none; b=Pje7A5/JtPHAruDzytdpfGpE+/62k4PMCqUEkrKhAEroQWoVIpn8mo1E11ZNtNrIXWMsyPZkFExiLPlFh6RW7uTSh27orMU4GnocmULzNXFkDMbGStgn9NHBdUL7vxqY7YtJDwYPiYn8utdWswBbJLDIRwsVvJ6z35410BMHt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850416; c=relaxed/simple;
	bh=Y5Etzkw3KQdKPnmljRQcnyA89UubC59kFtLUlql9iWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZQNLFsZTW0A3IbJjcyFs8etwJPy/T9ZbrgUEnnrcZJNmbkl9Oiw1bs0rwETvQpO/IVVJooz4Ymv6u5V21aiWwQQOAWGX75j5FHxVcwPHnVtLo0kpePdWSEdT/8M3pwjFw1+RmuZ7SfkdlFfywRg/T4mG+z0CF7+Xfe2aMiGlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EX5vDHlC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EX5vDHlC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5CBqr011445;
	Tue, 11 Nov 2025 08:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tESD7w
	BmyPoGTYMZSgyEjzfBTAnWjqqoi+FpE8MkK0A=; b=EX5vDHlCByWyeqSDHcwh8/
	NjefyJr1woXfSwuTARuLb1c5oBr8z8XZR4R+uuXp3Q1YeDzf/VJKvJVk0k00g4ll
	9sFpZsps9DIjyYSngNV6latMPmvmCO2h65fRirrDljv1VPXHRI4YnEJNfI6ifikC
	bCNgFpZCtPQgQjZ+r3+7W8dz0EtxJjKSXw3h6SceFMYnnFMXr7nwKw0jnAVkIbTm
	jqwJg0rajhRvf4IUEgAlgOy6a71quMZF9A29Jspxqotu74NYkSkTjjElYyp10705
	UywSh9v7IFEEhf+NRVL/RoWX73BoYoh/7DKQ0ug6Vyqm/h663cMYbNpVdC2Ku8kA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk845as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:40:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5EMfE028862;
	Tue, 11 Nov 2025 08:40:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sa1dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:40:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB8e19Z50528618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 08:40:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD985805B;
	Tue, 11 Nov 2025 08:40:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3197758063;
	Tue, 11 Nov 2025 08:39:58 +0000 (GMT)
Received: from [9.109.221.142] (unknown [9.109.221.142])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 08:39:57 +0000 (GMT)
Message-ID: <a8f397e4-beff-4fbc-a347-b827bd39aa16@linux.ibm.com>
Date: Tue, 11 Nov 2025 14:09:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
To: yukuai@fnnas.com, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-4-nilay@linux.ibm.com>
 <e8506adf-a90c-493d-a060-129aa5d417b7@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e8506adf-a90c-493d-a060-129aa5d417b7@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX2Em0tbHm3s9x
 Y53tQ3x+L+XVXGSTFk7cFEQGpD1pkeVq24rxzU/44ul1nU99bQA6Ja0L1fOMTRxdb20SAB+VQaM
 W8TMw3jKkf/dWqp+sg7J0isNRKFoG8uPt3mtyYXi6NmshBibjq1mEL5+/Sj19G8anbzW+jzEv74
 giwls8g/0jwr5jnCfK7JtHH+ZkFjZy5rhgIfOKXr5cVlqWh7ip0hWjst+HKCs0j2+NffTq+i1DZ
 pqLsaNZ9SGrlIUeasRjnythu38uF8chSTYJ+keQniONcugVEDlGL5iensVsuiIKdDipOrbEMa1o
 bjOPSy9Tz2hNBQiQiKNOKyvgiQryo4jtoYTLWUu4KuNbDEsCdQO4oC2kDZ73mGfl7461LGLrLCs
 ThF5o8Q1eZfy0EKv3L7vczPwk1KkNw==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6912f662 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ji6gVKsrb2LKOvRDE54A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: C5pMpoHbIukNefFDo3tvpuFz8jBFwC3u
X-Proofpoint-GUID: C5pMpoHbIukNefFDo3tvpuFz8jBFwC3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/11/25 12:50 PM, Yu Kuai wrote:
>> +static inline int blk_mq_alloc_sched_data(struct request_queue *q,
>> +		struct elevator_type *e, void **data)
>> +{
>> +	if (e && e->ops.alloc_sched_data) {
>> +		*data = e->ops.alloc_sched_data(q);
>> +		if (!*data)
>> +			return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
> I'm not strongly against this, but instead of the input parameter
> as the output, why not return data directly? I feel this is more readable.
> 
> Perhaps you're considering different cases that alloc_sched_data() method
> is defined or not, when NULL is returned. And this can be solved by fold above
> helper into caller directly, there is only one caller anyway. In patch 4:
> 
> if (types && types->ops.alloc_sched_data) {
> 	res->data = types->ops.alloc_sched_data(q);
> 	if (!res->data) {
> 		blk_mq_free_sched_tags();
> 		return -ENOMEM;
> 	}
> }
> 
Yes this looks good and feasible, I will address this in next version.

Thanks,
--Nilay
