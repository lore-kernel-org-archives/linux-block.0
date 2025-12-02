Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742631619A
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668908; cv=none; b=E8E2S+iMWK+EXU5OX3DdJBMN1471yd80Nzx1wzKRyMdqM7XNzuLtlcPB1bVaudAE9yct2tvarasGi5VeeEyoujI7CLfEFpwEPUqk9lPzzV4ILQj6eMmr9yrsUm4T+nDRWN21KajVV2eDGKsqNSX+D/LCiUsiff2jcMCZ/VW0pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668908; c=relaxed/simple;
	bh=/qejxCeyZKBy0rO1TPz+XLZpF6o5DZmOLKdwk02jSV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVJmyldJavxfRrKMYQXMUXnNUKi04LYXFwka/iouvhRENfxzaMPrxz3FuqXKzCXVl0cqb0Smd07FG6Lo5jyLKxSQ6DNpiLqrXmpidMB3pRFb5+J4M/W1e8HkfhFIbQx8Nkmj4+4Mcv5td3XmAkdzBVapg1k4m94asW6kYMsI7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPTayajK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNio0r9J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPTayajK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNio0r9J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B27M28o2692832
	for <linux-block@vger.kernel.org>; Tue, 2 Dec 2025 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4CsMDAZY2FVaahy03K4lio+2iA3SK+XYjQawaUF7nE=; b=PPTayajKr3iRPvvj
	KC7AF8srO5MffXNeYISXeIgFe1vtqZEi6bMij/FXdkVrggb3wo6+62v0aAfCRHDb
	BC0XqLrpypIqiVp44ojZ2kPXpczWvT5Wz9KRqFjyaneLKb6k4gGG3k/tQv2lphM7
	tXwAXdAZk+Arp//lFt9fzTsQQIuJE58hxPeoU0lcz5go+dipbjX9aW62jV54f+Ay
	NreE7noJ+nfAA6QwdXFqWjNOzLSEJXjE1Gx8KC1fCQgFHJdWVFm2ROhkWnw6gN1C
	DGhSVznmyqiBKmgKVrvoCjxweLXuDKZ+FIs0oMA5wQJ5q+VWfmpmPJegZUe4sQ1v
	TECvog==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asun90ffb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 09:48:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e5a18652so57144215ad.1
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 01:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764668906; x=1765273706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4CsMDAZY2FVaahy03K4lio+2iA3SK+XYjQawaUF7nE=;
        b=TNio0r9JTsgyeOCgcTDD/mhEoQfFKTpigswFaKaExVBuDqEiYAcPFSKheVFGwwu5iA
         JqdZVemxfAgUFSowfr6iVsFP0z1qBBZfdFI4uHYcVW4DkAXTQ/yM6XGn6WYD7I7dfKsu
         Zkhcho+PbNw4VtlLVJp0IDhdqWE04jmr4u9uaNPDLDJhQyQOZGmoPMdLTwjwQRJmpTiW
         vYZVAW4bUFgkL7PayIIpDGsyNiPVmkRmllXnS1T2Md7CJrDtgFxSalkoopPCk16UGdA2
         nSriAGTWpcTHzXSchf+tq3QJqvw7lGlGHV4MIVK98LJPqRrzL4kcJfIAvDZOeMjU8FTs
         v5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668906; x=1765273706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4CsMDAZY2FVaahy03K4lio+2iA3SK+XYjQawaUF7nE=;
        b=NR313e6sAs8aAKWdaQBgj67gEqyrLim2dDgO83W5MMmdLdYX/B8LQXMPkqjDHvNSZ2
         NVPJR+uS2o17/fDaC1mlfxmwm5BgWdDcU5IJ/g2BBW6A4nYJpvwY592XclNgQgpd8mhZ
         p4ig3m3tHF3VBrRO9yUJOD9GY+Ce5QRAMYcfdZCL2PMYcQv7kwd8ewACtb5+HoUsPjJb
         n3Lrch452RVsFY+xVqIF75IsSUdvRwPacwUCyLidbhPNxtSb7gGjgyZqslidvpoTG9f3
         xYRupZnVMoc6QjfH4hFKISU0anO849Gx+wNBueWPgVmVLW9a6ULeBPcK1srCp6Hqhk2o
         jrpw==
X-Forwarded-Encrypted: i=1; AJvYcCUOu84cszuAlH7jqzIt1c1wgH0wy1v0g+9L/eIwCpvNz1DgvRmzH1Vf2NK9v3U2verApWr/fdKPM7RPXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuXiQefYBz6XWtWrBBS8v6uBQBWHdL2ChCyfZSBq8XoROBt/B
	WXIkUb42GGp1U5avfWDM5+B8Sc8qHQAN/aRKpcITLHtlhfaROMrqmrEVHTqWxAyqVT9rOYKYf5/
	0x90hXknRJU8gdldQoAKp1QLXuREVdPYZkaFoAAf5+JhCm244EdgonmX+G6eDMB+p+1fcU3FJ4l
	X3hpk=
