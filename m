Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981878;
	b=vvtaNeSPIAcp8PNY3wJ83Au06Gc0HtfD1GjFIa9bdAmxrJaS8e5EU/MWUAvF9YsV/QJW
	 jVy9a0cCUEcHyHIzi1AJ+IBa9USmQTzMNk7hHA3Z8Sf3ATJUJct6B1QnfTry3YJt2W6BU
	 KqwNv0Q8+1uaWqeJ6TpSI57mmJkV/kmFXgtWW1RQYBr/M+lJq06DYs4UmUf1OOlD8uyzN
	 rPSRDUvnIazIgv0Zt9JJbqg9UZxPaCsvPZyXtLk/kRJRioM7vzNHqXpDX6Va8yVGGGrmY
	 26//Q0LCBNOB7uLFNYHHFsZ0V+J50dC8UdEl6Uflx3nf5VLl38nll6kUh7ZXEBaA1LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
	b=eYHzwvikiy7VgtZVJoKIttLK1ET2I45D2X3zhvIYlSePOCB+2svN71sf1PrTyn8bL4Qn
	 B0xwUHDWgRFVoGQ+iENOhURJRA77BbwAYRJwUt7fMwHGC13mFWTyH56VnEUh+B2J3vnMm
	 yOtWfafV7EuSNNmN+atMCJK4VJC2ab71U/VZ97DVqDYB5Shh1yc6zk5jNSPGPscZo57Ox
	 1fgJHNWbAX7Re6fyVM3HPH44cnSYb6k7t+hy1mSZmXXMlXZ1Jx0nEN0p3Oo7IAHc1DnoH
	 OxPXvs0uqraOvvbDXx/YEn0CB5fyoEvPRH3nLj1QM6rDNfwleUBZVDPv6uBO/5aDyhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="hgTjL/Ji";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QUSmsZCt;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B11606D82A
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 16:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B11606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hgTjL/Ji;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QUSmsZCt
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Fh3Yo2226201
	for <linux-block@vger.kernel.org>; Fri, 6 Nov 2026 11:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Olb2
	PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=; b=hgTjL/JiqI31WqgneDhZ
	0QZb7smQM9Dx2axu7QuG9gkXMcso4fLw4hbRvQ+6XLhZCihsk8tJLPqkDIzn4wvw
	UwbrCe0GGDAEAS6TBvTWOIkBaw3gFD96cUlIjJDQe+7wjiIjtuoehPb2/QHPnhLh
	QNADb6psCkQBHvz7mYa7mpDqfcD7fILBRKTttHMNN00NDpnvSOREow5wdekasHkt
	KkyGK3Hms8JbRenQXE5fun5v2w2Q5HbyxZc9ZuGU1p67q0xd3tECVxaIiXcACp78
	ZwUVRm2DX0dEybUju7gtJaU9IV5vGoaxXN401XU3gTTEuxm/wqNjEj6XW+3o0pyo
	rg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hs3pbvcck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 11:17:56 -0500 (EST)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98a9c848bf0so160185241.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793981876; x=1794586676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
        b=QUSmsZCt/RQlqjl4nZA3MPJhGb9f0YQlG1cET4a3SSMHs+U2M2inWUQLEhrS/8rahg
         zwsy3iDL9uJ38ZOr7aC5A+9oA4qwzf/C+MHFjEncz+wwxYwggCzcffcPOunowa07182i
         9knyGK0ys/noZbQ78rgInWoGyjFxatM/R4y8Nb7KhJ6kPWSTQSycVa+ffPKflmaE8m0F
         apm8udn0ujmswV5I/JLEAKf9rCXKc229P5TRvm/f6Zu52oNM8ST7DuMwnqyw7Ag0eVQN
         rGiSExtdFZ3Y7xCEAssDQuB6FlebMgtRsDlgNPIJjePp8vjBnjXL6HDeplU0FAOJ+tPX
         ai9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981876; x=1794586676;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
        b=nmTnEhEqxzCnXa6Th7teg8oj8cFVFqJxs9j57D8m4c/jdK7R7nDXi68YdGxBZGAeyN
         sgPODZY0QRKAar7+/m4aZjgBoU/t/7lGcQcMst/or7qam6zXl6JGbEO56SUo9fwCleWA
         TV4QBq7+p3aN0jF38mvCoPv8Jt9An/G1XU9Ul1J3iWuBCZ1MlV/cNA/SnWe9ljdQCuas
         7bEIRclL3On/ZhE84gyQhCiDhrUwn5m8PtaGHRqyv1y2ZgVBl+bNiToRxzotTCKpyvw9
         DzAkgLNngpl4MoMuRZlL0Bq5tIuNDjgRRw0NN2bd8Hpdu4gwB96C47HcswMowiV6RAuu
         L+lQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLGtQdI/PEIa542j0qQxHWlKoxAaF6xbKgYG3hX9sNfp6Sb32j/7G2aFieeroFqHHEsh+ETa1JzGJ78A==@vger.kernel.org
X-Gm-Message-State: APuU4Z++Zq9gsx33jLk4SHsVCczamGuLBKLcCkuIJfdvzeEjgV71uGHt
	pGKOhcjZlgFZAKPyYXGQSBkDOJWRSwD3/OSQLedlRznDfEDvauwKcQC8Yr1ZEnpol/8Bm3Y+L1I
	74pbw8mC9xE0WsaldJYIWUcHbvl0JnZ8V+/Rz36xs4iXsqC65hv7sqgUiSBPo
