Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF33033D6;
	Mon, 27 Jul 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169555; cv=none; b=TJqqkyIntLiCSnZdWHGOfU04L5P3bp1o1OuCjJAYocALHi1Jvpq5kiQyaqV78hsgVtWx0owKZCC0e5UgZzwOox7DZnllw+kh9SntQvPh/TTx8hB0fqWDZ/1imKJAfyB+MhENAF4CgUObuo5hrdV+uPi2tg0mJW1ywJ7mMMLOnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169555; c=relaxed/simple;
	bh=ece5mNZZ0viMxwqZlKtPD5c09/YicLdhETyMTyslRpA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cbknc/oXO2hEH0J6xAp2/4YzBWpGNv+0w6gYZhQZDeRejxrkYbkBGOHgn7sRqe1wCqHFtT8/+GutmGQLWtVrbzl431zeAu2+34MP/+9421oFWhctnBCrwCXcTnO6iA1QhypFPTR8j1Rh//+bEZahdpxcafcAvJ9Cy9w5fOYdYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k51zLveR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k51zLveR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn33G2374112;
	Mon, 27 Jul 2026 16:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jL9ufg
	g2MMEpYJXphOewdz1yH/sHcQz4R1r6gKHclN8=; b=k51zLveRIEokdsaEY9kHEs
	niXJBP2teBgflDC3zIl/dC/cI6XVNGakvp5Ql80mT6J3jGm/cUK8DBaxap/clHh/
	mk3RnTmAcAiTTaXDBhPNBpG261liSG7ItjG5HLPwj1wkpty5x0ou3UEywtFH61zZ
	IK99JBNqAOZfPjtMSC7PWZCG9UhnGer+fNMftae+rmlh7t3pWoFpAsfAbmlS/o57
	lhFuqq7GQJ334rfzYmG4EDxhMzuNRbuTGXx2Nwx3H/uCNsA7GFL3CBKdnG4D2Grd
	hY+hWCGhRQPM3aAEIuMG4l3woid3hUdlNiWWl3rWxv3JRDsGauiWXxRtRHy+OCjg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw790f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:25:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGBRkd028722;
	Mon, 27 Jul 2026 16:25:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh619k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:25:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGPbFE52298048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:25:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C35DE20049;
	Mon, 27 Jul 2026 16:25:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74CE220040;
	Mon, 27 Jul 2026 16:25:37 +0000 (GMT)
Received: from [9.111.60.83] (unknown [9.111.60.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:25:37 +0000 (GMT)
Message-ID: <e9d4fbca-ca91-4b92-a1be-950d0fde79b4@linux.ibm.com>
Date: Mon, 27 Jul 2026 18:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: reclassify u->iolock of AF_UNIX sockets
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20260713181401.11088-1-borntraeger@linux.ibm.com>
 <b15b5fcd-441d-40a8-9055-4d232f3780bb@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b15b5fcd-441d-40a8-9055-4d232f3780bb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hSR1pebgAMHEhZMufTefPJu8GVxp66ao
X-Proofpoint-ORIG-GUID: See-UIdjfjlqlKzDYUpIjZonqLdmrMOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfXztijp6KBtF9J
 2z2pWDyhvmrcsb+9MNwoXtSuiCmt9CLFNYjBCnYSyEcnc7ZnjDGNy0OfR50TGAjsX2Cv4nGujUf
 Qk1wJFKjJWfkUGQVNWbcUYmYIzdnSviWlHlQ228pPiRzQpE9sWmg0bPyZ6gw7tecH0RecImqLd9
 AgyxP5zqELvbCySJuhVWMieoi00smQ0TZukWnI94KvMyAlS/kabfHxRSbMNkYzGSCXgp6jpYqCF
 1WullAo5+Q9hXlya9C++KOflPkGJWln/4TYw3Uun/mqz3HkFPKHvSZsfwsVrapjyjcy29J8kVS1
 rwmBU9a19zqzqS3U0GpDJADDe3Xgv77uz9JQ9N2dmaNHpzS6axtgGJ4SeywfWm1mTwda74i5p5H
 5Mo9SS16bFpTKyZqhWjKnW+pcmZnhu3PEJ3jqvyG8Q7MW3H+sO6r/qpHQuQshD+AchZLAuo4UZk
 3c81hLQPS/vGGDsV0Bg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a678685 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=6R6TJRccWoc8txHpTBAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX76na+IjChDVZ
 h0FAiuyuuYgwjPxOVrklbANFwUy2Ue81OtBmrar+09XrWpd0yEW2w8sGpr9wR+UWtvIm4rAewaD
 V6Hntk0grh2BWCuyCxJjiIlaMpgYn+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270151

Am 14.07.26 um 18:19 schrieb Christian Borntraeger:
> Am 13.07.26 um 20:14 schrieb Christian Borntraeger:
> 
> I just realized I had my kernel.org address in from.
> question is, is this the right fix and shall I do a proper patch wit correct from and signoff.
> 
> [..]
> 
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 8f10762e90ef..a811e431b47a 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/err.h>
>>   #include <linux/kernel.h>
>>   #include <linux/slab.h>
>> +#include <net/af_unix.h>
>>   #include <net/sock.h>
>>   #include <linux/net.h>
>>   #include <linux/kthread.h>
>> @@ -1241,6 +1242,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   static struct lock_class_key nbd_key[3];
>>   static struct lock_class_key nbd_slock_key[3];
>> +static struct lock_class_key nbd_unix_iolock_key;
>>   static void nbd_reclassify_socket(struct socket *sock)
>>   {
>> @@ -1267,6 +1269,17 @@ static void nbd_reclassify_socket(struct socket *sock)
>>                             &nbd_slock_key[2],
>>                             "sk_lock-AF_UNIX-NBD",
>>                             &nbd_key[2]);
>> +        /*
>> +         * The AF_UNIX stream recvmsg/sendmsg paths serialize on
>> +         * u->iolock, not sk_lock, so it must be reclassified as
>> +         * well.  A held mutex cannot be reclassified; skip it in
>> +         * that case, as sock_allow_reclassification() does for
>> +         * sk_lock.
>> +         */
>> +        if (!mutex_is_locked(&unix_sk(sk)->iolock))
>> +            lockdep_set_class_and_name(&unix_sk(sk)->iolock,
>> +                           &nbd_unix_iolock_key,
>> +                           "&u->iolock-NBD");
>>           break;
>>       }
>>   }


Ping. I can respin with all the fixes (NBD_CMD_RECONFIGURE and correct from address) but
I at least want to get some feedback from the ndb maintainers if this is the right approach.

I definitely want to get rid of the lockdep false positive in our CI.
