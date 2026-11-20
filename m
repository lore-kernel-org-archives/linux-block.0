Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197618;
	b=aFvL/tNUaOF83foXKZAdGX+skZxokZWAYeeXtmc+Qq+0MCJTI+U0MdHay/w5RNnMmbk/
	 qsDA3225ZXU1eE/q+mvHy6NyBkNOliBH84l3qJUhuYPKZRbASv5PGRpvifow18l0vnchR
	 aXyn7IceRYr9b/C08iJLVZXsBuBsfu/NlaSw4GqFj4p0pqc3/GjeoQU9X5duqnpX6XRZt
	 HZS8azidk8Oe3QLjZGsOR0VvlXA8ejnnW6fwyuYRqi2/I4Np+jHfOnxr9MtHyhaBZgn1X
	 TvnQMY3OFPM2XCACtNim4dy8a51ZFBzWwcZejGTnZY/G8JQel9Tsu2zEY+36qx5nEgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LsOMxX1UC5KShfKDwijuDHl67flUSyLONj5U1Yyo4Lw=;
	b=czGfnQpKPMTayZTOv1IXALFxj2Wc/2TlPh4biMIsOh2FVmwiyRJmG0GCSiFx598YeIpr
	 fQx+1TeMV1SvTaa+RInNzmgqO2LWoKrOblyu/WwMyC/TnpFDpfFosa7RKAPGpf8adAsWS
	 uRdqD1CdRpTe/8ianCKMbc/S64vjE5c6g4zLbDjE9Yf/mjppEVZzzEE/rrMVyzIjAi8wI
	 uZIGoxdMGycRe5HLESuj16vX+L50YXHhGrbN+CDmMW7bl2lXB9WW+cbW8E8GMR6uZyq9d
	 yXkgjX+8l7WVfWktDa1CjMvRPt4n3ZDYjbKceUTGL6+yCeKfq+rQBAQQfADnEzqqdfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR5l3EhC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28860A2605
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 18:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD28860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KR5l3EhC
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEuJVE2177753;
	Fri, 20 Nov 2026 17:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LsOMxX
	1UC5KShfKDwijuDHl67flUSyLONj5U1Yyo4Lw=; b=KR5l3EhCpe3en8e85hEqxY
	ZNR2c5ixJuQXgv9XtsvyEixZSIvZsfICTeQNYRa4dwCB3UnveZzunYr60uEIIepF
	y02g92utv6BhOLj0c/KEEW8+VObk6sVI6Usj39eQFSL7zBZ44WXeyuw3e/RXdlZp
	GaxrUzHjtmqrEKPsUH/ApPTyN86xQes5T5QTVeCwwswFPh9m1ATXMdCSmCBmuo1k
	+kthGHpEnBR6SlQsOvHda7E0CocUGXYPwvW96mZa6ZOcW+VZvlOg+kJgupW0HTRp
	Etbp865+pKxVvIubXNmt2U+LpLK+gK2qvl4eBi5yO2kig1qaSyUdXVmkbPYMkZuw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w9rtw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:59:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHs86t218769;
	Fri, 20 Nov 2026 17:59:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xhhxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:59:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKHwvU215139560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 17:58:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6995805D;
	Fri, 20 Nov 2026 17:59:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D9858043;
	Fri, 20 Nov 2026 17:59:46 +0000 (GMT)
Received: from [9.61.150.232] (unknown [9.61.150.232])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 17:59:45 +0000 (GMT)
Message-ID: <b0e5778d-a7f9-486d-ae8c-01b7d9523c53@linux.ibm.com>
Date: Fri, 20 Nov 2026 23:29:44 +0530
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] block: rename need_dispatch to
 piecemeal_dispatch in blk-mq sched
To: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
References: <20261119071728.3145752-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261119071728.3145752-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3AWVRoGm0I5PnYO528YIm0WlJJVl3OwB
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6b008a96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=MDMhBAIpWWJb_zw50SMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Pk8akI_k6Gm3Kc8GfBbgBjonw9fYL1AB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfX8T2ALmCLnYrK
 ly5CSltia7RNfdV1rpN5GBJhSvnj+CeVEDqvdaL7tbO6NAB9gMxFEhXtK0GVjNYOgJLOklyu9Mf
 YOZ0boj64RVQijld7QqvvGKF5A7BMHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MSBTYWx0ZWRfXzbFfg/eE2436
 FA2YMjqz+z/lycNpc/Dxa8LI9Jr/IIGjhRpP4ZYKUF/7sJzYXJyGb52r/Io9UsUgwJxsOZmZihH
 Nl/Im4Rc8rKns6c5sFFMmnP7ZlmQBTPXLk9cuP32h3HdBZfYIP/IWdxEIlAmLN7V72ArLxzby6b
 HieGiOwC+h5wk3/Y5PvD0TOOVRYteRwsa3TbYR2Ecu08R6Meq+shCfAqp2TyxwnRnOp+ZTihwiy
 2rwMWmEoBwrKhmeNjHxw9RhpGtBFHeGv5KnaYyDDPBD5/oHyGqkA2S1+/8C34O+LAXVgCMCTInb
 lONkeE57uBRmzxqsK8clO/8KsQGykuBDaXDb9PhkBda/BQcj3kV/xzITqVY+yqZaGlJdTNwmg3J
 Uy800on5b9Ltdszzs//oaDIML2eeGCMJTDAgJxKI7OO1sKYyyG6M7xZIs7it/iGBSizAseeKDRg
 nzIf4lPicicx2SIl9og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200071

On 11/19/26 12:47 PM, Guixin Liu wrote:
> The local boolean in __blk_mq_sched_dispatch_requests() decides whether
> to fall back to the per-ctx round-robin path (blk_mq_do_dispatch_ctx())
> instead of the batch flush path (blk_mq_flush_busy_ctxs()).  The whole
> function is about dispatching anyway, so the name "need_dispatch" is
> not particularly informative and can mislead readers into thinking that
> a false value means "skip dispatching".
> 
> Rename it to "piecemeal_dispatch" to match the comment right above the
> check ("dequeue request one by one from sw queue if queue is busy")
> and to convey the actual intent: take the piecemeal, fair, one-at-a-time
> path either when we just drained hctx->dispatch (so the device has
> recently pushed back) or when the dispatch_busy EWMA still indicates
> congestion.  The fast batch path is only taken when neither signal
> suggests recent backpressure.
> 
> No functional change.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

