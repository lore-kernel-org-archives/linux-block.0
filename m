Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B6191
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069598; cv=none; b=JI//hd/GnhOpReEOnmPGwFIxJaWGh74TwIkW0HiOGdyX3XKDm2vpB20rpVGVyr/aqGAm/s+vJzzxlic248+oRBz+bI7T7gGzP3IffL3ejgo2MXuTPQ7HgN/vw7zIvp2r/iRHP6Iex3h5OZ3G/X5uPvJAY9FKBiF8rB4m/iooGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069598; c=relaxed/simple;
	bh=pa1NcYCqH2HWeEA/05toNOFdOtJCgS4HQlFWWFXX+NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pk1T7awf+QBRdI6sghEBcZ4FFx3vOYTl7TEvc9iSqVQ6AQSBm6VQ6zg6R0jV0eLVPi+pnEhVoWG6xxPrl0MnXNDUvMmXKYXxWAFK1F6vF9It+iBzafTPjKVjxKtRfVjbOC80/Vy/MattADS2n/yoFwDdw4PcREHFsUNAAePOpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejbfeyec; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejbfeyec"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI5FRgL023977;
	Thu, 18 Dec 2025 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WdXuE0
	DxOwaxnEgVQowLqhQEsFBzDJwXTQrKh0ZCFwo=; b=ejbfeyec07P2ovOzER1F8n
	J3Opjo4Q/1LhNV9L71//hr16aBTg1X5VNuDilQoW37rphMW5vGIloKcUIU8V/cjU
	Rb+a6dwRXlhwiqETlssmT2t4y5dlzHoyP8+I8lbhjASyFVL+i6cW1sMFoWJViIwJ
	fEGTLcFXv+ZDVmW4Ux2axng4osN+BtfkIjjVKF6K8FYaA77unf2iNpkFLabcnsgw
	v0aGQXWUT/E93Ztb+s3LUQDljv+mUYSLGNZnxm2VZw5yfl40qV3FDWD2yUEdp+d4
	EnnvioxvCFqvyanoogJSWfXf6PReQanwDfJ/sNlHFgGiwRdfq9hQR3oSnjbgdnxQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjmabe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:53:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BICSsOm005690;
	Thu, 18 Dec 2025 14:53:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp7j3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:53:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIEr3KU64225694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 14:53:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0504358069;
	Thu, 18 Dec 2025 14:53:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA2758052;
	Thu, 18 Dec 2025 14:53:00 +0000 (GMT)
Received: from [9.111.59.18] (unknown [9.111.59.18])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 14:52:59 +0000 (GMT)
Message-ID: <fcdc91ae-8c41-4978-8271-df10c4931903@linux.ibm.com>
Date: Thu, 18 Dec 2025 20:22:57 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] blk-mq-debugfs: make
 blk_mq_debugfs_register_rqos() static
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-6-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-6-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kUKpms7BKkk-OlYiOjJxvgedA_u71NUO
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69441550 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=svpNiCrhC-7QMpWi6ZYA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: kUKpms7BKkk-OlYiOjJxvgedA_u71NUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX1kTWmR8aNWIX
 ntIn5uXtr/0iPqBhzfnazP+Wpm6QPGRfeq6G4jtRgcmx/9rdCelQEMoNdDr1Ee++iMPh7xgX2XP
 7Fzv11i/lmcG+sjfds9IMYNvFzo1J0Cm9SI4SPfbj+K03e0+y2qxU5zeqX8D7M55ryAj4HnniKr
 XG+gn8YpfjCE9sQj7IsmZOW8cNnUdkavdLeV8qwjd+C5dqaynuQrxRPzlm/zr6gpmYqi+PjiK5l
 1tVkZy1ZVMxWoViXey2Ek1ZajWcEEJvzEi6kTIvfyY0kGfxTEg/nTKLY21HdSMT8RtRhzp8E3cn
 5X6boeudk/RL9skazGm04Lu/ISyfLOjTvyon3EZLMvolmtuu8DsXz3Q/iUJ0pnnPrW+PeFDb6JZ
 vlVXFwkb8dQ8F+qvWv19Xp9UAaSrwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009



On 12/14/25 3:44 PM, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  block/blk-mq-debugfs.h | 5 -----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 128d2aa6a20d..99466595c0a4 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -14,6 +14,8 @@
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
>  
> +static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
> +

The only caller of blk_mq_debugfs_register_rqos() is blk_mq_debugfs_register_rq_qos()
in this file. So if you can move the definition of blk_mq_debugfs_register_rq_qos() just 
after the definition of blk_mq_debugfs_register_rqos() in this file then you may avoid
above static declaration. Otherwise this looks good to me. So with that change, 
you may add:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>




