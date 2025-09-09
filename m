Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF23191C3;
	Tue,  9 Sep 2025 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419155; cv=none; b=hkHo1lvmMKeBQKE1MsMn6DBvR3g/hfjoLgXA/7JF0YdLrmV7Ue7vN6Lbe71TV5PFDT1sv7OYuqFrd8P+3682nur/glM7Nr7sLNEmgTVreAJCUWSQvfgHAK646nbKMl3KZpko5NM5ZyZrkMAIGNKvNEi1SahATP/qkmb81xJcyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419155; c=relaxed/simple;
	bh=dkMCPh+Obrjfe8IGzBYe9fQMLlqEuRcGUd6UaHQF+Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAfIF5CROAUlruhNstCIsUV6hGmsf/6NcOkwgqcq8PkCvCGXmHoOI34omaE/vwBNCQzz0mrgCnePD69rZ+sX/9tHqbiqBfmveD2L3Q0xvC2wgFM4/+1KU3mH2uyZTFrJ60ZMEDypa2RmCzcNO8kDGlJBsbBfXVbKnJsNHGLskyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hYTJjkri; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hYTJjkri"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5898Rgfv000683;
	Tue, 9 Sep 2025 11:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5e5WJL
	edHXLKItvGg4qOPvAsktAbj0tgIk+djXuGsM4=; b=hYTJjkrinxnQvLVQEDAOg4
	ZXv5qTyRCGFmPKOBRlWILpcu0Ri73Nfg9cZIz6zy4/Mj9K8nSFV4tneKgWhL1AQe
	iE6BJZsv6jvLp8hVSyhRqnm/abzNcIGzWbiVtEWgC2YUCUk6CmIPTTEf80RKCZlE
	YOxybsa6zbhvISpRqJP/hWWMcq9YZF79LrM+T+6oXJx6HTGsFVA6tV+5oOFVPj4J
	GDaRAypw/EB6MN6TUHFj2xykwU7o4diM19H61Mjd9VHELxw/j3hm5Mtbb8XtF7VQ
	GlMskyy25LEDFO0iEnTLXvnYiMQ+Fsx/jL8l1pOHq8O99DoRGJyMTTbpzXdiiY+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7k87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:58:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899pSFx007912;
	Tue, 9 Sep 2025 11:58:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pjyua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:58:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BwuUZ20972034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:58:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8227E58058;
	Tue,  9 Sep 2025 11:58:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AADB58057;
	Tue,  9 Sep 2025 11:58:52 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:58:52 +0000 (GMT)
Message-ID: <3a0668d9-e31e-46b8-9e74-17641dde19f7@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:28:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 05/10] blk-mq: cleanup shared tags case in
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XxIkrM3cvzfHzdeEkg-zpMIPHRfg4lIK
X-Proofpoint-GUID: XxIkrM3cvzfHzdeEkg-zpMIPHRfg4lIK
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c01682 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=p0Jn0yBFgIqnRlGow6IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX86zkWS1D3Wt1
 J9W0Kn5fPojYPWX7m6QcT1fED4hhWVlgyutFnIm4cEbAwawJbfKgou2UI0BGmog691vbQsjA0xQ
 PzCprWR79MXbFgL++oHmAY710+hpBc+nZ62DVGn5wtlP4oR5hI8En+HPEHS7CdWOIyAwfcmCUcA
 NGVNTaP4GW1hpayCu2nsnfBJro8RSKwq7QWND7J2Prq9v5x9PggbYQsoKZjTLyKeA/JwUKDXily
 LCdBd1Tn0JZiXn8WFxxHd4KbwIrvNnRNdQbmneqnJSbTvvK/rDZ2hJEMLEMl889VSrGRabJ8KeM
 LFKnId3A1ifJVhjpinDdfF9OpaEKI6DR9Pd6QYwRiSZ5+cAz6AX5Wms9pHMLRayPgeKlLJZB1KH
 3IvfNGwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> For shared tags case, all hctx->shared_tags/tags are the same, it doesn't
> make sense to call into blk_mq_tag_update_depth() multiple times for the
> same tags.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
