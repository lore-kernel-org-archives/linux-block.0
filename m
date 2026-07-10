Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26242CAFE;
	Fri, 10 Jul 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688932; cv=none; b=YRf9NKlQ7xt42fkx1ytVcMad2rd6xXmRsXd2PA+kxwsInM0M7B6HsaCbtLjaSzDs0kZNA4Bd7uIXLedfNqLJ/ffl9e02kmRugo2Lqk/0ltfk4+AIpBlfeTZCi4CaUjW59M5E+iq2iGb5bDn/2VFV5C+2klpNkSQzIgqpNLXYkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688932; c=relaxed/simple;
	bh=bfUEM5pFpkjMlAwpyGbdtQo+kmP4zccPa3/YETCdmRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQeUxneIU7onQxAdydxPwPu3KxXzLTMKAkb247Htpzj8y1jcjVSVoXh+sr1RW1HW8DQ6AXsBZqGU+Qw4sTG5tWZGu1Z63ujLyywEHoM6ipl04MrZLYPTqUQnBhjkNAXNTEd3P+/VcnN7CWHSr/Z1k72PPqTepQvgSLvcuD5fd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S/IyMo6b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S/IyMo6b"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAnQlp1030976;
	Fri, 10 Jul 2026 13:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aG0n1F
	dG34GazeQRENhR2+AgMsbo9WHY0fDlMhI9Jtw=; b=S/IyMo6bA2WKg1QwDn+eZV
	5sBNYmhNtkv3RS3IdjnB1i9lQEsk1zz15APh/JIDk2ieGHCg/R88pRDhDoMcWUGZ
	lr5AV7KY6RJDkNxrYpLJyWxuEgwLg6EOWmiLCVBlDICEq74N3x4QEUgW8YVdWjD2
	Z3VPA9088BRQ+othcJe5NJbFGazTl6ZQ2o4Z/L9aBhMVvBzzRYztcq5NM7FL695c
	2O80hgBwKn0orxZNrehgUxRaOuH3VuF94CT8CrZxPfxa8nN2kBnA366U/xcjHzt9
	wgTlkCkEiGPe0ffmNoDJpEQTyFc/98xvoiHqGwFfb8L6mRGmdx+09zpFNvmNpEsQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknx552-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 13:03:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACncZu019750;
	Fri, 10 Jul 2026 13:03:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yhrvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 13:03:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AD2n6N14090806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 13:02:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BB658068;
	Fri, 10 Jul 2026 13:03:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE1358063;
	Fri, 10 Jul 2026 13:03:18 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 13:03:17 +0000 (GMT)
Message-ID: <ae0096b6-e8d9-414b-93de-bd69824133bb@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:33:16 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/9] null_blk: clean up null_del_dev() to use cached
 dev pointer
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-7-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-7-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50ed9c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=MrS2xoVJ-OZOnyy_LdEA:9 a=QEXdDO2ut3YA:10 a=ZqXtYRWZLbkA:10
X-Proofpoint-GUID: KooNQOp1Pgf4cVUMGQ2u8p_pYhp8lJ4v
X-Proofpoint-ORIG-GUID: KooNQOp1Pgf4cVUMGQ2u8p_pYhp8lJ4v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyNyBTYWx0ZWRfX6sLkQIO5T1k5
 IISNEWWtNjo2QPLd500wkaKXRc9jgiD95BiVVKHFRe2QxhoXpTGkHR93xjZYk6dHFE+rPBu14VO
 HPHH1FAuGfqW3BDYik7yPYBM2FrOP2E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyNyBTYWx0ZWRfXy/P7WmaR+WOo
 DmvwnuDlp1FJ9KbR9YM7Z1pyjnPdZeirOFmkSHiCNIcQbgnTt85PBH2I3i5gLOINs5/n+bUimRL
 Xw5mgN5cHUOv2kKpUDa9kXPKrDNyjjdGQ9tszp6suMi4C75NoJXAMOkbVfD3FsEsyOBzgcS//hc
 ODYjdK/8BMfKsnItqqhx+X6MKaxt2ffdLZgvtrHNbC0G88VaUQQSgXaCywmGiFAaM3MOxvHUeRg
 /o05SphvCvzwSfqXbDeA6n9Oj/ZpmjxZ6APYUbHDu5WPcP9n3FT+LOLxRuHV3tEeiPiNYnlbSaX
 Etf1d1JVLVOd4XMucmbMhnbnPc+6/Zqzh6+N5achVtVOfnPDlbVJNEVKR9CGUe2zLW/XM9voem6
 o8jY2bnp3ksma3ejKWhCCvZWjGqD7Y84NcDdSdLdgMJy/41nDsEi3184Pgk4TvDax2LODtb3SyI
 wFqTedJGK71PkGJw9Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100127

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> Replace remaining nullb->dev dereferences with the already-cached
> local dev variable. No functional change.
> 
> Signed-off-by: Zizhi Wo<wozizhi@huawei.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
