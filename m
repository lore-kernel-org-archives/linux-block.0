Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5637BE9E;
	Mon, 16 Mar 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653565; cv=none; b=XEH2v3QSxt26Vmmi9sTMJGIhige8Zr4jvzi6KK0RtSajCON8F6w5XG4a1WDB0XyqZ2kRhZOnx4l2fxQnpflcsLLpn7vF/IvyiDzxwBUKXciTLPRNPTc9Eh1Swq9/HXCzhnqbpGVVuEFsLR9fPfV/8bZiDACHMplVvtc4tqbkrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653565; c=relaxed/simple;
	bh=NPyOBM6v7fSbXPXai+SzawMe/wWJ0zbdnHPyVHZ/J4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liM+vxV2e1pTAdWa/js7GPKBwY2P810+Nk8IEnzqCgRkKdArTkLdFyso5+AW/FLPGlEl8bCvVx7HquiOqDN1Yx1McEm77INKZhiA1QPd3RUdeQ633bjKwzaAYvzpCvccP7RvMJGeIqx4pb6vC5JY5HswOuTmsEONt0dJEPf6ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NaaQ/2aq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NaaQ/2aq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G14rNC1189868;
	Mon, 16 Mar 2026 09:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x1P4TU
	n/1Jh6XVpwzkISXX7t4+jUJdTfOdKFFnqUOIg=; b=NaaQ/2aqbApQOEVsLGWxrt
	Aw/68RvGLoyBhi24f/KEOqvWhLoPcKRPmYAvpU5fp35u21f/EcuxRDf+iUbhYrnH
	Ae8kSO3kumG1cMRxJWT+zTON3PycoktS15LmQ6iVg7Bvv7i0lOMZFQUN0jq1KcMk
	DNBMvb9ohgrbvMBN9+eiIVEBWbtVYgyFB/qoTzz7OjAExY8Bonelu+L3RgYsR8xz
	0yJ9xs1AXz4eMIYKelcGulTm0kBRoMY7pekqGQGwUHgtFSzQCzLLIqPdGsgsHbtR
	F7uxGBWPdf33ALKj3h77ZAN76jLVEDuKGehQhoR1EVKn9yzuUIJXE/UzhMl8PWSg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vf9dsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:32:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G5NnGh028739;
	Mon, 16 Mar 2026 09:32:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk46ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:32:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G9WB8225297508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 09:32:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0DC5805D;
	Mon, 16 Mar 2026 09:32:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D276558052;
	Mon, 16 Mar 2026 09:32:08 +0000 (GMT)
Received: from [9.123.5.177] (unknown [9.123.5.177])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 09:32:08 +0000 (GMT)
Message-ID: <5984dfd9-04ae-4387-9a2e-f995b0781b92@linux.ibm.com>
Date: Mon, 16 Mar 2026 15:02:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-wbt: remove WARN_ON_ONCE from
 wbt_init_enable_default()
To: Yuto Ohnuki <ytohnuki@amazon.com>, Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai@fnnas.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
References: <20260316070358.65225-2-ytohnuki@amazon.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260316070358.65225-2-ytohnuki@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bm2j9v2_8hUmvxhGeSyN-p7tmPZP5deo
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b7ce1d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=vggBfdFIAAAA:8 a=VnNF1IyMAAAA:8 a=OD0D0cZe8JJ7Gqt4sUkA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MCBTYWx0ZWRfX1jGNAElkdR2L
 SCKWA12qEgX2S1ZwRM+giKQgJk9udXaWFbQAwcPcQSVi962f9NN6tgAscpgN1+QvMF2CSQos+wA
 F5fCR5LaNpeTqvIOSmYIXcELguL7fWvEeq5h7zV+IwTVhpNgNHYkhMET5nVFfOF4ZC/UGMAyNWE
 wWLhXBQQ/90q1SFng9QMCGQyGeajpDUjhuUydhqvcvSHjkbV5uGPHI4AusqV+yoKHUfFffJ1Yc3
 bmIUDpKS3hQkq7wiNgwy5cHZOgh5rjsI5tmUIXEDqTZNKdq0KacOjskmFrjIInr/Iffr8GJwKcP
 3gFNs+JRcHMZygGZI3iyDy2f/qF08smm9CM3XRYyn4m8qj8vsPGEHHDXXH4rKQPV/9kzaMfN7u5
 2QjHsNIrveA/hfXI1DUzdhv2jwgWlt1JwSHMlPs4AGB4CPkSdX2k32oSz0T04gQVJqb1CIl2HQS
 p0MKXmiEHp4d9DMFkJA==
X-Proofpoint-GUID: Bm2j9v2_8hUmvxhGeSyN-p7tmPZP5deo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160070

On 3/16/26 12:33 PM, Yuto Ohnuki wrote:
> wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
> wbt_alloc() and wbt_init(). However, both are expected failure paths:
> 
> - wbt_alloc() can return NULL under memory pressure (-ENOMEM)
> - wbt_init() can fail with -EBUSY if wbt is already registered
> 
> syzbot triggers this by injecting memory allocation failures during MTD
> partition creation via ioctl(BLKPG), causing a spurious warning.
> 
> wbt_init_enable_default() is a best-effort initialization called from
> blk_register_queue() with a void return type. Failure simply means the
> disk operates without writeback throttling, which is harmless.
> 
> Replace WARN_ON_ONCE with plain if-checks, consistent with how
> wbt_set_lat() in the same file already handles these failures. Add a
> pr_warn() for the wbt_init() failure to retain diagnostic information
> without triggering a full stack trace.
> 
> Reported-by:syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> Closes:https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
> Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter")
> Signed-off-by: Yuto Ohnuki<ytohnuki@amazon.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
