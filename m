Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FE3EA8C
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572228; cv=none; b=FRJj30o6Fjp/cj2nuT8fWC+7n1yW4Rb0Z9QMnBxCUHGR/BYdZcakTRcdRHMcXrMRS8OxcqYXInIh5ALTwHvPz57kUyEkyVnYYr2m5ea59Fq55ET9AivJLNYwlLkXA2javM2EuNAPTuAxOs2WKombAVzZMmSCdpomW3luii4mMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572228; c=relaxed/simple;
	bh=nmzGjCfhoTBwGlT/qWPnC50wEjM32v4tIptLAxzsVlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCsIHeSc6/RCZrkCq/VYM8yFfGFg4biiEHOaVOLyA/xysy9LP69o26p4jZurpDh8Mjhd558isbQkVZIJOBosnMUuQzO2KX2UJHcqCRtdJF+bS8QFi1nWSxJpIVLSd5AJqUe3NX9w+2OSuE+vk1W2doHjZeAotDgQFYfvurZDq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f9m8L1TD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f9m8L1TD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438ARUcX014693;
	Mon, 8 Apr 2024 10:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nmzGjCfhoTBwGlT/qWPnC50wEjM32v4tIptLAxzsVlA=;
 b=f9m8L1TD+sIrsI4qSI3cpBOMKh2P71+Fnfzv99HYV8nS+J0BduAWzy2Y6MPjuulzu5FU
 Z3+q72wyBga/I72qmkDvZ96WjLiEf4zNEILsRueWwsB32/68aG/8mp/wZWbee/57WdLR
 Yz2C7cxA2WLOPJrx8G+ZN5NNiX63fuXPkaeU3nFuXaZj5swMy2dYz0R2OK+/a5hL6ekB
 JFxS3fr8wOXx+TL2mUYFHRZ/log5JjF+1gimasED4001szsuADbmHkVjTDaCcJUUqmRK
 Gxi+D9aYJcMfH4eV1Y2lJpISbnDU+nDG0Tc3s4fd4BCVE9fWMfV/q4k3b/IBN1XmvgVN 3Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceuar088-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:30:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 438A6XEE016996;
	Mon, 8 Apr 2024 10:30:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke273se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:30:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438AUEop22545060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:30:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9F15805C;
	Mon,  8 Apr 2024 10:30:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F048758070;
	Mon,  8 Apr 2024 10:30:11 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 10:30:11 +0000 (GMT)
Message-ID: <5f26a2ca-1413-4f33-abf3-7b977adfc7de@linux.ibm.com>
Date: Mon, 8 Apr 2024 16:00:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix EEH failure on ppc after subsystem reset
Content-Language: en-US
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        hch@lst.de, gjoyce@ibm.com
References: <20240408102329.442335-1-nilay@linux.ibm.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240408102329.442335-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HVqDhS1jS9kz32CmqoxEvdOJyj4s4UMr
X-Proofpoint-ORIG-GUID: HVqDhS1jS9kz32CmqoxEvdOJyj4s4UMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_09,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=599 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080081

Please ignore this message. I was supposed to send PATCHv2. Click sent before updating patch version.
Sorry for the inconvenience...

Thanks,
--Nilay