X-Gm-Gg: AYBFou3KSf/ABTpbvGTeSQI6D0962wNb5lKSZ4dHtDL3GBD28ySLEKsC+mhW+LCkMf6
	SjwZZG1JiD16G1XGpUi6oXtJWVnf2i1Z+uAWT1qaFajS2fYFRN7yZK0ADk8i6pRapTzJTAp6/yI
	KOkn9OxUWzFOJU5IOTRZtkw5GrkTb9e2V1VYxFLDzMe8tPrQOqiIIjs1ar94KQjRftkehhNpe6T
	/sa+psZ5V82NImQjjWAWLbqxfzZo7HKF+konxOp9+H9qwv2QCQDsf3NqJPSNkY2TiK+T1HybrDq
	jpcRwCo+oioe0/z5fZJHosywcjSLQdWJQcBTz91A4ZWvqyq/fpCBRA5UJfl4x1JBV7OlR53FXfh
	lxiWxEb9TG8euFALeCQD0lB2rCXhJOwd7UC/5Nc0TpznwJKgo1eR1bm1nf2PB12StiBSuFSVHrQ
	WTwXlzkfpX9kXGNPng7gx9iKThcJ5GIUG9CKvaZLEsc3jf9pbNrtLnhhOHOxQFGCpXM5l44dYUq
	5226Haq4jhO9OnSzcLS6z8PJKup2gZiyeXyBqGQ+oBXQSXAc5jJQJnuNqt3wtdo
X-Received: by 2002:a05:6122:4b1a:b0:5ea:f1eb:b9e2 with SMTP id 71dfb90a1353d-5ecc4431e14mr1609530e0c.19.1793981875713;
        Fri, 06 Nov 2026 08:17:55 -0800 (PST)
X-Received: by 2002:a05:6122:4b1a:b0:5ea:f1eb:b9e2 with SMTP id 71dfb90a1353d-5ecc4431e14mr1609520e0c.19.1793981875395;
        Fri, 06 Nov 2026 08:17:55 -0800 (PST)
Received: from [10.206.221.57] ([129.236.225.236])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a5ea5sm1678794e0c.4.2026.11.06.08.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 08:17:54 -0800 (PST)
Message-ID: <c0a08333-c236-4e41-867f-d94bc34ede6b@columbia.edu>
Date: Fri, 6 Nov 2026 11:17:53 -0500
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
Subject: Re: [PATCH] blk-mq: take quiesce_lock when removing a queue from the
 tag set
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
 <b7d03393-79a1-4457-8ddf-e0d141e4b3e9@linux.ibm.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <b7d03393-79a1-4457-8ddf-e0d141e4b3e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1XXUPLrH41c06laZCdfpFgZdoJUUW3a0
X-Authority-Analysis: v=2.4 cv=Jt5kP84C c=1 sm=1 tr=0 ts=6aedfdb4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=Z1ioWkiWWmTAar9A4mwgfA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=EY2qA-gEnykLEDzTMWoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: 1XXUPLrH41c06laZCdfpFgZdoJUUW3a0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX0ty2h2J7ZKSJ
 Q320OlQ1IAsrJHlmoa7XByRL92/TtUA/UnbW7Oe6bX23Nj+fg7LoNfmVSv2+PVnd7/BlYcoH6Oq
 /KTAjOSRZljQG6+3d8YoY7RvT4uD3eDTTVE7pFQD84VYYGi3txU40YPTEYK5DiJHTSdkWBLoEnT
 Y3QXoGUljBWu5gI+hwBDA31Y4LAdHPl8cl7dJ+ZbBtP5nSdjglYJkevbtYLd5MdasIuOEE7RqBX
 NPwjRrr6ULL0AQkp/ShGE65acSNot+XzzSfvT04KX1K9Js3dHhz1UCrSt1eCmwdrYGbk3dVbP0i
 k/icdFpfLYCVMTqhm1ioEzK5zOciX101P+9UAzdyq2wfZI0InNFU3EHXlGlSufgdRMaPDN4++kL
 jJ0KUBLTFT63wP6J34gci5doJunHImtZf+2uYsI+vnItvtogLZ7226NY09LBK3zJeST0VXmNQ2n
 ZYiQP1fFpgDVTgJbEZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX7xXw4Qz0mJuy
 qD9qASQDxWlKWfQHm1qdV9YPFPvYAizW20tQN6igNlTEJdJ1u0u2LmaImhuYzEJI5pbx9QAXk+a
 n5fgw4pkf993eNL/bbIZ0UnDR09p3Lk/oWBXA7WIwzO0/Qxwo+1D
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11958
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=10 clxscore=1011 impostorscore=10 phishscore=0 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060064



On 11/4/26 8:19 AM, Nilay Shroff wrote:
> Now that set->quiesce_lock serializes both traversal of set->tag_list
> in blk_mq_[un]quiesce_tagset() as well as modifications in
> blk_mq_[add|del]_queue_tag_set(), do we still need RCU protection for
> this list?


I don't think so.  The quiesce walks are the only users that don't
hold tag_list_lock and I didn't find any other reader of the list in
block or drivers.


I'd like to keep this fix minimal for stable though.  I'll drop the RCU
and add the __guarded_by() annotations as a separate cleanup.


Thanks!
Mani
