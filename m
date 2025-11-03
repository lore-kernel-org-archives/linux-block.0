Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D5223311;
	Mon,  3 Nov 2025 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146904; cv=none; b=ZigI8Ss0iwtX7jXvgfALTEimMbR/3uDXk9g+QW9LKhemNRJDIQ1L5UhbpqjHMeiemzZs/lQIZ42I6fZSXhcH50tNwSxu4r+NXTwLvl92ofV1zXJy0oBE5K9SSOkNOXGZJvzCGmgTzm8nNLjY4jg5TeJcd8yt85wv1UmJw6vNFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146904; c=relaxed/simple;
	bh=xMGFQ6DHqK+mnp7bsDgSqH+kmfCae6dKI9sv12mqSvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMOlKwp299hA0TvbVgQ7Nys5D50206VfzDIPeG3inCAq07zHjbOO+YcGOQYO5uM0+nQhaQExIBKqb9TnwwR1wm501nBJjIjbjKKbS8Zudetm8UOQV4F+TF+9+nrSuYFT9KwYGIRdwaLuv+vyq81dBeoHQOpuaEfWryiTuV/qZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tgjtfxpd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tgjtfxpd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2MhsZd023145;
	Mon, 3 Nov 2025 05:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jxWsZu
	tV3Ej1urmpmd9wiK4jd9o5KC4Fpu4xByUPaEg=; b=Tgjtfxpd7PY0imQ2R8QcDP
	pnmGOYx0h8GbuPRcau3SdQ6Dg7t4ozcd7+FuEtbh2Zc6xKWe4SH9+AT3CL+83d9l
	mGuNr5ufITGu1rOaPQAZ+hwsRaBGy7cr6e993rzVys7JsKaRZLshCTCXzd/aHCgb
	Ct2yImXQk/M6sfUIE8YjPQczQW/1JIQ9jIfd0WUDbZTj7StyJkA4CAgNEVo//RHN
	5+VyCHYhLJqckAmohNuf7V+zdUfGCHOprbQMgeZ4I3mYzHm7ASHlM4UomsJ/qWyV
	44TzmGTzjWorSHVmO7krlRdLhWiV/BoIP5eL9U9RSfwZU8r8aO9uOpJYUwody4Qw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbn0dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 05:14:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A32jJQL018804;
	Mon, 3 Nov 2025 05:14:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whn3x27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 05:14:43 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A35EgvB32113202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 05:14:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C0B58056;
	Mon,  3 Nov 2025 05:14:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BD9358052;
	Mon,  3 Nov 2025 05:14:39 +0000 (GMT)
Received: from [9.61.101.239] (unknown [9.61.101.239])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 05:14:38 +0000 (GMT)
Message-ID: <2cb14486-c4f7-4c85-8d84-890e668e338c@linux.ibm.com>
Date: Mon, 3 Nov 2025 10:44:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store
 callbacks
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
 <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
 <CAFj5m9+-13UHPTKToWyskQ5XGiEFEEBFjgQzkkuDa=VBKvF7zQ@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9+-13UHPTKToWyskQ5XGiEFEEBFjgQzkkuDa=VBKvF7zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX3OVb6PkdshzK
 XkIgHeRDfe4dSpLv1boL199HW2MKKJb5nUYDSpVn9kEsPeMMaRaadrt4NHzIBguGa9HqJ9Lk6TD
 qPrNr7Cn0TBnxyBXVaWCol8TeQV/fQWUJDWORZOWV05+MpRlaHyFqNMoUqPYsbh19pY8UNz3Zd2
 9UER1FTqhAn5ghc5Gf8GywJ1N6sKT4g+YRKnY2pRmBXogMd5KM5TZLxr0EFOU6kx9+aDoT4tU3+
 U+h+1XH4Pi6NUp3ObEQT7zOf0O8ClJu0YDcm8qCEuA8qNfyYPw5066aElJ7XzfGdnG8JV5dVLr+
 vTCi3UqG7aFG2RD60p7X0TcXwd+IfncnF+QjzzJTkqYPoZiSK4SmrMDYkZmBk+DYWOkWC7Tymer
 i0Bh4rd+my1cOyDKrq5KVRu42L2qNQ==
X-Proofpoint-GUID: 0TazcVzMIPX5xcP4fpHxKFo7G7clMU6T
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=69083a44 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=3pzJh3yUM3qKYZY7WwYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 0TazcVzMIPX5xcP4fpHxKFo7G7clMU6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021



On 11/3/25 9:42 AM, Ming Lei wrote:
> On Fri, Oct 31, 2025 at 8:40 PM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>>
>>
>> On 10/30/25 10:54 PM, Bart Van Assche wrote:
>>> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
>>> calls from the store callbacks that do not strictly need these callbacks.
>>> This patch may cause a small delay in applying the new settings.
>>>
>>> This patch affects the following sysfs attributes:
>>> * io_poll_delay
>>> * io_timeout
>>> * nomerges
>>> * read_ahead_kb
>>> * rq_affinity
>>
>> I see that io_timeout, nomerges and rq_affinity are all accessed
>> during I/O hotpath. So IMO for these attributes we still need to
>> freeze the queue before updating those parameters. The io_timeout
>> and nomerges are accessed during I/O submission and rq_affinity
>> is accessed during I/O completion.
> 
> Does freeze make any difference? Intermediate value isn't possible, and
> either the old or new value should be just fine to take.
> 
Yes it doesn't affect the I/O and so if we remove freeze/unfreeze 
calls for these attributes then we may still need to annotate 
it with data_race and/or READ_ONCE as Christoph mentioned in another 
thread. I saw that nomerges and rq_affinity already uses atomic
bitmap and so we may still need to annotate io_timeout.

Thanks,
--Nilay

