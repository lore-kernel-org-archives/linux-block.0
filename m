Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9A4430
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048310; cv=none; b=j2+3jvokxtA3sgg0g9jdf0UB6QKlEaW0upvIs40Rm+tzVVR+a9JGkYagY61rad2otj85TLbh5EhiuJ3Ac+96sC/vjfoVwArLwwGYxUQeyaV9LEmDFyjCN/XvfIPN/2r8YS/YxIZ3Dnk5F2QxmaE4A6FOQNM+nqp4flei9dyZBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048310; c=relaxed/simple;
	bh=HpnWKn04Qy4+miKmDmyr3a4SC1UBbfUCRooIPjd5+oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thpt+tbCuZiyfq/mXnHd3vtsqr9B/Kd+P6Da7wb6t+qLkTM/MZ1DiWKpMz1DGBEneXxdCTG903CnoWphZWJ9TEqLKl2QZMrWgaIffiY3zEMAmHP58afg7ixnPO8XnRAzBr2guW/BcAKRD4MjMlY+08xFL9p7KokTQvce2ogFo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sI52Bsj2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sI52Bsj2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLITv0026972;
	Tue, 28 Jan 2025 07:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C/rpk7
	a8S4+crdzBSryHBSnMFxuM6hH6xV1VSwEjVCw=; b=sI52Bsj2WiSo8r+KLFMceK
	FkPlWcf0i6Gd96CssF4o6fwvi5xx+1cyq8Edx50CpxV7oUR+Bn2xCk6/mS+b/Tw7
	xsuDZnotaiYflqTuJ8ms+hJRuJ/UqFlEIfzOULm59oNpUTbdNOwS41BapO66Rr6n
	6wrh051qVwV6gnWp2j6bOl1WKhXtYlIHi8XoLb8oeOQPYiR3YLQD95UW2nI5ECGq
	fULjhRlNj+6lphlQcBW41Dqz0WzkcLKtlBCA7demNmQj5qgMxGVNCVijzKErvz0v
	aU1UmDlomvwLWfzHMOOEGFNpMDBbvShy50OZ6/lJxQuV8um4bJeKEZaDwmFmSREQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5undjas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:11:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5UO06028099;
	Tue, 28 Jan 2025 07:11:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbska0wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:11:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50S7BdOT20447974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 07:11:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB3A558057;
	Tue, 28 Jan 2025 07:11:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE8F5805D;
	Tue, 28 Jan 2025 07:11:37 +0000 (GMT)
Received: from [9.171.27.96] (unknown [9.171.27.96])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 07:11:37 +0000 (GMT)
Message-ID: <426538d1-0039-43e1-9bec-30b43b80775b@linux.ibm.com>
Date: Tue, 28 Jan 2025 12:41:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/2] block: fix nr_hw_queue update racing with disk
 addition/removal
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250123174124.24554-1-nilay@linux.ibm.com>
 <20250123174124.24554-3-nilay@linux.ibm.com> <20250128054957.GB19976@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250128054957.GB19976@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LUP0PEzVeaMqGf_7-RJ4CNzsU0nr_ZDv
X-Proofpoint-ORIG-GUID: LUP0PEzVeaMqGf_7-RJ4CNzsU0nr_ZDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280048



On 1/28/25 11:19 AM, Christoph Hellwig wrote:
> On Thu, Jan 23, 2025 at 11:10:24PM +0530, Nilay Shroff wrote:
>>  
>> +	mutex_lock(&q->tag_set->tag_list_lock);
>> +
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>>  		ret = blk_mq_register_hctx(hctx);
>> -		if (ret)
>> +		if (ret) {
>> +			mutex_unlock(&q->tag_set->tag_list_lock);
>>  			goto unreg;
>> +		}
>>  	}
>>  
>> +	mutex_unlock(&q->tag_set->tag_list_lock);
>>  
>>  out:
>>  	return ret;
>>  
>>  unreg:
>> +	mutex_lock(&q->tag_set->tag_list_lock);
>> +
> 
> No real need for a unlock/lock cycle here I think.  Also as something
> that is really just a nitpick, I love to keep the locks for the critical
> sections close to the code they're protecting.  e.g. format this as:
> 
> 	if (ret < 0)
> 		return ret;
> 
> 	mutex_lock(&q->tag_set->tag_list_lock);
> 	queue_for_each_hw_ctx(q, hctx, i) {
> 		ret = blk_mq_register_hctx(hctx);
> 		if (ret)
> 			goto out_unregister;
> 	}
> 	mutex_unlock(&q->tag_set->tag_list_lock);
>  	return 0
> 
> out_unregister:
> 	queue_for_each_hw_ctx(q, hctx, j) {
>  		if (j < i)
> 			blk_mq_unregister_hctx(hctx);
> 	}
> 	mutex_unlock(&q->tag_set->tag_list_lock);
> 
> ...
> 
> (and similar for blk_mq_sysfs_unregister).

Yes looks good. I will update code and send next patch.

> I assume you did run this through blktests and xfstests with lockdep
> enabled to catch if we created some new lock ordering problems?
> I can't think of any right now, but it's good to validate that.
> 
Yeah I ran blktests with lockdep enabled before submitting patch to
ensure that lockdep doesn't generate any waning with changes. However
I didn't run xfstests. Anyways, I would now run both blktests and 
xfstests before submitting the next patch.

Thanks,
--Nilay 
