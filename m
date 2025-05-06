Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63C1FBE8B
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517402; cv=none; b=omA4LI87k9JAlYK6bwyNS+jQodSdW8lkpcX8JkJoOPqQLcN5kMSrFROYAhcRVVnPNi8WzYs7FceQN5zwWLxCyWj5GNzsZ7EvIDi0XsvCE1XcllUmnIzrB0uPmnKTh/pz1v5fY8XxalpYiZ2EEuHPoWTydbAgUVUYszP4P8l9FEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517402; c=relaxed/simple;
	bh=S5ZKCY1e93EPQH0pYSANyeSI3O4/NQCjn8bw4dLO/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmWCSaQ/0Of6rTiXaFcxsreKNxPE6BCnhM3lzNk9jO4VpSANGOAuNAQmQDGT2qBYRrbtQaVk8fMPyVHNst58oOZcUL1wm+52gbm24HIFoWvnUqrS8Zk29YVEa6qxVdYz9cim4MwecFVjy/Ion2cTBWyTx5X5Ffh9jHdJqj57jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MIJfvh0E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MIJfvh0E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3kJ8018495;
	Tue, 6 May 2025 07:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0ysd7s
	kbKWLRcp9uS1cnuvoNdJBWtrnHCii7WnlN/0A=; b=MIJfvh0EI1W+tXx+jbA12O
	aDW6Xmb7fdHcZTmb9dplbLGdmX0Ihb59enKZS4DZkOPdpf3j/9LkBo/YIc9eU3MC
	fHVkAVUctpfYI/W8pKa4BpnuCBTwyQmH02qiVHCPGRu7HiYtfkCgsu0aQmAdkmFJ
	PiGlU7KL77az7MyhakAX7nMj15ucZJaZwIyvE6E+Y8GCriCwC+o9H5m6pihHckzg
	FM/EOrPL9YKcTD50m3x3S6NUCTDcO1GBlW4MJcb+XK28hTKCs77ALAo7GwzJRFpu
	Tc9EEjhQfW5M0LZrJlQgm6i2xcmCO681AVvnoPqNhKv78ni1zL8KSp5hDdZvQRGw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkj0xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:43:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5464GimK002815;
	Tue, 6 May 2025 07:43:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfntd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:43:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5467hAUK28902072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 07:43:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D89CD58060;
	Tue,  6 May 2025 07:43:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E520058061;
	Tue,  6 May 2025 07:43:08 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 07:43:08 +0000 (GMT)
Message-ID: <af8fb6a2-bc7d-4206-9d54-d15dca4cccc2@linux.ibm.com>
Date: Tue, 6 May 2025 13:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 07/25] block: add helper add_disk_final()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-8-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250505141805.2751237-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=6819bd90 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=7JgCmGjYCqbvFsJFTUMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2yWHJNrX1VecDkkYNQKFulV5GSbqk-CL
X-Proofpoint-GUID: 2yWHJNrX1VecDkkYNQKFulV5GSbqk-CL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA3MSBTYWx0ZWRfX9ihP0Ku2eNih GGQ+Nn1N4TN4UJUHxkPqKqt4lUt0Q2OvnJWrO3u6wbUCMN1wfHl7Rq6u4kA3N4rIfkBHUN+UN6P Pj7QXd0tStKpcE3/e59730kZvBVcWc3w8x2ZCbhSMMEboD3zRKG9cLTneneOFaWYa0sfJc/EVVy
 paRLQZBiW513YjOdGdI4+wDJ5wx/kqDI4BjDc300EVpoHsn76FGKMOd8i+xuCynkKEbMx51PWPJ IO/QPCYVkOLA5sA/NXavAJzXuE7XMOVTMkZhyF6zbWquE/33Tq1NDWa+gkmxH7p4siiq0kaImVb wnf0qIcLXZRTKkSCb8Z+m4MP05HhRhL2csm1q2jiUCuedMYJuTCd8YlSZ0Tdo7i/++axv8Up7Yx
 6RK/jn/XSc/gmGM9Nbg/V2jxvGkVfKeqWSKqwbUEX73D3kA3rFcR68z8drROU49I3mIolyzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=797 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060071



On 5/5/25 7:47 PM, Ming Lei wrote:
> Add helper add_disk_final() for scanning partitions, announcing disk and
> handling the last thing for adding disk.
> 
> No functional change, and prepare for prevent adding disk from happening
> when updating nr_hw_queues.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
