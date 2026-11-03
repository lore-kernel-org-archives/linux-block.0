Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683720;
	b=cwY/Axdw1hXxvYsLE0dz7gOUWswl7cEMHdec1AgsTy8FgiFKyPvq645QlZxGMLQz1EoZ
	 xT5LqK6oesVqBCkWwEzHcrEKkceIOdhGTng9+7dw+nwt2sEquBwdtQ4vibbOuiCrdFITc
	 sZw8RGdV4C8T2cayIBXK1uLYUyzPRjyxk73zC/7jcWS7/saYDTOqTflauZVQefaFgLbej
	 ZcNEVDDVAGUagWoP+jCerl3ncjHPgVLCGK0ooJ+HP3KoA7maGp+xIdwCgAC7nRL9hzNDD
	 sSQINr7r9MosegK4H1qTJCFCPounOb6mnhwl15JKI9hJ9PZmPHnRg8xtww186Vznm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683720;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7lFZR5opUMXLmMJF3wLCID2BYE9mwlTi8gWcDog8rJw=;
	b=39/RKnR2ubnB2nNVu6eND3cCt2hCsPH1xyiwSnStQ+Jwm2q3Jq3bu5me6Bfxd+PQVpxQ
	 MQDzWlfPCg0PuAakLNiBO56f5pKPreeL8IjL5nywqFlOzW00MLi6NCdLHl25yROCeQujj
	 7g3n0sk4QxzYtrrk0id9hBpuGGMe4jaraS4JDMluvyHWm/sG+nVnMvKEO9xyDgLnI6Zyc
	 meZXDll4TihpU69J2m4EHsh/8TLk0d5Nq0ciiSXb8SNQ5sZYbmhdw0P2MKeR7Ink/OIkC
	 L4hXkxYGz6sAXiEY6lZ839poGK4N3LVwTY+7iPCGOWZLbsbxbsMsaZ0pNhH3h9+Ou2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=odozQj1Z;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E7606A324;
	Tue,  3 Nov 2026 05:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=odozQj1Z
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31jM2X528445;
	Tue, 3 Nov 2026 05:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7lFZR5
	opUMXLmMJF3wLCID2BYE9mwlTi8gWcDog8rJw=; b=odozQj1ZMHLW5E3/uXq5nC
	GC10RZSBql01724o5EMR8UYyWrFE81hTf7s7Viz3WH4ZczRN8H9/QLz8rvf8IAEl
	SGEyuT4uIBAal6xUidu6ncEjQ6YRTJzVLS9yRQ/MIxbpNFjgWqUV+CYyFPJYfHL1
	3ve7eKwlSi5nAVdKuNG1WMEmkxHqOq+8u8uF4V09wg5XwzL78nisUC+/OKKol/ls
	zMOG8OE1CVQTKj4bgy3arN1d6S5FPZnaR0uNn3w9B1jqX8MmRAoozbFj7s8pk7Yy
	onG83hDXpuisfEP73Imc6TgifgqvKuuxwg4bl/4ARFm7ijXL4+Y0Q8K0fRq9y6QA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3c126-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:28:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A324rNZ1827064;
	Tue, 3 Nov 2026 05:28:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vh1bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:28:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A35S6i11508058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 05:28:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA1FB58061;
	Tue,  3 Nov 2026 05:28:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D88158057;
	Tue,  3 Nov 2026 05:28:01 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 05:28:00 +0000 (GMT)
Message-ID: <0d071b1f-82c2-41a5-8b0a-7ea67706b4eb@linux.ibm.com>
Date: Tue, 3 Nov 2026 10:57:58 +0530
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
Subject: Re: [PATCH v2] block: only serialize elevator switches of the same
 queue
To: Laveesh Bansal <laveeshb@laveeshbansal.com>, Jens Axboe <axboe@kernel.dk>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Yu Kuai <yukuai@fygo.io>, Reindl Harald <h.reindl@thelounge.net>,
        regressions@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261031044141.5569-1-laveeshb@laveeshbansal.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261031044141.5569-1-laveeshb@laveeshbansal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae970e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=7Tlg7tASAAAA:8 a=VnNF1IyMAAAA:8 a=QfggKeMjAAAA:8 a=XSM4xmzmucexushq6JAA:9
 a=QEXdDO2ut3YA:10 a=hkvjNyikX2LPLlzviPNC:22 a=KawSF8pKvnAe-OBSxQn-:22
