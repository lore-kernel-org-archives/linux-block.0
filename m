Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177DA32
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762067; cv=none; b=SDM3uJnL/eSZEkBB+ezj372SVZGuentEeeeZXD61TxnCUnwRnKWiQ0v/HOgl7Y5ndxJ7wKM8LUhi37N70HRU6U0CEXA1TDT/0uzCjgzoXMeN2gNYcPPHAzrb6C32PU9WpPkujNDze/ksC4pSHxgJ393ZR/Te9CXKRGmMaEqPwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762067; c=relaxed/simple;
	bh=XPkJdjQRPGlBY9IL2wnC6vEn3uAScAhMrGoRum1Ozlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR0MmeLsRKE0xhVXMp8VboZIv96kU8uUHoTLgWjZi5V77fw+G4clnDw9gP9j01dDBmYYxbh0THNWNFWzE4jVHTFSaYsrzQTzaSnur2jIKVl2Q9HmGNGmeYwrCGFub/qAGz0ZHSvuYodOxOW0dA3xck1WOLHmeiRa31Z6UWMOqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NgKDmFbn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NgKDmFbn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5157WjMf000508;
	Wed, 5 Feb 2025 13:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WMpwoF
	MTeiab/R30/eWfvI0ywJCIDQ1rmwpgwXL6YNU=; b=NgKDmFbnH1Wpww5u5kWPyY
	yFs0RPNx9QH/IoIZ4tKc8L57+dD4bcoVBcfgW12F3idEMUHD7ESBA1RdX2Oj+CHM
	KyVHMURQDvJCGsU/Y3zHBZvG6Fqxfn+UzRqFOZBxzm5A9r9fVl7AQmojkKkj67Ua
	S/V5WsTZBK+4k3TgPfstc6Mc2+QComf5zqInDWUWGCkXS8l3bM3bQgiSDHptNzal
	HSt7tFeyR57EQ+Qeo61EX2/9zPuol6s7V2aHrO42f3Kc22ZLRefZfksB8a0fMlHj
	BqsdvGHa5QmaUHhTpeoBga7Oe5gE5ZI9GZsykI0SUGnzpCrivl4PggG9xsF7kDkw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnskjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:27:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515CZqgP006516;
	Wed, 5 Feb 2025 13:27:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekgufr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:27:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515DRepJ19989076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 13:27:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6993058058;
	Wed,  5 Feb 2025 13:27:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B155805B;
	Wed,  5 Feb 2025 13:27:38 +0000 (GMT)
Received: from [9.171.80.122] (unknown [9.171.80.122])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 13:27:38 +0000 (GMT)
Message-ID: <7513082f-8ac7-4058-a72c-d062bd436591@linux.ibm.com>
Date: Wed, 5 Feb 2025 18:57:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@ibm.com" <gjoyce@ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20250201184021.278437-1-nilay@linux.ibm.com>
 <xcgbpthn7v3xpprcqyer7jvfgzlaavvm2i3kureaqc74df263h@vuv5a23bbocp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <xcgbpthn7v3xpprcqyer7jvfgzlaavvm2i3kureaqc74df263h@vuv5a23bbocp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WHTU-P0uKuAdu9yE_NNPYhO-2JLiV3wj
X-Proofpoint-GUID: WHTU-P0uKuAdu9yE_NNPYhO-2JLiV3wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050104



On 2/4/25 5:25 PM, Shinichiro Kawasaki wrote:
> CC+: Bart,
> 
> On Feb 02, 2025 / 00:10, Nilay Shroff wrote:
>> The srp/* tests requires exclusive access to scsi_transport_srp
>> module. Running srp/* tests would definitely fail if the test can't
>> get exclusive access of scsi_transport_srp module as shown below:
>>
>> $ lsmod | grep scsi_transport_srp
>> scsi_transport_srp    327680  1 ibmvscsi
>>
>> $ ./check srp/001
>> srp/001 (Create and remove LUNs)                             [failed]
>>     runtime    ...  0.249s
>> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
>> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Permission denied
>> modprobe: FATAL: Module scsi_transport_srp is in use.
>> error: Invalid argument
>> error: Invalid argument
>>
>> So if the scsi_transport_srp module is loaded and in use then skip
>> running srp/* tests.
> 
> Thanks. I think this is a good improvement.
> 
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  common/rc    | 11 +++++++++++
>>  tests/srp/rc |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index bcb215d..73e0b9a 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -78,6 +78,17 @@ _have_module() {
>>  	return 0
>>  }
>>  
>> +_have_module_not_in_use() {
>> +       _have_module "$1" || return
>> +
>> +       if [ -d "/sys/module/$1" ]; then
>> +               refcnt="$(cat /sys/module/$1/refcnt)"
>> +               if [ "$refcnt" -ne "0" ]; then
>> +                       SKIP_REASONS+=("module $1 is in use")
>> +               fi
>> +       fi
>> +}
> 
> Spaces are used for indents. Please use tabs instead.
> 
Grrr.. I think my editor inserted spaces instead of tabs, I would fix this
in the next version of the patch.

> Nit: "refcnt" is not declared as a local variable. Let's declare it. Or, it
> would be the better to avoid "refcnt". Instead, $(< /sys/module/$1/refcnt)
> can be used as follows. Either way is fine for me.
> 
>        if [ -d "/sys/module/$1" ] && (($(</sys/module/"$1"/refcnt) != 0)); then
>                SKIP_REASONS+=("module $1 is in use")
>        fi
Okay, I'd make "refcnt" local and update.

Thanks,
--Nilay

