Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43357171BB
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161913; cv=none; b=g9mpmIdhkTf4nG9JzVb613PGnBAyECegMdMeVWs83YPXfHq+j/N9ue65FEDZ0MTxTKFOZJgXAsUAsP665cmu5B4TRdpE1mxYbDi7kDDhPoWHsHfyFsV4QD/FCYmGImi7u20YuXu/VANEU4GFvd533WbGaNaduKJPcATIT5PCwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161913; c=relaxed/simple;
	bh=IhnKrOA3nn2uuXOCOairsFb4QDe1aUX2Np2DBVQalsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGAp0k6bnjE3DAlwXM6+Enr5NNtbPG2n/HbNzELlT8M2roJwnfzRirMkvBnfR3xq04bqaSdrvl8fCcMpSLPLVU4li31EsXEdT56LTiNhOU42AL139bC7u6hgG61ykcky5dKNQj8I7UWL3PZVSrivLQQOQe12TSNveTjrynLZ+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pq2PGOxN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pq2PGOxN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e98c72d2bso70673e87.0
        for <linux-block@vger.kernel.org>; Thu, 04 Jul 2024 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720161910; x=1720766710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJFwEEs4mSuW4ndjeE4fUMXShMedXXb++Zc5jeXPEB8=;
        b=Pq2PGOxN/I2Wj1xl3Bml6vsctG0blrS0rCLLoZQqLwz+/azFK9Qo5zyPgR8v+KTk8/
         qGpepLrf6kVoAkiPrp2LnGvPLgWYGCc681UOzYH41hNFjv03KlPAj0QmlwkY4lQARH47
         pka/EIOKMPgZfV/xteWCS9aPzmuCGYfA/Ba5PL2DDlI23qQjYo5FJT+SBofrHclQ0Czr
         0RqAObhhIk1ej+vAqlsS3nbB35Uj02G6O4zUpH6iGHSiB2pRSHeHVtJB5RxlobrgwxSB
         +7xT0xtar/b2meUIiftUqMJeL7R9UwDIa9bPLFM1yQn661vFQ1CcWnpDysretC2HmhPi
         MXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161910; x=1720766710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJFwEEs4mSuW4ndjeE4fUMXShMedXXb++Zc5jeXPEB8=;
        b=KbVdeCqby/wKjbOm6Dz6I3/C5OhSDEPYhsqcFn4koEs1FEKxqr9y1kgFj+ouVptzak
         jRs2RTXsoqkD5WJxf577izgzkETjdtvU56X1qSP97ckhgAmm4YZhCA29bFzwVsZ7AtbX
         Bn1LVj5SaMKMAn3fYkFjoceBakbtHpoXqxocRkq0UlA4SmIodGx06Yae8/6S4YNtS4Kz
         UjVrAzXAH5DtGThHVmAI59Q9zoDfpl9lIRI61poPMFmm7o7nFyeax0dxx0JAsLGPaIiu
         HimYoTMJbznoONuaPQIZSR+SupTOhfndya9vuj9m3iTBvkuHjp02TfCKM6x1T8xxxupX
         IjDA==
X-Forwarded-Encrypted: i=1; AJvYcCUkWyIyX4iIdvtFSFfCI8vUXPpJLGOj5bsuxd2dZHIf2/K1BaiA+7307J3meA5y3Tka7G7bynbDbaVQ9nR/juW5y5R21lT1ONKL36E=
X-Gm-Message-State: AOJu0YzPA6aqoV791F441tUfQtt/5VzPRFmHh5wS7xXDdE2sjXJP0sef
	93OJ5bn/xSNJ7jgP3yp4BXAf/8iPl6GwDalWD+UiZXprEgxVdftZSGfijlkObMU=
X-Google-Smtp-Source: AGHT+IFGzxQf1NVbK6llMn1tg49wKbuLEtrSOCtYJsBpnxpYrlp0VXtIH5fwqCHfDD+hE7dchwcseg==
X-Received: by 2002:ac2:4115:0:b0:52c:6b51:2e9a with SMTP id 2adb3069b0e04-52ea062998dmr2337124e87.2.1720161910248;
        Thu, 04 Jul 2024 23:45:10 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7e4deacfsm2471448e87.14.2024.07.04.23.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 23:45:09 -0700 (PDT)
Message-ID: <b4940767-b5ba-477d-98c6-a9671b2bc290@kernel.dk>
Date: Fri, 5 Jul 2024 00:45:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240701165219.1571322-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 10:51 AM, Christoph Hellwig wrote:
> Hi all,
> 
> Following discard in the last merge window, this series also makes secure
> erase and discard interruptible by fatal signals.
> 
> The secure erase side is a straight port of the discard support.
> Unfortunately I don't have a way to test it, so I'm adding the eMMC
> maintainer as that is where the support originated so maybe they can
> give it a spin?  (just do a blkdiscard -f -s /dev/<dev> and then Ctrl+C)

In lieu of that, qemu does support mmc it looks like?

Wanted to get this queued up, but would probably be best to have
that tested first.

-- 
Jens Axboe


