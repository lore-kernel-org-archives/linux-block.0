Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493651D799D;
	Tue,  9 Sep 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421375; cv=none; b=poI91snxP6ZJEa8vbcrEwX5oMVQ7sNUQYZuvarqEo38VYrY+7ApchHgx+PLq8PYaOxpsmi5N2om6Ny4ohByDlU8JihztoeEJpX0fwopQej0LTtjvicrnv5LgcMreW97cyRcuSwNQ8+4y5yiAnFAPJekWnjffFUNHYjlNJ+ayw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421375; c=relaxed/simple;
	bh=7rmZVvt1lcuBAeV6Cot6FBTLe3RiTlDsHklY1dOONpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7QvecVXK8ZzbMFaSgMnVRt4ZlpzaOfTiW4INqRW26073JQnDppJ0o02Ook0FOJyXG2BC2xkzZi78RzQE92hqNxji3vB9MqgdxoJIDFzCqXOm1+2wLBAmJq+lG6kvHzZGPyvmeULlzlUfiVL1Q14mbFNmDFYG1koHumzpMCjgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ryAlLX9U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ryAlLX9U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589ABrAa029066;
	Tue, 9 Sep 2025 12:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9UCon7
	2yABUdesFhCOJAJC9dH242g84d7p2QQ2CuUGM=; b=ryAlLX9USZ3R25WpmThfJ6
	aAS61HA1INKmFFOZROWmgknAWsyXQKkJW8wBid2U2PClkhcwMXJqhsjnnvay2muw
	3NHi0xrww0mNDIZ4/1PuC1dLznY9vDaMxjxBDl1IJmh7/CRZA8FBSnXAJeolN2U8
	5w2CrsEnsszIDwXD9soQBM1vh6xbaterVu4YfkiR9ZRmMcdH6Ea0BMyvodBDPWCJ
	i53BaPiya05DVMRM+nPDC7fcP8c40cLrQuRnLChMlyrnN+1LjNmlLQZhx4FGuFyF
	aGuRIuITHULjht/TA1Uthuh9lAgRAA4cuoRWRM9NM1TEuLeQJAXwAohB6b8XiHhg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwqpx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:35:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899mdTQ020469;
	Tue, 9 Sep 2025 12:35:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0u80w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:35:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CZs2q6686178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:35:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAEB858057;
	Tue,  9 Sep 2025 12:35:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107C458058;
	Tue,  9 Sep 2025 12:35:51 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:35:50 +0000 (GMT)
Message-ID: <12a95d11-9153-40c5-ae44-92e827817c99@linux.ibm.com>
Date: Tue, 9 Sep 2025 18:05:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 09/10] blk-mq: remove
 blk_mq_tag_update_depth()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-10-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-10-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VsOWi1pG2SwKRGVplQszkobCTW9DSyP1
X-Proofpoint-ORIG-GUID: VsOWi1pG2SwKRGVplQszkobCTW9DSyP1
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c01f2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=tYaLi_SPQAiz_1EOLDQA:9 a=QEXdDO2ut3YA:10 a=Ba5x5ocL4jwA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXy6EQRlZyGX2K
 NtRAF6k8vg2XVPzKz4uGijYiT26W4chrIrwRNIpxZQgMkjOE8NSovfvdRFVym9ReTl64LRqxZvB
 BzncdNbBQlVrCewYYaLFL656kERoB/m4ke5qh/OlBPXPXa0L7IDPT5+vHxqUs9ebek8XI/47vGO
 q/mOBYVSQ155pRv1pVeds1nnbBWdranUhCmfXxC5Qpc93byv15kBhiWQ938UYV0mdo5cMqIMPQS
 0hoxJ47VC23EiHXsSauKwkbDjmioqkDm4uAG7vQIhq3Z9Dw+gS+BnZCzmewCPGKlIBFm1fjkXPu
 MOsq7ObOBOjpKpyBV9EPACw+LJizpDGqTX4PNCQctWdYzhPGCxYfTrfc8BypZjQBKP9S7n6n5Kh
 CdVGw/jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This helper is not used now.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
