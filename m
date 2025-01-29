Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FC1ACEC2;
	Wed, 29 Jan 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144518; cv=none; b=L+LFTZRuP52wBx6iQ4mmw0+hdEWhyUe05TLJDkPOzg3TXadLMUzbZmCZ5LNXz8FmMmmStDeeN+48SkTkqEM0mL5FtxxL3fq5VRqy9n7fZmgbRh+T6jCL1fLKoua4qRRcJYfY4LAewvdj8561/smQ5wIIMA2UL+PXx/urW8jGLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144518; c=relaxed/simple;
	bh=nurb2gdfnmsDf5k9lQZ2GeI9jK1G4SPomiZAkgbzTtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSMGZXvT/G5Rrm31vUCugaDDNgB2dyUc5H3WD85+04yUZCmbMNWMnF0Z8PfAQ+fgmzCNqvxrq1zXURJmy+fpAXGXNi5qpJBIMDGxKMYJ4Qa4WVAlTioupJ3cAeDzMW/MFfcpcIJHkfp17Q4QX5AaBl8Yp8EStUijHlsk2/Jvhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S69PLcWW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S69PLcWW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T21IAc029637;
	Wed, 29 Jan 2025 09:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=usmjl7
	ABJRKotUzXG1g98T82o0226T/3yDvMFxw9pTY=; b=S69PLcWWqcpiDgXDcVKjNE
	O+QG7CPlpqlE2AnHa0AcE2cCiuc3+fLNOvVhttBKsdKa7r4Q0Kelv6FhZBF0blMa
	E3/IIr0I5XZHpPMbJrwq8fva1TvH9XgwV5+LqKQcM7cYpCq7jHSWuvYWniBM7hxC
	/fQ/cTIClK0kqMVUhmCrBbH0H7S5JICvXTgJDzpz+lZkBudzXHaE7kOXjZ2mWgG6
	huvuicH2a99EPnnSFLT7DbxiRiOzhmc7u0RBaKprQvXRUsrKMP/Bkgt1rqnkDmrX
	sgAuqPMNQnO7zX7Yq9546JpPm3FyTk5+NEqspNNnwO5Z+LM/7NuLRLA/ENFbbRZg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb609hg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:54:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6P3Zc018922;
	Wed, 29 Jan 2025 09:54:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01fksn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 09:54:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50T9svG731195802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 09:54:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3494258055;
	Wed, 29 Jan 2025 09:54:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2061A58043;
	Wed, 29 Jan 2025 09:54:54 +0000 (GMT)
Received: from [9.109.198.253] (unknown [9.109.198.253])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jan 2025 09:54:53 +0000 (GMT)
Message-ID: <669a9e1c-bde2-4323-b997-cdbd82a26eab@linux.ibm.com>
Date: Wed, 29 Jan 2025 15:24:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d2EY-MP-VCV9R6ZjNtuHoq6fqyixjhZ_
X-Proofpoint-ORIG-GUID: d2EY-MP-VCV9R6ZjNtuHoq6fqyixjhZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290077



On 1/28/25 10:04 PM, Daniel Wagner wrote:
> blk_mq_tagset_count_completed_reqs returns the number of completed
> requests. The only user of this function is
> blk_mq_tagset_wait_completed_request which wants to know how many
> request are not yet completed. Thus return the number of in flight
> requests and terminate the wait loop when there is no inflight request.
> 
> Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-tag.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index b9f417d980b46d54b74dec8adcb5b04e6a78635c..3ce46afb65e3c3de9f11ca440bf0f335f21d0998 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -450,11 +450,11 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>  }
>  EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>  
> -static bool blk_mq_tagset_count_completed_rqs(struct request *rq, void *data)
> +static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
>  {
>  	unsigned *count = data;
>  
> -	if (blk_mq_request_completed(rq))
> +	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
>  		(*count)++;
>  	return true;
>  }
> @@ -472,7 +472,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
>  		unsigned count = 0;
>  
>  		blk_mq_tagset_busy_iter(tagset,
> -				blk_mq_tagset_count_completed_rqs, &count);
> +				blk_mq_tagset_count_inflight_rqs, &count);
>  		if (!count)
>  			break;
>  		msleep(5);
> 
I see that blk_mq_tagset_wait_completed_request() is called from nvme_cancel_tagset()
and nvme_cancel_admin_tagset(). And it seems to me that the intention here's to wait 
until each completed requests are freed (or change its state to MQ_RQ_IDLE). 

Looking at code, the nvme_cancel_xxx() first invokes blk_mq_tagset_busy_iter() which 
iterates through tagset and cancels each in-flight request and marks the request state
to MQ_RQ_COMPLETE. Next in blk_mq_tagset_wait_completed_request(), we wait for each
completed request state changed to anything but MQ_RQ_COMPLETE. The next state of the 
request would be naturally MQ_RQ_IDLE once that request is freed. So in blk_mq_tagset_
wait_completed_request(), essentially we wait for request state change from MQ_RQ_COMPLETE
to MQ_RQ_IDLE.

So now if the proposal is that blk_mq_tagset_wait_completed_request() has to wait only 
if there's any in-flight request then it seems this function would never need to wait 
and looks redundant because req->state would never be MQ_RQ_IN_FLIGHT as those would 
have been already changed to MQ_RQ_COMPLETE when nvme_cancel_xxx() invokes blk_mq_tagset_
busy_iter(ctrl->tagset, nvme_cancel_request, ctrl).

Having said that, I am not sure what was the real intention here, in nvme_cancel_xxx(), 
do we really need to wait only until in-flight requests are completed or synchronize with 
request's completion callback (i.e. wait until all completed requests are freed)? 

Thanks,
--Nilay
