Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24522126F
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513142; cv=none; b=ozDOnmE/Q0gVIlLVVleSkoU2cOol/BFtKfqPHjHUQOsRt8U/q5S2TumvJDZzTJhf0273HWlMIPXKPBAQQ4T1eCcmh8hnmdBLXMKs0DK9Qdx3OoIK+cc9mmtAAEi2vPHNGlGp/tKY3zoc6r5/MxNiP4FUdDwl1NZUUd8Z8JVrYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513142; c=relaxed/simple;
	bh=xY0yA2c7SFC64cCxJdBib21IlyWGAWsVb4ohrfmk3tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euY1xr/tdKRXNQBkRJit1ol+Zf1KtjCOz8E49aOamwNlwMURxLHMjqdChDySiTJIocMZiVKu6HvdLJriVCRhCk+pdVeyyqqUrmRzpjNNb3NESimdqH7JpcigtYXpm8iCSZ/414LaF3zBJ5nnFJXJHwWz/RAxho1fDblPqOdD2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJGPf+/j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJGPf+/j"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465ggEf006673;
	Tue, 6 May 2025 06:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TOUN9E
	tp5QoOEH/W1G4yogVA8pXVkkdo7MHKbRsr8So=; b=BJGPf+/jljsu0m65ftirlA
	N2IVsQ4SQ5aLEnWBO2BCHRaKXH3r/yZnmVJDVwxedwu6db5On27Ne4Ly+BD4Zfg0
	OvjL/dI6At0mTroSSrq8/bSbo4j3XWE7FV26yLuYXM1YJWvv17+EGdWvlL3rcwak
	sDYL5H3fx+gjGHP2smGAtG+i3eRB5WAfYOC31QDhSOdlQ4tRqfaQQNDDCvFKQCRx
	KQ4iPxhWftjxS+3IgA9sPMxYHVisf0j6eJF5xgR2lVSjVjQYQm7nY+ud68VV8nW3
	XKTEXCvdJPBwwmK615NcnDu1DWaQRfN5JbinmkDZMHXPXh1oeHL9fbyzJ+RagM4g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy058y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:32:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5463GST1025783;
	Tue, 6 May 2025 06:32:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyt8xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:32:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5466WARd20054758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:32:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54BB15805E;
	Tue,  6 May 2025 06:32:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D847A58062;
	Tue,  6 May 2025 06:32:07 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 06:32:07 +0000 (GMT)
Message-ID: <51505e23-cb80-4668-9278-07ab52deeb93@linux.ibm.com>
Date: Tue, 6 May 2025 12:02:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 20/25] block: add new helper for disabling elevator
 switch when deleting disk
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-21-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250505141805.2751237-21-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WfoxLOTdacHij5S3P1z73L_1384a7Tld
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=6819aceb cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=OEWwMA5lVpoZdBteCZUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WfoxLOTdacHij5S3P1z73L_1384a7Tld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA1NiBTYWx0ZWRfX2hIagTA1mlls 9tknzGHUu6FTLK1TRJG13q4IrzXIFy/pCretMWgErGKFxxkT6L6dQ/MBgP1wU88JfgA6XCv3Eq/ xPOUPxC6iZckCWdLwzX6DGJ0JGRKydVr2NKhECtoErYgX8ohh8qkYeahaa2t/jTIjVi2tQhrU5K
 VZ6THwN+fL72JMEz8KQ0AwnGhh9XmsyJ2NIgaTeS2JzP/cu7sFm5RZmZkrPsmefJhinmYC0iOoH Fnmu0GCKmNL1q8K4MMvVj44Alspp83JZxtUjL6k+YzMRS15lbTrtCmX+FauYX6vEEG/uuwCGkro H0KF/qQdW+kZ50rcm5VZmBjvKZKVclAX/sITpYsVA7haUelmYHO/zLnksA3J9Kd36ZfLSMNKeul
 BDsd+9RjR8PjKRpjP1wKBX5IWqvQz+56PySeQ3sBwt97wLNia1lo475jJTYnnvng0DlkEoFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=939
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060056



On 5/5/25 7:47 PM, Ming Lei wrote:
> Add new helper disable_elv_switch() and new flag QUEUE_FLAG_NO_ELV_SWITCH
> for disabling elevator switch before deleting disk:
> 
> - originally flag QUEUE_FLAG_REGISTERED is added for preventing elevator
> switch during removing disk, but this flag has been used widely for
> other purposes, so add one new flag for disabling elevator switch only
> 
> - for avoiding deadlock risk, we have to move elevator queue
> register/unregister out of elevator lock and queue freeze, which will be
> done in next patch. However, this way adds small race window between elevator
> switch and deleting ->queue_kobj, in which elevator queue register/unregister
> could be run concurrently. The added helper will be used for avoiding the race
> in the following patch.
> 
> - drain in-progress elevator switch before deleting disk
> 
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
