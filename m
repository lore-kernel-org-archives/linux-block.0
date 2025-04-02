Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A32237705
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601530; cv=none; b=G0+Fv7dXb27kfuQ/J6cGKSb8dwT7z5Up8bSxHxPjOz8mMYNKk5Uu9j5dqKTHhj9xAaIy50Onn7NvhbE8ELMfI4yhVpMhlpAb8KCIyelgQZ4yJURENuKRGuczOz4/+X/nMqeQw7WC7iuHpk8XbPTlDFN44k6TvLI6qIx0BzoKc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601530; c=relaxed/simple;
	bh=wpxgcrnMBdMIHZ3G2H8+wmIq+MGGvzcnVMwEf8Yj9Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPsb1w2bdWSX3ewn3vJ+iJYsOLiqXXZKq38QS7ZaGXw4p3qBdsc5P9hbYOmXsScyzOklosZxuPM7ZvgHHcAGLu+VLHiL17sM9PEYJpQTHTlOT8xDj7fr922hau0sMzfE2NSAG0Ml4omknrcAK9KwgjMwcutYjQc1hdn/qmHbK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G0/YJ7PM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G0/YJ7PM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532Ce2GG032701;
	Wed, 2 Apr 2025 13:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yppOrF
	m3zAcxE9nCMx/Pt2LdvdXftQ7UBk2dDSh99FE=; b=G0/YJ7PMejUQxvzQR1FE0H
	/3FmAu3HCxC9pn72GK+9YYch88G3irHjYt5I4O9FXp9R8KwZsX5R5ENjSMZWqyAk
	beadLZyDbckCE5ZhnSz/EhrtHQFspU+h6Kzx+6yegdW+5Hyv8lIomQ548EEEep2b
	Vy8pWO3IQem7cwQXg1YFD6iFgSgGJgJJict39BffjrdtFnVVnKrbB1kCJlGiK6p7
	WCPUcliXFjUxltmFRACzPNbi4wWAF+kUHihxqRCeJqdX/GmpQ1rY+gf1Ldl4pEiF
	p6kdljbkDsfYsCAgxUU/lZBCbxgrp92hltQijZHg1Ospw/3rIn/zhBY0hyl+SeNw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rwmaawgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:45:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532AiGaX019422;
	Wed, 2 Apr 2025 13:45:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t8d40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:45:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532DjHIi066220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 13:45:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A70F458059;
	Wed,  2 Apr 2025 13:45:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7932958043;
	Wed,  2 Apr 2025 13:45:17 +0000 (GMT)
Received: from [9.171.6.25] (unknown [9.171.6.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 13:45:17 +0000 (GMT)
Message-ID: <5d8ae5d9-050c-4e72-8d6b-cd078563ceed@linux.ibm.com>
Date: Wed, 2 Apr 2025 19:15:15 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: don't call freeze queue in elevator_switch()
 and elevator_disable()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>
References: <20250402043851.946498-1-ming.lei@redhat.com>
 <20250402043851.946498-3-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250402043851.946498-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: toUy7frbojwX5ipTYAWAxzgsp0InqUuJ
X-Proofpoint-ORIG-GUID: toUy7frbojwX5ipTYAWAxzgsp0InqUuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=692 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020085



On 4/2/25 10:08 AM, Ming Lei wrote:
> Both elevator_switch() and elevator_disable() are called from sysfs
> store and updating nr_hw_queue code paths only.
> 
> And in the two code paths, queue has been frozen already, so don't call
> freeze queue in the two functions.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
