Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFB45009
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986158; cv=none; b=jflGa7aIKj5OO+RmrxBjYYTCthtRgkA32h/gZflbLj80n5VdQ6AHxZ/Uij+/XOHEelZ5p2KkG5OPbZWo62LmasG5nsVGKgi1uX4HsXWliGxGpi7PZVmb/k8HaBeEq0VfY3Y3z9av5O8pGIBJ8D/8J5rVtKmY0Op59omkquxOfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986158; c=relaxed/simple;
	bh=j3W8bdpKI+gNKHXc6Mb+lEq5ildQoi6jsaJ5QSDUR20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDQTR/m6+EkVloPeE/wklsWXAx0zM8OztjEzh7iS53WugAXipP6cY3oMOCN4JyLr7SYtrs2OoZ7tqK7/wINlukeFVXYn8soA2niz8p+pogI6LRfvbnuTwbqsyOCi+flUZ7LdKAF221KdGr0elKl+oYUvpYaOTxj/u/vC+rRVYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWGHqNab; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWGHqNab"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IBTCqK019255;
	Fri, 18 Apr 2025 14:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a3Cf4+
	5znQawmv06mXcSZw7fd4AQqZlTEDiNv9WvQ7E=; b=AWGHqNabuZ2brhDVBwuPJW
	+PhC3/amIm23nDWsrhFUxEyCmrkxfsH41xqYfF/lOGd/w0HY5qxrLCbQAOFN+Az1
	8+Xpl37jwElZ16lBVbPS6t7Dm98vddYqvXMn99VrtH7NY+ZLFbxvdwmn1Jm+hdNQ
	wUa9dTwTfM8aZeAmzMTGWgum0C3pOn6FiANFHwkq5jdsNRhluZCG2oHP/If65Kr6
	Pe5QailIcwyPuZWHGyYCKPIkIWSfC4LSTUxB7mdJWC/ZxfgLgbELXMguHyQukGC2
	iUz6GMRgecss1VmUwe7ArsSi8xxM0sv1Vyfh88ayjzTjbfc0R96ixZBxzO8Dc57g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 463bm12vk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:22:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53IDCkot016722;
	Fri, 18 Apr 2025 14:22:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572jput-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:22:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53IEMAFt26018494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 14:22:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D8858052;
	Fri, 18 Apr 2025 14:22:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654BB58056;
	Fri, 18 Apr 2025 14:22:07 +0000 (GMT)
Received: from [9.111.33.1] (unknown [9.111.33.1])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Apr 2025 14:22:07 +0000 (GMT)
Message-ID: <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
Date: Fri, 18 Apr 2025 19:52:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de>
 <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
 <20250409104515.GB5359@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250409104515.GB5359@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WaUMa1hX c=1 sm=1 tr=0 ts=68026014 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=_EqFHIO4WOhHW-ejzvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZPMG74TzNc1ujRm5jyNMKy-f8Dmr2jay
X-Proofpoint-ORIG-GUID: ZPMG74TzNc1ujRm5jyNMKy-f8Dmr2jay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=716 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180104



On 4/9/25 4:15 PM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 08:05:20PM +0530, Nilay Shroff wrote:
>> Okay, we can add an option to avoid making this behavior "the default".
>> So do you recommend adding a module option for opting in this behavior 
>> change or something else?
> 
> I guess a module option as default makes sense.  I'd still love to figure
> out a way to have per-controller options of some kind as e.g. this
> option make very little sense for thunderbolt-attached external devices.
> 
> But unfortunately I'm a bit lost what a good interface for that would be.
> 
> 
I don't know how to make this option per-controller as you know the 
head node, typically, refers to namespace paths and each path then 
refers to different controller. So if we were to make this option
per controller then how could we handle it in case one controller has
this option set but then the another controller doesn't set this 
option. It could be confusing. 
 
How about module option "nvme_core.multipath_head_always"? The default is
set to false. So now it becomes two step process:
1. modprobe nvme_core multipath_head_always=Y && modprobe nvme
2. echo "<val>" > /sys/block/nvme0XnY/delayed_shutdown_sec     

Thanks,
--Nilay
