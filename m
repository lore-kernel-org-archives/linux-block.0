Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8003101BF;
	Thu, 16 Jul 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210245; cv=none; b=IUtzgx/hYExZFIDVoKAbj0HXYK4Gb07/CWBMmf29DhW5JvA8pmS9k0FSqTpRvbhvzOuTqkqIdHUE3DzaI066+WwoaxHsYDeEJg8i+PIVQdIDJvM08laAk424bSMonW8+aT913e+ng/rU3KTKE7ViUObVb7yo3K6wCXuL67GlDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210245; c=relaxed/simple;
	bh=drUEoudMJUi504tz/EQeiKWY29mSkT5Pz7Y+/zG4Wag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nw+9iSqI5J4vaJ2yzRBfqfqA9U5nm29yFLmpzM88mblMdruStXC2141RuksCrFtrDiToFel6u4ZikD7VhSA35xLvYc5aLPHqfSQigTcF+UygpBrsvTP8Auy5a6mqYK9HKMAUul2gzjlum1PkIRCN+/sNs3NFNT2oxuzYj4IHFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/MC+jjH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/MC+jjH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDffZ43370673;
	Thu, 16 Jul 2026 13:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=++m6IJ
	YDxYSga1Ch1W5QeDggP//DEF1nrADpHdfR+hk=; b=i/MC+jjHt6ip6dWIdL5MUT
	QzIUzKdRxzpnUW/xEUOD3PYzxA1k70H+HlZdn9owuK9AdzBD0XvSAIoqetf3A/VQ
	Ahv0w5XEJtncu/bbu0NyQZEYZGU9No15p7oWdtj6Jp4y9OMKA4lJv6eQcCEmh7G+
	Lhs3CKx44tDiJfN1jRRJklfVrgRc34AlJ7Qlm2twWxt1I+EiOIq6wYnENaMLJIph
	1OCjB+emnUbCCiqXrpexb3WntMqGoXz5gESded1iaZBgTXH+Em6nX0YEslP9E1ad
	ZC8bJ6iqZc9pPBkGbnSi6UJLyxgO29O7YsxAkX82BdMCokVZ8dXuS6PBqbFeun9w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegth7eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:57:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDniso019165;
	Thu, 16 Jul 2026 13:57:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdct0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:57:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GDvBRX38076906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 13:57:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C964720043;
	Thu, 16 Jul 2026 13:57:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E76720040;
	Thu, 16 Jul 2026 13:57:11 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 13:57:11 +0000 (GMT)
Message-ID: <7ef2df61-b92e-463e-bff5-69a1c1e1a675@linux.ibm.com>
Date: Thu, 16 Jul 2026 15:57:11 +0200
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
X-Proofpoint-ORIG-GUID: XksYaD3EWu9LpxZFlZfg12rOhfsbNA4W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX21B5HfZE4O/N
 kRUgMyAJgut4+/vbJBZlHQE+rbAJM9RKDFu7NmDMPCh/jtBdcIHqkJ3iPWS3obCopnQ4/8A1hL/
 VhhOiVjl1nwvJ7WYUQQ68yshd/tTpUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX+nFH/eSytQWa
 Mwp2OH+nUr/sDgOjErELKcJ+ZmCs4b3sjb4BQ0B160XnsViAxJW26eeRs5V7ZX1i3byMMVoXm0p
 eh2jChn9J0R9ykHq/p0jgYP6d5P9J3Aeg4BJxJpmde4AbnQwKu6zmX0W0UshvRT3Hn6baBzxqSo
 qUEvVJ2fgYXi1YEUxuAhD3xD1KIhYzjAut76o0hw47SZOno86DuJkL2Usq8M+/6jhXb0vgp0kgZ
 ethvTdlK3VGmtTBc50y0VVKcxVQY//yW2jqy1tTK4/L4W7STnszZWVynFEilAfqXznLYICKSLAU
 spAQHpbmOvaR3Al1vpxrJvcg7QDtamyuO6QNQHh0Vjw0JndpTGVx4HnqYf4YfA5CMYbRsq6W55X
 BGuzVGx339KYQoUG5JNEhMr+nXksW5UTYSJLfB5C3y2y3h3a1b3rE60kO6z2+tnUVklSeNjHYl3
 mb6piR8n7MVjfJFRV/g==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58e33b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=6R6TJRccWoc8txHpTBAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eImNXZ65MCJa22igXkDX_-5Bor-kRNfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141



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


And when you are at it, maybe also do the reclassification for NBD_CMD_RECONFIGURE

@@ -1371,6 +1371,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
         sock = nbd_get_socket(nbd, arg, &err);
         if (!sock)
                 return err;
+       nbd_reclassify_socket(sock);
  
         args = kzalloc_obj(*args);
         if (!args) {

