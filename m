Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39520010C
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047503; cv=none; b=UIsW58Up8FsmFaHRodywUyjwEvAK7/MePJwalmrrVyPjykr7V6c/81XkUOHhVcR6BL797TXdielD3fde0hDaVVzz9/oSlg9N8pPT4d/5kprX5uzWQ82gQ4NC1ulxmUVRw1AFQSDGmQ9Qgc/dNe6RyyUmMrlQvu+lZ8H2zaiZQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047503; c=relaxed/simple;
	bh=S5QrMjzVZ/aw4H33FgjFDBXzmkaSU/UrMkwLS32/tBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdLGc3HBNkKRF9hLvNAAVg6QhwYqaGYd/pcH3+OHk1Lhn2b5z2VI5BnwrL4NnJE7wy6yZSXeihDJyl3404DcB55HEsNEblCin4erWhdZtqlXie9ySL/0Xd3gvg+vDX/FkFg2jwCCIH2UiiM7CzrqxOjJ2s8JgbK1prMyrqatt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9b+jc1t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9b+jc1t"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5691jDnp026476;
	Wed, 9 Jul 2025 07:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GAFn3h
	5lpKEYbIm/BX64s1L8xYOD6trPa8mIymR459U=; b=K9b+jc1tfzjpQNrqW5TrH0
	tZnPdeZW6nG/6O42TqbVjSval7RzMHZGK6NXuI7tGXvqlKLRDqE220kRDUpTOSMa
	C5d3o55aSVNF9rzEmroB0Jpxts6/zECKJ45P0/JuhcMTBmyyxE4SZKwx4uk+p5Tj
	tSWK+G160yp4fepC2AQCWZLFP2dpWvyK7LBDD3n4obnmgVmei//m1IF9sh7w2uCL
	VEc1a1XlHxmb/wMxVLrmoyzcNvzeq+5e+MoUgHHWnnN5V8riarRjOzr0cR0LbO+P
	+Od66L1jAY6x4+BskyUwnAML1xThx+Kpn0Kn3+yfm3LsYmqB2VHZpsAfeiW5g1jA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss4vu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:51:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5696td0J025593;
	Wed, 9 Jul 2025 07:51:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp75jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:51:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5697pNAM21889546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 07:51:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B47C58065;
	Wed,  9 Jul 2025 07:51:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8107858052;
	Wed,  9 Jul 2025 07:51:20 +0000 (GMT)
Received: from [9.61.141.34] (unknown [9.61.141.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 07:51:20 +0000 (GMT)
Message-ID: <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
Date: Wed, 9 Jul 2025 13:21:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250707141834.GA30198@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686e1f7d cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=vhI5hjkBLNEgjNdrGl8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dR_hcUfhlfw2W_hTFPcPdhxpwR5_S6X1
X-Proofpoint-ORIG-GUID: dR_hcUfhlfw2W_hTFPcPdhxpwR5_S6X1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2OSBTYWx0ZWRfX0kqy9dlptlhk lPb/kHToluSLLRiTmmPAEHJllVFwNbyxbouYtWxprBH5/isrwAYGhWQvh9TrNRmBeDj+xDHtCiI VMaGuJvRiuh4FO/oKxEs+3E2QGlHKZrTSOagvDWpZe76ldcLMjmv6KdI5ghettwm9HBU855MgPQ
 +awvxiz8Y4I79rAcf4BIshAF+wXYVUl5flPrGLGIICemcfFPGJn2/VSs+1kUZUJAMTRkxTHN4rF 6cnWVUAq9ibjZK92X2UqHiWuEfcZkIsE7JmhHoWCYeg9dlN4wbXnIs/XXGp+659ilBGJ28VfxNy pFEuqikBrJN6pPESvRyctlYP4Bn4v2IFWHi26TJHLPpxiAgNaKfpeJOUFQr+IOkVMa6i0tyxX6X
 +hdHUYtGud3kw1PZMCi4EOks5gBFkwbZuNwpc5filczXyKEhZFT2iZ+4YQi32BXD3dk1DGfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090069



On 7/7/25 7:48 PM, Christoph Hellwig wrote:
> Hi all,
> 
> I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> 
> As a short reminder the main issues are:
> 
>  1) there is no flag on a command to request atomic (aka non-torn)
>     behavior, instead writes adhering to the atomicy requirements will
>     never be torn, and writes not adhering them can be torn any time.
>     This differs from SCSI where atomic writes have to be be explicitly
>     requested and fail when they can't be satisfied
>  2) the original way to indicate the main atomicy limit is the AWUPF
>     field, which is in Identify Controller, but specified in logical
>     blocks which only exist at a namespace layer.  This a) lead to
>     various problems because the limit is a mess when namespace have
>     different logical block sizes, and it b) also causes additional
>     issues because NVMe allows it to be different for different
>     controllers in the same subsystem.
> 
> Commit 8695f060a029 added some sanity checks to deal with issue 2b,
> but we kept running into more issues with it.  Partially because
> the check wasn't quite correct, but also because we've gotten
> reports of controllers that change the AWUPF value when reformatting
> namespaces to deal with issue 2a.
> 
> And I'm a bit lost on what to do here.
> 
> We could:
> 
>  I.	 revert the check and the subsequent fixup.  If you really want
>          to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>  II.	 limit the check to multi-controller subsystems
>  III.	 don't allow atomics on controllers that only report AWUPF and
>  	 limit support to controllers that support that more sanely
> 	 defined NAWUPF
> 
> I guess for 6.16 we are limited to I. to bring us back to the previous
> state, but I have a really bad gut feeling about it given the really
> bad spec language and a lot of low quality NVMe implementations we're
> seeing these days.
>  not the 
> 
I believe there are multi-controller NVMe disks in the field (including the 
one I have) that do not exhibit such inconsistencies, i.e., they report a
consistent AWUPF value across controllers and do not change it based on 
namespace format. The NVMe specification states this (quoting it from 
NVM-Command-Set-Specification-1.0e):

"The values (referencing AWUPF / AWUN) reported in the Identify Controller
data structure are valid across all namespaces with any supported namespace
format, forming a baseline value that is guaranteed not to change."

While the spec doesn’t explicitly require that AWUPF be consistent across
controllers within the same subsystem, it seems to be implied. That said,
I agree this should have been stated explicitly in the specification.

If vendors strictly adhered to the current spec, we likely wouldn’t be 
facing this issue. That said, given the current behavior, I also support
approach III. However, choosing this approach effectively penalizes vendors
who have implemented atomic write support correctly—that is, those who use
AWUPF to advertise atomic write capabilities, do not rely on NAWUPF, and
report a consistent AWUPF across controllers.

In my opinion, the proper long-term fix is to escalate this to the NVMe 
Technical Work Group (TWG) and propose a specification update that:

- Deprecates the use of AWUPF for advertising atomic write capabilities
- Mandates the use of NAWUPF instead

Once such a spec update is ratified, we can move forward with approach III.

Thanks,
--Nilay

