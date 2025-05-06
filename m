Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49522B8BE
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517670; cv=none; b=F5N/W84HR94crOGIgWOCF/AmNDpLc9jfK/zT/ZP3c9pG3zvaAlKrTPHMji/vA8poMP+bO+INqB4Kf3p2wZVByJRRuZiDa0Jt+IsXplW0ocQdAb5FQq1hBrzv1SK8DeSCFCUj52aLAAHI5JPd8FPgR/cAv3c1WNH1OxvEcnmhEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517670; c=relaxed/simple;
	bh=kVbgOVKMbStNahEBJCAo29rsODw0bmLA5nw3T6rTTnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufpi48iWsoYRTA+JmMlA9dbXiVWytXL+biKgij8GliF7S+wL+k58nSPIJF7EppHVukS4JWo5YoarV/DmWKhEhdIct8rnpgnJQpa5CuzL2r86kWpWEEO8Aj/X4mIxtWC+E6ZESIoylM4yZnO4eaKKTnr0IkO4eLCJjGQPF0T61fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DXYy8KkT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXYy8KkT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Lh1nN015147;
	Tue, 6 May 2025 07:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=guua3G
	HNmWgKPaPrj4ZsEIAufyjCwBOMct1yur1uQKc=; b=DXYy8KkTZSLFEy61x3ynsd
	SSwrCn+IpVRQ8Y2GTTByE2cARp8s/KesMb/wJuXYsgm8qLSnvznJwLZTZGT1P4hK
	FhJ8SvSV5+NuqtaTrf1+Kqps4pExiFPpqF+Xi98MhhXipzOHGEzC0N+CkuUnzKbp
	VVcVH5QXPmU9lYH/eVhnScpY6gz1oJ5PQKoy7VZ8kgqlH0Jj9ZwlmSc+dTDJsSPe
	MSk/a6rP6SoPDI823+OzLjlaxrklgB2eleBTXchtszsKNjI8/84iUUNV41NKGjpK
	wtVplCdzc+R9YrnGX3d2dXmKREBrRlx8TkkMntKEW8NF9/z/aLtvjc176vIjO0mg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw1v3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:47:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5467VQmW025783;
	Tue, 6 May 2025 07:47:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuythyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:47:38 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5467lbL925428532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 07:47:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 779D058060;
	Tue,  6 May 2025 07:47:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3769E58056;
	Tue,  6 May 2025 07:47:35 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 07:47:34 +0000 (GMT)
Message-ID: <f146a179-4ac9-4593-850c-dfd5fde698ab@linux.ibm.com>
Date: Tue, 6 May 2025 13:17:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 12/25] block: move blk_queue_registered() check into
 elv_iosched_store()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-13-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250505141805.2751237-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA3MSBTYWx0ZWRfXzL475rInUXbB sHaGdxZvJ6l2IaqF+cRhi8/K7zU3SoBkFS6BfvbYXqm0ohy1R1/x7dANA/yXUhzoUqWJSA3XAoU N+YfGR0VmiLlTI0qNTxDSSXNYGN25jJXnNvtO98JCBI0HyKDNHWh+nGtl56+ItViPEQx93PnRJY
 ExVmsB/OTfJaNXhFOtvU00ylZ/jnEqRmcJfPwokAcIp/6c8B24GP2sVxkTGoMuDe1WA8p3nZdb3 AYBHPNewaq4gIzsWtEOC0wdfnn+KY8YCexQ1tu/dZLcq9uVwGdM/Z4Z5u5B0zHMn9pXBoLmBUWp JVi5hhyiCNESglNE67VFK9uqGqkORm5vdj+aN9dth3ZLpquIuEM6n5Vtrnqb1iyMnFkhfLwexUo
 7UOxrRsz+tcOuq4ZYSAjPsY5HwXCtwhLVdIo75jlJOIgXuwIuVSUYkwpqAXfU5rTDe3t40yn
X-Proofpoint-ORIG-GUID: VK8d8IMfV_yGgiS6jHdzGJK_DSRt9TBZ
X-Proofpoint-GUID: VK8d8IMfV_yGgiS6jHdzGJK_DSRt9TBZ
X-Authority-Analysis: v=2.4 cv=IaaHWXqa c=1 sm=1 tr=0 ts=6819be9a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=WVzOe_Jleud_T6ht6n8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060071



On 5/5/25 7:47 PM, Ming Lei wrote:
> Move blk_queue_registered() check into elv_iosched_store() and prepare
> for using elevator_change() for covering any kind of elevator change in
> adding/deleting disk and updating nr_hw_queue.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
