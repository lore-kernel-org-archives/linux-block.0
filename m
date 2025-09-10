Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BE3148D2;
	Wed, 10 Sep 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498948; cv=none; b=PYzW31/O1YE5IKmbfDZk6XfLt6OMxu/GHJ4i+vgyms8UWRKYQCKqh+LXwbqml6R+IrUUGazn+W34jTp3cww5XQSFcJMU9d4MQzC+d9E6bBtdNU3tschat1b2CTxAfWFq3rq1BgLaqd7CEmqaeDhDNd4BkJjsr1si86WQMJ4TR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498948; c=relaxed/simple;
	bh=Yw7urFo1XJkTV6Rbao9ijZVc+2mkTbZoWD4FeI7e3R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di0YPtM0cXLRr0/g0wv2kDf4g48pVD6+hhQnAQD4XBXSUTtA6cnKTpkHBKLOSpF2G5Uwr79Nup42HAUnrbU8+vpvU3oEj3DyN3Ikvubx2HCMYSZnWTHiCfL6D1cOqur+qZIJlOAM+1GA45TZLQxfKLBxTGSQJSpT3zNlp6USwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gqvu3Lla; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gqvu3Lla"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9os0M029387;
	Wed, 10 Sep 2025 10:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=likaU/
	FOcKZAkm8jAvvUDMPBbTRjF/U2gkyAfC8RkQI=; b=gqvu3LladePLAGqk4b4YfI
	uq5WTrpieCOvePE+Q8po2aVC6QrcH7rnoTs1omrxd8VKcQ0ub81jFUPzZVGCjWfW
	6Z8ezDeLhiiNEHb+5uDLsw5Z/5r3kDKK7Zrj9tfbizLJMeKZCzBkNJnSvgxgJVO0
	ISHVx9DpT/TC6JnJpfgtPzb+T+7H7QaO5cHXkjMWAGJrLr+NY2YFOWOAdlGz5253
	XIhdNSDjgzz/DFjfuB3tcbs/kKS58ZtcVBQfxQ1aXI36Bh/z8hwgKp+MVKZcIumA
	wbcZDhm2cfupFup3pSbCqPkxUhsXxFAr1E64hzlZKAfKYtJ2aP85o+EpQGDuDujw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffdct1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:08:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9b1Sl020492;
	Wed, 10 Sep 2025 10:08:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp100tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:08:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AA8oAv32964884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 10:08:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E52858066;
	Wed, 10 Sep 2025 10:08:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E798058055;
	Wed, 10 Sep 2025 10:08:45 +0000 (GMT)
Received: from [9.43.57.88] (unknown [9.43.57.88])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 10:08:45 +0000 (GMT)
Message-ID: <384ce5cf-a404-483a-bac0-6307b62c52e8@linux.ibm.com>
Date: Wed, 10 Sep 2025 15:38:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-6.18/block 06/10] blk-mq: split bitmap grow and
 resize case in blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
 <20250910080445.239096-7-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250910080445.239096-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFqNYJDuSvoNvfTazYoA7z1TIP18aucD
X-Proofpoint-GUID: gFqNYJDuSvoNvfTazYoA7z1TIP18aucD
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c14e33 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=V5-dstEP5heE38FwefgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX7nTxIKUUcVAw
 X3IBexlUCE7snELaN55UaIakraK7M/hiJgrPx4QDxCu02cmw5ULYzegI09w0fyTXG1oGD6cYoHg
 Hy7A0l168KPfJ4vE/n658yz1leTZ5J1lSPK5gn2suvW4WCiZM2dA7boey7JKMpME2vgAUcASX3S
 TeucYivcr4t67zac8K9s+r8vsGTZ1iAPEbYyUsnY3C6xuieSzJGcCxiH0UQi0UMBVn99dlXq1vP
 uImbgnRtbCbULfZyrT5sOaJnVetuaD7uBCUtTFcDbN1fLbPKbbp7YAP3SBX48RyvDw+hUoZotn/
 VyXrGoMYBZdVwe4ShbXvF5Gk1vZHG/p77LdE8RyNEmGzxBw01PiDwL6VLh/sAynjvxvNtrrgv/f
 ZvsfrTy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/10/25 1:34 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> No functional changes are intended, make code cleaner and prepare to fix
> the grow case in following patches.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
