Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589851E5B71;
	Mon, 17 Nov 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374219; cv=none; b=r88rL2kU3l5XeRstXbapihmt3a40gTOhIfbC+DZCkIBAD8xl9FuIGqZvCoMzFVQ1hXwXMk1uWJg7vatZ2uNvb5YVKx3r2dcYIN0zPoVkk/YcuV+ICEuX+EyM1M8Y5JpU/rkvQMsEYEb1lVjClm5q3wYHvg2JHQ/7eRU/t81PicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374219; c=relaxed/simple;
	bh=62ZjEr/NmehUGgu4/7eoSV1GlVp/LSQ0DqgLm/X7/pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RTVemmUdsBhYqPkt72TubBdTqrbttuo9rFcLNwGb6CoH8oo+t1rLM3hwvoSfo47Ekq2Kz/Qv8e2PhgzTAfJpi7GIJN0r/6XRHVLUoAjaXB3qHPbi9OH6HSQbbYaXPHexpzOhoRZlANqo/PYmkJeFwa715X6NMqZzQusBo29s2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RktZ+j+t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RktZ+j+t"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGKEn1p010859;
	Mon, 17 Nov 2025 10:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a+a15b
	Geo3vMpt0ntIJFgJxWNgugy2Rl6YpQWubpYps=; b=RktZ+j+txijUyM3zYws8xV
	2wecua+QslWOAmhntaAuWvpTrU1ndAXxMynje/kmz9Wk1V6PZoStMQifSC/Q6YEh
	fNKZyrSd84T4nJShxigFZB+idfJVPwIB+XvBdLttVx0yi6A0ik+eRDsWsNzamrZD
	aq9UeXC8+fJJHQzyWMlS0Fb0lsq/dKPJo71eJTezVGFf+hJA9J2YTUesR6p0PN1f
	uCgQnepxGxYC/BjacMcpz74LtvL+vzhLseA89W3RoiCGHc4em3GDsmniityiQWS2
	me6SgPotJqyv02GiRwucGg0PuSl/SiGrHE3txJLUzewTdZlqKuhR7vLed6h8W2Wg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk15hk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:10:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH728rG030854;
	Mon, 17 Nov 2025 10:10:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xna1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:10:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHAA42O33358552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:10:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE60558056;
	Mon, 17 Nov 2025 10:10:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBFFC58052;
	Mon, 17 Nov 2025 10:10:02 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 10:10:02 +0000 (GMT)
Message-ID: <68571a38-64ca-43e3-ad2b-977370179a42@linux.ibm.com>
Date: Mon, 17 Nov 2025 15:40:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251116041024.120500-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691af47e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=gVGvchPwfcDIOqpBW_sA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WAL5XTecKFxNLGZEjY6YjDGMFqyI_6Wv
X-Proofpoint-ORIG-GUID: WAL5XTecKFxNLGZEjY6YjDGMFqyI_6Wv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5IYli7141XYj
 VVr0tyHta/68jRiFnWDzsEbcr+cCgYbE+MHXSh3R1cVHHvy6MULOUzWHSeJH+JZuEZLUN+fF8G+
 r4yllgetWg0ZkhtiXySZTK57jdhF3kCYnlaW9DxksTPJuNKD4g+uq/0tHdGTpZb2E9ShlPiO6B2
 sK/YkqsIIo/4sKUtPDeJ9UssVci8FLIKjCr6VntRTZ76FdBLV7jCml+i6tsn8XLY6FKIfT9AQei
 9L4+Pez8KLcRexkjcwfp9EYPCYgIgM8Vrec+xKZhmFYg8NRkK/Licoldy5CTMACpVojRXHSOlcH
 kZ8yiPl/2rBgLO+p65hLHhb4DWTJThAtnZM3g93NMxkWYbky6XacUfQYtGefTu+8kY/r3SMXj0Y
 1n8XAnBAtukR+ypeAxyG1T7FSxA54Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/16/25 9:40 AM, Yu Kuai wrote:
> queue should not be freezed under rq_qos_mutex, see example index
> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> parameters"), which means current implementation of rq_qos_add() is
> problematic. Add a new helper and prepare to fix this problem in
> following patches.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
