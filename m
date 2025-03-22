Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13F1BC5C
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742681378; cv=none; b=IDKlxUITGUHYbw9Qi8hdMTWCa4YmMC5dpHo4mRpyp+0I1/I9UVy/zu2pSPqyoz21TSjWdXUzuQ3Pfyq8aCv0PaCQlDyUSioBLNHZQF/6+iHTR5laFl5w7GGT/zw3WTWrofTxSkbJO6qLj/Cj/e5t8/3tu22AxIp9bc8CgD2jM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742681378; c=relaxed/simple;
	bh=PTurONkUkGGINNE/bQL09a4e6SfKrpkVJbMNWwJNgI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOj9YxzPDlHjiHN+LegmNb8P7+FxeR1nCJlMywEaI6WuTrvTz0fooU44vdcVkBBbC+rA4FNVyoDfGOdZCVQDeTsbx2ySH3sE56PfCjEQQJBaFc71kIhf/eTZ+ruMhN4dbWU7B6/sdPyzCBMnWACF7TQMKelhEet4C05xvUVqtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FLi7zmLV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FLi7zmLV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MKaqZR004917;
	Sat, 22 Mar 2025 22:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eIBnml
	g0TBh/Ri6uX8U2LEzh1zqBgfWstotLF6REUtQ=; b=FLi7zmLVwM3QlNT+oQWt25
	G7iLgnUmlxzxEhlbmKmjTxYLBCJ7ueGnC6wr/ti5kywihyyvW/7dPy18864Q+hKh
	Kq36DhkZOzdl8mMIi3x6G4Hyb+tBhrZJT+8s562IBBXvx9ZuIPKHOumV1ehtutUz
	KtAE9xMKdsSDmgg3IwvN8Zv30QkxHxVunMrGY5M0/ltL2rZWVAmUMdhQMMnzuihv
	dZwOD1fBPq4gqxrPNwip0A5b0HHNe6BI0Ar6FALMzKhBS5y5zJyhtJY6aztlxRnE
	7QOq6ztTR46HNv+717ikF6hEwbXaJd5f5RosnmNrleUBS0AhJBzHGODKc4s66yEA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4cp07ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 22:09:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52MIhHtY008997;
	Sat, 22 Mar 2025 22:09:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45hn6tk503-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 22:09:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52MM92Zh12649202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 22:09:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCF7958058;
	Sat, 22 Mar 2025 22:09:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE22E5805B;
	Sat, 22 Mar 2025 22:08:59 +0000 (GMT)
Received: from [9.171.47.152] (unknown [9.171.47.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Mar 2025 22:08:59 +0000 (GMT)
Message-ID: <e51e3390-0f0d-4a5d-99bf-7ea69c63592f@linux.ibm.com>
Date: Sun, 23 Mar 2025 03:38:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com>
 <yq1wmch7sga.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <yq1wmch7sga.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4urnbvzEKj1_Op4fSdYktBL9wUYzYir2
X-Proofpoint-GUID: 4urnbvzEKj1_Op4fSdYktBL9wUYzYir2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_09,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=899
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503220165



On 3/22/25 7:18 AM, Martin K. Petersen wrote:
> 
> Nilay,
> 
>> A new sysfs attribute, named "delayed_shutdown_sec" is added for user
>> who wish to configure time for the delayed removal of head disk node.
> 
> Shutdown has a fairly specific meaning in the context of NVMe devices.
> Maybe "defer_removal_secs" or "delay_removal_secs"?
> 
Yeah 'delay_removal_secs' sounds good!

Thanks,
--Nilay
