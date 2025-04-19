Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3E4690
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074375; cv=none; b=HiAG1ooJAEluOoZzLBHQ8K40AtNmn3cryRj7Ab5mrPqwM9lM1NuWN4XgKSZthKNss3Lzo5UlC/k+nJMuRVIihTwsYR3mM9iaJFfSN0Wh0RXQC+gOENbF+JZzcBjIBvGaJ7vc9QXAbAjr4sHZrYuCryU4ajDP3rvoiambyLxDmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074375; c=relaxed/simple;
	bh=zIHXW+7eYqJwPQsd4zjC6aBjJW99MYMaeJoqY9oiia8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9RqWRlZ+xdTJD0zYKg+wpFSphmd9PCewwQ8cU4buJjU6pByM6b+Fv8RNPTQeQVud+NKJTfBFEzXnR1WH0pqpV25H/k1x90OSFxUSe24SOUxbPnYo8wc9WTaqoW5KQpfRfWl63gRzxIk7Lk1XWJecjlppNUk1TVYCtQtk0VQcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZwPxFCxK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZwPxFCxK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAhT3G013755;
	Sat, 19 Apr 2025 14:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtP5mB
	JmDwdJNfftJZsJRSRlv5EA7y0B3XKGuVynf54=; b=ZwPxFCxKCBzZLEdqjVwH+I
	uDuuQS1Ssv05M2m4dNT54aACb8wlIr2PRaphSc9xYucRVTc2bJWAJaS9qAEVYym/
	ZrN6nET1/KiM9yZfRVXbmeOhwrKfYVH9KEZarmd8wMuJIRiyU4FrRLHddUvz/RhP
	3CgdZr5eiCPPwoO3prCb0VQpOSwV77Nl2urQKCFDn8p+XqWp6xhMYeavoW71sNPw
	jNnewWoU/LQH0SBinW09qcAUeqOmTwbRkZGIQfo81J3BXci5dqdlvDnYmU/jqXqd
	C8B4MX85KyjxGmLFUGIh1s7KiJHjO+qcCCAOi+MASpY97wtTKvHlcrdm+Qbzcjyw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464a9rghu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JD9lR5001258;
	Sat, 19 Apr 2025 14:52:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0fy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JEqiu019661316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 14:52:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 800785805B;
	Sat, 19 Apr 2025 14:52:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB1B58058;
	Sat, 19 Apr 2025 14:52:42 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 14:52:42 +0000 (GMT)
Message-ID: <a8d82511-2957-40ce-ba9b-754cfaf9b72e@linux.ibm.com>
Date: Sat, 19 Apr 2025 20:22:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT as request
 queue flag
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-3-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: goQO1xbkuslJItdKSmPelm6tcAcX_Bj9
X-Authority-Analysis: v=2.4 cv=WJp/XmsR c=1 sm=1 tr=0 ts=6803b8bd cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=CM7IgfqPxMKTh3cUqF0A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: goQO1xbkuslJItdKSmPelm6tcAcX_Bj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=906 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190120



On 4/18/25 10:06 PM, Ming Lei wrote:
> ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
> in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().
> 
> Making it as request queue flag, so that we can avoid to deal with elevator
> switch race. Also it isn't graceful to checking one scheduler flag in
> wbt_enable_default().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
