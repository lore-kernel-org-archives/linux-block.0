Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2638FB9
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619841; cv=none; b=XomhTOp1TjAcm5HbsxltTU3JTKoClVlhIMcLld/uqs7r+h397T74aAA/D6wmZlIXiRje22yCrz3rDFxeIj1gBfnU27HT05g1VpwYBbnn8cAY+1nf5h/Rb/GsnxIUjGhdn8FR4vQdXru7qX48jw5J5D0jCQP5LXrke68Hx8+s25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619841; c=relaxed/simple;
	bh=qyaYKj5sIykbBnxqQXhzqhtB5Bt2HvAgt35mo0Qr36M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0oUDAHsttcy27rVfH6udDlK8D4xP5YqpwjthW2A3KbU935zoDljf3is8sf2Zbx+8djhK2+USDxXG/w4YWMiJwwVNa8RC6id9x6rQ5iaDlObPuoImRMsbi1WaWYRR+DnynQogeTTrvxslqiQmcQepTxnkuit3tMDJ7dcZqR56Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x+bTbATY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x+bTbATY"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so5759975ab.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734619838; x=1735224638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0QIaHh5uixgUYXfYLebamTLXZjOgnIzfFGjl21V7rk=;
        b=x+bTbATYoxPqU7+kUvvJEVgOp+YE8RX8BEebls4EsVYgwQo14a+KhigxLthxl7ZsSf
         64xHc97vTyeBtzQPSnkjZIHLT+95ZHb5xJyFFPgIXjoSZZXmS7DjyZ6lu2k2SyyxPm9+
         1pt7sLztN0osbRhJrHpYkomj3Fk/ePIdlQxd4z2fnFPUkrkEyTTVoxmAzGWUwgSMN7/R
         Wp29nfhidIjjFhUXtv2NPKivDxp4Iwio5eSDj84EajM1A00Cz7Tjri3v00LsVWvOKogA
         brcvmYBro5+xp0+q92gZTedrFTXYJZ2cIDfVIWH/0RxQkLBka3OjPIvmqKgJBJyFfpJM
         SjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619838; x=1735224638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0QIaHh5uixgUYXfYLebamTLXZjOgnIzfFGjl21V7rk=;
        b=KSPko06QgGZP5ZO4ujFY+9N3uQsr4OPbf93l1qJoTRMs6Nwba590KcUwCkMsALAYDi
         YstZvTdHPBJQK6Kk1UvmCrseQc8CinZ8JQ0BvltnjbCC9xCzFjJQbDQwCyV/3oV8CRyV
         saeWDZuLz/O+Xh9zVwawHhdZt/2u498xf2ci10WeWvLkcXm27eOOs/xXCkeDf86s2nnP
         EtFq+9nxXRzo8RmyYmEpnYHMzJ7KEoQY9I5y+Z4a+c7ZSSLiqC0jE0Gvg0iWQVQty51L
         PMbM5w5yk/62UBBLUOV08RxiE0Snl/iXeZqMUGc4elS201AePj0rJoE7niCTji6Y4HMb
         Vw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmcwjl4FWFx3Q42Lk1DT/GRDynMAK7oL6aoRtY1C0lVX17SE+0Zg2t96ZKkJaMl+ddunxIovXsZQOTJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqLOz4Ze6xrWznPLVbTe+DSL501/bHFlGnja+yokADb0UAb8n
	xihjViT/yWCONxE2SeKsxjBOatZtNcd4qjqyNsjtYYTd3/a6F8n4cYOXbKHuzuQEihWqgjGRibN
	O
X-Gm-Gg: ASbGnctWOlQ+MMFkPXIYfhypRFEcDsx80eVWAMdzBs3L7HaZuXyyL+VZE/Q4BtKwDgf
	lBAjyEWohq8+8wG/3ucgZbxPaVPAxuLH9s6d4RPMZHCk8NgkavYhEMyfQ1nw5mM/KoOG+YE6GYJ
	8B9P1NdDgFIA7pcJyjolIz7N3jGVgjMv+TQeru4nGYWtVadoBCHadqI0JVE0EVZPENDPL2YkaRq
	BGd7bUKi7mmNKlj7twkfEvUKTRNb1Y4og+0a5fsg3pEw/WZB6Io
X-Google-Smtp-Source: AGHT+IGeoJz/4q9I2DsJY4VCwBl0rfLCbK69CiYkSi5SKpmWvtcg7HtwmYGAjBCXpvSqJ0R7pdfDqA==
X-Received: by 2002:a05:6e02:1486:b0:3a7:78a8:1fb4 with SMTP id e9e14a558f8ab-3bdc184574bmr67077005ab.13.1734619838520;
        Thu, 19 Dec 2024 06:50:38 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c199922sm310316173.103.2024.12.19.06.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 06:50:37 -0800 (PST)
Message-ID: <4fd71721-8a38-46b1-83ad-2b1744b074c5@kernel.dk>
Date: Thu, 19 Dec 2024 07:50:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <20241219060029.GB19133@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241219060029.GB19133@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 11:00 PM, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 12:41:50PM -0700, Jens Axboe wrote:
>> As per earlier replies, it's either -EAGAIN being mishandled, OR it's
>> driving more IOs than the device supports. For the latter case, io_uring
>> will NOT block, but libaio will.
> 
> And that's exactly the case here as zoned devices only support a single
> I/O to a zone and will have to block for the next one.
> 
>> Like Christoph alluded to in his first reply, driving more than 1
>> request inflight is going to be trouble, potentially.
> 
> If you rely on order.  If you are doing O_APPEND-style I/O on  zonefs or
> using a real file systems it's perfectly fine.  

Yes this is the way, rather than attempt guarantee ordering for multiple
IOs. It's fragile and will repeatedly break.

-- 
Jens Axboe

