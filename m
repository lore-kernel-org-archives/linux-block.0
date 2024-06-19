Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398C8120D
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791697; cv=none; b=p+kty0kFDcai16vnt/3apmhIa0/fXD+g5fNRnFOD7yB14yrMO591LsA5QZX51W0fRJJPu/w6gC0pNgG9I2G4rjJBTR0wfoXllhto5Et6Zzcpbv/DTGSeVWpaceAIDmCiDEEYeeMHh6HuI9suYCKJ6N1EVann/dHpwcbVBOtEbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791697; c=relaxed/simple;
	bh=dUBQ8Lkw4fdG1e/qi744ODaLpXnGMvFDRihQCzbdGdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+mVsi9/3AlqFYlgL/i7VF4ADT73HilzVAOTlJHkpnJbscDZStrzBp6pp84Muh6I4V20oN05qmmpTTIv2qyMR4te5H/B8Kr834O4X7diGOoTerFSjuRp7L6+Zrgc+pe3sJodG2v2pkLMZzwUknKtpdEnKD35F7OU3Gz0hK6T8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+ZznwQg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+ZznwQg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J8tv80013711;
	Wed, 19 Jun 2024 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	ioqf/KSNvBoKmz5a81KS4KivkoGRWFgAHkeLB1D67w=; b=h+ZznwQgr9gms7rAH
	xE9sw3j06EGTAm5PD1LJXQBq5UVp5+MzxH1jsAEWcIejungtTQyYjhFJmhz1dIJt
	xqbxaeGMEe9c0t8oRRdqxVnZbhqS/o2s7bwb8AxhHiwGYteaRBmb50yL2kiC9A0a
	nlwuOtN0Z0ub+v79Pki4EGVvklf2QbD8RdwkQTBuLHmDpOjs6rY/NMt3ihnwdxYw
	gYARsvjZbsJDvFN5swc4FJYoZlVk0OSj2jcz1kXtVBXjfziNaUv9otyTPlFvPktw
	4N4BUExQ2T/pPAy5yvt/xsGA+8mWru07S1197rpxsNA+PqC6aSB1HbYx6MEAH4uN
	DaUTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yusnarjdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:08:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J92t4q013389;
	Wed, 19 Jun 2024 10:07:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr03tvbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:07:59 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JA7ui239977218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 10:07:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C284E58058;
	Wed, 19 Jun 2024 10:07:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C8E05805B;
	Wed, 19 Jun 2024 10:07:52 +0000 (GMT)
Received: from [9.43.48.107] (unknown [9.43.48.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 10:07:51 +0000 (GMT)
Message-ID: <fd0fab41-e7b0-4a41-8ac0-8c482aa92537@linux.ibm.com>
Date: Wed, 19 Jun 2024 15:37:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, kbusch@kernel.org, sagi@grimberg.me,
        hch@lst.de, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
 <gpatyu3gqzfswxishsa7juix2z2upmbrkec7n57pbgfzw56jla@lyjvwhv5dvc6>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <gpatyu3gqzfswxishsa7juix2z2upmbrkec7n57pbgfzw56jla@lyjvwhv5dvc6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q_j6pTffEguM3cUiw44qVg8TdVMBwDD_
X-Proofpoint-GUID: Q_j6pTffEguM3cUiw44qVg8TdVMBwDD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=859 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190073



On 6/19/24 13:20, Daniel Wagner wrote:
> On Mon, Jun 17, 2024 at 02:47:22PM GMT, Nilay Shroff wrote:
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local subsys="blktests-subsystem-1"
> 
> Use the default variables instead of duplicating them.
Yes that makes sense.
> 
>> +	local iterations="${NVME_NUM_ITER}"
>> +	local loop_dev
>> +	local port
>> +
>> +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>> +
>> +	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
>> +
>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
>> +
>> +	_nvme_connect_subsys --subsysnqn "${subsys}"
> 
> As far I can tell this could just be:
> 
> 	_nvmet_target_setup
> 
> 	_nvme_connect_subsys
> 
I updated test case using default subsysnqn and blkdev that works as expected. 
So yes I can use defaults for setting up and then connecting to nvme target.

I will update this in next patch.

Appreciate your review and suggestion... 

Thanks,
--Nilay
