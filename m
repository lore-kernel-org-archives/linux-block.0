Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C74696
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708758336; cv=none; b=AMn+TAyOGbbs2RHRzjDsdnCcDKWVRWL8rKcNtg26d7kdG4kyLLfKXpxfkWYX/U1gmt/cRubkOb//3cXIHX1A69/Crr6UuL4p7o4wWEv78J6b9pMrCfFx9HNK2HXyEcpMCW3Msv/lul0lJ72ql0SEe4BvFaf15mCS1gAiaxBdPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708758336; c=relaxed/simple;
	bh=8PPH3Zf6wMfbIHuBdXcoaS6b5PfyKygfj9J8Tq73wo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ6drrXwSO9X3N/vqOjDftrYUDIEXUOUjLyzt2S6Z7kJcRKyOPZaxrIiGQwempc8oaEUabRDMYtXBVA8JTiwA1HaEjbnFpBvZEOTbz5jxHWyX6zepOt7rM077vJo7ZWzBJfzFwXyKJr2b83HpBEqYGBfUONr+JH/g981NBQIQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VRKMZQJM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VRKMZQJM"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41O6P3JT006025;
	Sat, 24 Feb 2024 07:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8PPH3Zf6wMfbIHuBdXcoaS6b5PfyKygfj9J8Tq73wo0=;
 b=VRKMZQJM6OoUhnb6AqvkMjJGEVB1oBalnRDhjsSr7A/ylxbvqBdfXexf/+a/CA5bdaoD
 NaatdocMwEniSyKasBG4Ehn08Y9BUjnqdDsZ++1gA1qCY9PrSDhP9eeQMhBTT9IttvZg
 aGcNSCbgr+SHmG0PGUBbivRVzUqCll4OdcOVbojg5ncRYtrDZpkuIlOLZ/OTU0EiWfZ1
 Gvd7O9BgwBsMbRhE2nmg43p4x9ZrsWBe0XEeACepLjuu3a06zGz4a0JQaBkIoV4LjTBB
 zhdDzkYvAriiaBLpG4/nEld9dLicMEDEOl9X4n5h6vsO2VjKg7E5kikRz+fAM2BJ0p2y CA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wfaaxh7tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 07:05:23 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41O70GM2010932;
	Sat, 24 Feb 2024 07:05:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wfaaxh7tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 07:05:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41O4n6kM012714;
	Sat, 24 Feb 2024 07:05:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ub64s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 07:05:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41O75Ji036635354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 07:05:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AAC85805C;
	Sat, 24 Feb 2024 07:05:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F001E58054;
	Sat, 24 Feb 2024 07:05:16 +0000 (GMT)
Received: from [9.171.49.82] (unknown [9.171.49.82])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Feb 2024 07:05:16 +0000 (GMT)
Message-ID: <b5b76135-0744-45bc-bd97-a2a0a3fb57c7@linux.ibm.com>
Date: Sat, 24 Feb 2024 12:35:15 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 4/4] blk-lib: check for kill signal
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.org, ming.lei@redhat.com, chaitanyak@nvidia.com,
        Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <20240223155910.3622666-5-kbusch@meta.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240223155910.3622666-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pckS6wasKbQx0mHpdpm-kbq7qtggfmqv
X-Proofpoint-ORIG-GUID: ODCAu3bgVugCGUTcsk2XPfNQhb6IOiPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=741 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240056

Looks good!

Reviewed-by : Nilay Shroff<nilay@linux.ibm.com)
