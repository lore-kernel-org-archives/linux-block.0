Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD111A8F94
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826012; cv=none; b=J4pjeSj7jE0yRiEHtirxSju25JcxpiwdPxaYLhozA/Y/ychMNLD4bUAuRhsQReJPJROwRVtuy7Dl2RaGqbp422CB4L6v9Jq04sYBD5Yp8RfeAgtGa0NQELCpm7VjgjjCUzZ5RG5R2sFVwdZrz7Zj5RFdpC/bz7rnz5pBTEXjXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826012; c=relaxed/simple;
	bh=5BSECx7bIyB2x4MpqU2XznPf+4CBqdYOeBH/je23d9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eA7bQ3/UCb75stbyYFqTw3T+CEJ2tBpNKAuT+WYzM7wvgeV/lQ8KTccrtiryAPR5MubYdKm8Srq6LxDlxFXNGaoJyNlKkABY+js+nH+dAicMcV+Y19gnUDfkxZab7tKQvxUfwON8sEcLvhq8VaM7VW7ETFGMnKhXp8sSHiSMlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p/RSzv9u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p/RSzv9u"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RLd8BX025852;
	Mon, 28 Apr 2025 07:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=unOf66
	4HLgxp+t4LlNsYi9OrYQuVdYgTtNLzT/jF7bs=; b=p/RSzv9uTKuvIZgIC4/fPQ
	7/nDjNHSGeBDFS7XOAzaRQeEGz1U8bnVOnWcdBo7DL1TLohMXxSHEAg8+3FQKV7I
	VZkAqV9pT/Q4fgxIpjDRJKcQbVIUrIxpi0H6oiVfDijVUxdW2V6Rk/n1LNxLnNC+
	n7e4e17fByPYbr/u2ps9iglSXuF968KPSiRrEhxqX3xFvZeKKKjh2a2wjYaThcGU
	1uKPjsl/yCsvPJ+9YszskgELnFlzoBkUiY8lSjWoOJZG7Y3TRSn8N0C682w/CHSC
	4/iWpJYGeU/HLzEN7Zy7KKlR79jsISJgY9OIZoVi8EWJ7RiPPrUmp6107v2b6Exg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vp8hua9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:39:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S78IQK000644;
	Mon, 28 Apr 2025 07:39:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atp5cmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 07:39:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53S7dKpQ26608234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 07:39:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E730858052;
	Mon, 28 Apr 2025 07:39:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C505058065;
	Mon, 28 Apr 2025 07:39:15 +0000 (GMT)
Received: from [9.43.89.161] (unknown [9.43.89.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 07:39:15 +0000 (GMT)
Message-ID: <a33c691a-d4f6-4cd8-96e0-17e2e4078d37@linux.ibm.com>
Date: Mon, 28 Apr 2025 13:09:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
 <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA2MiBTYWx0ZWRfX6yBkcDcZVISu FIIDTqqxYG3hJYcxhp4pQpKEWtISHBFs0oOa8pg7N2L7ahl+Qc4GPlqsXQajLW1QdGF9Noq6FSk Biz1kaRi/d2gBE/pWLjnslNi0JKsvOyjEqmGiw9UD05WhZuVojgRkIDLLsauOGHuHIbN8r/zN7o
 u6NyO15Zj7pucflPeTXPv+EjkvbXnxpHYI/i26sXM0xPWBQvpQFhP/XRv2MEbx+t4WM4T7vIxym 6sUQydmIAeb3b0ca178TF20akTbGYS1zujKtALuclMlSleuMAZ1V/YOi8ceg7r0oTSdUimUhr/w c6gedzjbCkhRZ3TB8YNOBiQqbfriYRlI62lKZ7d+2lWw/MKV2DKJ4r/H5v1qJ+HH+Gorb55aYVS
 PCf898X8q/8HmZiapRwq8tV/Sl0smp6Td+liNhKqz5nirthTzCn5RbuxrljsTsynVbiq2v09
X-Proofpoint-ORIG-GUID: EZn055TTAEIL_dntKkh9XWUKQYu_Hm4f
X-Authority-Analysis: v=2.4 cv=R80DGcRX c=1 sm=1 tr=0 ts=680f30a9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=YxCs09HgoanL8TQdLBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EZn055TTAEIL_dntKkh9XWUKQYu_Hm4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280062



On 4/28/25 12:27 PM, Hannes Reinecke wrote:
> On 4/25/25 12:33, Nilay Shroff wrote:
>> Currently, a multipath head disk node is not created for single-ported
>> NVMe adapters or private namespaces. However, creating a head node in
>> these cases can help transparently handle transient PCIe link failures.
>> Without a head node, features like delayed removal cannot be leveraged,
>> making it difficult to tolerate such link failures. To address this,
>> this commit introduces nvme_core module parameter multipath_head_always.
>>
>> When this param is set to true, it forces the creation of a multipath
>> head node regardless NVMe disk or namespace type. So this option allows
>> the use of delayed removal of head node functionality even for single-
>> ported NVMe disks and private namespaces and thus helps transparently
>> handling transient PCIe link failures.
>>
>> By default multipath_head_always is set to false, thus preserving the
>> existing behavior. Setting it to true enables improved fault tolerance
>> in PCIe setups. Moreover, please note that enabling this option would
>> also implicitly enable nvme_core.multipath.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>>   1 file changed, 63 insertions(+), 7 deletions(-)
>>
> I really would model this according to dm-multipath where we have the
> 'fail_if_no_path' flag.
> This can be set for PCIe devices to retain the current behaviour
> (which we need for things like 'md' on top of NVMe) whenever the
> this flag is set.
> 
Okay so you meant that when sysfs attribute "delayed_removal_secs" 
under head disk node is _NOT_ configured (or delayed_removal_secs
is set to zero) we have internal flag "fail_if_no_path" is set to 
true. However in other case when "delayed_removal_secs" is set to 
a non-zero value we set "fail_if_no_path" to false. Is that correct?

> And it might be an idea to rename this flag to 'multipath_always_on',
> so 'multipath_head_always' might be confusing for people not familiar
> with the internal layout of the nvme multipath driver.
> 
Okay, I like this "multipath_always_on" module param. I'd rename
it in the next patch.

Thanks,
--Nilay

