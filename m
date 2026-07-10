Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B842668E;
	Fri, 10 Jul 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686716; cv=none; b=D8kxpZxfKWy7w/PHGTGGLqb2taO9oE6jLCvwZPnB1I7IuZCPBCfD/5V/DlCyS5nRgHZdIoDAm23nxt/ctUWNsvOi6Ay92hnCiQhJD6r9vlDPxANObpODSEKD2ev4LybAx/ZCOjUvk5AWvz5eJpsS/2ED3/NOBsfRcmShzooVjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686716; c=relaxed/simple;
	bh=l03PmTdaxaCBzfWGkvFG3sLGTFMS7OZLiTpBot3Du4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pn4tA9bw2x0iL0ENbJ8h/B0tgSFV9C9L+WfCpWx+pbqdy0wYT0FP0og1Od0C6Z2fnQ+ieP3O3wqD0Zs36DJznSmrMprLDOfZ+8P3eRb9v3F3y8LmKkmBLH5AVEIkWtx/V7iTND3L2DZlHRbuXQVZ+d5KXeTrKIWieRz0roT3jtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tF3Tvkvy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tF3Tvkvy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAn6Yv4168310;
	Fri, 10 Jul 2026 12:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7cs6vf
	QI8WV3dCq1HSN7eXg9SnZ2PqzTlBzUygUewRg=; b=tF3TvkvyCs6+sqMEBOwxVN
	32AUAVE82JJSeOB7uW+gaLW+o0HPRQe2PXSizaRcT59ZXzCagcY23Vb6jeqn3+D/
	oac/dh5BX9UV4p+nTa/LAi6ME2hTWSwJPowAEnIF3floxWgIrfvkld/dyxb/vpVR
	1Kpl8nwT+pLiVLx3HvEq9oXOnkZ3R4VKOMbhf6kFo1T4PBzZ6obxZx2vOGWc6wlI
	AFNGeIutiU/H/sDYUzsXl6o6g2x9rrbBo1RPN/fia2NH+NNUUSH2uYvQRIgur6Sn
	X/Xo5Sjarsh7i49E3JBFov7GVLVgETzvAs+RYm9eQI08KHjmRyh1K8/tQ567rNHQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt6ufs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:31:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACJcNs032025;
	Fri, 10 Jul 2026 12:31:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsv9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:31:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACVZh010093268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:31:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7720258059;
	Fri, 10 Jul 2026 12:31:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C8AB58053;
	Fri, 10 Jul 2026 12:31:30 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:31:30 +0000 (GMT)
Message-ID: <53969d40-04c9-43a1-b1ae-512ff4a201c3@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:01:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 9/9] null_blk: serialize configfs attribute shows with
 the file-scope lock
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-10-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-10-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fco8OZPbttMdbM923s32rTN-vRGl4dTN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX1fF1BfdyZ6K0
 fbNrw0r0m1hUddZEQI/uxvBSf7sBxhWFd67hQVbT28ddxpMmmVZpkrY6lVW3aLwert3qjd4DHZQ
 L0N8qmEHkaCEYUj79tQ0ogNVR8rbF+g=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a50e628 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=dBYY0X1fOmiodwhjrZ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Fco8OZPbttMdbM923s32rTN-vRGl4dTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX9OyROnxf7pPN
 11D10zjy3+zv5V6sGcVKGUEfowGkopdu1vR3KyJnA6gAUjdfniYe/JcstW5L5kteU8l6P6nkdTS
 /Qx7mJ5VyLeo7xgN+gxjlPqp5N4Gbdi7wNfzuKYEr78TZWr8tyRLteE3W6NddMlmtX5XnnO8WfX
 d0gY//F6lR2h42mBYnr5C9ETkncLNMfI2QoEXbDhqnyc1AG1NBYNhYtgWPWsS25/IEav4fcdPK0
 cL0N6aY+ecBFgDLqnz52VD5lHZ5I4MWBD/pYm8AKBxhWa8z5JQ5bBYHaXEepLug0HYo5CZMQax1
 nsVUBoWYjGTMoClk4590kaVErvXJSudndGM5Lf2gulf3ip/3vplH6e+Dj/I3XyW4nqTSMyD8my+
 FzC0Hu4murOGhoSwef7nTbPIUNToK5NvXzAWHeQpcXZYoHNVaXIbDbfohRGFWg2eX9tLNs3obIX
 gF71PBxWAhZsr1NE0fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> The _show callback in the NULLB_DEVICE_ATTR macro reads dev->NAME and the
> _store path writes it. configfs does not serialize accesses across separate
> open file descriptions (buffer->mutex is per-fd), and _show takes no lock,
> so a concurrent read and write on the same attribute is a data race. The
> _show readers also race against writes to these fields that run after the
> configfs item becomes visible, e.g. in nullb_update_nr_hw_queues().
> 
> All of those writers now run under the file-scope lock: _store takes it
> unconditionally, and the setup-side writers run under power_store() which
> holds the same lock. The only remaining unsynchronized accesses are the
> plain reads in _show. Rather than annotating every field with
> READ_ONCE()/WRITE_ONCE() across files, simply take the file-scope lock in
> _show (and in power_show) as well. This closes the remaining _show-vs-write
> data races with a single lock and keeps the writers as plain assignments.
> 
> configfs attribute access is not on the I/O hot path, so taking the mutex
> in _show is acceptable from a performance standpoint. The dev fields
> written in null_alloc_dev() and dev->power in nullb_group_drop_item() need
> no locking: the former runs from .make_group before the item is published,
> and the latter is serialized by configfs frag_sem/frag_dead against
> attribute show/store.
> 
> Suggested-by: Nilay Shroff<nilay@linux.ibm.com>
> Signed-off-by: Zizhi Wo<wozizhi@huawei.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
