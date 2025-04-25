Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149124EAAA
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585429; cv=none; b=Sl/hfkLH8CvqP7BLNMUpIUkvKah+QrfZxLGkAtOnNSashqKvTI/Q3ishsNkaiDNPf5217jQ+dFOHjoSgRP2NLCKHUi5IFfoUeJLLpIGx3igT5PR70SrGfgNaiTlt1Cg4b0IvCJkprDsN6ovGhVlpULWw9yc1WK7cn0GEM6gky+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585429; c=relaxed/simple;
	bh=wiBXqYDKwplZBXiFFKDIHHXdA9jnaFfWw3Mrw6ffTLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqD4VxO7EiKzIkLW18UPO/KxWnovvxs9/jA2488aRqdxOOuXqVUFYAJqWKboy2ALViYSESa81w99jP+0tKLu090c0sKlryZGHAz3bwt92R/HYAIyCZUqSj0+cmCI1up3Fp4xVRuoZjqpErcohbDIyoggPId9gWPpk5/jThmInlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q87EM4z7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q87EM4z7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAxOf9004039;
	Fri, 25 Apr 2025 12:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d5nFx2
	ZUbQIFOcvj9c0fCfTDQo4kW/ttfL8hahkg3ik=; b=Q87EM4z79mpcFM18NnUCVA
	R9hpav/SOCFnlWVN35661jY+8Gj9Ha1LmbGayhcZNLrP3KHqiec8iFhwjMyreH40
	YWyRdYMGTcQxWZrbsN2inxEj0sw7GH8v+drsadK/Pm+eokBHEywHO1aA4cSo+w6U
	yp13StD/ulWKJXS2xBgJVhgdy56nWpNrMPb+2k7HHWLsCCfxHWFVh3332hZc8LOp
	Vp941/bBFAjyKsgqP6HlwRmNWciFa1CyDjTFFzqKw6AE+QJtPc+NAXJjOdEdzHZO
	E93BNcTOjANMbFTVGeM+dIS++XDiA0/wd+iEXbQqopBfKQCR3wUFAve/lCx7eDQA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wew37qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:50:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCU8ux004062;
	Fri, 25 Apr 2025 12:50:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg058eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:50:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PCoK3126477298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 12:50:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3676B58058;
	Fri, 25 Apr 2025 12:50:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE8BA58057;
	Fri, 25 Apr 2025 12:50:17 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 12:50:17 +0000 (GMT)
Message-ID: <5f2fdaa7-e843-4e79-b69e-795374c756f0@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:20:16 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-11-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MSBTYWx0ZWRfX+BLJ1eGnNmMH ftj3sKuQBiV28Wj53uFhcv8jYZVPYPS2kbThhvSREwpfQYFoM0kMX3H4qbWcr5QtzGsOrn11l9B bCWbJaQxR1TGCQX6rv6+ytJPocDr4NQH4QRlf7JQWGPm/zOPWsV0JCN4oNHWZIToRi7iYgA9RfU
 EsCxeLBvMBkDJ7w0EtSUpGdMmyeUoOc72bpZEPkp7EE8Aye8FOg5U3itWxLBLk4AOe+5qgnVwKA 7M1gjapBt0r20+kyw/aC/bTyEKSTU17LU6F7ySrQiKz4M5Hwxgu8sbvzOZqZ3fFDGyhxHfri7Wm g52hlVvxYqajmNF2YtEUzCaRb370xcqdi2VbZnM4Pnmh5eQBD7+iviAYUS+Rvc5bIPbINvAvGOU
 RH+QGRTogejJCgurVIPtNTlUrYfNo6sT+0fA0CeydgkCW6yzHns31Tt/lUEUrwBiQUabF5P7
X-Proofpoint-ORIG-GUID: TzFyE_rZtz4XAU3dGHA2NEnpjsMFBxeM
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=680b850d cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kaoldDWLg75tHDjwJSQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TzFyE_rZtz4XAU3dGHA2NEnpjsMFBxeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=981 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250091



On 4/24/25 8:51 PM, Ming Lei wrote:
> Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> for unifying elevator switch.
> 
> This way is just fine, since bdev has been unhashed at the beginning of
> del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> with kobject & debugfs thing only.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
