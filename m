Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B53E5578
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392672; cv=none; b=tTjea+L92t2eVpfzbPlxPr089/h96UiUUhiHJIEL9wiFo6puGu1CIvlSf8PQ1dQpsGgLefwhNNN1rdLhvJUcBYANSYKHXJFJ0k88z/33gwqaG/83fHorFHNFktqZSKof3R12bUTK5pg+L7EuLEc1RnG2xqpozL1ZnQueu3r4t0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392672; c=relaxed/simple;
	bh=OF+Eh4o7UEivqe4UN3ghOcExbILjVEA+gNzFFBTIyoo=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=iSHwm4bzglSvA7snBtzrRnLKhm2G8CXe+0nR2PNAQoguPSE8Rt8Cajum4lSNoEr4qIxzyxSoAiZxQWXEyGpQYQ5DaTxS+iSpcxnTzbZpNp+cLsHzDTvUEH2j0lIVSCW3QDkv0vzRSczrEY+VlWsmdRsgzZZqLcw1JVH3XfDwVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m0yNpjby; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m0yNpjby"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFq8ht3350414;
	Thu, 21 May 2026 19:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=t28chCpJIT3oxZRNkyd3OgjrRNtf
	zfMYXbodcXMESuc=; b=m0yNpjbyR8fvP7zvLAf8+DLh3UIJyNmuBQjyNjrPGDLC
	NcIKJE5SAAwTEnGWLExL9FjdKZuK3JVZR954Miw5KV0m/2sRRQNFChcVAXVl0sin
	mViMHx0WJD6mtBO5/zuiDoZDUIIFok1CqoHPYOpnkeldO62Ivte8i8+9lTp1ogMH
	YJtHAPSOA/vFd6eDL+ztKA0dB2q1eqQAksB2rMFRtjS/bDwUcA6BjbBdmah10zsh
	C3jKZFaQfT7gI9rNnItcOp70x4Jg72nlzKSVc60Wj6chLSrE0DrtAPKEaDuuj33Y
	sjv7L7TW8/YCayMNLgm/BLis+3WkqEBoMJLP14ACkg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h758rj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 19:44:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LJdHHT026217;
	Thu, 21 May 2026 19:44:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhwrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 19:44:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LJiNUq32899808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 19:44:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3176B5805D;
	Thu, 21 May 2026 19:44:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9112558054;
	Thu, 21 May 2026 19:44:22 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 19:44:22 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 May 2026 14:44:22 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: tom.leiming@gmail.com, jmoyer@redhat.com, Gjoyce <gjoyce@linux.ibm.com>,
        wenxiong@us.ibm.com
Subject: Observing higher CPU utilization during random IO fio testing
Message-ID: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f609a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=Q6jePD3fZOPkgQIsfhoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: tDx-jnDsYd5Q36eO00NP0DVnov935rUC
X-Proofpoint-GUID: oWuutqNpoiKW6Rd8P_-nvxEv412W7bNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE5NyBTYWx0ZWRfX4a4u5YcoumKC
 x2rBSZll4391LMuhrhphx02So9Jl9z88/emkyB8rt4waoudJNHQrU5at01liHI77rKAJ9qwJdKE
 cz2gyywrRErDQ6wckdSQOEJSjYVB7DeltPyeatvMl+O0GG6idJDbhpxLwCTGtBRSA0+yZujnguQ
 j9MCEpaKXDTsQqaB4FFxutmGyTtzNoDmQ86l7RpYm9UgoceEA0+0Y8ocbtZQncXOQTQ6WNnnfTM
 RaWKFBgEjY85MYOdjhOArz7rjeQWY3OJmF0jFhEG6gv1NwTqtq42SaTGSQdQ+qoVFLT5BQCaeyo
 UPXbxaBlB7ZaqBah3qEAMGr37505GV7gufEXJCT2RWfrjk4795hkMQ8c/FKZvQ97LNLlGijxgRU
 od/hdDYRXSUEAp4/EFSjRZxeW0OFxJIGNL0pZR5mpzm2A37Rt8ssH2YNGA8figgz9wN93pTF8hI
 uJHK8giXrLIVQzW7Qzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210197

Hi All,

Our performance team observed the higher CPU utilization in RHEL10 
compared to RHEL9.8, observed the similar issue in upstream 
kernel(v7.1-rc4) as well when running FIO random IO tests.

System configuration:
47 dedicate cores
120 GB memory
PCIe4 2-Port 64Gb FC Adapter
FlashSystem: FS9500, 12 LUNs/FC port, 100G each LUN.

Random IO tests are more CPU intensive than sequential IO tests due to 
several factors: more context switching, Interrupt Handling,  cache 
Inefficiency etc. We found out the following patch which caused the 
higher CPU utilization in rhel10 and newer linux kernel:

commit 060406c61c7cb4bbd82a02d179decca9c9bb3443 (HEAD)
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Thu May 9 20:38:25 2024 +0800

block: add plug while submitting IO

So that if caller didn't use plug, for example, 
__blkdev_direct_IO_simple()
and __blkdev_direct_IO_async(), block layer can still benefit from 
caching
nsec time in the plug.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: 
https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

We reverted above patch in rhel10 kernel and upstream 7.1-rc4, saw lower 
CPU utilization when doing the same FIO test.

The patch adds plugging in __submit_bio() in block layer, maybe cause 
performance degradation:
- Random IO tests have less merging, flush overhead.
- More IO scheduler interaction, forces requests through scheduler 
instead of direct dispatch(direct dispatch to hardware queue)
- Poor cache locality during plug operation

Below are some performance data that our performance team collected:

RHEL9.8 comparison RHEL10.0
Iotype     qd        nj         rmix      mpstat busy delta    lparstat 
delta
Randrw     1         20         100       135%                 109%
Randrw     1         40         100       72%                  81%
Randrw     1         20         70        278%                 174%
Randrw     1         40         70        272%                 191%
Randrw     1         20         0         93%                  30%
Randrw     1         40         0         104%                 36%

RHEL 9.8 comparison RHEL10 with reverting above plugging patch in block 
layer.h
Iotype     qd        nj         rmix       mpstat busy delta    lparstat 
deltab
Randrw     1         20         100        -12%                 20%
Randrw     1         40         100        -42%                 -4%
Randrw     1         20         70         70%                  71%
Randrw     1         40         70         %51                  60%
Randrw     1         20         0          -14%                 -43%
Randrw     1         40         0          -33%                 -51%

Can a block layer expert help us resolve this high CPU utilization 
performance issue?
Let us know if you need more performance data or other perf data.

Thanks a lot for your help!
Wendy

