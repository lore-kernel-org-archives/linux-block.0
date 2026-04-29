Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957238E12B
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464987; cv=none; b=pJ7JVG+vxx81ZHO2u30w/b60VPmRrJdKrzVBgSMQjaQmYQqQpwcNqwfAScMT/9bUWByDbrsULrvemAkcuwIVv/fF+m6pJKO1yzJBRlgtuNyG2zbOMsle1xxfNzVVVgIe7tpaHm1YOpJsL6zQPNbQzRoDcYrBi77Q+gbxGPzjWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464987; c=relaxed/simple;
	bh=0AINFMB412N4ys59nggwXI8kfKnUcgLurLm/n7HY3y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRsCTttFL+kopHg02asG/26dcHp4QGv45YI1n0Ba6L2OIQZqOJywGAse64axm8CJmxHlK40qM2ahiKauzcvyt4JNT+bI1Jh5oCDqQDKVKoYOeJOqhpCB1w93OBKFo43FWI5sV+RqGAhfBllS50H4LpR6TahSZVx5+N6Nl73uruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EvcDwbK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MWmQRQLv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EvcDwbK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MWmQRQLv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q0uN963253
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pdgqJgNwaEnNSRtYSBvFmE51YSFb4FYx4jVfOBaK0A4=; b=EvcDwbK812CbL7se
	MjOpb3IXvmGsVG0ldWD3ZjxEKKtosGiFDrTUEGz1zdBQtXp0WgC3tKE9Il5aFp3y
	OwbGrlNNcYBNam9OEhsZFowIkxI4kJ9aPLPKI4B7wEtKHWGyQ6NhneHiAMj3cZoF
	N9XK+iyOKuBYRv4GeTV67IcRyTO4vCfxzjwGIwmu0y5gaTtIY6p+XXyvKpnaJbPn
	zB9b+NN5u54k+ZO2ZYmCLqrXjCNy+HDl8TYq7pG3se5fyuPdMn5lk5slQ0y5SaUT
	vP2DSPvlRDTXnCxo0JuWaNP95P4R1hm4c5G4NrXGbVC9jV0MkfX4G7w8s/aEgXfp
	p6R+Lg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4uatw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:16:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2d889997495so2302526eec.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777464984; x=1778069784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdgqJgNwaEnNSRtYSBvFmE51YSFb4FYx4jVfOBaK0A4=;
        b=MWmQRQLvQ8VomyMZ0e8TgBrQClPKMdnh6K9Hxhr3QcaeDQdt/vO2rekMfaMaTcmaSN
         KoPUv1pHBS1hGzkUUuRtui/coO7PoVv0XX29xdKicZxy0HH0wKtTJgGc1fctjuqrBr1Z
         BSs2iUz0yI4watysFYpCVFiHfbh0f9MMQRiyJvtPlNEg4ZZ3osBRBUhaaB0Ew8NzO+LU
         nsp/i5KKW0mrKWOns8P/MylfOQO4JlZFThwlhcH3J08tDXW3XyDvdD2qGQNfbGW02AED
         Jc4D0lrkoSLsO8UcLoWnYMwU8zl28B1rNqolTMTNrEs48I2RpOgpzw8EjtIyRE3mVCYH
         To/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777464984; x=1778069784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdgqJgNwaEnNSRtYSBvFmE51YSFb4FYx4jVfOBaK0A4=;
        b=JIH+f4OP0x98n17jNU7j30wnYTwnSwIpSr+hAu2sU+dI0NlqTkwvzW7Nf5ss7MKZ3g
         kVEFOlixFUrzPgbsmyNlldQ2IlZfPj/BziU1ARTjGFKGLXahMGjILccstYqvcNgl0wpw
         XuvDiBhiH0eGhJEk71NzGpos2Aj1FZyxRQRRVicQR4ERqpNfP5ygFMgTjEt7I4RMA4Zg
         G0djR3GSKMmnYODvIGCvtG4WXs90pF9nzX6o+rptiHDpdFJb9SS43mkDi6I5QcnuVORZ
         Z8MWTbyfUy1WTQyigpnuTGN3/Eoto2pmEp3TiaN3EjoJXlYEIfVob2T5zfPtff3BV56j
         boCA==
