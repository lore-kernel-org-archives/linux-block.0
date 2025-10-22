Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81534B407
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146670; cv=none; b=NRTfrDV8M6lv2ph8Pjzp7VPrpMFlphGaRoXdhAb8G+DwTryk9RER62n/GRMnAnaLtqNNRvy+mdAeS57E2OndR1E3X7sHALy6cgLlOGfNNEDFIfN7QwWvEUwfVkuMLmgBd1ZyHaydOt6qiATeq+8STg12NCZ3PM/dJNnU7ENbfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146670; c=relaxed/simple;
	bh=DJNhJ6IS1lCG9VexJPNA0TjGWtE2rH252KxkFbLxOv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LseC72YYJUstBHRK2/piA24lX+AXf2pKP49KM+O6iqkZLgU8WI8zPg8VWyRbKCEydGbMdCRfB+k3pxdh6fKSPE1xFXWWtqUpm+Z84fV8aI/AjIlFqQjOmf1exwXj7VynApngFHO3+WJ/WHlZNaxGDnl5z1LTyD2B9VFvNMiH92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QzcHI20X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzcHI20X"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7lJNg014602;
	Wed, 22 Oct 2025 15:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lu+SRB
	MoeksmXcA7YPHWXb0VULobYlejHJ6C3xKZYzE=; b=QzcHI20XaBe1JEn2TB2AAU
	LWU+uo19WgKHITWRrWfNiQ2UGQjhbrKxgN7xujuNKyCZGzKMS2P6AcnqnUtMwFPE
	+FErUc2XvYcohlp2LvlxyvTCzzZQnmLc79Gn1SKygYvw6vsSgiSZi+grr4looxM/
	gb2VnIooCMOs+FXI2wwaXzETHeWv2sJ3ClNgPDRpPF4QGkWVTiUXRxvbqDSw5L5C
	/Rdjl79C96u6qjfIhJiycQeD8KYz1fJssomPRvzsg9d287lL613HbVX6tZcQ9sia
	u4SUHBS/4pzyTYJQywQyE7v7cB2VAe0Ez+LfK7jVLV27ivorRLXF4elSD+WlHngg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s5hxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:24:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MF1j2l002488;
	Wed, 22 Oct 2025 15:24:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejgvu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:24:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MFODHi27525650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:24:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1799558064;
	Wed, 22 Oct 2025 15:24:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8DE158054;
	Wed, 22 Oct 2025 15:24:10 +0000 (GMT)
Received: from [9.61.143.219] (unknown [9.61.143.219])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 15:24:10 +0000 (GMT)
Message-ID: <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
Date: Wed, 22 Oct 2025 20:54:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
 <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7VEGHUwGyux2mKhwrOvJXM8UnfTx4GN8
X-Proofpoint-GUID: 7VEGHUwGyux2mKhwrOvJXM8UnfTx4GN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3yeOqzDX+D4l
 GtoUlTWltDvj07HNEUod6rznJnhZUk87pC+ziHTcgq5j+BoNMxcUZNFaVgWRzXO3eZiDxU+mYiy
 sdKfQQgwguyDn7izq2266K3x2klAc70LaABuHa5nlX+13JcQqPEL5UfzaW/45vUPFg4Ew7fhsCT
 xp2uhakGg/5AcT1dwU89kbaHfj4wG1Z6PR59ftkybeU48/SLVaCaIXczLJTLrlYfj4444weYwYt
 f6G9Bt5O2vvqF1hTMlxLrnUGXr0D/cdeqF2eAMpLO9pWsX8pNJJA+YfufqkeHvBsWwF5msQi324
 y+Y92a915j2gSC7IU2XRHM9WZ51agl53I/J8Q3qPc7Swd7c5K2tXWSZg4wA6M1PA7izPhlFuJn6
 URCv3ov3Dxv1Zguov9TQe4thEi0ikA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8f71e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=P1pzS-bjeOVViHUOnBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/22/25 2:20 PM, John Garry wrote:
> On 21/10/2025 16:02, Nilay Shroff wrote:
> 
> -
> 
>>> Does the drive which you are using report NAWUPF as zero (as hinted)?
>>>
>>> If so, have you tried the followinghttps://lore.kernel.org/linux-nvme/20250820150220.1923826-1- john.g.garry@oracle.com/
>>>
>>> We were considering changing the NVMe driver to not use AWUPF at all...
>> Yes, I just tested your patch with the latest upstream kernel on my drive,
>> which reports a non-zero AWUPF but a zero NAWUPF.
> 
> Do you think that you could check with the OEM for updated firmware (that reports NAWUPF)?
Yes, certainly — we can check with the disk vendor for updated firmware that correctly reports
NAWUPF. I’ve already discussed this with my manager, and he’ll arrange a call with the vendor
so that I can directly explain the issue and what we want from the kernel perspective.
I’ll follow up with you once I’ve spoken to the vendor.

Thanks,
--Nilay
