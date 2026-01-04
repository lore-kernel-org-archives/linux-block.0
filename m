Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0F12FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544698; cv=none; b=PynVkCEswki8KDxOUt7f1bWWGL89/MHSfbAv+VoXJbNj+1fkLVbMBU3O4ZqZmZczMmoaMN7VACFzcaZJMyUY+v9WyO1eKfvLXEyNwVGgB4Pa2RHV9V4xbySAbpyEG4vBjOVjjzygEU1B/FnAlYiXUjq14ghBRnhy90VNTUbN7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544698; c=relaxed/simple;
	bh=C0bOM/iWB8wyZ1HrtY0GEgPygZVeP2tTL2Nb2zIhSiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GVghVI4AAreqRag7EgwfwBH+v57VOzZF0fkadA8SmUwwcJtqQFWm6dpJUDeIlBG4Re6dPWduOqKacHQMN0ZBjL6boBsZMT5w7+EfZkqph/d+X/WcJ0DbG7LEXJfGzdblyms5u7yl8aAUEXC6767BDXPPsU5xyIRd3ru9Q4+D8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NJKCmsbM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NJKCmsbM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6041rLkN027096;
	Sun, 4 Jan 2026 16:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RdEWFg
	7b8Z63urg6B1i5PHzSsMTZ67WihcMTPb0Me2M=; b=NJKCmsbMFVJ+A/Hx+c/eYm
	7KScJSDDHFl5Zxwc9IaBG2j/t/ACIxXaRFigergX5HGVfNXCWx5JaHGvWi918ibt
	hvaGKdjQTeM8ryDiGIEH5LgiYr4HsQa+9IaKi4BqDWHGPYJK0IknBox5N/bJUPd/
	a1ocnTx6NkU7rHn561zmjQq5YonLUBnqzsNQkYEUlQJSppc2BId0WfBXdFNHyLFV
	7cs8935LniRDvYYHmYkfifG7tfzxjJThRySVEd2apcUo1O7cQSV/D7NkiiKkoSEQ
	ZiYjQkvUfaHG7L7J83SMXCs++qXoGU9SDGjjQ5HxnbEBfLMA0XaDqjvIpEFSdDfA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjuxmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604FgVNi012590;
	Sun, 4 Jan 2026 16:38:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj1vb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604Gc0rO55837088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:38:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F9B58053;
	Sun,  4 Jan 2026 16:38:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382B958043;
	Sun,  4 Jan 2026 16:37:58 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:37:57 +0000 (GMT)
Message-ID: <3988a5d5-caba-4ef3-aed0-42f2f2f963b3@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:07:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/16] blk-mq-debugfs: add missing debugfs_mutex in
 blk_mq_debugfs_register_hctxs()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-8-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-8-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695a976a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=AEYaNwp6QZsth99Cp5AA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: BJeDn5gjiSv7u-GsWy16S2WhG-1H1AVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX1iN5+f9bmhJD
 U5COl09sUIel9f5xxYNEEajfTG17dqLu3PYdxx3elufA5QA+XuNaLAL+U+qAaKMxL+fa93J6C05
 7mUS871A02ZP3gs8rbS3gk+v6Pr+tBvg9Aa9HuD67AyuO+zzUXkJFbylwMVcQPWdWIBfUOQzEYT
 dd0FU0znrnP5vXnyxSeH5MAuVB4atSATh1DhO/Oh0QMGkZZ2FLmDdpOgi1A8BF7PYQeAuApY+6p
 LY9cKAeT/9dF/eXa/4e+gM99kbAqJSIauQ1M0HEuFlprYSREsKE2mwRYJGMqPXDPcQFXxKsBJEZ
 EjRxyCb0mANBlkY1/TS7qjoRjjqemqp3rpef2BrWZqRK4B22embX8RfTyAeB9Sb/hAFuyWXf+e3
 +RVDNnVhwJq9a/VZMxO/dk/H/dT0bi6lc10YaHZzTbZvxgGX0dzQNRb/b745VR+sWqdynqQdKWO
 LKQSqiTpoCxCj6Og8XQ==
X-Proofpoint-GUID: BJeDn5gjiSv7u-GsWy16S2WhG-1H1AVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
> creating debugfs entries for hctxs. Hence add debugfs_mutex there,
> it's safe because queue is not frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
