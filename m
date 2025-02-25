Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A45214203
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475434; cv=none; b=WbdvXtBksaSxJM+lyQLF3R9Cg5eg8G3WQsQa9Sy6CyC6luIWxsl/4o2UywpsSENH+a1JqD7ziuvjW+3h1+2lkujbmJI3FQEt0gFuV9ejQo9w+UZgZbrPmq5l3HdZuBScgv+bxuxYJHjPFkiN1SYbJ20rc85BG2bzXYQETJa98Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475434; c=relaxed/simple;
	bh=Py3+brg9yvijJ/WWLLWJ/wpfr27D7KoaSA9EbZbNv5Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AqM4CkUimdiWPKNID38BZEu5Fd4PwvqJ4vLws8Ty5NoXdRupfhpEQXw9F5MUQzHErg4ndG24sjJ4wZHx2uFfLsDMWKX+GzUPlOQxkGrDMFC00kRcoZ1XQhewBQo4uW304jVjEx/n2q/8PQEuxewAYP3HPgRATDpM34Hc97aGC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG+oNo8x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG+oNo8x"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso272302166b.2
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 01:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475431; x=1741080231; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9rVD0HbpiKXQSOBLeLUA5bb7NNk0p1uaWDafORJ4B0=;
        b=HG+oNo8xj71IHJ12oITSR0u85nJZ78jTvNSVcO7NyfS8jIQkjLnVq5gssNH7hS8HJi
         dE9nPkJSRaIhLGs5Xe0k29utx3OuFHWhQr+W02VMpqhTNW44cECZBD298GBkMkaoCxcS
         56l86RrKpMm/9Tox5jsxrQj2avq22WpTDTObOG6nexuqIh8lYodwMPXKzrBOeDhVo2tX
         f1+wEGyDwgcImmLiPczjsiuBApOyb1CtQftLZTQjgx0al/aTLGgPzMBOwdC461AYIbOk
         kdZKbtPqLRO/FA8J6MqTTAOq0pgdY/UoRG/W1KtEAgZ23qJBYgYhip2pZBl2YNTaIGTH
         v78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475431; x=1741080231;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9rVD0HbpiKXQSOBLeLUA5bb7NNk0p1uaWDafORJ4B0=;
        b=oit0ult/WgccEb7LWOCN6lUvLU23/tmfYmjPTEH35lSPbrzAV6lqJlnsslGSysdyIW
         dzOxp8nCircq71KBBrelqhvbmvojUe+md+c8LP46xANcOQrLnRLdMrOcS6i9PpCtk5Af
         QufisHw8ip65aWO2+9kGvLzMG1xOhwgSk/BWWAWzguux5jIe7KHwMlAXPYMYeUsr5lYY
         QfO8+H+tf+jAr/lHZ03i/8ERitbC/T1JJHvPuMbi3iOCOEdcdzmsbeYawUgyskhfLlc+
         z6TJOwcgxLIHX8zt3PiMQ6DlB6UpFOae7HRG4PkqdGrZOIqv0LCvNos3dK6hJx1N5/IG
         gB/Q==
X-Gm-Message-State: AOJu0YxIPJSeGCAFAK+Ph9L9hMZ5+WEthcURaQwwEqpEyB9/sQCU9Le8
	G+MOdorsloAP+3w/L83cJ99DgAl6AFXxxTee+3hSzVvzPgrje52PuTpHLpgZzpE=
X-Gm-Gg: ASbGnctsfXFird0mUYl+HaUfyMqNPTEL9mZdR+CVPEcYRwMOHWGh629cyur8UqbEkw3
	q3iGcOlpAOab7m1J3gPuJ+6lyW5nUjRtYs9dN+2gYyJNoqZco4wgoZNeMiq6bVoigVf4TTBdxes
	vBzBCCSNGTtsGFWd/Y+3l9UYpYLSWsnK99/0urEEff5twJNIul6uQ3sb7blcYyXvQi7dvAu5Fx+
	N0quVihM/SrQ1DofgA6SS0gdU2FA+EVvDeZ1JJmQThwoTmvbFRodu/jgSNLWEmh85EoJQ4Ox/sF
	SBUcwbXpT2eymVxOt3nqbOpVeGguQ+7Y+4hm3mnpoC9IlS2+PA==
X-Google-Smtp-Source: AGHT+IG693op7F52mSdsKyXQAQMfwBdwER0E0yQbf1y+OR04IQ8qfJqmlwoJ2oecTszlvQNXKLgLLQ==
X-Received: by 2002:a17:907:6ea1:b0:abe:c11e:29d8 with SMTP id a640c23a62f3a-abec11e2a27mr538447166b.33.1740475430700;
        Tue, 25 Feb 2025 01:23:50 -0800 (PST)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d537c3sm108970866b.38.2025.02.25.01.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:23:50 -0800 (PST)
Message-ID: <67795955-93a4-405b-b0b7-e6b5d921f35e@gmail.com>
Date: Tue, 25 Feb 2025 10:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block <linux-block@vger.kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>
From: Milan Broz <gmazyland@gmail.com>
Subject: sysfs integrity fields use
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I tried to add some support for using devices with PI/DIF metadata
and checked (through sysfs) how large metadata space per sector
is available.

The problem is that some values behave differently than I expected.

For an NVMe drive, reformatted to 4096 + 64 profile, I see this:

- /sys/block/<disk>/integrity/device_is_integrity_capable
   Contains 0 (?)
   According to docs, this field
  "Indicates whether a storage device is capable of storing integrity metadata.
  Set if the device is T10 PI-capable."

- /sys/block/<disk>/integrity/format
  Contains expected "nop" (not "none")

- /sys/block/<disk>/integrity/tag_size
   Contains 0 (?)
   According to docs, this is "Number of bytes of integrity tag space
   available per 512 bytes of data."
   (I think 512 bytes is incorrect; it should be sector size, or perhaps
    value in protection_interval_bytes, though.)

Then we have new (undocumented) value for NVMe in
- /sys/block/<nvme>/integrity/metadata_bytes
   This contains the correct 64.

Anyway, when I try to use it (for authentication tags in dm-crypt), it works.

Should tag_size and device_is_integrity_capable be set even for the "nop" format?
Is it a bug or a feature? :-)

If not, what is the correct way to read per-sector metadata size (not only for NVMe
as metadata_bytes is not available for other block devices)?

(This is on recent Linus' master - 6.14.0-rc4)

Thanks,
Milan
