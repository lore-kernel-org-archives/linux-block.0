Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C02E11D7;
	Thu, 21 Aug 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778937; cv=none; b=MQNjSTNHIIzZfnbH6pCKhy8sDOA76aowx/uieslaYEWbPk950NTfzyHJAJwIrUiiqp8quOG2DXltLtxFXeVvzUwB2bt+maF/w8YGyQvy68/wFSwkBVuKCdLha9gv9J0MzK5cV3vwu2FyK3M4yIRAG9oAfbwrbZUYlEiJVgcNU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778937; c=relaxed/simple;
	bh=qNcFoh/UlNjjFgV79qooYF0rIFA73Dk9vUEULa8BVHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJCkRm7X0YewksDXxGwBOhCzRISUykSjDYa2qOZUHAlGKpU8Rg6sBFxHCMcwSnmTi60ebMY/V0pVp2w87QSTbJoPtWUOkd89HsRMdrCy23IRoqbHQPIm3qaT2CTsJkrqmY5mjgXa0MFLD1o8iSKXiEJfD7mECx80R/Ve7Z5FkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVTy1H79; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVTy1H79"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LBRhAJ002194;
	Thu, 21 Aug 2025 12:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A52f6L
	2XomxtU6yBzuD6WmyIMfHyxLnbdp3M3IJQVo4=; b=LVTy1H798029Bfy/769xw/
	Yi4SBO5sHVmfrNK7phGS94QN5Hh9axh41ZCrlrQLH+vc7fHFrdsCCNM2zxBJRIxa
	TaCgOk7GmU+cvJsdGbonsftEIGSpXIMkXJahCkv0VDv0ave81HKB7+gUKshZnoQ6
	oTeq/gJXvzNPXLZ/sXJfc3mRXzYLa39wbfM6DJjHFh7m8sXJYYrZN/R4VwZD7OAE
	/xPPF6OnKoeE82URwy2+Gmij9U68qobW3ldWBkgGDlltxreAa8UyO9TwnZZ85o7V
	YZhTKannySI7K4MZr2o4zoCB2vOAUEhX+5u26ilT2y7TacllRsKkDGsVax9xw2sw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w8cxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:21:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAo8s0015613;
	Thu, 21 Aug 2025 12:21:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my4287de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:21:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LCLpHM29753862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:21:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5335A58060;
	Thu, 21 Aug 2025 12:21:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA0B58050;
	Thu, 21 Aug 2025 12:21:47 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 12:21:47 +0000 (GMT)
Message-ID: <98b30bef-3f7c-411b-b724-ed614a86b056@linux.ibm.com>
Date: Thu, 21 Aug 2025 17:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] blk-mq: fix elevator depth_updated method
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
        bvanassche@acm.org, ming.lei@redhat.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <20250821060612.1729939-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250821060612.1729939-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX8MxBI+DUbmlB
 gtPYZuoTM/8zmwLXcN8isjjOR+6ICeV6g4++RxBIvInmqJGb+QseBJpGcTADnKpuQHi2fX0drCW
 IIs8w7WOgv1PUj9K1ezA9IJmYVJtxMCMFauPuIi59eOGX2DWj5gsGqY9JwZAz1b6qKpmcJAd+td
 fyQvFj/fjAlXmxlt0riELlUc/6bVjdfV02v70378d1Boxnsi9o09CjjWGJWY6pV5OviOsK98cTR
 UhIw6DlCP0HLHlip0iT6z8gh85cW3Y/+M7kb419cPIOc2bvMSucFMymCiUftcXeJuwUbH0BbEhC
 8xtJyD37Eoc6u8qwg9gqBUubmvU177La2OWn5KVsqQcLSTQ47Fm6r4XPCwXoRJPVLIGYtapMAu0
 cKrNWRhCnEi8xzjfRNu5UWLdb1Kx8w==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a70f60 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=G2FcNzjyDMgwL_yvhcQA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1NdmM2f24fRXeyeJCiB8Ab2F_qlC7JCi
X-Proofpoint-GUID: 1NdmM2f24fRXeyeJCiB8Ab2F_qlC7JCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222



On 8/21/25 11:36 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Current depth_updated has some problems:
> 
> 1) depth_updated() will be called for each hctx, while all elevators
> will update async_depth for the disk level, this is not related to hctx;
> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
> this hctx update failed, q->nr_requests will not be updated, while
> async_depth is already updated with new nr_reqeuests in previous
> depth_updated();
> 3) All elevators are using q->nr_requests to calculate async_depth now,
> however, q->nr_requests is still the old value when depth_updated() is
> called from blk_mq_update_nr_requests();
> 
> Those problems are first from error path, then mq-deadline, and recently
> for bfq and kyber, fix those problems by:
> 
> - pass in request_queue instead of hctx;
> - move depth_updated() after q->nr_requests is updated in
>   blk_mq_update_nr_requests();
> - add depth_updated() call inside init_sched() method to initialize
>   async_depth;
> - remove init_hctx() method for mq-deadline and bfq that is useless now;
> 
> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