X-Gm-Message-State: AOJu0YziU0QZ8NNT4eFK36ylJSPrOpXiiln+thEr3ts5g322gVl+wX3Z
	NIbZn6Oa1593KeF43JAvI/EW3UNqBKaBzjh07bPlnqtoI1g1/yaLg7B5AojGG8Vgz6EyC2T1N3+
	L5sj+AA2et5Rv7awJrYSIXZbJfrDI7llgwR38zmPdaSh3hTUorBBs0PbtlwHutVWW5g==
X-Gm-Gg: AeBDies3fX/Y6TiXpD8ag8xiYnm9mn8IHOT+IrbTOUfMKt5cz4qfRnevXleFwCCqepk
	uCxKpUCE9ZzbLWYXheg3hH/yDcmWfhdw2l5kL9bNVPfCnd+63BV5laMbEsk5Di/YaCTV1FGCQiS
	8RV7oRMy4EkDsU67J2zrl7h/PmtAoay39pIWrp8gHY3GlPcjo8S4fXEvOkkOTnkg+rrVKqX5oc9
	vPAOD9srXAqY6FkhxPU6s/IA9Tlsx3dRknaCZQwa64vgpk9l4ChKrtlpNDcf2zVLlLoFi+u7AbW
	gS7XXlOtRCwCVb90DLoNFYCW5otqFcY6MIpPGDLoch4gjsOJx4fr9h96ueerFPoxM1OlGobZX32
	cnnOnvxVTB5c5pqGKaFeRsa+qoyamUQzkIGm/phungor5fO/ZGUKXPDcile9csaL0kp5EZm/pYj
	vyRISVW9Azg3h21A==
X-Received: by 2002:a05:693c:2c97:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-2ed0a0f12a4mr3972391eec.15.1777464984176;
        Wed, 29 Apr 2026 05:16:24 -0700 (PDT)
X-Received: by 2002:a05:693c:2c97:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-2ed0a0f12a4mr3972372eec.15.1777464983599;
        Wed, 29 Apr 2026 05:16:23 -0700 (PDT)
Received: from [10.110.45.159] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e268sm1841718eec.12.2026.04.29.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:16:23 -0700 (PDT)
Message-ID: <653ed773-62d9-41b4-9934-138d2ee677eb@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 20:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae65vfakVKg2aGcp@redhat.com>
 <af84cfb7-b673-404a-a7f9-6efd9d23a08f@oss.qualcomm.com>
 <f92f318b-5c99-4880-906c-136aa180d58c@oss.qualcomm.com>
 <afDeUNNWEIlxl5HC@redhat.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <afDeUNNWEIlxl5HC@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNCBTYWx0ZWRfX4jfHBm37R601
 AUZw7ga/3/WoZsXbDqleCGBUYojwb4usey6wmwkziFSJuJ8lZ7MZ+AuWCf2apmsdirut3h1szyN
 6ofKX4YeSkU95kow/ItH4Qr285LX80R4DFmQMJqRFVcQ1uwiO4tI3TJtrNVeHJoOEC3kWjzMZ6d
 ptcGWT56EondQTlJsfGHyE3wwUE7w8v7iUfp1TjwHKpLmLzkAHZ0xVytNhXohYfQTo7GYRXcitw
 tMlvQwYk8MCP5jRGhVqnbaAmTbNnYpPpzqQQuADnoWDYOb4t/Kn8bAuRwC6YbNWgh4WcELHMy8o
 LEopJGgEQ65Z5Mz9DGbdR2L+11rcBL21W0ZgGJtenBhE98scbI8k4btJbzkBON3/WJCOKXc0/p5
 8Wk8SmXgQ5xe7aumUM0tgg6nRZ/Xm5TUKfav/qkpVEo8QlsberN/NG+qxsYlZiROWZuGHM5SfNR
 qCxhjqHOtBUUgaBWd9w==
X-Proofpoint-GUID: gv03ARZhvO8CGqyrWdrCC0ekQrz9VQ5y
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1f699 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1XWaLZrsAAAA:8 a=-UBaOc0O724XT2-bv1YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gv03ARZhvO8CGqyrWdrCC0ekQrz9VQ5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290124



