Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25113CA4A3
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038814; cv=none; b=FCrensftycKnvKr7Dsa4jPMc0XdoGQ4X7XR/tdVIrmAhpr9p8mv1wKgYhtajsap1Yvxo9QtkIvEr65RbJueybCijm23D56Z5k0A9+xO9+g/MU5BIMXvhE1x8EweqOSxeJFDJu29bHZCSTHyTfmqu0q23d1CfLdhrT5Nyx282tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038814; c=relaxed/simple;
	bh=Ew/WV0PUTr0b3usbEk/Lg6XKBeQ1rjvblixshSrvBb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPr2Qjvc14reR19/TJEAwK3dlT6OF5qRa/9IVZ3a3fxthB0kc8OZ8vPzbh/P7U/6Jbh3cSziSFala7Z6N/QXQ9OqI6XggT0po9dWmoUg8shk0YtHb26AQaIPx9uKOtAAftDyclB/2yrEcYpX/39xqg5ahxhYzZyFvWWrK79G9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6Zvbauf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzQnO+Ih; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6Zvbauf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzQnO+Ih"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O8vEfU2710318
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 13:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8PoJPEsRbQRU9RB6wNnJ9EpTGXTP8HI8ZOx3/+rwVA=; b=D6Zvbaufpi1byZhs
	x1fHDUi3wN4G/kJT1JMgu4Oc4XtfHQmkNuMPGg7GG+qXMeLXiCfoB1s/Ecj5QsBL
	MfmlhkrcBP/9/3N2DGulHpYSNQVC/BtGggdBIffc7IY8JkSk/CmCQP/0WarBqVyF
	J/0P7XvGWfqCO9EmCoPvhnTe4LQH+osWDmuM7HOHtOv4eJdsim2pTyCz+gZkaw3T
	5g3yh1xkj9Ks9Yu2nqZf7T3T1LmKYyYjX9+kfLEM014W+5EJYOcTLV2fY//bcDEE
	Nisztc9D/K/EJMWmhEfaoQh0oB+6iAye9iOq4LLuisGIp+Gr/EQ16JSwk2vVxDoT
	8ro3ow==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqqu9vey3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 13:53:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2dd1c74508cso12656724eec.0
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777038810; x=1777643610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8PoJPEsRbQRU9RB6wNnJ9EpTGXTP8HI8ZOx3/+rwVA=;
        b=CzQnO+IhBkYPjVKoCtZ+NHlsnIRQO4OW4DitvFmKUgkniO9MAAh3wK/XglxUDehKfY
         cYTKOKoYIiAEhh7xdk6/jxTtWzHPEL1BdVaINXLtEW+/9ArcZsFTi7YKaWYAlg/BgnLu
         rVwoQPEBHrORCgkW0STAxBtEM9o96hYxwmJoll0OyReAfL//rLzLyrK4LK9w8VydjfKi
         SyPj+ylwcNrA0XgiS2MQXy6K2GOw6j0fn61lGizucc/N5zguaprxszoWqqQ0bsyNLEpZ
         /NcCQkyMvSrmmvYq+meL+H9RyVJP55jqnHCpQ36wWk4KIau2P1heMFbcR+niZ2+puXAa
         Z5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038810; x=1777643610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8PoJPEsRbQRU9RB6wNnJ9EpTGXTP8HI8ZOx3/+rwVA=;
        b=q9gEndNr2hYsYECtrci5DnD2AZTtBouEC0GO6GQvF303+29zVX1tB2tTfcATWDX4Q+
         omrVQZyplWqIR1N/7AtAUvK1t6lEvKPXnteDX2CwdngE3/KBS2JlnHLNLQsc/lwuadwS
         n0qo50XBz+v/fFsw1wFja/aosu/phOKrhzE/ITvASiyWcAYhqQnSYgouoBPh4uwdQPhO
         b2AZ0E707NKiqFNOfKbzNOSxNRaz15Fl8bGcAExZvM45bC8w4wq+Kgb+lCTzCjz4+JLX
         WA3ptHWml1fLLxrVW4MZIklbue209vulYNKpgVTy//LSPR5oveL50NwA+4YyKS6R40vN
         HgnA==
