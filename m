Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B963FB2F
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621777; cv=none; b=r66EfJ23+9B2DGZMfgc5QIquaSp+cF+YZU1H3Cb9E4+INFGZnzfY0N7ueJyOX7flAbG0ADLS0P3hF+bnIW5BVwpdsixGN/WWm5CwFLiXSj0nEpCWEc5vwqPxQeghc+008IRtIMwWQVfc2Vsj0iYQ5aa7XghqSHL36bwq+4IYPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621777; c=relaxed/simple;
	bh=43N9sriE0JyZZ/vNjdD5EnhxRuczFe/dCi/mk3cqCsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTgSYPPNJ2XXhQKkFArMnQn7wvRPAUY6Wvkvg8dZefodGfLh5HZKjl9SIi/eEEFEvCwbLHOjWvhfUjnhiOGEaLDS3wPyxkMFFI+7umXqytmA77dMgKmvhjmNLmIBT/21TNRBu9xACehY15qXxoBOecKS/KYYElzX0s9/2qYLEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E+xSe1GH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E+xSe1GH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8N31S021057;
	Thu, 28 Mar 2024 10:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=keke/RHsgLPtgpV2YsTbNo8QH3RGmjjUM7GUT79SdEQ=;
 b=E+xSe1GHwCbRytNAeTlrfH8e/7RPusySPi7kwZiuiVbUZxDS7Esvj+EuGLTI2hj6Ncfb
 ptPfW1XDt2ZoVaH1K23LPmopRKJRaWJj5QuuyJ59iKosZIUo4ZU4Xtj+pRmqKaUiIGy6
 QwoCOD0w/IASTEB/QWR/2bj+UOITuL/1+jVmuoE9eRpulUsp9AgGuyIOPP0jeo37l5ll
 WvlAqwKLBOAZKGN9nJwZDea06ZKC5Si53LmSEXiKsF8YTYi4cDcRpFTTINpkeixQnkXT
 kf9cstaIn11VCb8IONNgtuR0dBOQnNO4kJ2/oeByhIrbkQa2kzEKy2CkrpQfewjtHk42 cw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x54ysg9jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:29:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SAD6c9013370;
	Thu, 28 Mar 2024 10:25:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0w1he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:25:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SAPndo15008304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 10:25:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1DF58056;
	Thu, 28 Mar 2024 10:25:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FEF05805D;
	Thu, 28 Mar 2024 10:25:47 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 10:25:46 +0000 (GMT)
Message-ID: <4f10606c-654b-4ee8-9a91-a56bf49e0ecd@linux.ibm.com>
Date: Thu, 28 Mar 2024 15:55:45 +0530
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
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com,
        Gregory Joyce <gjoyce@ibm.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <20240328071552.GA18319@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240328071552.GA18319@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3rJ8AFXgT_t-lLcXdK0gdTmhVU1zj8XI
X-Proofpoint-GUID: 3rJ8AFXgT_t-lLcXdK0gdTmhVU1zj8XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_10,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280070



On 3/28/24 12:45, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
>> One of namespaces has zero disk capacity:
>>
>> # nvme id-ns /dev/nvme0 -n 0x3
>> NVME Identify Namespace 3:
>> nsze    : 0
>> ncap    : 0
>> nuse    : 0
>> nsfeat  : 0x14
>> nlbaf   : 4
>> flbas   : 0
>> <snip>
> 
> How can you have a namespace with a zero capacity?  NCAP is used
> as the check for legacy pre-ns scan controllers to check that
> the namespace exists.
> 
> 
I have this NVMe disk which has a namepsace with zero capacity.

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys2     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme0, nvme2

<snip>

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme2n1 /dev/ng2n1   0x1          0.00   B /  46.01  GB      4 KiB +  0 B   nvme0
nvme2n2      /dev/ng2n2   0x3          0.00   B /   0.00   B    512   B +  0 B   nvme0

I didn't create that namespace with zero capacity and I didn't know about it until 
recently I upgraded to 6.9-rc1 kernel. It became only apparent with latest kernel. 
However as Daniel mentioned in another thread latest nvme-cli wouldn't exhibit the 
issue I reported. And I'm going to wipe this namespace anyways. 

Thanks,
--Nilay


