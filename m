Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71F1C9B87
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111631; cv=none; b=cG4Ra3ys8uFwvl9pFd4svNuu1+u2WTe5IXaiAKp6gnJAs7ca+v2zG67UjgXZc9+HhTfcPzawmuoMjmq9aa/bcMgwRbY4z+RNlzFkvW7UjZK+HdKCnYqxhfX3VaMqwSxR2H46emUDf4OgI31tTq0+JuWlGLTz5S4BnPZkmisaWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111631; c=relaxed/simple;
	bh=9/MZ4ziZbpMhT6/DxH2odM2OKnJvPXTUsqHPAN0ntUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ3auEjw+vqVSiZAbT+vhfhr2sKQCgq4bS15Wde9qkxfhgfjqIx3zuShJbrbA7+8imkUI/Fb5xkTMo6TNJUjebHtl5zOljiZEdQNMpLw6IpSzCAx4DOsXj9SpYkZ+Jrz1ba1Vbh6CFk+QHU5ihVKeK9GwrDEvRLRFh/cpGb8aNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OWEGsKqn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OWEGsKqn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK7lm3g002773;
	Wed, 20 Nov 2024 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1GuDeF
	Uj6LqwrNYgCSdn4xFiJPa0CXZ9bYmm3HhkVBE=; b=OWEGsKqnDiW7wXpc6UWAUH
	TgUeHP8N5xmqlhtvNfforfRljWbSrnIZzvm1Unl8AG6JbaOg4Vq9COVxh1wdKs0P
	E0QTrfVjuW2LnKOH2Hj1omdWMmL7Lf+Y75dEFNNWobg65KUvdTnOucCz4CUzOF4K
	Ikjlljap9WbSYJtC7q3HugcxEUOPJ9mHyw+spGzdDh8kjyHIjJ8tyZCS6X+Q/biH
	THtvW/ulbX+lW6tmUX6XDgdbYAoRRyMVokmt+c9wlpxdYjsQn2ew8Jealtj8jRXg
	tUXKFIF2u8uJ4P7fKqITvmcs5zqc5/5so57YXzADGU1CR5hzGp/ce8FTDN6rw0Bg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjw88p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:07:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKDSLKN000576;
	Wed, 20 Nov 2024 14:07:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77mbg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:07:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKE71GX56230284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:07:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4F05805E;
	Wed, 20 Nov 2024 14:07:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B27875805A;
	Wed, 20 Nov 2024 14:06:59 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Nov 2024 14:06:59 +0000 (GMT)
Message-ID: <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com>
Date: Wed, 20 Nov 2024 19:36:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest
 linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rU-Xj3lsQs21YkDwzdMlCRvWdMKZNC-i
X-Proofpoint-GUID: rU-Xj3lsQs21YkDwzdMlCRvWdMKZNC-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200092



On 11/19/24 16:34, Yi Zhang wrote:
> Hello
> 
> CKI recently reported the blktests nvme/029 failed[1] on the
> linux-block/for-next, and bisect shows it was introduced from [2],
> please help check it and let me know if you need any info/test for it, thanks.
> 
> [1]
> nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
> interface) [failed]
>     runtime    ...  1.568s
>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
> 2024-11-19 10:55:13.615939542 +0000
>     @@ -1,2 +1,8 @@
>      Running nvme/029
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     +FAIL
>     ...
>     (Run 'diff -u tests/nvme/029.out
> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
> entire diff)
> [2]
> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
> 
> 
> --
> Best Regards,
>   Yi Zhang
> 
> 
I couldn't reproduce it even after running nvme/029 in a loop 
for multiple times. Are you following any specific steps to 
recreate it?

Thanks,
--Nilay