X-Forwarded-Encrypted: i=1; AFNElJ/dhpUr9ZoQBdDi9v+Y5/y2aEjcDF5xX655yzLHReAKJOEJY4xoofeSLWEfwO6g9z8Mxk2BJTxyOL5wSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6whK7gbcultMP8n4PiuwGleTobox5r+Fs3F8oYby26i7cwxh
	5avmzQI4LC9fNhcEjGGB6xFhXJVS8HY/+W2lgYU4TNY0YSA3ZY6awISX/4N+H7/Ri85py6QJztY
	EjCqGirloMYFJcjCoZKHD8p8Wv6UCtrF5yThpGFfLNOth3GAHeAQsJODbGpLa9lc+i/TX6ooJAw
	==
X-Gm-Gg: AeBDieuH85HwosAfDTEG91R5HSqmcLan9VcqBQfQMT/TmF1LTwIJfMHgN8ePzovpnS+
	0EqE1NyEzFrIzx/vN4/ewwDxAsqVeAkWNq57TktYhU3GdyGRe36cyc3UhSTvF9+8Tvkoxwn/J3L
	VxwngmPhKwLviEw2SnBEHIg2x3VK+pyVwTvNG1K6BQtL+34mA1T+J5P0PPrgDfms4qA3jMe+Nt3
	o6vnHX4a9XxIrf4gXnliR0DNhXmjsxgsmT9Zcozr9dApMrQbABVZcwPaPKPuMADhz06Rlzivn4C
	6Jy3iJeqsbu0vIpyC20+uRVNWL4w9NTX/oNSXSBHz5iGGvG9IOxNhUUACMcrLTQOhEfSMGeBCjq
	F3imXbeCcMh2/IOR2a751xXO8/dqEyu+sQPFIOTblNJJEPoNiikQRwtGEgNoxJBvt+UJpN76EPq
	Ut3NIDkQr3OgxM+g==
X-Received: by 2002:a05:693c:8005:b0:2dd:144b:6c2 with SMTP id 5a478bee46e88-2e478e28c50mr12950269eec.27.1777038810402;
        Fri, 24 Apr 2026 06:53:30 -0700 (PDT)
X-Received: by 2002:a05:693c:8005:b0:2dd:144b:6c2 with SMTP id 5a478bee46e88-2e478e28c50mr12950239eec.27.1777038809634;
        Fri, 24 Apr 2026 06:53:29 -0700 (PDT)
