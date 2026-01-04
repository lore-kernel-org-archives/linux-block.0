Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA312FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544876; cv=none; b=aqRi6Cw0JlSKquVrt6gPqX34DblVJZEiZrnVcqEftE5qvam8eNRg0YeOMjdzKHt4D8ABaukyrYexKV1XQLVywnn1/wCNlqcfaS0FX81zrkC6YVdb8hfG/J9Ie7Au8xjNNuqHYsKK+X3iyPV0z2eocQQy0f+mZWeXf4Oe2770ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544876; c=relaxed/simple;
	bh=k9VCfL0//R1wZAYDKdKhad2mNZRg1VfJz2+0xSqKFOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h1PSBPVdbTc+5xPg5yFPvG1NgoWdX2GQpT972jy5fdn0Z9L6/l/AKLOIEFHaaaMB8zIa8XIC8u5lDyuRpouS7wL8bHeDoOeM3MdTsCSYUmbjcVpFXFMjL4iAZdIU0r2xfIvLQPLQl3+Lk2fbG6vNuMR7ML5ZWvSr/x07+fD4PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igYaLMDq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igYaLMDq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6048uaZO018987;
	Sun, 4 Jan 2026 16:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=diJGgT
	X1/Xy28cEZuO84Pgnvf7GFf/i6f+teB6W/pgE=; b=igYaLMDqVnNR1oGh/LW8SC
	92xwe/fO8g4AYDbo+qXOXaMwOo290FILTDnaKmiG0WA2nOVhVxTyVCw4MMLS30C9
	Gmc38V2p9Hg7XvcNFRFSInzucjYvn2BOfXr69miSWnsUT3A3bZE3ePsmS36W0cHG
	oWUeiW6mKHHy4h4PlNAJQOxogIlJ1e100b76749Ytk3x0//YvbidACFgkc+wjYlg
	EVDiX1PSpV1vNXV6t5CFiYtunFlByjq0z7AzVGqBEoYiNH5h96GKnhQC5uI+7yZ3
	OxL8LhqKeOIYdWH8F9cMoeIaIIPjP86ou6nCDtAgnUQAj6HXW7tQhrsBySN6VNQw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshektfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:41:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604DWtOR029602;
	Sun, 4 Jan 2026 16:41:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfdtxj69d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:41:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604Gf1Rs26477278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:41:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4714758053;
	Sun,  4 Jan 2026 16:41:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3FCC58043;
	Sun,  4 Jan 2026 16:40:58 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:40:58 +0000 (GMT)
Message-ID: <7b1fbf2b-e8ef-4248-bb1a-e56e8e8b2a74@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:10:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/16] blk-rq-qos: remove queue frozen from
 rq_qos_del()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-16-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-16-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX80bswxxqp/Ak
 Mc1NDnppJgsbSG+I2391y5bwxzW9KaB30lic4LrEJCqWo0h6WuoyDpyhyc73Ud5kbnsbaw+wwha
 HIzYTkZb8XvREadSIFsCDpnrHvzCFfwY0gv3XhSZx4GJeXRymdFnX7nPTGFuin4XzkA6Nul2cpg
 bh64Ln+zEV2CcSw6SphJ2LzwlG60j4/ocAxA3xtNCYgPtlNSuK30qx8Fxjupyh3tnEZeDbo4pmA
 4trMeKu+qUl4SfXDaz0xbjbhGn7Jdk+RoXFZh6Kyjh9/UP9M5eOTr8NgN7rZXExJ405jwUbupxt
 Hap5rib7ZGoZoauzFhw+Vb03to5v+ZZJP/FT3cxtfRtZgH/rS6kRnd7Ym9WtHsCwOYNqGhNBLwf
 T28w5xTC2Mw5kWt1GHjpvZH4XYvUGgLxAKA3m6rOn+sxi9xtu+4g+55VsGQCG275wGvGz6vsEOo
 SsXDdbb7Em7ZMLZOq4A==
X-Proofpoint-GUID: F1jNJvkwDnF3AO5sEqRX9j7UTK0uZ0K_
X-Proofpoint-ORIG-GUID: F1jNJvkwDnF3AO5sEqRX9j7UTK0uZ0K_
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695a981e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=ttQx5oi95VPzTDNic7MA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> On the one hand, nest q_usage_counter under rq_qos_mutex is wrong;
> On the other hand, rq_qos_del() is only called from error path of
> iocost/iolatency, where queue is already frozen, hence freeze queue
> here doesn't make sense.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
