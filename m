Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1A25DAE0
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705189; cv=none; b=e9YJgRIy2izowTQZZJsfu1xTwyXUJbaiMIiJToAD3uJAsXgmM7ZHiptAEDLJYLrFRec8fV0l6njIrbfPD6lCX9WAL1xNERCiw6GgCPD1suavMjD52FkJIrbik+lg79vaOqybb12PUsYvvpoS+kSndHmWUFgSCLWrDDlURgiXQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705189; c=relaxed/simple;
	bh=8VZwvSZCk6Gu1QO98pxYItw9GLxVHMqLTGKXQbEeSVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nvr3U2LfEEldt6zfTjj7gjcxUpHDgjlUkEw2bEz8/vkWJtZPZYflD2+iORJRfsA74LQNROxASLtO/k7mWk4pkej4BlpMZAfi290hWufHTKhcYiJKhqinzaLQlRhHxXMMm8kGXT24kTYckEaQYK+SOJ1mHgN3TalUq7lr8WHpo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6X+RQ+c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6X+RQ+c"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so1200757066b.1
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741705186; x=1742309986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ROiX/fO7ILOAQ8O4GIOyW+Hc+ZnReYdkZBi7W6ptzsk=;
        b=G6X+RQ+cLk9mQVScPl/gVG0VUA/aE6lk+rHQ94vkaLC9Elaavi9cmTvoA+rLsjh2ow
         JbRueNOJf1Ku2+SbLk3pEKJnl9vmN6tyGarlmkQq5e10gK0+LtfVx/dRDn/H+5s5GJ0B
         E4R++vkWL6LE8GRIosPpEC9juGEtSw6IwQc71YG4qBwmE3pLEeRdVfbwS8vj5iXTBMa0
         cArGWpm7OrrIhqI6RHANqzPsbGdULJcJXL2MquvpBTlui1QVdouYn7p1xVVjYHVxFH7r
         W0gD2ZWgZYq5VGbb5u5FMaduDDxvNrlALvTyrXXlUm+4Rqi0iMpnrFWqP8C2csP3CFrp
         MGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705186; x=1742309986;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROiX/fO7ILOAQ8O4GIOyW+Hc+ZnReYdkZBi7W6ptzsk=;
        b=btzi0+kzckjLxG1kzZvsHYdh9xzcln8lBBMm25lOXeiCtHgXWEZu28S8ARa9oRFJr3
         HeexnAA2QfHNUmSgsXuReXYxovCLkf/Hgs3XrPk8tn1wfNALOdNEsXcL2L8LVX7hCMh4
         9OaZTEj8cYi4tj2T+y+8kXGDjLPgGTLbtpbh6LTqsd6eBLsUs6CW97/GkiJ+CMKa0i5a
         +mT2fKbuAriWuV2dXjF3PpT/O5mW/g/BtdttYIM8R3MZiLjjDYVGu1mW1fELVRGU8ywt
         UMyc4NXXZStOB+uPlpIl71cVBvTkTpEYqAEEQFqWjJH12z5ayv0x1VChbTWNYL1L3RAS
         J3ow==
X-Forwarded-Encrypted: i=1; AJvYcCWg1N8JbZ8LlWly0aCnXPNEnNKQIIoIEa9G/P7NijAZrzw9gywGMb93+odiv0mRAFie5I3BqjG0/WbYiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxztKQk7o1km4H0Zy6nC5q/uBMeTMw9QjirPdLAnD9TYsRebqEK
	dqgL7qoey2IAF5nMj5/xAkaL5TYnjrXQeII527zu8KOVhvDJ9CwM
X-Gm-Gg: ASbGncuZC6DDTmLGc0jUVFOwdhwq1Rt65oFZIHnn85E9QVM/xj6Yf4jbmN9+Muf0Dvn
	iLOoKGtJ5XM323d1XzxvUnH8Ah4IdKraM+UlO/lGNkz7W7dthsBe9rdDUN88DJdAVlDRlBicJYC
	ZLNBCO04SEsoxHA4Ig9qQDNtmr2brhWhFFQ3hSwRPRhEU8eyH7sIQWj0DOd5kOa4Cp3locpdtep
	etId5mAcbBSDf2i4BTIrksQNjCBBH6TA8JXMfduD50hkPEPUMQ6pKxOzGDZauBDcU/U2CUmaIph
	RCnrbBmOqY94KWEISX4zRkrWP8leml3fmRKSeHVAPHIHXCS0I27F+U96adWBDTU2W4LS
X-Google-Smtp-Source: AGHT+IFZsJjg4B0Y22r/mWZ/aUby3JWlEL0IqPydvj/DSyQpNVyHMD+sL4oxOYSOlnj4JlNgW4QWVA==
X-Received: by 2002:a17:907:c08c:b0:ac2:6e54:ce6 with SMTP id a640c23a62f3a-ac2ba2036b3mr491194566b.0.1741705185810;
        Tue, 11 Mar 2025 07:59:45 -0700 (PDT)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394894cbsm936262166b.70.2025.03.11.07.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:59:45 -0700 (PDT)
Message-ID: <cdc19799-fc72-4581-a942-adf411b19a94@gmail.com>
Date: Tue, 11 Mar 2025 15:59:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Ondrej Kozina <okozina@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Alan Adamson <alan.adamson@oracle.com>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
 <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
 <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 4:03 AM, Shinichiro Kawasaki wrote:
> 
> I created fix candidate patches to address the blktests nvme/039 failure [1].
> This may work for the failures Ondrej and Milan observe too, hopefully.

Hi,

I quickly tried to run the test with todays' mainline git and mentioned two patches:
   https://lkml.kernel.org/linux-block/20250311024144.1762333-2-shinichiro.kawasaki@wdc.com/
   https://lkml.kernel.org/linux-block/20250311024144.1762333-3-shinichiro.kawasaki@wdc.com/
and it looks like our SED Opal tests are fixed, no errors or warnings, thanks!

> Jens, Alan, could you take a look in the patches and see if they make sense?

Please, fix it before the 6.14 final, this could cause serious data corruption, at least
on systems using SED Opal drives.

Thanks,
Milan

> 
> [1] https://lkml.kernel.org/linux-block/20250311024144.1762333-1-shinichiro.kawasaki@wdc.com/

