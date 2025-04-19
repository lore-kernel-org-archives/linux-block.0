Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40B18DB29
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745066443; cv=none; b=uKwAyD/a9FxgtQqIku0jpydiPfcTa8YYDS98QMnBTZyTIJx+aPH3olb9v3o7f9JHdV8zJjaAmoi3Va45VREzpjTXzQr5hZKMCbY7OfKO62ahNK1BYUFHcwEnkqv8hI3mQ33KVrhQqx8DRaGo9GspRQ+RzSo2R8p/ndIKcgSpmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745066443; c=relaxed/simple;
	bh=ULvGP0Ul9tCT65JwmZPVYqlC+ALVaVp9dW14d4RXXZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBtC6qDiq1EyMqp2jKB7cguqcQbLoyJ2l1k+BKZMhP3VHOylkvLkR6HIIbrSy2f4w53YNE3lJ2zFT3GLtYpc3P8eJRbY7ReKqQTVx7MssyE2sAi/EgjmJrb+xUD4d2SJ7Rc5mQJHRcLJzrg8LMKqkWmvR6u6xA6xl3Bcv+fi27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pvDSWkT/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pvDSWkT/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JArNUm009730;
	Sat, 19 Apr 2025 12:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7LKl9N
	emfeCSCE9zxD0REsVZo3M9h2oNUT4TC2ed38o=; b=pvDSWkT/zGjvJTiLPreT/H
	6EPqBS4+WlqMfj6HqRiquaWQguqzznxjWs/RXufv3aV7QxuRUm4UXUqbU9UU+zRu
	v6G1AdnD+1HbQ8c2ftVPcl28VGutTP60ZAKECFR0wRQpWs/5e365wt8968FpofmQ
	GeujUytvnYtHPcQ0z4y9IYCS6sy2Lu7yh5/aemiGTvYlzbpQ8mX+oI7/yFqDWeAX
	4sw2wmErSVizMEG4wGgo+R+1oylODLeP7G0AugOcnyzGenTJyyb+/ksuMSeD8WB3
	1M5hDGXtXFx92Jo1hIp/ENCZ2spzLByR1J6yzS07A0ad5ySijjH0dbsIjerAGH2w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643gxsca2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 12:40:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J7cxrb005548;
	Sat, 19 Apr 2025 12:40:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4647kx0tuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 12:40:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JCeWHY28902032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 12:40:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008CF5805C;
	Sat, 19 Apr 2025 12:40:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19BF858058;
	Sat, 19 Apr 2025 12:40:30 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 12:40:29 +0000 (GMT)
Message-ID: <88b931c5-623d-45f8-bc7a-964917e38293@linux.ibm.com>
Date: Sat, 19 Apr 2025 18:10:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 12/20] block: add `struct elv_change_ctx` for unifying
 elevator_change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-13-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n1ZRxU8UgH3R83cHsRbmuxyy3GJ3c00n
X-Proofpoint-ORIG-GUID: n1ZRxU8UgH3R83cHsRbmuxyy3GJ3c00n
X-Authority-Analysis: v=2.4 cv=I8llRMgg c=1 sm=1 tr=0 ts=680399c1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=g7RrT74SvQRNlGl7mdAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190102



On 4/18/25 10:06 PM, Ming Lei wrote:
> Add `struct elv_change_ctx` and prepare for unifying elevator_change(),
> with this way, any input & output parameter can be provided & observed
> in top caller.
> 
> This way also helps to move kobject & debugfs things out of
> ->elevator_lock & freezing queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
