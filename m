Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B331DF97F
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826032; cv=none; b=lHd5+mOFcYtZ4IrLGC18IGkoFLioj26Weru4o09nh5MoJEZlObTTVOnlSGiGZsv3j8EmIAXDgY+dxv5nxSBiqXBa/4iZWnF226y8mSXX2cItG/lUuYz+q4lCUBLgo9lSqJ6RxPjFHq6iCHNj1k7Wum01onXI20H8/hc0Vcj1fVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826032; c=relaxed/simple;
	bh=4kY2YqcSVJbd8rH/MKomhxWFXWMkF7ylCIfTHEHNRyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSBjo8yq37D0kJJcny9OmtjmYRS8HQng2yDy9JoB0dqHQI/fODDlecEUBIqn2DNkN2GlwHMYBsS1D8iEaKb+en5qnrv1cxOCa3dY4GXSfzJYxdrOnPTirx5LaQoI00QPB85DtFgVaPYddxqOjCEihi6M9Tx0+s5iaoK3vANpHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M/vJawf3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M/vJawf3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RLtMRP008942;
	Mon, 28 Apr 2025 07:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R23FCT
	6upMUICY5e5yi7gKI289TI9HBN4syIytuQ13A=; b=M/vJawf3e3pg1zlxsm+CbF
	OXqtI5Q1RgxMEgrJSfi1rSd04KQ91KtWnTdENAcFW+dEM0BwzMPHJAkTmSi7rS5M
	0WroUK0GHedOzfH/8gJSqCl1XZ4dGTRUcZAh66r2Y7rvD8Zt3icYCndhTDaX1JNc
	n0PuasNvwefVrIkGck98mT2TErny3l3I7yR8l/WpIwyq/G2yybCPmaf1q//QaFEL
	Rs27DnDu/UyvFWmBkL0TxptwDgF4QzlUptSXeOxmi/xuhij//qR4/tH73VkXQpXg
	dOFovp4yxmZKr1Yv9WSOhRUZ956+YDRu4khlxzad87nhlVSlY2phOOBba1765KWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469v5khw77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:40:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S6Itvs031628;
	Mon, 28 Apr 2025 07:40:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699ttwhs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:40:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53S7e55s31261300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:40:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B800958067;
	Mon, 28 Apr 2025 07:40:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B98805805D;
	Mon, 28 Apr 2025 07:40:01 +0000 (GMT)
Received: from [9.43.89.161] (unknown [9.43.89.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 07:40:01 +0000 (GMT)
Message-ID: <6305bdd1-97bd-44a5-98f7-a167b7c64c0d@linux.ibm.com>
Date: Mon, 28 Apr 2025 13:09:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-2-nilay@linux.ibm.com>
 <859e8758-83a2-46d2-81ed-c5199f326508@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <859e8758-83a2-46d2-81ed-c5199f326508@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tep60Gd0Xl1XIbTP1rYFJzoznczwNCsF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA2MiBTYWx0ZWRfX6TbtyUJyCY3C mRX/IeTHeF+i7YWDbjrWLNuddrmPvxEB2PrkaES8x5xuPhTCCSNaLCky10Ur1vcwdOQcKbp4S/x E2rahWS3DeE4gJObhsV783rmAfatDHj+nDeS1R02lUZxzoTCxQt4HJecMfJ83gUXlCfT7wjtGuB
 Ij9jr22Tv+YRftgbUvegElHfR+NwlFcWLKecjkC6hz8FozTZcnkM/y0olZAsX0UZ4IBaDcXaArA bl7vo9KVowVQWeIYVgcIwMlgfkXqpZvPz04Vlskxar2YVXq9CayzOEU7uP8W8TQC4lvwc8luxHq CLnY2b2HTtgKnepTK2L/GegAb76yvhu5vy4lIhNq2SJw+N+Qt2IGWO5GqeJqmBmgwZyRQdgxwF0
 iNnmnMxx4vicr9Abi2PalW52/CPXYUcBg5nqK+hP6SB9ZDtq1+TTWYTWKhN4f9QPuHJueMfm
X-Proofpoint-GUID: tep60Gd0Xl1XIbTP1rYFJzoznczwNCsF
X-Authority-Analysis: v=2.4 cv=DvxW+H/+ c=1 sm=1 tr=0 ts=680f30d7 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QUCVYTkQBvY6EVLPVrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=830 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280062



On 4/26/25 3:56 AM, Sagi Grimberg wrote:
>>   @@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>>       ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>>       ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>>       kref_init(&head->ref);
>> +    if (ctrl->opts)
> 
> While this check is correct, perhaps checking ctrl->ops->flags & NVME_F_FABRICS
> would be clearer.
> 
Sure, I'd update this in the next patch.

Thanks,
--Nilay
