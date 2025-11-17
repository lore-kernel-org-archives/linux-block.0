Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A62D7DD4;
	Mon, 17 Nov 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374354; cv=none; b=m7cHsSYClWkgkV6Oe7sajVRY5c/pXkj2e9EzIhyZS2/4CLaqHys+kwzl1ANdSxet5mAvAho7mMwxQlT1Ow7A0qVAaWy0A/IrFY7D6nJKPYOB/Pe2w3sXjOiG2q2lWCNdRH+uxlHZ+kJ5Pd7uk+Ux55WLQNhDtrLO5IXUoOI925Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374354; c=relaxed/simple;
	bh=s1yOL/M/Rf5B6/M9gchATcDjfCB/COxVYmOGfuIpHF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pov/10aP26pBzy5TfEpGpM/RChpi8FdAIomqRrIpNYqdb9e9mjpWpXONeB9lDS6zJjYt3oXgpDB7VzuyHfpVO2Qc0RewMo13RATnEq4aDNskPBCLktQYIR1lcQHNa5jXY85IKZkimCDU1olrXsuSLqFDjI5J3c7bustqynYTsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bzxf1HWe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bzxf1HWe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGKl1HO025632;
	Mon, 17 Nov 2025 10:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s1h4/l
	ivnUIEMkP8r/tJuYIqNO43xBRzoWHO/V5g+I8=; b=Bzxf1HWe61cxItu3qJvkab
	+DKNnibiVtUx5VR8qLPxZ6o9ua6oI38AZc8AW7aaDwB6rFopW8YKpe8m9BTCik/N
	y5iSfESwNcA4S6WGNoGxPM0WTuawo21pJIUo5o5Hl8CRwa8yxegVAz3E12oXVBrc
	N5h6WnOxuJmd4MgHAaC1nNIxPMaibAOu6wwV0w552xqNvWTInV7IxXNETix4j67W
	0cuQvimwjlyeInOmPqwCxZNy4BuNp1Ox8XpLF6A/v19ZNbrMjz6WS17uROOk1ESR
	5kT+WcZRv1Ci8SuhcSsELX78XTPciaNvYZCBo6jpeGgn5fLQazNiS/UcCsyOTMCw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgwncch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:12:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH8efFn007037;
	Mon, 17 Nov 2025 10:12:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62j50up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:12:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHACKsX25362962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:12:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C51F5805E;
	Mon, 17 Nov 2025 10:12:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6122258052;
	Mon, 17 Nov 2025 10:12:18 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 10:12:18 +0000 (GMT)
Message-ID: <3622d80b-2946-4f0d-bb64-eb4eadf78dbf@linux.ibm.com>
Date: Mon, 17 Nov 2025 15:42:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/5] blk-iolatency: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-5-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251116041024.120500-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0jJ8JcResbEM97lukhOg0na1o7vNR0Fs
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=691af505 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=_oUg44UKUsW_fKanFwMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 0jJ8JcResbEM97lukhOg0na1o7vNR0Fs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+niSXKYZ3cpN
 xAiOWN8P/oMRf2NERbC/CrFY33X6knKTvyU/jF72a4dVhxaB3hj4JJzseGHKi0tBM/T227UpF8i
 vAJxyDKp9tL2n02YV9PRlwp15ajLBuLgOQd/RznnS+nNL6+6avYh8yjucst5joiaMmSUPiT99qc
 hQBEfyNkkEklTuP+p1Qjd2xUym6ZG3MCgndiTeQGaVdb9QOw5Vy8YJWyCJ5bbA8BKnfqovmV9ex
 Tu6qB8CIW1EBN6IPEscYxoiMap7oNIYt38j+VEd3Pbn41LF02B5WGt9F7FCC/lbNY7ItEYbawfj
 9DmpvBJUFUYmi56/buuNVpwMe53ezNMec8bnMB5nqr1PEK6/UR/UOZ0OqQ/0kcvV8QU1RgJ40nZ
 kPOurPhEXa2h1g/XNQUZwtRbIKjgpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/16/25 9:40 AM, Yu Kuai wrote:
> Currently blk-iolatency will hold rq_qos_mutex first and then call
> rq_qos_add() to freeze queue.
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from iolatency_set_limit(), and convert to use rq_qos_add_freezed().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
