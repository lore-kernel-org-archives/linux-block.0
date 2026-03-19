Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057883E95B0
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937480; cv=none; b=GgNIXP8C5FA9FmUnRgXYIVubFBWAdqrj/lIReRovBtlsD0yJPrcUXMb2LvVvAZ7cPjzep1t2GCKmvNB+TZNhjwjAb0dGwnqv7zD+LGPP4+vjIbF8UDYfWkoJd4rc/LCg6uL3xu03/F5ZF9IqWYIL50EvE8NXgpk/2bEHJ+kxYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937480; c=relaxed/simple;
	bh=i5bEsur6q5AOCaIqkFdt4U5Kl4ZvU4DHDJP4AyV565g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baKJJRPjQ7LWTqnbQRE40Q1I2/tP625NLGpNJpBF3BGbC0olyAKn6RG8J9bPduG4cJEP+q5U/m2y9+BasS7tRMnfNhQp4ggakPIbluguOYa2777LXZss/NM1amFntxHQDyG6M0aFEG/0qxw/onyAC1GdpQH7aL5kxhcr+iT7qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ki50Ghz7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ki50Ghz7"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d750eeaec3so533453a34.0
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773937472; x=1774542272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqSs7NEZUIMAL/y0ygWiwFX2GSqCOOSj3mbfwPHkboI=;
        b=ki50Ghz73vZ1ROIcEA9Ptij3toCuc7/h5UZgV3LT8axzrGY9hjG2WamVCIAlzORzti
         b6YglTeurXg/AG4zxOV/moGKtbgNpf5WM/ZFhiNE/cyWKOjj+xPJfEv1/Rt/CMW0ZFKA
         o1HHlhOVQx/P9ebbvdS4XZQHC1pGgKPLgb9jYqBZAPjt7BMnYn/O8X+6lWq20jEc2Rg0
         v0Zh71w4pDqpnTD9ydky8ukTEp7ap+E7M0FuP3NdZmubbOShgcdg9rvQjyTYJ6RRoiKA
         gXVg+zQbMbp4bcR/4iaZ5dD2M0Eyf3htdhNrn7ID9xz7bjUQpK6YTp8ey09e3szIpzzc
         m3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937472; x=1774542272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqSs7NEZUIMAL/y0ygWiwFX2GSqCOOSj3mbfwPHkboI=;
        b=aaTzYrK69igLcVrOMYJBp7u1mcSfOOnDKBifFB2aby8AbfPApgsXrTkN81/rBHAzSY
         I1mGClmO9dGCMFjnLD/ygysg81XNnvN4jxs1KA+PsiGQwsM75OfuNDCRgYm+OZJwGamK
         Df2RScnh9OZGIvsu3z/KXe/Q07sFWqtTX34wH6uq+AcG/Jh9XSRif/8lDcICSsW5XBZd
         Me4IGG55+CY9HUbPSgFyLvPx6INPHbnxCmRys0mYpY6pAuR00O2v/3woB6goSKboYee9
         J5klyY8EM+PfKFJOFhDxncdEB0dCAhqibMPelYdSB3pfj9y9zpxs9cU2eYeogxu8T9eX
         p2fg==
X-Gm-Message-State: AOJu0YzMvNCJYIuhPYC+fkzNIIagTeruLCahzwWzfx2HVepLlAnwxhS1
	n3LisRIIKmyJ1bAgZxsgsH/oY8Qo8jNn1ThEacs7kjylu2DzEH2ArNIoR7KdPrCZemA=
X-Gm-Gg: ATEYQzxZXeHtGgrK8fCrOrkSnYGf1VTvkCFPYHhZeUKbyrjEz9MI331chiruzpYXMb0
	epWcamfwKgy7VQain2XyaHw1DTAIcpATtGXcoQsYtg3pgJSDvDwic++Nlsj/8zYkA+fWRKl5Xyw
	WJ34ux0+HadCH6wrMpAR/URJ/s5nkVmiCG0TmMKM7TiILD/NiovlMCL7MAQtwTwHjc65efkjJDW
	2BZ2B7WcmFd2gPVS8hGBFg42wtU0dD+H2+bXDKRItEMYrjI73A6tlNtN5oCnfk9WIlW4syBqKPu
	JAXPdfVJhPHLgeDqycs1Bi142kSnufHBJM8vq0OJJeiHOZDvrmQo5kdfknhXXK706864gw5S/85
	CAmDeOP6PMgVI5j/LtzRDjXk4W2xwcDAJlFuZej9YjHlNSBVsjFT+Dg/IS4Qq5CAm8hbalYezCX
	Ti6tB8Ee/AWDd+loS7umBUesNxsepqZA67a4qwfPprnaFPcIufLknsGsaFicnYV1+Eg4GhkjSWh
	yljnV6V
X-Received: by 2002:a05:6830:3783:b0:7d7:51af:4aa1 with SMTP id 46e09a7af769-7d7ca711a3emr5410368a34.18.1773937472260;
        Thu, 19 Mar 2026 09:24:32 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c995109dsm5045043a34.4.2026.03.19.09.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 09:24:30 -0700 (PDT)
Message-ID: <dabcebb4-701c-442a-a456-1e3c260ff095@kernel.dk>
Date: Thu, 19 Mar 2026 10:24:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blksnap: no feedback received on latest patchset - any concerns?
To: Christoph Hellwig <hch@infradead.org>,
 Fabio Fantoni <fantonifabio@tiscali.it>
Cc: linux-block@vger.kernel.org, Sergei Shtepa <sergei.shtepa@veeam.com>
References: <5459ee8c-075f-453f-8999-19219f9a6fdc@tiscali.it>
 <abwhdNB-j6GOQGRv@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abwhdNB-j6GOQGRv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 10:16 AM, Christoph Hellwig wrote:
> Hi Fabio,
> 
> a 2 year old patchset has been paged out of everyones mind.  I still
> think functionality like it would be useful, but it needs to be resend
> to get fresh eyes.

Indeed, it's ancient and nobody remembers any of that anymore. If
someone wants to carry it forward and repost, we can take another look.
I wasn't personally convinced about it, and I'm always worried about big
patchsets like that being dump-and-runs - once you've achieved the
company goal of getting it upstream, motivation to maintain it and work
on it often goes away pretty quickly. And then we're left with the pile
of code.

-- 
Jens Axboe
