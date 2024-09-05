Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F11C2E
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561288; cv=none; b=RgmXFODevwv5vpjzb2HS8kuNPFvJ9kg0+8e/167dULnq8ld64Q2Wrc/UqU/XKjIa1T8ccrY+Z9R1tjcqQ9mWk0uRzveVKDTjCIvtagdTBwfpk9bHMfz1yEaNXZU53l8y/5qU0YwWv4CkPCU7Y1EF6khhlWvDTPgiMtVYFGeQ6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561288; c=relaxed/simple;
	bh=wku7BF7FPEUKajciySgUaEhihmowhV+puGzrctVB6Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFf0P9tMiQAl0GdzynobwZzt50/bboL8VMXthnTHMGNCY3o9hNs+tHhn63dMhi3xWnzpOSMA8qvAVI6DBOthy65DrMdxrlcMi8Qo3wBtsaIqh8xdHT3qFbdYha9ev7tS1p2J7fRfBznmsXD60SUas5jW0BMFCGbOR6awxWzsCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ziETT3Ir; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ziETT3Ir"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso47194739f.3
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725561283; x=1726166083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQ8391DK8+LhiYv94yWR8zy/yMdB9Y/ds/lDuepT0f0=;
        b=ziETT3IrKvwz26u5g63/MNUOqGsbXMIAT5Dlq4x75CCO1iZT6KgEOdc4mZvbUscgAp
         URWcPJVX2BD9Z3aZ16cqUuDPmddss4P+5Qr1233sH7s++uSHf9XR6nQk7UiaUw/D6BCg
         d55/7OhSKJ5mTZ1NrC+r5hRATtXRgpNOhvsb4YBkh8HPbi4mN0YCXCBrcSeSGotzPMut
         Xl+l6dcZRpiQql+Oc/BSKURg7nQPKKHq6iHxoV0+Vks8i6xpziQ7CBBB4z0+4tqu+R5X
         ssvD86ZucnpsRXdbjI3A6OSybwuxI5//NRdne9dodq4acLOep3uAWbYjmNXYqSLSde2F
         92+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725561283; x=1726166083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ8391DK8+LhiYv94yWR8zy/yMdB9Y/ds/lDuepT0f0=;
        b=QeFt3reErRrUvRxu9wpdV4MycbS5QbG5AOxzBCsMDVZWIYy+WJ8txTVO5ZAXenbvJk
         Wp4LQ3/CT1/4dLJO+Ui8I/m1nGf6tBIeULuK9Mc6tT+idzCTa7GRjumUt9IOHZ3ySsgm
         6ImSyZcqazM9W3tlamIPDzRYyRS0YskfGPSAd8tB369UCPNX27ErlYcELEzTw/JC9gTf
         ZNJjR3ogkSiTxPNE1MOd1h3hNwnWGlTHkTeWoZ/ibyXyWdAvEuVQ7/juTyrHPmtWlDgL
         v4dqTc+fjDEMOHr++Q52MltEXUxmUc72+KZsISPgPx4wHKGaGcPfeQb+n8O947+9HfzF
         Q48Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBuAr2BtVVwTLGySa2uqgdkbRNW5ZCRALMIivokDpOWOHLMsJ1Wt2IZPMd4YrDanHFEb+1khYRrUXagg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTS/xV4qTguJuG8gx2Iql67G9R/XawN2k7eZDxchVYViGvdpA
	6VOKL6XcI0rCmeIa/Fnse3mbjks6emHiw7a6nbEnDMrCfUUZt5AUy7WyI/4Ad2g=
X-Google-Smtp-Source: AGHT+IFmvbX98n0yRYn//FzC53rES2JwLSzR1RckucL1DhKvBiaGhW/h7lG6kCPMW6VWPirCzb7jaA==
X-Received: by 2002:a05:6602:15cc:b0:82a:306b:950d with SMTP id ca18e2360f4ac-82a5ed0d8a7mr1598540239f.12.1725561283336;
        Thu, 05 Sep 2024 11:34:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eb17basm3664018173.155.2024.09.05.11.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 11:34:42 -0700 (PDT)
Message-ID: <5e19d14b-1ef7-4022-a3a7-e2c1d5001f65@kernel.dk>
Date: Thu, 5 Sep 2024 12:34:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@unimore.it>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
 <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
 <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
 <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
 <805c9f7b-49fb-444e-a81d-5b9d457bf262@kernel.dk>
 <CACRpkdYr=baNp9n2GDtyw9zH5yzi5psbBWHu9jCitby2rS-fhw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACRpkdYr=baNp9n2GDtyw9zH5yzi5psbBWHu9jCitby2rS-fhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 12:05 PM, Linus Walleij wrote:
> On Thu, Sep 5, 2024 at 4:58?PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 9/5/24 7:03 AM, Linus Walleij wrote:
> 
>>> Which production? For singlequeue devices it is pretty widespread.
>>
>> We tried it at one point internally at Meta, and it was not pretty.
> 
> I didn't know you used any singlequeue devices.
> 
> If you used it on multiqueue devices, well that can't be recommended.

Of course we have single queue devices, anything that isn't nvme is
basically single queue.

>>> Maybe we should propose these rules to the main udev repository
>>> so that they also go into Debian and we get even wider use?
>>
>> I know you like to push for it to be the default, and I always push back
>> because I don't think it's stable enough for that, and now we have the
>> added complication that it hasn't been maintained for quite a while.
>> So no, I don't think so.
> 
> The reason I like it personally is that it has actually saved me from
> crashing my machine by preserving interactivity on a (single queue)
> device:
> https://people.kernel.org/linusw/bfq-saved-me-from-thrashing

I'd consider that largely anecdotal at this point.

> For Androids and chromebooks it keeps the device interactive
> during heavy disk (eMMC) activity, such as when Android
> updates a pile of apps (.apk files).

I'm somewhat dubious that that problem could not be solved in a much
simpler way than what is BFQ.

-- 
Jens Axboe

