Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEA24C08D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585675; cv=none; b=VaX3SfjWfRIchJt3sceKi1R6N06dQkDarYvXGTf93FQ8oDTvtyxxBQ6qXd+nhZNFPiXFq7JQTdzmyEt4RJcdTzZF19V73hf1CCAdQ8//boZqcu89LdXEHxg6Xc9Y3xVUiZ4rL2JqW4VA+WBZIGVk8S0tTXX2Ypp2pISVKNjwmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585675; c=relaxed/simple;
	bh=6Kb8diaKfr77tZmKSkOnSe7ySTloJivHyVilUkwG5Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWT2GyjIrdnouYm31+Z1/UJ/luX/F9OzuuO2eHSKK1US5KHtQwddmqYIzkR75iFWUCzm4a1/UulwYiFKWMVtVzBkGJP4nvzEFdz348vciNlT+zyZvG2JYi7aApGd3sqKrf+INQ3MZiHxfydYbQtPo0DPyAp6SFLIYJv65ilpCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kFuoogXv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kFuoogXv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA1wZb006660;
	Fri, 25 Apr 2025 12:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ezCZAX
	Yn1UVV2+EakdnPE7g/cH+VTsHf15YSWdrRnV8=; b=kFuoogXv2+cgkRlqwSKZvn
	nrEjAOOk4JJUxpf1cy/NR40qm19za0/3e5iOsk7pfsLu/iYi2KcKExQFBrzTmc+k
	ePd7w36ojSikR21VkZq7lSP6hu9t1Ib7sUl/tOHejKjHd+qoyIXR0lX7nlnpFhj8
	r6kFj7+CtwujJz8ZLWrskKqzHsyT/jYjL7uGRdTWMl1cG3fgQH+0ytrrZ2FEBV/H
	XEtmDNtsA9VKROIeT0eqhmnGTIIdaf4D4HJxuEzrsY27OiV6IjaELWLmQ/vNPRrT
	b05QdGszdHOgZm2SIYPwV8/0ma/cJ+g3LmB7PfJHInH4IP+qmFfx3R4z6ssQe68Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9kas2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:54:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCdEUP008670;
	Fri, 25 Apr 2025 12:54:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxw8x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:54:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PCsKLu31654428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 12:54:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A6D58057;
	Fri, 25 Apr 2025 12:54:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F88F58058;
	Fri, 25 Apr 2025 12:54:18 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 12:54:17 +0000 (GMT)
Message-ID: <2ed86276-1c3b-47fd-9716-0c5eb22bc778@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/20] block: move queue freezing & elevator_lock into
 elevator_change()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-12-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SK81Z7HcKW1naUUlkJrVe-eDyFtHfGYW
X-Proofpoint-ORIG-GUID: SK81Z7HcKW1naUUlkJrVe-eDyFtHfGYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MSBTYWx0ZWRfXxFiFrnS/XHcp 0EjduTsJInprNZwYo4iJu0Zq0cbn/zYgXxMKWAy4bRrLjZNmTA27amAoyvGTXpwW9bnqXyeMnSg dT7pP1KmNrHY2Y7uiZmJCff4cCFwbxyciy1BhFK4ACjC3Y+/v/JDLnL9MPxGiyKi2NloP010Veo
 EjfOlTNE0rB/Xr8AXwVVlPBxJ/rgYqikFaZ3NeNq8XltJeKPvq4LUxPsAUHkUvPwnzEUrbjKdlx l9bwFExYrBWUKjo27NaM3j1LQJhd1EhZYK/Pn70o+QaiFMC+bC9v2YcbHuWmkkY7f1lUvNcoui/ oNhm/Z/RTUc9vvicPrTv9frkkALSVNqwNgS0TSvQCTPtbnaIWq7u7SVP9mfAQacgglHyEuy+Wz8
 4l3xQ0KK57Ifuj0ST+agPE8JfC3P8KSSa0UwRTP7LpNfma39MH8v8vUyKnnk9VFyUb5OyJVo
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680b85fd cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=KmxriiqL2ezpLREnnaMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=834 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250091



On 4/24/25 8:51 PM, Ming Lei wrote:
> Move queue freezing & elevator_lock into elevator_change(), and prepare
> for using elevator_change() for setting up & tearing down default elevator
> too.
> 
> Also add lockdep_assert_held() in __elevator_change() because either
> read or write lock is required for changing elevator.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

