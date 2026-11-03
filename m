Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685261;
	b=LeKFm1CsxsKLkFJ7mUgVTPX7xZwhaGLTPOJ/twlVChIuz8K195OckMFTA9X2EftdhJ4Z
	 UQ2cSDeXT9fYm7olLTE2t7cnCFor650fj46RC+XjNANrXPqfY/2ocBVEXL0Wf6J3hXdXO
	 ejVMGpDPmN0cf38WwCzJnWbrgQhGZ+LC//o90nT3FC7qiC08M57+4TtcqwJA5dRBml9z/
	 VSXivsJDLcThq0qCDAoQ3SGN/G9i+WpxlON2CUOjh4tjKMuldRy90O8hSzWqXfqUcZuxO
	 XtxG/K7tS7q+FYHeODl1WZp7B4JH8G0TIr21S4cQGn33CrRbMFce9Z3NEl2nITG56gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685261;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=19Xmglr3EckNw+SbiaE9to29kj/Uv7Cs/KIXA7qkfVU=;
	b=TvVpVCOVP07J2a0p4e0rk9nhgRFuDxRDcxJ10+1c5nd07c5gfawsofR8O+ZrNK9hjOYz
	 fS5eVXRj8nfBD9M+kqFnhWziPcboBhyoapH4uuUPT/BoWJrOJv+SX2r8GWzPMwLLMLEsh
	 hCPZFFNVseA0xt3uLjrtP88jYFSmDaDXl+tRcDmvrEEShbgmhU0E7cxpMi3rhITRj8anA
	 iAbr5E/9Vk5m3PPUMNNHjAVNBEFtcu+D75aPDMAKPQ8BX+OIReFj1O3lZ1JTkNW36iYiB
	 XMcBR6PCNYaGSG04vEnYrcemMQhCOw6LSOklsk33HI16YigSRNk6C3CZ4kyNB4YjxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qSD4+6kB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D6606A329;
	Tue,  3 Nov 2026 05:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C56D6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qSD4+6kB
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31iIdY236026;
	Tue, 3 Nov 2026 05:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=19Xmgl
	r3EckNw+SbiaE9to29kj/Uv7Cs/KIXA7qkfVU=; b=qSD4+6kBPhaSO/tTF56Qdw
	Dh4qqbrOPKpihQRlxF1l3puCfXLRbsWhumohZqmJvAOV/3ZVigq+p9SC5vozeMAW
	mKrAx7mQhlGh+HIeqHMIibZOlf3TmbiOULY/Oxv8Cluukto6Gjn1rB9sE8jS9sp9
	q2booqxeLdX2KINfjjxQnSM/iv8LAoa/fTNgwrJaAwEUOSe7/ROrzvYpGzrarZgq
	oPOtV6dHv16BFpnUDEs4K1I6w90SMxbSiw08MiemwHVGRSIF0TNKch5dbIWl7Gvp
	bzpwVMuGltmVUROcvZfBQ1L65SOLriUbeCwHCOdVwRjhrjD3S9pi35O03vD7WuNQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhm55a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:54:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31nxEe1838940;
	Tue, 3 Nov 2026 05:54:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwby0rfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:54:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A35rG5W27263522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 05:53:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0A8958059;
	Tue,  3 Nov 2026 05:54:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522FC58061;
	Tue,  3 Nov 2026 05:54:01 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 05:54:01 +0000 (GMT)
Message-ID: <44b0d0e5-b14f-4e6c-8e00-16b4af712b7d@linux.ibm.com>
Date: Tue, 3 Nov 2026 11:23:59 +0530
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
Subject: Re: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read
 lock in del_gendisk()
To: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
 <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E5XXn22rnhrjyfyL8Mm5dXsOJuq6Th9K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfX1x8+iNoUGrSD
 fuFoE79zriB0B4e1rBCzuVFdjAhV9LgSTmXDY7Rf4csKZ47a4WxiVd96MgOPTHDInaMyUT51QfY
 3+3KoQv7pfoYpex3WFXCrgHGgupmfaM=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae976fe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QfggKeMjAAAA:8 a=eLFNBQ4JqrOy5HXTT0cA:9 a=QEXdDO2ut3YA:10
 a=KawSF8pKvnAe-OBSxQn-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfX7T2GCMMi6pBb
 6Pb/oBwUYEc1ie8CZ3WxrCzNnNl+K0kyBm5AqUA7HN0r1sEUY/pAdlYYJ6ncbF7a2ndNddXN70Y
 s1xiW0Kq+Mh0aRMcr9lQlh/O3yHCXe1Tvi5HmMrtyNXTn+1ZerXDOmRL5On1SR6CiBa3gPihfV1
 01rWVlSbTIrKLUzJcbedWAfOLdCVcEFTvqXq8UWiclm4J1qFBew9203/CL/YNkerzYW0CJydKvu
 siFPJPm/e2g9bKzOoTwT0PdikJY+5YoP1N6InjrbC4QU+fu8vxGauA+7IiIRBoBoe0m9YUwqqu9
 f0Iv1Ny8GADi7BdjRGljAB344ghnV21RhcrkYf2QT7JcmB2mRPILUIpBosg9TUqsLUvUoix3+W9
 I8BFiJMWwJ0BMNEpMT01Ok9C2EuSLvXiCx6chNYWAmHUFd1Ajrig1iiKlCTX/xDYt/Jau0PUoua
 IahJoCcf8aQ2ig2O23w==
X-Proofpoint-GUID: iymZEAkMF_5fSf0SJ2x8NQHePZXaKuRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030022

On 11/2/26 11:44 AM, Qiliang Yuan wrote:
> del_gendisk() takes the tag set's update_nr_hwq_lock for write to set
> QUEUE_FLAG_NO_ELV_SWITCH, then for read around __del_gendisk(). The
> write lock was there to wait for elevator switches from sysfs, which
> held the lock for read when the flag was added.
> 
> When several disks of one tag set are deleted at once, as nvme does for
> the namespaces of a controller, each write lock waits for the other
> disks to get through __del_gendisk() under the read lock, and the
> deletions run one after another.
> 
> Elevator switches from sysfs have taken update_nr_hwq_lock for write
> since commit 4ff58d6bc9dd4 ("block: serialize elevator changes for the
> same queue using a writer lock"), as updates of nr_hw_queues do. Set the
> flag under the read lock instead, which still waits for both and keeps
> them out.

Currently, there's a patch[1] in-review to change update_nr_hwq_lock from
write to read while switching elevator.

So the proposal in this patch may not work out if the changes in patch[1]
are accepted. I understand your proposed patchset but I'd recommend wait a
bit till we settle with the patch[1].

[1] https://lore.kernel.org/all/20261031044141.5569-1-laveeshb@laveeshbansal.com/

Thanks,
--Nilay
