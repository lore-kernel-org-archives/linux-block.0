Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34841F7E9;
	Fri, 10 Jul 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686997; cv=none; b=HxdtvnAkFHBKQ2YE47sHPeS66TQcs+TXhev+aqS38DCip0AtN47yRGY3Osd+6F2ZIaKdJiZyTP9A4YIoaQlQq4OwJDG+QVrwQ3gFH10iGR3ZnUPfhq0pvN5LxjOhTrxWdCchGXSEmPtznKE00ml/XrgNwYn02EYVO+cejmJIoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686997; c=relaxed/simple;
	bh=z87ftC8umwG7TGqrK5BDwHBgNm+BATghkkaxqshF8vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ6ovldaFsV+9Yip7MdfNse1C2TV2LOrDLqpP1GmnI/nxoSezNyxxnUK0GfhQGo1qpvPjP38VqfKiz7Ny3U6fNU0KBXCPVGVjF6ILqzoaxnLGXR5YRiM2gg4AHydpsSAtWg7QRoVVbxsRCBJqYYAZgFjLoX3D3Zk00tNbQoEWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=me5+028Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="me5+028Z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmbVW888655;
	Fri, 10 Jul 2026 12:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z87ftC
	8umwG7TGqrK5BDwHBgNm+BATghkkaxqshF8vE=; b=me5+028ZBA4/XRV3u3bvns
	TBzlh6dLK9HjcKFF6jI/IcE7nyfz4UNVOHlTheUMwlPxWaz3HHoVb/PuDjuel0Dc
	/WkW40Utf/RlpIamgqWjkp+xnFa3hvgjYvrDvq72qrocfEo655/m4UR06McNQq98
	l8RzxhJc5Lu28A/GPQAA7jYWN/c2OyZRdYRlT8DykLLOmA/lz/5Ex399twAAGgXr
	HCI/DjKdOeUkja5Q1wkk4wTiCErdsZLkpzPvinpLEU9cC/cSa6cOSZEoY8ULa3uz
	6zWXef//J6JS4dEdGCbUGLYknrpmsePD6FHaZYhl5uo/twQmcd8JelZZOy7VOWFg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0bytr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:36:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACYx2j023653;
	Fri, 10 Jul 2026 12:36:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwj6m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:36:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACaJqC61407742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:36:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52C1258043;
	Fri, 10 Jul 2026 12:36:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3459158059;
	Fri, 10 Jul 2026 12:36:14 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:36:13 +0000 (GMT)
Message-ID: <a0af6e54-9cc7-4f9e-8a13-8dc33c166514@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:06:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/9] null_blk: register configfs subsystem after
 creating default devices
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-3-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-3-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a50e744 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ND1QlC8BqVg7SnU7v08A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A2wz0WQxyEvBbhrsfpFql1uy89s518zY
X-Proofpoint-ORIG-GUID: A2wz0WQxyEvBbhrsfpFql1uy89s518zY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfXwARQ/hrf+6GW
 jodV0851kSIzzwsp6YDu2h84u0Rvn9sG/VTF0DsqQFFVtnVQp0KrHFOcWGZRPAtaY8zGGo5XEdv
 OF1BYszHdcZG17oaApdvgEVeFeQoaDw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX5YNj8Cxpd0bM
 3Xth27nIeXHNltPXI3dgpcPBEUHgs28MXawIaWZzEonuU1RwRB1QnNsu6OcTgFKOr8KuZNbmUdN
 CEIufHz9BXay/XbOBn+W0cQz5Q/1PmoHFO+QsOVVendRhkRWirN5fSLt6n1/6CldcYVZZ0CRgmr
 oAZ6QoMQD87a1wIDxjB6eiK5EB3c1NoNICCMOcq1FggP+IlgAe+adlES8BZGdXPgvbkR3lr2ZIP
 R5HKGC+0rpJQVih3QWAo0Yaey4FZ/tEZQ3EPQ1ZAahkDlufddBm7rMPf+KHYCwDuH411FZzY4z4
 SnJsNoAK6E7qoKJ0ju4qtSEjCN5dLseSgmsLav9Ta4fp4swOPmSw3ziNShTz4O5i/I44wsafDca
 364pPHy+YnPmiKVYr5UJT+QEKywHDdUDF4KEEWIP9F0Cgj7P7dn0gAP9yrAXHWfCcZAzGUs+SfZ
 mGd9WkRJEwCj8XAMm/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> In null_init(), configfs_register_subsystem() currently runs before
> register_blkdev(), so when null_blk is built as a module, a racing mkdir()
> + poweron from userspace can reach null_add_dev() while null_major is still
> 0. __add_disk() then hits WARN_ON(disk->minors) (major=0 with minors!=0)
> and fails:

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