On 4/29/2026 12:20 AM, Benjamin Marzinski wrote:
> On Tue, Apr 28, 2026 at 06:43:08PM +0800, Linlin Zhang wrote:
>> Correct the response to Benjamin's comments.
>>
>> On 4/27/2026 8:20 PM, Linlin Zhang wrote:
>>>
>>>
>>> On 4/27/2026 9:19 AM, Benjamin Marzinski wrote:
>>>> On Fri, Apr 10, 2026 at 06:40:30AM -0700, Linlin Zhang wrote:
>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>> +
>>>>> +static int inlinecrypt_map(struct dm_target *ti, struct bio *bio)
>>>>> +{
>>>>> +	const struct inlinecrypt_ctx *ctx = ti->private;
>>>>> +	sector_t sector_in_target;
>>>>> +	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE] = {};
>>>>> +
>>>>> +	bio_set_dev(bio, ctx->dev->bdev);
>>>>> +
>>>>> +	/*
>>>>> +	 * If the bio is a device-level request which doesn't target a specific
>>>>> +	 * sector, there's nothing more to do.
>>>>> +	 */
>>>>> +	if (bio_sectors(bio) == 0)
>>>>> +		return DM_MAPIO_REMAPPED;
>>>>> +
>>>>> +	/*
>>>>> +	 * The bio should never have an encryption context already, since
>>>>> +	 * dm-inlinecrypt doesn't pass through any inline encryption
>>>>> +	 * capabilities to the layer above it.
>>>>> +	 */
>>>>> +	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
>>>>> +		return DM_MAPIO_KILL;
>>>>> +
>>>>> +	/* Map the bio's sector to the underlying device. (512-byte sectors) */
>>>>> +	sector_in_target = dm_target_offset(ti, bio->bi_iter.bi_sector);
>>>>> +	bio->bi_iter.bi_sector = ctx->start + sector_in_target;
>>>>> +	/*
>>>>> +	 * If the bio doesn't have any data (e.g. if it's a DISCARD request),
>>>>> +	 * there's nothing more to do.
>>>>> +	 */
>>>>> +	if (!bio_has_data(bio))
>>>>> +		return DM_MAPIO_REMAPPED;
>>>>> +
>>>>> +	/* Calculate the DUN and enforce data-unit (crypto sector) alignment. */
>>>>> +	dun[0] = ctx->iv_offset + sector_in_target; /* 512-byte sectors */
>>>>> +	if (dun[0] & ((ctx->sector_size >> SECTOR_SHIFT) - 1))
>>>>> +		return DM_MAPIO_KILL;
>>>>
>>>> If ctx->iv_offset is not a multiple of ctx->sector_size, this will
>>>> always fail. ctx->iv_offset should probably get validated in
>>>> inlinecrypt_ctr()
>>>
>>> ACK
>>>
>>> Yes, this assumes iv_offset is aligned to sector_size when large crypto
>>> sectors are used. That’s a requirement of dm-inlinecrypt semantics, and
>>> adding an explicit check in inlinecrypt_ctr() would make this fail earlier
>>> and more clearly.
>>
>> Sorry, the last response is wrong. No need to add check in inlinecrypt_ctr().
>>
>> iv_offset is the starting offset for IVs that are generated as if the target were
>> preceded by iv_offset 512-byte sectors.
>>
>> I think this concern is based on an implicit assumption that
>> sector_in_target is always data-unit (crypto sector) aligned. In this
>> target, however, sector_in_target is derived from dm_target_offset() and
>> is in 512-byte sectors, so it is not guaranteed to be a multiple of
>> (sector_size >> SECTOR_SHIFT).
> 
> sector_in_target should be guaranteed to be sector_size aligned.
> inlinecrypt_io_hints() sets the device logical block size to at least
> ctx->sector_size, and validate_hardware_logical_block_alignment() makes
> sure that the target starts on a logical block boundary. The block
> layer enforces IO to be aligned with the logical block size, so
> an IO that starts 7 sectors into a device with a 4096 ctx->sector_size
> should be impossible. 

Thanks for the detailed clarification!

In the next patch, I will add an explicit alignment check in ctr() to ensure that
iv_offset is aligned to the configured sector size. For example:

	if (ctx->iv_offset & ((ctx->sector_size >> SECTOR_SHIFT) - 1)) {
		ti->error = "Wrong alignment of iv_offset sector";
		err = -EINVAL;
	}

Please let me know if you would like this validation to be handled differently,
or if additional checks are needed.

> 
> -Ben
> 

