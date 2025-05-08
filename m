Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA171DC994
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702778; cv=none; b=mr8wty6yS7HtsiKF5GtmMmWzkLYlZODu6ZuGcFACG+pkqCY5UkjguGcH+bYvhdxnNrWg8NbBc1p4kQqzKmjLzTJY4pHS39X9eXhAbeAATpG6errN3thDyQg7DyJpZuiwn5XdgvuVdVC3MaaFJnf7PVVJnK3Bt5FxCh3h7BHmZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702778; c=relaxed/simple;
	bh=D765o4+cfJCj1Mn2RLFuwmX+NI4Bg5hH6IDFn4x9goU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKC/icFqUIyLbEXWFCwBV0knTNEY/YKdR9XxYqyFkiDwePb4WKou7WZn9fpxQHdsg4Jpor+cMCv7GrEzPpL0PdVKYhLbAilxXVVK3q96b4t+6REpSeUOzfWolItWwyKXPlTnI9kqup4pEW33F8ItTwN7BqduLo/3viOoFxfCmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fQIJ95UJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fQIJ95UJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548AXZ7S024721;
	Thu, 8 May 2025 11:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bCJVZr
	ltFGQpLtV3uLePx5Fn0NlmCjOeGuY3mGi/Ewc=; b=fQIJ95UJ6SiOTs0mYORVgT
	63LVk0NfTGiencPip2eOnNR2e0qRI9N5ZLY2OhtRaSVBSvZEVvsGuoQ3LAeXq+XJ
	PMou/lsW0MqtWozNboES8dXZlGQfKMbKr4ffLJKq9N3ZlwcXlSYuqziDkcJG/TeV
	4Ruj9+GZUr/9mOPKFGI1aStghLh1LaXVW/e9QEv20Znr3iybcRhKobHyo5UYWHPF
	NEtXG7DpqXGrz4wn3M6pBgaic/Vv/1XlCU2BN2L0qgua2Uy+PJsOXjvc6T6Pqzu8
	Wvszn0bMSMy7Sjm2edqdBhHElwNTy7ANXE7F+HHFKvO6kgU/cyUWKgBtwcrR9DMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gfm9b2c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:12:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5489LR5G026038;
	Thu, 8 May 2025 11:12:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv05m8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:12:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548BCkFT60621282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:12:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD1E58050;
	Thu,  8 May 2025 11:12:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A289358045;
	Thu,  8 May 2025 11:12:44 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 11:12:44 +0000 (GMT)
Message-ID: <cf7d2318-a76f-4710-804a-653ecf4cd8af@linux.ibm.com>
Date: Thu, 8 May 2025 16:42:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: move removing elevator after deleting
 disk->queue_kobj
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250508085807.3175112-1-ming.lei@redhat.com>
 <20250508085807.3175112-3-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250508085807.3175112-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX3PGDVlTkjEGv HYSSMkSSKO4rnC9RWJBXcHNgfWJl145VJGnU48ayMEN2feHqi3xr0CSQ9vqsNw0xi1XvREC295x cKEFi8j1EwOrbjME8gZJW9dyf4HvCoTkOBXWRTLbf0cgPnCV/hKrl0uAyWXTx2qK/dUhiEGKmIH
 p5lprKeJqZPbGlO/S1m9scqgZ0qFZ/P98E4AFbSWMQXy9hlZIBQtswiVNRzhkjSjxAwv7EQVk+m Wqq188r037bbtCv5I3K1ZcUiV32OZuo3MU7RjBRtunmxuDeAnyi3/v17JE9NqIFsl3q1Us2y3ZB lxBKLTd92yJAAfTnmNMEPMX7gbrdspxk1HOD3nhOMnhSoysGdXnbcF37F4ZR8zq698wfqDe1K0q
 T5jSUNMPWXkKPaNjwNE5FobUbHznJxot7RWDPdSjEBZNa/yNW8gn0J8HJW44m3xUL92//b8l
X-Authority-Analysis: v=2.4 cv=RIGzH5i+ c=1 sm=1 tr=0 ts=681c91b0 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=kuN696WzSKmu7c6pyiUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BCXY1eX6y6XbFf9XCBsecn7EqPvJIaVT
X-Proofpoint-ORIG-GUID: BCXY1eX6y6XbFf9XCBsecn7EqPvJIaVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080094



On 5/8/25 2:28 PM, Ming Lei wrote:
> When blk_unregister_queue() is called from add_disk() failure path,
> there is race in registering/unregistering elevator queue kobject
> from the two code paths, because commit 559dc11143eb ("block: move
> elv_register[unregister]_queue out of elevator_lock") moves elevator
> queue register/unregister out of elevator lock.
> 
> Fix the race by removing elevator after deleting disk->queue_kobj,
> because kobject_del(&disk->queue_kobj) drains in-progress sysfs
> show()/store() of all attributes.
> 
> Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

