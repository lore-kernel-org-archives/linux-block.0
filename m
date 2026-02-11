Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60099318EDB
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794564; cv=none; b=Q9WvxK60JFolE9PzBZPPngLIKboUPyHv4wzEPZvmKEbRX8KVWi7zb4mTa7W5u31fK/Im+qSmwBAZb7Uu/G/ebotTZFPDJwTnIAbqjsxpRg511V54mcvDUIc9L3v0vAfH8LkgOvhiNi3kDoZ3OYVi23Z+8ChC6dQdzytqo2dil/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794564; c=relaxed/simple;
	bh=r/TC9uwUTNGzWKXTX7JnznLBcSz58uVxn/QZC6/LLlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UL4uT2Ihc9rOnO4ArIuohv0xUw2xBLKy6k81U+ySPc2btUNTBqdYSDfwKF85zSIPXeZ4CcUnok1VIwpr/KVIXTg9br27QVH1paawO1eRiAkTBUIqmjM81l+Br3rLnEIeSDJkgAw+oRLnL+LmHbSMN7t5GzHpwZPFjq5c3pEahiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XieUfMZk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XieUfMZk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B2OGfJ1782847;
	Wed, 11 Feb 2026 07:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xd3njL
	ObZPu+okLAMxqsbmt25dYlYn1HwzxBYcfm5Sg=; b=XieUfMZkVrebm8ulUgVkM2
	HmzvLzisRwAToYQL+LVkVVNWfHSCRh/50uYly8bx0tfousA1GfeJ3lerBOZAPRDH
	z/YW4UPOSpDwN90XYFao5eTpeGM/SiI8Skkow/9UJ1oIGaXTZh2QaPpZS57tA9xg
	r77wc3REaZrBsCksXQwz+AS5FG/PLuIfXIaU16J62H9w2D1hwJ+EgklU0f8FlZBf
	LTIX3lo9CoaukD0ST+X20w9Z//vkk6DrdywEzZb/uAjD+z9Uz8D3DW/FaG3OO913
	Ye+WbVXlsVW6N6gx6Moc6bPvNfxwzPC6EEMgteheKIAgewfBy647Y3jXjMI8IFdQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wwmy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:22:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B3ENIb008404;
	Wed, 11 Feb 2026 07:22:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ycxag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:22:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B7M43T28639850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 07:22:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C3C5805A;
	Wed, 11 Feb 2026 07:22:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33A4458051;
	Wed, 11 Feb 2026 07:21:58 +0000 (GMT)
Received: from [9.111.95.190] (unknown [9.111.95.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 07:21:57 +0000 (GMT)
Message-ID: <606e2367-ed25-40c3-b618-f1d0dd3f8693@linux.ibm.com>
Date: Wed, 11 Feb 2026 12:51:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-rdma: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sven@kernel.org, j@jannau.net,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-2-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260209082953.3053721-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698c2e1e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=tJLSzyRPAAAA:8
 a=VnNF1IyMAAAA:8 a=MQnJZRgATxulN8aL5nkA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: JrqA_k-0_1fTWios-ZBcus7u60ZeJN22
X-Proofpoint-ORIG-GUID: JrqA_k-0_1fTWios-ZBcus7u60ZeJN22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OCBTYWx0ZWRfX3VExwt1Y9npz
 QvLTHxemYqm9Vyi1JrNp79ODbRlvOIENeX17aHVFCQgmqvftH87rscxIXZ1sDTLagt1TIOIPFgU
 3oyjMExW6bRz8uRDlCQ1wY4Ypv76kfPMpY7Sxxa5EuYtBgV3U84j7lZtziSQOo807AdxXFA58EQ
 mGyXnc4t5R0kkoQ6CDweO9aqARQMEaK1gFTiPa5khV7Jwu6eYpLt4NBdbXTwtTxOkPoR6LX4RyU
 5wq6cExFkT6XdXDvdm/s5FzfkJzvzWmboSfUZl0LPLTsWk8esARvqvZT0DZ4sE/EIuwLjym+XvC
 uo3NguKsuo3VlyxKRoVt0MyolRT3QRNy1YBOxrn5foitFr94l3zaDVj6Hg49EdVLC03pKb9Wru8
 BsD8Ts7IK04HgmaOQssBoBRJxko0QGBrg9J/4U7XWuN9KL6K4XgG1Tqa01WbaZy8yeVYzhz4PZp
 OjYPYNFqduzraQbNeGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110058



On 2/9/26 1:59 PM, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call, the freeze depth
> becomes 2. The internal unfreeze only decrements it to 1, leaving the
> queue still frozen when debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