Received: from [10.110.109.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm34425608eec.30.2026.04.24.06.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:53:29 -0700 (PDT)
Message-ID: <dd833ec9-9e9e-417e-8a6a-688987a499e8@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 21:53:24 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dm: add documentation for dm-inlinecrypt target
To: Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org,
        ebiggers@kernel.org, mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-4-linlin.zhang@oss.qualcomm.com>
 <1a36c5e7-5fd6-4923-926e-65bb04c33b04@gmail.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <1a36c5e7-5fd6-4923-926e-65bb04c33b04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JMEp20yU19bGe9enM0T3OFRbN1Z71u5X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEzMyBTYWx0ZWRfX5T9uPSmuSvJE
 bgLEN7/aaLLbTctQ0+GeNX6IQ7uVM8M9O7Yj9nCpsrTNBY1zvghZatS7+tdfXVpoiQH5k2bClNP
 CTyyTKF8mLpKHef2i6sKepOdm2nYS9cthLXYD29BrwGYDjBFO7iHvEIeMFyXrVU5j4Jobd4GXKH
 eV77q+4E6ThbBUdjMOHCJDimLns0ADdGNY/PKI+ASdnUknEowfJi/DoCMxeU7YmGeAM+VOazW3R
 L8K24zG4CxhSxdygYA9yCicu1k5Y8n1G6nNOWzoRchk3Tw17Q3nH1FLRWCNJSj2wS71sgTGda9s
 439AAhPmB8LmR7gcuYlpOspoL7MO1I3rzcFGoc3adBmUJz6RoqiEFqIw4Ur+GTlJSlkxs+etzQR
 jAGbjbDT25jsoDMjJ8WYJOcCj1nGoLiBBhdLknnOhLo7lO17sI+ZP9TT100BkQYIDgFAhyUYq5L
 lJNx2F+MOJLoWz+Vb6Q==
X-Proofpoint-ORIG-GUID: JMEp20yU19bGe9enM0T3OFRbN1Z71u5X
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=69eb75db cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=9XuA7vtyGULosQ0LkOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240133



On 4/11/2026 1:07 AM, Milan Broz wrote:
> On 4/10/26 3:40 PM, Linlin Zhang wrote:
>> This adds the admin-guide documentation for dm-inlinecrypt.
>>
>> dm-inlinecrypt.rst is the guide to using dm-inlinecrypt.
>>
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>> ---
> 
> ...
> 
>> +
>> +<cipher>
>> +    Encryption cipher type.
>> +
>> +    The cipher specifications format is::
>> +
>> +       cipher
>> +
>> +    Examples::
>> +
>> +       aes-xts-plain64
>> +
>> +    The cipher type is correspond one-to-one with encryption modes. For
> 
> ... with encryption modes supported for inline crypto in block layer?
> 
> In your patch only BLK_ENCRYPTION_MODE_AES_256_XTS.

Thanks for your insights!

Yes, here the encryption modes refer to the inline crypto modessupported
by the block layer. Currently, this patch only supports
BLK_ENCRYPTION_MODE_AES_256_XTS. 

I will reword it as:

  The cipher type corresponds to the encryption modes supported by
  inline crypto in the block layer. Currently, only
  BLK_ENCRYPTION_MODE_AES_256_XTS (i.e. aes-xts-plain64) is supported.

Could you please let me know if you expect more than that?

> 
>> +    instance, the corresponding crypto mode of aes-xts-plain64 is
>> +    BLK_ENCRYPTION_MODE_AES_256_XTS.
> 
> ...
> 
>> +iv_large_sectors
>> +   IV generators will use sector number counted in <sector_size> units
>> +   instead of default 512 bytes sectors.
>> +
>> +   For example, if <sector_size> is 4096 bytes, plain64 IV for the second
>> +   sector will be 8 (without flag) and 1 if iv_large_sectors is present.
>> +   The <iv_offset> must be multiple of <sector_size> (in 512 bytes units)
>> +   if this flag is specified.
> 
> Is it true? I see this comment in the code:
> 
> /* dm-inlinecrypt doesn't implement iv_large_sectors=false. */

Thanks for your comment!

The example is describing the general IV generation semantics of
iv_large_sectors versus the legacy behavior, i.e. how plain64 IVs
would be computed conceptually with and without the flag.
However, for dm-inlinecrypt, the comment you quoted is correct:
iv_large_sectors=false is not implemented. When a sector size
larger than 512 bytes is used, iv_large_sectors is mandatory, and
the legacy 512-byte-based IV behavior is intentionally unsupported.

In the code this is enforced by rejecting configurations where
sector_size != 512 and iv_large_sectors is not specified, so in
practice the “without flag” case is not usable for dm-inlinecrypt.

I reword it as:

  iv_large_sectors
      Use <sector_size>-based sector numbers for IV generation instead of
      512-byte sectors.

      For dm-inlinecrypt, this flag must be specified when <sector_size>
      is larger than 512 bytes. The legacy 512-byte-based IV behavior is
      not supported.

      When specified, if <sector_size> is 4096 bytes, plain64 IV for the
      second sector will be 1, and <iv_offset> must be a multiple of
      <sector_size> (in 512-byte units).

Do think it's enough?

> 
> ...
> 
>> +Example scripts
>> +===============
>> +LUKS (Linux Unified Key Setup) is now the preferred way to set up disk
>> +encryption with dm-inlinecrypt using the 'cryptsetup' utility, see
>> +https://gitlab.com/cryptsetup/cryptsetup
> 
> Cryptsetup has no support for inlinecrypt and it is question if it should have.
> It would require additional options and maybe LUKS2 metadata flag to make it persistent.
> 
> How did you test it? Please remove this cryptsetup example.
> It can be added later when userspace get this functionality.

You are right.

cryptsetup currently has no support for dm-inlinecrypt, and the example
would indeed create a dm-crypt device instead. Supporting dm-inlinecrypt
in cryptsetup would require explicit userspace changes and possibly
extensions to LUKS2 metadata to make it persistent.

I did the testing using dmsetup directly, not via cryptsetup/LUKS. And
I'll remove the LUKS/cryptsetup references and examples from the
documentation and leave LUKS integration to be documented once
userspace support exists.

I reword it as:

  Currently, dm-inlinecrypt devices must be set up directly using dmsetup.
  There is no userspace support yet to integrate dm-inlinecrypt with LUKS
  or cryptsetup. In particular, cryptsetup currently only supports
  dm-crypt, and cannot be used to create dm-inlinecrypt mappings.

  The following examples demonstrate how to create dm-inlinecrypt devices
  using dmsetup.

> 
> ...> +
>> +    #!/bin/sh
>> +    # Create a inlinecrypt device using cryptsetup and LUKS header with default cipher
>> +    cryptsetup luksFormat $1
>> +    cryptsetup luksOpen $1 inlinecrypt1
> 
> ditto. This example will use dm-crypt, not dm-inlinecrypt.

ACK

> 
> Milan
> 