X-Proofpoint-ORIG-GUID: l8LyX_yC9Hdn3b9gmAIVXaG_2CiwPXWC
X-Proofpoint-GUID: mii11LsbumAXKBaGSGkVNS9JZhj-yP9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMCBTYWx0ZWRfX4htgYT9zM3FA
 ww0ScYVrJT4XN+TmXVl5kNxUcpDfG2/+8FVYmZug1Cj1MdJRJA1/7LmRM+Y79DSOh2t//n5mNRp
 V9Rnx7+L2RRFasnJGwCFnOZBT4dcjFded0WW2l7yjnL4dzDEPWC0FCLG9jN+vAwlEID8lkZnpp3
 /Ogg1KyYTRFWNDDh2V4YcB7EZoBUo8nKQxKXxAOHcMaKG/ZPkKetKb06pjGnrxJZxU6Focf1wVU
 uugvYLoimEVY9NSbRpLOyNcPG7pwA1JNA/6HfJrVqX0X+tU2TRGRVg6BuiTe1BHzD1W/e0Rm2dM
 89lbbCpupXRwxMZ2HM1ZqKgm75G9LRhD4BZcmvr2GmAPJbZPgGbISVP8kp7ZT+fSFUS27XBfOj9
 vKa2p9oH6bK2mtdZFz6kRi8XH+YTDX+364Gd9lHRuAj9b5z4udwgodQOHU0eXZzdyWDEHrZv8D5
 Ocas7/cTU8pNfxVY5lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMCBTYWx0ZWRfX78fjvqFHEmYh
 WGlTsKzudUFiYuZWUMLInPVpvC4k4UdKDhHXf7sG2eP6ZjRnP7l1vSKdgq9Gbl+L1H03PRfb+IM
 fiZFoyeqNt8WCby1KphdkH9teakbng4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030020

On 10/31/26 10:11 AM, Laveesh Bansal wrote:
> Since commit 4ff58d6bc9dd ("block: serialize elevator changes for the
> same queue using a writer lock"), a write to queue/scheduler fails with
> -EBUSY whenever something else holds set->update_nr_hwq_lock. That
> commit takes the lock for write, and it has to be a trylock because of
> commit ce8ee8583ed8 ("block: use trylock to avoid lockdep circular
> dependency in sysfs").
> 
> The lock covers the whole tag set, so it is easy to hit. A scheduler
> write fails while another queue of the set is switching, or while a
> sibling disk of the same SCSI host or NVMe controller is added or
> removed. This matches the udev failures reported on 7.2.
> 
> Go back to taking the lock for read. The write lock was there to keep
> two switches of one queue from overlapping in elevator_change_done(),
> which touches the elevator sysfs and debugfs entries outside of
> q->elevator_lock. Use QUEUE_FLAG_NO_ELV_SWITCH for that instead: a
> write sets it before elevator_change() and clears it afterwards, and a
> write that finds it set returns -EBUSY. Disk removal already sets the
> flag under the write lock, so no switch can start once it has run.
> 
> Writes to the same queue, and writes that race with an nr_hw_queues
> update, an nr_requests write or disk removal, can still get -EBUSY, as
> with 4ff58d6bc9dd. A write to a disk that is being removed now gets
> -EBUSY instead of -ENOENT.
> 
> Fixes: 4ff58d6bc9dd ("block: serialize elevator changes for the same queue using a writer lock")
> Cc:stable@vger.kernel.org # v7.2+
> Reported-by: Reindl Harald<h.reindl@thelounge.net>
> Closes:https://lore.kernel.org/r/077dd42e-cbc9-4c23-a5ef-3d20e4fc7757@thelounge.net
> Suggested-by: Nilay Shroff<nilay@linux.ibm.com>
> Assisted-by: LLM
> Signed-off-by: Laveesh Bansal<laveeshb@laveeshbansal.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
