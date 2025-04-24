Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A615B0EC
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502975; cv=none; b=IGFTK6Zr6WHEKuDBCX0BWBlePMGihlYu+o8jPV/Gxz+bCXJVNAL3aDAvDYVgCAjv4dQErkzk4XVYxoWhzIE8xE8X/itjfUevYkRaku2PU08GswsU1iLigbTWUP6DyalW032Lo2MqbP4YBo5kuhMsVX6RJP258J/wRuPzYmRBwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502975; c=relaxed/simple;
	bh=XfSGw2P+fraHHNLx6VvTul8E6ytb2Eflh5JcLsOmNCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHGJrSXpxYZqYwF0ypzASSJI42Pu5tJUd3iKnP8i8S7k7H+v/HennY76QmZoA8EclmlyvhB92IJTUVsJmCznu2slnhfcmEr9io4HT4H47jIDFM889cSWgxEDdN4ONX0sbTnp298GGTcZtDfPJ4SmLgP8sPg8yRwAbTrnPv4c6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP4GS77S; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP4GS77S"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c553948ab4so10013485a.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745502973; x=1746107773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irqlq+RBcYnX5dKtn8fIfja3VUtfm9geSOe2lZBIeAI=;
        b=FP4GS77SflJRjO5EEHNZ/m18Tl9E8Qeb+M61CW1KueYhZ8+KmgscLrnDodXhhNvTTx
         ZTEgtj4Y5i/KL+lo6z90CweLF/Gh+3+GkaJklSM+SpExkKzN0IOd648yPZthedNN0DSB
         D56V3F5qwD9VJRylJE/9i8Bl+VHgGssFvue7QP0rUfV77T2b7lP0YyOhmguLG4rZRcq6
         7G1IvLQ7HUX8XCPn2ejL1m7VhWZe9+A08Ts29b/Jo3RF88PkBvljpCh2b1xL47r7Zn3v
         ly0xwgd46OEdDLLoO/iwrpyxuPS+HMs2rK1zmFcCeTxR7VX6xSVOM5R38z/ruygnohLk
         9UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502973; x=1746107773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irqlq+RBcYnX5dKtn8fIfja3VUtfm9geSOe2lZBIeAI=;
        b=El1JpiEsuCkCFWu6bthXmCT4vJaAUlkdwrFu+CswEQJEt4CNRocFM6w2zW9W2llBwd
         nNNyo71H6zD+5Sqnk4+FWPTvS7IueFzUU3d6jf5e3x8pWMUfCAMdqP6NaNNVH49YCteq
         69/P8aBySWxyHzH69FlVTzSMuJESG7a1/xWvicOYab9BgjIX3gVyX+/uLB/gV1j353VG
         IQ9pZXkhhOyv3LZixpLdUbeNNXkyj/IKjmD24mAA9ZuBCfLeqSel6/6renGc1VjWtDI+
         DIHxbqNpAnUVKahNFm4eEc2Gsy9OtWfbn4hNN2GDe8ncrI4rsLAYIZdTgsByZbRGXUGv
         95pw==
X-Gm-Message-State: AOJu0YwW0LpQ4/E1PTgkmNStksYj0dNR7hKfkIJVETWpsTkRTFE+5ZKk
	qipUGPQp1fKnnyFMtUebJNhbeoltBMr5sUZrjZxZTjx6NtFkNLZ+
X-Gm-Gg: ASbGncu0xT/JEOWQfoBw5WaGGq6ge/ncJWSizuubdaFruAJM04KOZFRkNy2aQRnJaWB
	KMh1EhipMnjbTey+PTk0b+IeCyyURX/WLHFuIH9wiEzt4+oOL+LpmLLSMDMYb3fvhUhgrIUMnkU
	qZycVloRfrupG2xNh0WTQKgvju1+0zjtldH0E2u+tBOzxI8hk/iv564WnFQmBw2jeN/vRrRK0S8
	ERBn7hhlweEdvPg7PGK+H0Z0idfBaY2r7juzNfZLAprepBZQCAOHCR/qVRSI2G7qwWADoFm9VR1
	OOgPaO4OGR5xiG7n/ZDjNM9Wazh1P2LNEQ6kiwRfxDKt8UUaGhtkLPhhLlAGm5aet2wLQfW5UI5
	ANxuDhmHJaAHcPA68
X-Google-Smtp-Source: AGHT+IHmaDuA8dHNLw+vvYl3r9trKs7AdNHmttJhMd73NJWk8iHrw6Nkmwi4sLQ6kRaC7lYeyhrqyw==
X-Received: by 2002:a05:620a:258d:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7c958347a9emr104115785a.4.1745502972714;
        Thu, 24 Apr 2025 06:56:12 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86d65sm89859985a.86.2025.04.24.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:56:12 -0700 (PDT)
Message-ID: <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
Date: Thu, 24 Apr 2025 09:56:11 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 07:30, Shinichiro Kawasaki wrote:
> On Apr 24, 2025 / 01:09, Christoph Hellwig wrote:
>> On Wed, Apr 23, 2025 at 12:49:57PM -0400, Sean Anderson wrote:
>>> The block size must be smaller than the zone length, otherwise fio will
>>> fail immediately.
>>
>> In theory yes.  In practice such a zone size makes zero sense, and will
>> not work with any zoned file systems or other users.
>>
>> So instead we should just warn about a silly zone size here instead
>> of trying to handle it.
> 
> As a similar idea, how about to skip the test case if the test target device's
> zone size is too small?

Why would I want that? The test passes with an appropriate block size.

--Sean