X-Gm-Gg: ASbGncsibcV/r9XqGZNoozzck8xSsCdSRBMh+BXsdnUXNB6Boy1lPUun4BO8BnSvF9G
	iUmWKq73VKcjRWAa94+tMEsWiWf57GxLz31CBUG/zYkZnMIOHPuoEMjTw35ACQcAGJ30yVNS8iv
	6h9ljtBnpOnW2Q/aLyPZI6FMsHyHJB0FHdAcleKc2+Q35QgGMU0MuQ/9312sgyRfuOKAfp3ETGv
	zAuSc4YNp+LH03thtcW1y0AbQW1WPZpwJStQZgd86cUG0SYvWKpvF0rM7zltNrlthXZBZPAfO/g
	UlYuOprF/mj8Lr4bE0VbLT2o2Hittn5coZayDWs4MxjuIFXJvhtiWINRIPm2jMBrBwVY8Qp686x
	THxJK2NCXrz/gfgrQFmeKtGCga0+a5IjyVdG5L+pJVXfkZ7Dmfs4wKUiBGqWdZVAiLwb5A0Cp9S
	iss8E=
X-Received: by 2002:a17:903:2f10:b0:297:f793:fc7e with SMTP id d9443c01a7336-29b6c3e4c3amr431308805ad.19.1764668905816;
        Tue, 02 Dec 2025 01:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8DwtE75mzbmXISOTRq1QosEolgq/N3Dj+fh4eoYyaUm4l6E1gY7eo7WOlgFd1xZKrzFJbag==
X-Received: by 2002:a17:903:2f10:b0:297:f793:fc7e with SMTP id d9443c01a7336-29b6c3e4c3amr431308525ad.19.1764668905335;
        Tue, 02 Dec 2025 01:48:25 -0800 (PST)
Received: from [10.249.22.154] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce416f00sm148351595ad.4.2025.12.02.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:48:24 -0800 (PST)
Message-ID: <d010fa56-3c7d-428a-810c-02ff8b1091a1@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 17:48:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Abort suspend when wakeup events are pending
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavan.kondeti@oss.qualcomm.com
References: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
 <aS6vYCg2Gks2BGHn@fedora>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aS6vYCg2Gks2BGHn@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA3OCBTYWx0ZWRfX+vqUbihAq70S
 pUfILC9/5+8x8IARchbIV7g7psrQvrX+uqwqMLDfKLkAgsWHGxbOaJkaBQBvJ5y1HavnO+2vZeX
 mHvUOoxonZWJ0y2zwM9LoFqvXGfT2NFJbh8E5v+fupy3oPzfnNa3q/1c15WtezEfxT04SYNexeB
 XOMLlnggy/k6cooD/jWXOvCWjtIoITxlUydql0kVuhZcsv3YJsbc7Pvn9CzIw2VZyUWtDsJGFBh
 ALdgBo9xQ5KFVOYzHsa12vAN9Z39uq5ySX7dPT6NzI8cS+hGQxuBRkAngKHaQMaSKGGDJNfTwRA
 R++U8JLrLKzhfafv8pAfh4rzRfw7oFa+OGnn6xtsSFRk9C+xP2XDufX5MeLKvq8BDCnl2Afyhyt
 T21uMELm42W41SboF7oxROwx+sqTYA==
X-Authority-Analysis: v=2.4 cv=DKOCIiNb c=1 sm=1 tr=0 ts=692eb5ea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GTZyfoVqD6E8GamsXEIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: mMq-1GuSRokztvxaeOGhGBtlc2a5ns7H
X-Proofpoint-ORIG-GUID: mMq-1GuSRokztvxaeOGhGBtlc2a5ns7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020078



On 12/2/2025 5:20 PM, Ming Lei wrote:
> On Tue, Dec 02, 2025 at 11:56:12AM +0800, Cong Zhang wrote:
>> During system suspend, wakeup capable IRQs for block device can be
>> delayed, which can cause blk_mq_hctx_notify_offline() to hang
>> indefinitely while waiting for pending request to complete.
>> Skip the request waiting loop and abort suspend when wakeup events are
>> pending to prevent the deadlock.
>>
>> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>> ---
>> The issue was found during system suspend with a no_soft_reset
>> virtio-blk device. Here is the detailed analysis:
>> - When system suspend starts and no_soft_reset is enabled, virtio-blk
>>   does not call its suspend callback.
>> - Some requests are dispatched and queued. After sending the virtqueue
>>   notifier, the kernel waits for an IRQ to complete the request.
>> - The virtio-blk IRQ is wakeup-capable. When the IRQ is triggered, it
>>   remains pending because the device is in the suspend process.
> 
> Can you explain a bit for above point? Why does the IRQ remains pending
> and not get handled?
> 

The wakeup capable IRQ is not masked during suspend. When the IRQ is
triggered, the kernel does not call its IRQ handler, instead kernel only
marks the IRQ as a wakeup event in pm_system_irq_wakeup(). By checking
pm_wakeup_pending() suspend process can abort if a wakeup event is
detected. That means the actual IRQ handler is not called during the
checking of blk_mq_hctx_has_requests, which cause the issue.

> 
> Thanks, 
> Ming
> 

