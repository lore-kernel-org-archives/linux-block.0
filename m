Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8D4F885
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620356; cv=none; b=PpEV8FO6qIMHXE4KXAhXuRvU/zbP8J19yZJV2if7U8CikvPqPc2WvIj62AgBnfvhgYQU36JgQf6cBxkjbtycMaIlXs1o5Grp89kp7Qh4zckO4yg8fBwE9d5ij0Jn2SfivNS5VP1KxQu/Y0FWDi/lpAzvZFAWXSqz9PgKCBDgfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620356; c=relaxed/simple;
	bh=RQ9BeMnVHklW13dSNxnK78MuuvmmuqSY8cmWhg8H/Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKS0Qb/XtXp5c4xsWIqiBj0HureTnLOypAkvxg561IV8WpbkpTaSCtq22EYKEp3cgjKEIeLDWmI+3c58BBei/Fzd7CDmbbZ8KL8vBYLbBLZ4HlcZsjOJut6t/eSfnjtH7I1oe6BcBXMB/OF+pQfSPf2P8m4u1UHhEDwUvR4rsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j3v6zLx7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j3v6zLx7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S9Xb0x008425;
	Thu, 28 Mar 2024 10:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DzdNYFHD35QNPdkaeJu58WIZnSj6PqMjOlPmxbYOeCk=;
 b=j3v6zLx7PMzan09+4qVApiSdLdH5Cldcwu2HxBYeqXic/53PG0m6Tsfa3XIFg3RYfKzV
 suiovL5CM/w8VnzhBuxZoQJFqZdZ6kbn/LYsiRpa6ZZUhsLWj6TzJOd1+Qx7I8dr+G0s
 8GaSJ/rN6/oY91iW/Otu3acVyracxq1uL45tW6zPUnpPPPVheMKSORVZvzyenERJiTDv
 vrKZjLv33Ny6plZX0jT2F8cC1As7bBBIu2dFC7RfIUuHfUGs509ViCPQF5CI+T6UeRRK
 vOHytxr2JIukY28L2Eb57cC3mXb19nsCGqMNllasMey4TP31ZT/+9PygjBTHbm7UxI5+ 2g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x561002c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:05:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S7tBPT028650;
	Thu, 28 Mar 2024 10:05:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adpmrwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:05:40 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SA5c9G23200294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 10:05:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2B315806A;
	Thu, 28 Mar 2024 10:05:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A1C15806C;
	Thu, 28 Mar 2024 10:05:35 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 10:05:35 +0000 (GMT)
Message-ID: <d8557e3e-a6b9-483f-937e-99cd94216339@linux.ibm.com>
Date: Thu, 28 Mar 2024 15:35:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@fb.com, Gregory Joyce <gjoyce@ibm.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mc69C_40QUxT_eioVv_2F9bDqI6dQqjc
X-Proofpoint-ORIG-GUID: Mc69C_40QUxT_eioVv_2F9bDqI6dQqjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=937
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403280067



On 3/28/24 14:15, Daniel Wagner wrote:
> On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
>> From the above output it's evident that nvme-cli attempts to open the disk node /dev/nvme0n3
>> however that entry doesn't exist. Apparently, on 6.9-rc1 kernel though head disk node /dev/nvme0n3
>> doesn't exit, the relevant entries /sys/block/nvme0c0n3 and /sys/block/nvme0n3 are present. 
> 
> I assume you are using not latest version of nvme-cli/libnvme. The
> latest version does not try to open any block devices when scanning the
> sysfs topology.
> 
> What does `nvme version` say?
> 
yes you are correct, my nvme version was not latest:

# nvme --version 
nvme version 2.6 (git 2.6)
libnvme version 1.6 (git 1.6)

I have just upgraded to the latest version 2.8 and I don't see this issue.
I see that newer version of nvme-cli doesn't need to open head disk node if
kernel version is >= 6.8.

Thanks,
--Nilay





