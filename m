Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1282765DF;
	Tue, 18 Nov 2025 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448882; cv=none; b=bFGoEHFVoycdDbFTbI06urIxoSkjddDZeUyRP+Ms5cN6udANU2PibLpmd50z998AHUD1m90ixx61uRpfrYxhD8P6ocLI9TyrW6hHu1BvIjMwBep4P/DKKAI01lBfRqUaK80e5UR/V4fM7dDT3gWgjW8zVG/0mi0ALgMdP8ITpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448882; c=relaxed/simple;
	bh=LebpfCEip/cocDRnVaFi1zHPQqTwEPdbsEzR572KnVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUInYFFxs3H0KqsW3b4ofrs/Fvn26D3d541GR0DlFZ2xIaSfGfLg/BOj1aHSx0NvycVNths5SBU5wbEDDgB4/qCuen0muCeUNjiBKxgQVnO7s7kss20kAOW6elv/CKqEgI1PVSMqrQ189Vav7NBP/0cYI9+Ma8Lx8kALBHR4i8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XvMxDI0W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XvMxDI0W"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6A3Kg010088;
	Tue, 18 Nov 2025 06:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6S2EZU
	hKLmk+JLWuZVP6R2KC/LftLk/pvhfBaSGDZNI=; b=XvMxDI0WaihQcAv+8N2EJ0
	e3/zDcAWWkp+tf9/bOw4D4eXa+1jcUbsQuJbwGNvHQ8ueAdajz+bWkxzQ3W9x+k4
	i4DyBD+MraNyB0jIOfkrbaqXzvlROUYTJ3rIwn7EiKd0Uu2RUYzCkaKWms6ZFd+p
	HQ+OiluUe9zH1zQIefMdPnxwBjxmj4M3ReDxYCrIfzFXTXXig2AO/iUE0HJVQO60
	MG4Y98xTUX30uU6NTpbZFgNtC9m31c0yRJvSoPtH2Ihkaiyangrpr6YBOK1Nnmk3
	bTPcGJFoJ+hmXjLT3dtd43Y0a34zXQjrFi4NU4DJP/R337Tdp/IMXGadDaMKHiDA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjts8te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:54:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI4JSNC017305;
	Tue, 18 Nov 2025 06:54:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1hgvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:54:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI6sFgo20316694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 06:54:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D58E5806A;
	Tue, 18 Nov 2025 06:54:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D86815806E;
	Tue, 18 Nov 2025 06:54:10 +0000 (GMT)
Received: from [9.109.198.217] (unknown [9.109.198.217])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 06:54:10 +0000 (GMT)
Message-ID: <3ac3f360-1484-4d61-9c7e-0d8577826c45@linux.ibm.com>
Date: Tue, 18 Nov 2025 12:24:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] block: Remove queue freezing from several sysfs
 store callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20251114210409.3123309-1-bvanassche@acm.org>
 <20251114210409.3123309-3-bvanassche@acm.org>
 <542de632-aace-4ff4-940e-55b57142b496@linux.ibm.com>
 <32b831d6-a313-4d8c-9c2e-c24aa2cfeb56@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <32b831d6-a313-4d8c-9c2e-c24aa2cfeb56@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G1GQmRmxNWn26gsZTfOmohmVsgs3xEfM
X-Proofpoint-ORIG-GUID: G1GQmRmxNWn26gsZTfOmohmVsgs3xEfM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX28pjD5H3dKTD
 dWUyBfCpaZ4kwcPT0c4hYUiZuTxk9AsQM68i8FUruB0fmFb3gLgnrB9pCK22A56UZ/pBO7JpgQi
 Wln5XA7h+91JHTSj0W1VoG17ZOXmvcH831/DkRH15dViz4r0Q+3uCD83AFKjLtGMs/kv7QABYT/
 t8gOpbykzeeeBijs18r8BXbXMGXCCQTh2OHPvW0qCBQyp385OzwMBcvo5Awd3vagU3pQ1fSFF05
 a6kva/3DqVirzZ2EDHJZB+cZ9G7nozzqWIjhnXvBe3BdMRxRDVKy8CbpOUgqh/qvWd1/jystAJt
 ZpD+28ZL+YpHMctsjgwXFky7NJm+gxvFy7ofqL25fQcRJIDtIa30+5jL2GSVwxRyjKN3gWLA4IO
 faJqBDU3iC3QIYerKnj/LO2zfrw93A==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691c1819 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=N54-gffFAAAA:8 a=FxOnb52w6FBVaU0-eEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/18/25 2:14 AM, Bart Van Assche wrote:
> On 11/17/25 1:01 AM, Nilay Shroff wrote:
>> This change look good to me however as I mentioned earlier,
>> introducing __data_racy would break the kernel build. So
>> are you going to raise a separate bug report to fix it?
>>
>>    AS      .tmp_vmlinux2.kallsyms.o
>>    LD      vmlinux.unstripped
>>    BTFIDS  vmlinux.unstripped
>> WARN: multiple IDs found for 'task_struct': 116, 10183 - using 116
>> WARN: multiple IDs found for 'module': 190, 10190 - using 190
>> WARN: multiple IDs found for 'vm_area_struct': 324, 10227 - using 324
>> WARN: multiple IDs found for 'inode': 956, 10314 - using 956
>> WARN: multiple IDs found for 'path': 989, 10344 - using 989
>> WARN: multiple IDs found for 'file': 765, 10375 - using 765
>> WARN: multiple IDs found for 'cgroup': 1030, 10409 - using 1030
>> WARN: multiple IDs found for 'seq_file': 1358, 10593 - using 1358
>> WARN: multiple IDs found for 'bpf_prog': 2054, 10984 - using 2054
>> WARN: multiple IDs found for 'bpf_map': 2134, 11012 - using 2134
>> [...]
>> [...]
>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>> make[2]: *** Deleting file 'vmlinux.unstripped'
>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>> make: *** [Makefile:248: __sub-make] Error 2
> 
> The kernel build is already broken without my patch series. Anyway, I
> have reported this. In the kernel documentation I found the following:
> 
> **Please do NOT report BPF issues to bugzilla.kernel.org since it
> is a guarantee that the reported issue will be overlooked.**
> 
> So I sent an email to the BPF mailing list reporting that the kernel
> build fails if both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN are enabled
> for Linus' master branch (commit e7c375b18160 ("Merge tag
> 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/
> vfs/vfs")). See also
> https://lore.kernel.org/bpf/2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org/.
> 
Okay sounds good. Though I couldn't recreate this without __data_racy
on my platform. Anyways, I will review your patchset.

Thanks,
--Nilay

