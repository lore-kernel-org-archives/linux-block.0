Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D191D618E
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824001; cv=none; b=YN8ZuFRe5TjYW99339o7t3cl4XRaAmJus7DgElM18N1PD6CvjhEtO2e2Pb25cTEbUVCU4Z5nXW7eOtGqM3TgIR+zhbLE7m9CIS4RqMuKWsZ1h6sPSs4wGfauGpvmDLj95p5A/4cISgGxBsdMTw7exNRXuAW+ofqxaiZ01cwhEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824001; c=relaxed/simple;
	bh=TAIGcfbk/dNzCLmb5V5JiUpw8rXlcZp4srz9+oXKkQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt3LldRjow4WSheK/z2XuMlA+Vv+1bHGiRlMe/PbgbTjA7sVQ98oeyz2uAXCGwixv+mtVxHV08lsQrUDkffdIl9XJszMC4rwUjFMd0tniffR+3rNsTON30MUW/zFRNEtKa121D8/hUGIwWOjxX6J/WzPcdbrX1l9JFrOF8emj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kECOd+i0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kECOd+i0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RMsC4b030709;
	Mon, 28 Apr 2025 07:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fSBcxh
	gjp6pGgsU8t/AVofpb0szx217lgH4Lxevfkx8=; b=kECOd+i0KQr04J9Bf3y4JS
	Osx7gQfELbKhwcKiE8WXxxBtiN33ZdryNAA93A+sTX4XchmWYfNp8MpMITCz6mcl
	cFjqWrKYTwhN3Wyj1FF/99T7NcQAU9MwNFDNsoInRq4qp63dzmS/gHZcWWP9qzi8
	K7sC84HQLr3VaePNzxn00SlO+cWJgo213PmK1drSkPSjaNjFa2QZVkn77NV9c0Ac
	V3mHE6KzjLVRtSWK2Pcv0dae5m7oi2F2/iZRr/wV0XyAIQGlI8ckU/TLFCEZpuGz
	MY/mT4Mm4s5wuSjxTray7qHpzQKxrfHf2Mnrru+px8m4YSfFHv2unne+MZaTIGcw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vp8hp2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:05:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S6dCj7016095;
	Mon, 28 Apr 2025 07:05:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a705bt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:05:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53S75o5t23265826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:05:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E1858066;
	Mon, 28 Apr 2025 07:05:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5C458062;
	Mon, 28 Apr 2025 07:05:45 +0000 (GMT)
Received: from [9.43.89.161] (unknown [9.43.89.161])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 07:05:45 +0000 (GMT)
Message-ID: <3916ace7-833e-4cbb-8f8a-cb8e87403c7a@linux.ibm.com>
Date: Mon, 28 Apr 2025 12:35:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-2-nilay@linux.ibm.com>
 <20250425144336.GA12179@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250425144336.GA12179@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA1NCBTYWx0ZWRfX+r88y7Aa5JEK gzcSaPNz6WAFUvg+rem0Iokp78UYcXLY/H+fkWD842leEiZ9/VUl98erHfXKP5Bqq+sJi9LVk1R 7IrGFISA5sB84dgmRJXp8WU6gKoy2JWWxDYBuFDP/jkeIoqw6rKZMEmc9k0B3ND9hVQ0CD8+9v3
 Bcq7jzTYEE0odu+OQaM802p6V75B6leBpgJoUXySGB6nSHR7sBk+d1QyssG9AiNGcrsixtSyfJD JqkVwpmKunW6grHtx+LtekcwWVWO/Tr1Ph0vsFuttb+P7AAafP3xOPxKfHo11qJZq3WPd3sQksG 1wM0VasaQ2AcFr2SAU9ILjEUGyh8Sc1iLLtmMLSQc++dlYLO1xj5odTKATlkSZAnVHQgFH6MnWK
 2l+JzhBSA6ncZ8XNa3Czrwd9+vy3CMvz4dpsAtNpjIwvNDdOzJ0Q4mOCUArTppOviAbSJAts
X-Proofpoint-ORIG-GUID: D0yc2WKt1qw-BsAKCpxaEJWoL44rnSBQ
X-Authority-Analysis: v=2.4 cv=R80DGcRX c=1 sm=1 tr=0 ts=680f28d0 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=4pJLPQpC4fobCXiKAOwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D0yc2WKt1qw-BsAKCpxaEJWoL44rnSBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280054



On 4/25/25 8:13 PM, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 04:03:08PM +0530, Nilay Shroff wrote:
>> @@ -4007,10 +4008,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>  
>>  	mutex_lock(&ns->ctrl->subsys->lock);
>>  	list_del_rcu(&ns->siblings);
>> -	if (list_empty(&ns->head->list)) {
>> -		list_del_init(&ns->head->entry);
>> -		last_path = true;
>> -	}
>>  	mutex_unlock(&ns->ctrl->subsys->lock);
>>  
>>  	/* guarantee not available in head->list */
>> @@ -4028,8 +4025,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>  	mutex_unlock(&ns->ctrl->namespaces_lock);
>>  	synchronize_srcu(&ns->ctrl->srcu);
>>  
>> -	if (last_path)
>> -		nvme_mpath_shutdown_disk(ns->head);
>> +	nvme_mpath_shutdown_disk(ns->head);
> 
> This now removes the head list deletion from the first critical
> section into nvme_mpath_shutdown_disk.  I remember we had to do it
> the way it currently is done because we were running into issues
> otherwise, the commit history might help a bit with what the issues
> were.
> 
Thank you for the pointers! Yes, I checked the commit history and found this
commit 9edceaf43050 ("nvme: avoid race in shutdown namespace removal") which
avoids the race between nvme_find_ns_head and nvme_ns_remove. And looking at
the commit history it seems we also need to handle that case here. I think if
user doesn't configure delayed removal of head node then the existing behavior
should be preserved to avoid above mentioned race. However if user configures
the delayed head node removal then we would delay the head->entry removal until
the delayed node removal time elapses. I'd handle this case in next patch.
 
>> +	if (a == &dev_attr_delayed_removal_secs.attr) {
>> +		struct nvme_ns_head *head = dev_to_ns_head(dev);
>> +		struct gendisk *disk = dev_to_disk(dev);
>> +
>> +		/*
>> +		 * This attribute is only valid for head node and non-fabric
>> +		 * setup.
>> +		 */
>> +		if (!nvme_disk_is_ns_head(disk) ||
>> +				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
>> +			return 0;
>> +	}
> 
> Didn't we say we also want to allow fabrics to use it if explicitly
> configured?
> 
Hmm, I think there's some confusion here. I thought we discussed that for fabric setup, 
fabric link failure is managed through other parameters such as "reconnect_delay" 
and "max_reconnects" which is handled at respective fabric driver layer. Therefor, 
head->delayed_removal_secs is intended exclusively for non-fabric (e.g., PCIe) 
multipath configurations.

Even if we were to support delayed head node removal for fabric setup then I 
wonder who would handle fabric (re-)connect command? As once we exhaust number of 
reconnect attempts, we stop the reconnect work and delete the fabric controller.

So do you think we should still expose head->delayed_removal_secs for fabric setup? 
If yes, then it'd add further additional delay (without re-connect attempt) for 
fabric link failures, isn't it?

Thanks,
--Nilay

