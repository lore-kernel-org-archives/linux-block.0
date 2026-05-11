Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829A3A4F3B
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485583; cv=none; b=J2FAHigMqGk6airC+CC8Ed2dM9K2fQifH666yXk4yx7c+7XP6vK661mmFKrCIFiGT32DHJDLUvt8PW1qsNLlItkNDC3aqPr5iZY/ksX9d1oBDDJORdSLmO5gks6rAJzr9Tf7zrLryh0ohrwmPEwyzv9wtl5LOcQEU0lVP254W+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485583; c=relaxed/simple;
	bh=G5G49DQAocnr1uwCMhxbqV7M8UkSLf1k99/6bXbqfUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urY14SmIeI6GUlcatSacWhywSMDPcsxPuNKbI+ScM7dlguNAGG2yx+nKQGbD/BuBYiBTmmWQQYuaXnetvUK1ET30qDh8BD/bio/AhxXcEUnlKI02jbZcAQHxGMF0DxNEs8SLMX4eF4jMWlljM+rMfGAAcPIGrr8lpN8GiY41syk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PheNxGrZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PheNxGrZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMm6bw992031;
	Mon, 11 May 2026 07:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pbqCH8
	LYpgvkUUvp8LgdAUTZE/g1LA/vpbRss1TbrII=; b=PheNxGrZx8aU+FRyrAd8Z/
	HYFzVSq06JZknaowZEco5I90bnnTPbdQmuM/YWwdt4tLWxkSPB8XkmaVNxeqOf0l
	vzqNnp3L0aJEmKYaWy7dWuaztul0LyPCKH4eM0+bwFExoBaiTjNCUo7KwLfF+vI/
	k33FcjtE4iTdPvOtnsGZH5WSpeBpVYUimYrdyakwNL5Wq+6mVF310qLBxWBJ0bnz
	C1rTBcGgufEYorevtgdIKgBbbLKZUalMRNM1oeG8p6qKyMT8J04MPVEJty7ondWg
	QdrDjFPZwBgUlZRg88h6Ht7Gbf/1fel3eT3GlhYxdOrLxFEH6NvIDC3IQEu7SwFQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdpseu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 07:46:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B7dXQ3032382;
	Mon, 11 May 2026 07:46:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvvc9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 07:46:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B7k6LX31785368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 07:46:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 386ED20043;
	Mon, 11 May 2026 07:46:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF2520040;
	Mon, 11 May 2026 07:46:05 +0000 (GMT)
Received: from [9.124.212.213] (unknown [9.124.212.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 07:46:05 +0000 (GMT)
Message-ID: <1621bb15-b425-42d8-9ced-b3886dce1060@linux.ibm.com>
Date: Mon, 11 May 2026 13:16:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
Content-Language: en-GB
To: Daniel Wagner <dwagner@suse.de>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
 <afIGq_uV-l9_98Px@shinmob>
 <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
 <440d1e82-e54f-4709-829b-24d8fb16246e@flourine.local>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <440d1e82-e54f-4709-829b-24d8fb16246e@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a018940 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zEfdA16uAAAA:20
 a=NEAV23lmAAAA:8 a=hM82mkJf3RfDBQYuXFQA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 18_uA5exxhkdb7inl0tOuPj6dZ10lpnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfX15zKZscfMA3g
 KN02cTbOanu6DiDfY4plIhEnUxnsv6dg84vwN33bCAYzxhSKmRlfNzTe0FJYbuvcqbWX/QeYn7m
 c1xFpCR6BR2OlAbYHoCS9IZX+YAveam3Xd6mNN4TFLMD4ZTSC8SgxT7CmOrRB1kyOrPcRupVuu5
 8yhjR/JSpQwARXjlit8ifyBsg1fWf2EmxFUB9EWmf6qddB/x7fsPqijl42jvvx7XTADOemz4D44
 E97+/+DIw+BTFHifYGbccUGVEJE5PD1y0Sg+CDtipznuG2M+a2HecNSSBV9ndPiKFUZvj0gvpQe
 seOme2OJ8qGAKxeUUIwEjxdRUXI3gijga3835andiP8rkK69UxJVX86u9+eW+BrSlNh1f+XeJNi
 bBZhs1CbJwFkrHEqCpOPErSDQxISGuY4v/d8es2usuCNJ+iGCLlTrf+34WRETLX1rLVGf6UN5yX
 wp0QVt0FwxN6n5HUblA==
X-Proofpoint-ORIG-GUID: 18_uA5exxhkdb7inl0tOuPj6dZ10lpnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110083

On 08/05/26 11:09 pm, Daniel Wagner wrote:
> On Fri, May 08, 2026 at 04:51:41PM +0530, Disha Goel wrote:
>> After further investigation, I've identified the root cause. This
>> failure is seen on SLES 16.x and RHEL 10.x with 6.12-based kernels when
>> Secure Boot is enabled (kernel lockdown active).
> 
> SLES ships an bunch of additional patches which hardens the lockdown
> feature a bit more. IIRC these are the same as RHEL uses. Not sure if
> this is the source of the problem though.
> 
> https://raw.githubusercontent.com/openSUSE/kernel-source/refs/heads/SL-16.1/series.conf
> 
> 	# Lock down functions for secure boot
> 	patches.suse/0001-security-lockdown-expose-a-hook-to-lock-the-kernel-down.patch
> 	patches.suse/lockdown-fix-kernel-lockdown-enforcement-issue-when-secure.patch
> 	patches.suse/0002-efi-Add-an-EFI_SECURE_BOOT-flag-to-indicate-secure-boot-mode.patch
> 	patches.suse/0003-efi-Lock-down-the-kernel-if-booted-in-secure-boot-mode.patch
> 	patches.suse/0004-efi-Lock-down-the-kernel-at-the-integrity-level-if-b.patch
> 
> The patches are in https://github.com/openSUSE/kernel-source/tree/SL-16.1/patches.suse

Hi Daniel,

Thank you for pointing me to the SUSE lockdown patches. After analysing
them, I found that the second patch (lockdown-fix-kernel-lockdown-
enforcement-issue-when-secure.patch) is causing the issue.

This patch fixes bsc#1237521 by directly calling lockdown hooks, but it
appears to be too restrictive - it blocks blktrace from accessing
debugfs even though upstream kernel 7.1+ allows this with lockdown enabled.

The patch works around a timing issue but has the side effect of
blocking legitimate debugging tools. Is this intentional, or should
debugging tools like blktrace be allowed even with lockdown enabled?

-- 
Regards,
Disha

