Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE43CF65
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872129; cv=none; b=VJX8y6RTTMDNAiGp7BgccINY10FJG5nH8d66ULIw0uKCxLXdHnTfYlYxDTAlAWgBW/hBy9bl0uuJJsjKiLP3ZH6C9QbLK2ucQwyIgXFcdoF7O7C7h2MRy7ZuEy9DTBeSx+H+/tghjUGn5pV8uoBjTUYxdx+6/ixamdX/lGvWQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872129; c=relaxed/simple;
	bh=dVn5Bw1bVgTHpDPA83GvDLheGsxnhDsfZHk2KFl6cw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NxILjuU+ZrpC+hpCScPy6FodK/aKLXulnlOW/hXI/kTVUnnE6BkP/U11pyoKVqvgWHEC+zb4impAQLWOLQLzN8BzLVR/kbD5ESpUAvMiFTJIIi6GGmdGcPK18c1EsRldEDut3WihPx7CnJtDOYcd65KhAhKYw3AvVhPkqaCUygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKqXwaJD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKqXwaJD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K8SMBk012665;
	Thu, 20 Jun 2024 08:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	dmkn7pNoXvL/qudaa21sMLOq3EG7vGda5G+pgfuP5wg=; b=nKqXwaJDvkAVFomY
	fEBARHhcoxhTE9g2QYK4kBpa7PQbOOfzmoe6zPozw2YbqnUZIycpY0TTn5zXs8Ed
	OCVzfhFF1tqLTL8ZRgjr5LGptECriyBLd/lX0sLRXxteq01gvTRMvW4MWCC67Exx
	9gDbcwMbcp7UulvgiENZf0xJdJwSnz0urNyw4yRj5KnVMJZEM3AY6Fd4grGpVDYT
	TNN7m3/MGCAGEnqrO1lrMMZhbZXlMjsSSMy6vTIdVppH4JoTHiDoHdiz0k5BmRc2
	eYut9aRmRsxYyfmASMAYN5+kK4v1lp+daqfN7PCqHLmgXKafuhoHj7ySF9uGqesG
	JWMYgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvgxm800m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:28:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7FA08009411;
	Thu, 20 Jun 2024 08:28:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn3thp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:28:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K8SHdJ62783982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 08:28:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AC258051;
	Thu, 20 Jun 2024 08:28:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 489C258069;
	Thu, 20 Jun 2024 08:28:14 +0000 (GMT)
Received: from [9.204.205.49] (unknown [9.204.205.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 08:28:13 +0000 (GMT)
Message-ID: <2bc331ea-2514-47d9-8a58-8e682e400272@linux.vnet.ibm.com>
Date: Thu, 20 Jun 2024 13:58:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sachinp@linux.vnet.ibm.com,
        gjoyce@linux.ibm.com
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
 <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
 <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e8gBd7noQxOSON7YsueNmao_j5xyvykL
X-Proofpoint-ORIG-GUID: e8gBd7noQxOSON7YsueNmao_j5xyvykL
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
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

Tested this patch, with and without the below fix, and observing 
expected results.

https://lore.kernel.org/all/20240613164246.75205-1-kbusch@meta.com/

Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Regards,
Venkat.
On 20/06/24 12:10 pm, Nilay Shroff wrote:
>
> On 6/20/24 12:05, Daniel Wagner wrote:
>> On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
>>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>>> +		uuid="$(uuidgen -r)"
>> This adds a new dependency on an external tool. It should be mentioned
>> in the README and added to the list of tools to check for:
>> _check_dependencies(). Alternatively you could skip the test if the tool
>> is not available. Anyway the rest looks good.
>>
> The "uuidgen" is part of util-linux package and I saw that it's already mentioned
> as one of the required packages for blktest: https://github.com/osandov/blktests
>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>
> Thanks,
> --Nilay
