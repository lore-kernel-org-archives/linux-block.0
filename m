Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC601DDA17
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122950; cv=none; b=kPVWx9FAvxnfjO5/evTET9HVe38e8WqcOjUICmhRd8raC98UXKxiRrcZm8vHcQBMVCtdiL8mqRfutFmURwxmV/taJvDFclEMl6nqCjNEzkcDE5txS/vPUubOama0MoP50HouWNNH1Fx+twmt4Bx+SxFv0QfvUH+knzk9lAvPCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122950; c=relaxed/simple;
	bh=QmjYrGnq1gzzons9JIK9E0k5q/RSBSofHWFHn+nwWrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUwWa2Y3v4i2vWebym05SSWxZ1Q2Uh+Gg4jzcHez5bLkK+CnCR2Fs/SLqNIZu3/taoO/HeefKCSZhHytsKpeIrPsO3+AF7vw01H6JZ0Ln6T9NgpL+TacqaTTF90xjWdNozTsvQ/74LbhEDu9VzHbf2xi9XKfm1cUsG+ngGmM1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f1r34uGe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f1r34uGe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538E3M5e014109;
	Tue, 8 Apr 2025 14:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c+Srwo
	6LrJTV8oflR/F/lteItYrj/hb48b1YykMtkhc=; b=f1r34uGeM2FDqJDiLDwneV
	CPwRo83voa6VCBfvp6W5YImVj+IoUzxzB3Kp0CgjhVDfC8ZZOIOupyGpJAoKEEgb
	o6GnqPS8+okB4jzgx5QV7jjruX7PuXjpDqCohyf/hwEh+T0LbQovAriyBNOs/jSw
	bdTILAfRNgRYqdnT6F3F2vv2zYBzAVYv8znRuIbpVlde3wLwKdxDacAj4G6WGLdK
	wi/SlUmVrw+9JB/qO34T5QfwfLobPSWWh1+wHdp4O/P3C5+Ynvf1Zucyt1nR7vcv
	6b7DpfpfdI5vJmyaev72Yocra9tfAVT4NSCaGq4zhprxgODCKb3FkDrGaNQtqB0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57pr6p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:35:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CJV7i013860;
	Tue, 8 Apr 2025 14:35:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunk28h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:35:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538EZMhh21889778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:35:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D825805B;
	Tue,  8 Apr 2025 14:35:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6DEB58068;
	Tue,  8 Apr 2025 14:35:21 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:35:21 +0000 (GMT)
Message-ID: <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com>
Date: Tue, 8 Apr 2025 20:05:20 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250407144555.GB12216@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RfZCNEjzWF5Yt7aT8gq7hHVlpNdSZdH-
X-Proofpoint-GUID: RfZCNEjzWF5Yt7aT8gq7hHVlpNdSZdH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=443
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080102



On 4/7/25 8:15 PM, Christoph Hellwig wrote:
> On Fri, Mar 21, 2025 at 12:07:23PM +0530, Nilay Shroff wrote:
>> Remove the multipath module parameter from nvme-core and make native
>> NVMe multipath support explicit. Since we now always create a multipath
>> head disk node, even for single-port NVMe disks, when CONFIG_NVME_
>> MULTIPATH is enabled, this module parameter is no longer needed to
>> toggle the behavior.
>>
>> Users who prefer non-native multipath must disable CONFIG_NVME_MULTIPATH
>> at compile time.
> 
> Hmm, I actually missed that in the last patch.  I fear that is a huge
> change people don't expect.  I suspect we need to make the creation
> of the head node and the delayed removal an opt-in and not the default
> to keep existing behavior.
Okay, we can add an option to avoid making this behavior "the default".
So do you recommend adding a module option for opting in this behavior 
change or something else?

BTW, we're not removing nvme_core.multipath module option as we discussed
during LSFMM. Keith and others were against removing this option. So I'd
drop this second patch in the series.

Thanks,
--Nilay


