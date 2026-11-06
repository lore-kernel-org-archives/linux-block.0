Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983630;
	b=HFt8YL30NI6KtirPTKGnYXMGRwULpodDjAbJyUyQfmuv4cu4nFOlAfLoj9nG+/aotQ4+
	 0XQ2/6TLM1RzQmfisya34uWWuwwls1DKnAMhsyip81j6uMhI7VcaERyW8m3Z4Et4dcZVx
	 hHjIHFB+8j2P4lMieH8s/9LCzN6QzvMOWEpK1Hp6Mu6iKvzQy0xysQX8kiazmui9BsQu0
	 4/vDwwdnftSScEaspBlc1HOyF09/QxV+zZ2II/WEMkE8bAZ3+nQxcVSj0qFd2B06YhXLr
	 jcRnaFpCOPfBvWzfqMRuOmo8pc2x8Tm4VffSvxZERe16glXK3nrFVhxk22OK/y5KLoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983630;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=6uvy8Y5PB5BogqHXs5KLBY6brLmXOD/GskiecvLqIDE=;
	b=klrRORQZcrwg98WVKI0neiaDJx/7EWrBOc+nfLWi4XvAYh4wVnja0dkGp8KARarloYMG
	 QR3Zr++tJpD+bJ/UxhACJ6A+olD+CHmQP3nxS7xCufJfvBASDM66diN0GDh2a00bmVz9z
	 36f3dntTrOw0OTdmJ47PbWCHfsA4cMJuv4fE5LajFhMjzsf6IWAVvioF81G8GnLYLJoAD
	 kKOH/q1RK+piD9s670N3+t/MSvFzXRU1kqUm9m5RAMv9zNWpKV8kk796ZTr/RRHkXkvdO
	 jRJ7EYH951w/Ppt7/zAN3B5a/az0Ml4DNPk5qBwPITNQGu5HMrbgRM9iGpTp5rQKxHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CA606A326
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 16:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GX1te2699763
	for <linux-block@vger.kernel.org>; Fri, 6 Nov 2026 08:47:08 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r1cxme-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 08:47:08 -0800 (PST)
Received: from twshared16865.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:47:03 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 25F732E8C811A;
	Fri,  6 Nov 2026 08:41:35 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Qiliang Yuan
	<odys.yuan@gmail.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <hare@kernel.org>,
        <tom.leiming@gmail.com>, <nilay@linux.ibm.com>,
        <shinichiro.kawasaki@wdc.com>, <stuart.w.hayes@gmail.com>
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
Message-ID: <179398329515.3869217.15545511916631956024.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:41:35 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: roe-_HJQjAhvCjwQ6B_ehblQxXQMI9v-
X-Authority-Analysis: v=2.4 cv=RboFmFtv c=1 sm=1 tr=0 ts=6aee048c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=795gGRjyxyIWziuDvicA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: roe-_HJQjAhvCjwQ6B_ehblQxXQMI9v-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX66qF/tNMjw8e
 56gV/bP4oUIG9dK3tsL1g4MefHbBANSTSST7Pzm8gNWfN0hUH3CUnwbuiAC40PtrfJcirbqKA/o
 CmfH/bV34nxj+RXdu+ocm0g/+MivZME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX3JoMAFLdW/Kc
 SGH1ohjk9wsDJSPqa61TGo0o2WRVmKuZ+UFYzon3FGbTGeviBjxeLRQArz0gBSonWOlpo+dYsfJ
 RdSeyoshhLMr4EWoxS6C55Ad4QaixAcfVjPRMx39aKq8qkwNp7Yt+HTariW4+kkwDeA1CmQTWX6
 sfIysXlCHci/+MCGVn7TLYCnsN0xK3TzZ5WLgE9JAp9cxUsCdJeJu+B+H3ov8zLwNjTmpCQw6S0
 zz1gc+FJtTsuKDtlwc08wUwsp95lBV/OdS9BOYE9FONcD75MmZ2yAy2xwbo/JKratoQBBjmzeku
 k9YU9jeFeILOyfRKaR82jA9XOgmD+3/bNKCtTNvcIvJqiQLdZxvZVon36YlUYDVjYvv2ytMDkCG
 1awUL1fSssjchGNJk+VJrgeMd3BPqmCHSHLZeiHheuPRk3OX0zuZs9pIjWQVinzrQsLHzGzBhL5
 W3wx4Co25pkT0gCPb0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01

On Tue, 03 Nov 2026 01:28:02 -0500, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: remove namespaces in parallel
      commit: fc991838ef25f1cab9ff34b55b39f16d95ed39b3
--
Keith Busch <kbusch@kernel.org>

