Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00A272E7B
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512810; cv=none; b=DCeek1dssUMJenAzWbE5UUv8Cm5v/LmfCMprTHNGWlN1qsgdbNPECrLqRpkoHWX3O/htl1nD8ToPoK5IKu1e7M5ff3U3xXOUyh6TUpcQBJElquE7wLDeVPk2k7sgTa1L1lAWlkElSSIp9bXpFRToKPDO99QNmmEcp6Ba1KhzWYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512810; c=relaxed/simple;
	bh=M51Jgii1CUjJWxOf4q3ajOpZyw24Y3G1sVr+a0iycE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIzFi7SfbkCPCKbluFjzsPPUrtRR6FOIPzmOunqpAM8sRSClXw43KTbpRF69Nyb6Q6AZQZRJcpL+2rX141vUPcFiZTrh4lXQryJRRwOlheQ3aT4tSXAIPbwq66QmkZ0O4CPt6pwvs1y78Z4r7tvYWxo78qGtwRAix0OWTg/0KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ceYPTLdW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ceYPTLdW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Lh2qJ015169;
	Tue, 6 May 2025 06:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sSSmxX
	AcOiJx9Invqg25/MBY9tkg43ykOYEd+2Paqeg=; b=ceYPTLdWdRIE/3qp1eOdTM
	pmIeBH3kHfZ+dMCK8CoEtg5MnZsLZaRRfCC5ZJCTDBvurmFvG5SuKgYnimTlPYjt
	AK73m6FT7Z+X+hZJUBDQYzZ0x7hQyeEhtGNwHj7l2dDwzSmfKblfnmCmRlu4XIIo
	9eQ+CmCMqOFvQaa8rxTNpwxQp4rX+33dCxDo3DocFO0XGSdDN54bPBvqwTiVFMu4
	1Sq0i4HowvMjKkF2scp80piOjvxJUrZn7D3+DSzryO55MGnDzht/fpSzwCD2JNIQ
	Wm8I653IovRjP2LqOqeVprVKm6yF6H3kUbkZabypdI0jEL2FHZ05FKjtw7d2Nl6A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw1hjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:26:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5463K7Bm025813;
	Tue, 6 May 2025 06:26:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyt8d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:26:33 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5466QXDj33686134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:26:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 234C15805C;
	Tue,  6 May 2025 06:26:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81045805A;
	Tue,  6 May 2025 06:26:30 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 06:26:30 +0000 (GMT)
Message-ID: <eb711d6a-8357-4c69-b26f-aed93026783a@linux.ibm.com>
Date: Tue, 6 May 2025 11:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 09/25] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-10-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250505141805.2751237-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA1NiBTYWx0ZWRfX8i712pKRQTZQ q8ywTLY86codB39XazxcPtMBemQXaeCemVShBFGBC6kucxlf1tohShwSrlAxNtGerjM+CHQiVMg 6LaRjxX/2whO/NR4TEe4k9oKu8BPhqLeHgAxsiGCYfbVVnktJTGTkH1CEamNxwUGP9fzeZOKcLy
 6aF3Y+4ttVw8xIr9MJEjnxOH+TRKfSZDHwUOUT/ewam73e98S/jtQgtpFddvd+pQO8SjiHqFQYG qkpZ8pTCzY0vMI//rGqfF/thNmLDxCvFnC8ucFzqx2XiaA8J8Q67XL3Nq55336VA8oqVqHcnyt0 LHXp3J/Ab3OrEaGncj90Q7V7YExy8NBVBvXxYw7Bepk5xi/pdbX5VPF/HcmqtRXEMikiKommz7u
 w9AZCR7SvUw3+1WHc+A8Y9//+tHljR9qjpkwLqQFKwIyroivMAs3bnCnrcbeP0j5syo9Qhe3
X-Proofpoint-ORIG-GUID: vuu6qm20xQ6JFKkvjIP73-YMui-tk0Kz
X-Proofpoint-GUID: vuu6qm20xQ6JFKkvjIP73-YMui-tk0Kz
X-Authority-Analysis: v=2.4 cv=IaaHWXqa c=1 sm=1 tr=0 ts=6819ab9a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=slvex776Pt4OcWLdlGYA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=899 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060056



On 5/5/25 7:47 PM, Ming Lei wrote:
> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> path, so it can't be done if updating `nr_hw_queues` is in-progress.
> 
> Take same approach with not allowing add/del disk when updating
> nr_hw_queues is in-progress, by grabbing read lock of
> set->update_nr_hwq_sema.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
