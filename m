Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EC3D3B8
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865668; cv=none; b=D3jsAxjMyMOaScPjvDCK8017BjmHr+Wb3T15X1qikdnf/RymqTousqRAYXcCuoo2X5PT/xuKx0HbTtZuXVgRVSCEoWJcUxTe6ag9UyBGB1iWuMmKOJMoSEZfUTT0o6fKsdxEp97AxzpXfnbaQYuVbStyUUAX5vtvow04fhjNvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865668; c=relaxed/simple;
	bh=TGxjZ3wiWjAMaEctMB9XLqto3w+tMOFB411UZ/3WiEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aolNLRbpkSdWNdSuhViGBcLxrf6WzvUTtMmVs0h6kn7A5CANUkE0HARRW0A4cZETBR+3xYZZlbzztLzvW0nivNxUdZaW2i8zJ1m6nIgjm7VPkzPpeYuukttiK4NxvqXxSsViDl549QpS/+o0u1EAzRZjfVAEKeWLaSoVPebTbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QHqu9iro; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QHqu9iro"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K4wta5025801;
	Thu, 20 Jun 2024 06:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	hmYCNIzzd/shatlH14CoDfIMguS94rK9E3jAKvz2dDQ=; b=QHqu9iroqj8Ztxtj
	g+inueZFQmfusR/vs1eoGyTcagI9rWEnDrsNtr4m1yx0sJixmOX552atd0gg+RRc
	Vm3HY//QzWQ6pRX01+YcyngCGGVm/bF4eTv6cDufRPMnak/iRzqnuYVG2E3h3RE8
	fck9TDl6aeQ/5tyez1BMRSHyDYOEZAMye9bMe8Rz1e+pFUhArBatVPCs5ADCJ8VO
	VdgoqvB5VmdRFK6+mzTeQTwE8k1RNjLcrjO9NBUnPUG3Jfhy9uc4rdbKPF+p1cP/
	HQ9U4JKTzF4fTXS4xGJ54ydrYoEmzqzu9b7SQYv5+Re4FYQce+Q7uqBedASkjztB
	x0U5mA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvdv8870p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:40:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K5Aiu0013392;
	Thu, 20 Jun 2024 06:40:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr043078-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:40:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K6echS21037740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 06:40:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245E05806A;
	Thu, 20 Jun 2024 06:40:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2501258072;
	Thu, 20 Jun 2024 06:40:34 +0000 (GMT)
Received: from [9.43.39.114] (unknown [9.43.39.114])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 06:40:33 +0000 (GMT)
Message-ID: <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
Date: Thu, 20 Jun 2024 12:10:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, venkat88@linux.vnet.ibm.com,
        sachinp@linux.vnet.ibm.com, gjoyce@linux.ibm.com
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
 <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M_VTLM2jpijficeK4BYCFMJhY5ZbIx-X
X-Proofpoint-ORIG-GUID: M_VTLM2jpijficeK4BYCFMJhY5ZbIx-X
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_03,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=692 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200045



On 6/20/24 12:05, Daniel Wagner wrote:
> On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>> +		uuid="$(uuidgen -r)"
> 
> This adds a new dependency on an external tool. It should be mentioned
> in the README and added to the list of tools to check for:
> _check_dependencies(). Alternatively you could skip the test if the tool
> is not available. Anyway the rest looks good.
> 
The "uuidgen" is part of util-linux package and I saw that it's already mentioned
as one of the required packages for blktest: https://github.com/osandov/blktests

> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

Thanks,
--Nilay
