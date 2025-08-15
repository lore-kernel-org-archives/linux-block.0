Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9C823DD
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266729; cv=none; b=sjTpKyg0rvH9ymegqYKkb2vtShhM1xSTY31n9N3GxKgwRGnwvxCvHyiafnGUTZq1yLj0XL63/0AKz/viImhChAkQ1/i5v7NrPpER/L6UX/WrQezYcM1mi60pVPTlKXT9kxNLp+DL8Xlyxy8Li7DfWv26JRk5hYhdQ96l/39Vzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266729; c=relaxed/simple;
	bh=u8V+AawIb/eF+BKIu+0ZFIjRtQXr+S/aEkrtW9h1blo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyQB4PRZwQm0NQ4QbmEzmeJBNu1l1Bfiyj1K7qQAiezo441O35Dk07GY0Ok2Lrk8oEUeWe+9cnTXoWcUDsQyZRN6AooIUNXqd0hwwc2abP2+OHY0u/ii92UOGieQcAI+mKWaRsBQXOrc2Bn6go6WzKKndMwHSFaAIamB7MzD/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R76Fl8OC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R76Fl8OC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F3Crjx008554;
	Fri, 15 Aug 2025 14:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pwmdtv
	UpE5gACLYOSPZ5ewu9i5fLkANsFh9qc1RICjs=; b=R76Fl8OCfl243PGQNUD26j
	UFPLPZhtamGmB3dQt9G/UU7GznvLkBCMDiihvdVHX/t5wtehaVoUn+H9iBnuujyE
	E71eNqEhHEMhaCCKvsyTrYBOmTwcjya/pcpxnDvut8T1RqAGsbSb3OTJgQP36Mgn
	fK0+527iH/wysKEAFqL7TzwGQyvH5nvJYWs33/2lrQwrrfhvl/pshP+qMSj6dl76
	Rz9MU4Mkwu9FrpDrzAflwy/J4xaM2MFEFbPIVZ13EpvLSYV/CRBIBHm4iXyPOJmP
	jrRgl+9XzSKPldzHhxRPSPDDuYYOnWv18FVPjivQ5zubynsPs4qu7hSOcoFX0iag
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaakw25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:05:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FBE7ho010622;
	Fri, 15 Aug 2025 14:05:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnv1ch0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:05:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FE5Efc30409006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:05:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F3958050;
	Fri, 15 Aug 2025 14:05:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D260258045;
	Fri, 15 Aug 2025 14:05:12 +0000 (GMT)
Received: from [9.61.133.254] (unknown [9.61.133.254])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 14:05:12 +0000 (GMT)
Message-ID: <6c6158c8-db83-4c2f-b347-fd925dff3a44@linux.ibm.com>
Date: Fri, 15 Aug 2025 19:35:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>
References: <20250815131737.331692-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250815131737.331692-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689f3e9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8
 a=20KFwNOVAAAA:8 a=YlFXSKSEVZNZ-en7UKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ukZlrn6v5fRT6qjt5-gFqgKCsBtywGsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX+tNqdTPlDS3h
 2pgDqzPaWzbHoEgU0cnwc/lGMUTfkWxoEfvdgo5qUwScN06G6aNu4xFBJCAP1s0nYGB/gJ2X5rl
 oou1tWARHWmbGaGxQwJ0CdqWNgXewNc6XdYAFiKZ6W4jMwWfmPKXIQ+qYzQW3KxNJ45tTnkZq9Q
 Dt260yAHRWF7DXuY+rrF7XMKnIOwZe6XGl/nCfxf5pOxe4cMKjT+Vd0mWvjxfwOUfcD0edqa0DF
 7UHcbxHyGntPPTaYJLiyDf9xADbkO/dYXnzIxXgT7VcJtvh7rP3AcbJOBmtfrnGDTnwr6S4JVFq
 Wo4b5p516RVjC5noXBfi2Bj78CGGUdjJOyRjG8rdYog6c+4jtWZZ9KWr0fbmCoOiEcCU3xDCIbP
 76bJzqk/
X-Proofpoint-GUID: ukZlrn6v5fRT6qjt5-gFqgKCsBtywGsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/15/25 6:47 PM, Ming Lei wrote:
> Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
> running nr_hw_queue update") reintroduced a lockdep warning by calling
> blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.
> 
> The function blk_mq_elv_switch_none() calls elevator_change_done().
> Running this while the queue is frozen causes a lockdep warning.
> 
> Fix this by reordering the operations: first, switch the I/O scheduler
> to 'none', and then freeze the queue. This ensures that elevator_change_done()
> is not called on an already frozen queue. And this way is safe because
> elevator_set_none() does freeze queue before switching to none.
> 
> Also we still have to rely on blk_mq_elv_switch_back() for switching
> back, and it has to cover unfrozen queue case.
> 
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while running nr_hw_queue update")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
