Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3B14A4C7;
	Fri, 31 Jan 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310954; cv=none; b=kmCyCLDzXV/tc9EFJmyo0eF5yz427xvN8GoMRUCqulFMm721L/Z3BRUfdjbb6BVxQwG6QTTDpayTtbjNE48jTWgFW5hjAaV/rK1RpWYY6A1joaXYtJo5uT86LrsqvybJH6NmMoULy0mhYQuWDqvylKSMdu9qaasTcgtzrcSFhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310954; c=relaxed/simple;
	bh=C+lBtiDCsw4EkiUUmooS/6N9GLjLsYYT8VopvWxwDH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kulWxmLftj9rAN98KVfgmhDne8t76cEFNY3gl9oEX8D9Ur/MHSbA3jBpRXM2hFuhCOQDjD8ucRHkA+DYxLM4VcFJv6WAdcyjwl3Ql8tu+eD2O7Lg5VQ/mvRfdP0m2qeMB05mle6w3Vxsin0VMzSRdSZ9+l/HTJr+ky24yZTfQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4363ae65100so18506235e9.0;
        Fri, 31 Jan 2025 00:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310951; x=1738915751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljk6Bjbe6KEIsfvfP8aXIclZ09kMqt6Zf6rAW6hJAjU=;
        b=mTlURkjuMlsNYDZ/lEkV5FPX4JyNEZbsxJK+MAJKe+sKWYOFwDfHDdYzklYMyIVHbU
         pt9NF27CmLjrvKIrfqjhIxb5a1B6TX2h69TXM++bsBCNrGM1awJqJPeSpHXTCR48AvSg
         7V7s1YeluxqyZtBHXzd5cHC7RHP26ppr9vUbuXdq++8JDOVeHWznz11L4qXAIFSZNU++
         v4UzejUudibVFTWcgvJmckjMGX15dPli/s7SJ8aBgnGj/2DkdzOXb3/eHGHAOb5zcHh3
         hZvXBPKlKvylO4hIcI/86XY03MoUImvVLliEfw5xn6LTCiDCmZkOOrCP5nHueOJMMZUZ
         wINg==
X-Forwarded-Encrypted: i=1; AJvYcCVogXxz78Qgy60nT65/WFfqICu4swe3BHWuPFw190EXzEFicyKJ4P4rDdWfHnFyQHKPI8FN64qis/8of+T3@vger.kernel.org, AJvYcCW+rp2kCfrUbGblE4d5djtvQfGRuH5ieT5Jw7CdKJpYkzyNBpNLq/vcSBTo5VtoFqyWL1UVLY1f2Pc/Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/uVrsyONazquEHfod0/mUxmaA0J2+W25YO5berAKJGF732xM
	c5bNlGZu4pp351vzSZxcQxci/mFwPTp8YNyybl/GIXML/bOKE6cf
X-Gm-Gg: ASbGnct50UYyXEqG+VosAIsFKME1mCFEMmOOGbWKpwaQMirhpiNhnCba4QxIplQlz6/
	Lpfsr+udIucX1sCixDpSHPY7J3AK4Y1THkBeCt9dzKRp4AfQ6TYYdKslxBEgkv5Yefi+7XqdMoU
	XvCCz8PFO1LUwrPTd5/y+9vrcaPc7mKuH4NzOWuRaIluAujX45RWgWsBbzC/6f4yWf9fbOuoMBq
	r102HElHw3bPsKWkbLqQ2MG6GpsxvlYYLFa4N5u7ln0Zwi2N2kpyqwMOoloD9ggM3L01sFcl8wj
	i2n8fgYXuraixuWz2x3IYnFnBO5j/qYkVhfvTTx2BtC5yuK/uRc=
X-Google-Smtp-Source: AGHT+IG8U8qtb55GKUG0cAn303iaS3JbFJZrFNF9WjJ6Adzj7bEnfTaN1soMYjK/D6qHIvxggSZ5OQ==
X-Received: by 2002:a05:600c:3c82:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-438dc4251f2mr81680585e9.28.1738310950470;
        Fri, 31 Jan 2025 00:09:10 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm47905815e9.32.2025.01.31.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:09:09 -0800 (PST)
Message-ID: <d944d241-cc33-460b-9975-e8b68eecefac@grimberg.me>
Date: Fri, 31 Jan 2025 10:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
 <20250129060534.GA29266@lst.de>
 <216ab5ef-1c8b-4f3e-8a1a-f11e28994620@flourine.local>
 <20250131072947.GB16012@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250131072947.GB16012@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 31/01/2025 9:29, Christoph Hellwig wrote:
> On Thu, Jan 30, 2025 at 04:25:35PM +0100, Daniel Wagner wrote:
>> On Wed, Jan 29, 2025 at 07:05:34AM +0100, Christoph Hellwig wrote:
>>> On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
>>>> If a lot of request are in the queue, this message is spamming the logs,
>>>> thus rate limit it.
>>> Are in the queue when what happens?  Not that I'm against this,
>>> but if we have a known condition where this error is printed a lot
>>> we should probably skip it entirely for that?
>> The condition is that all the elements in the queue->send_list could fail as a
>> batch. I had a bug in my patches which re-queued all the failed command
>> immediately and semd them out again, thus spamming the log.
>>
>> This behavior doesn't exist in upstream. I just thought it might make
>> sense to rate limit as precaution. I don't know if it is worth the code
>> churn.
> I'm fine with the rate limiting.  I was just wondering if there is
> a case where we'd easily hit it and could do even better.

I agree with the change. The reason why I think its useful to keep is 
because its
has been really useful indication when debugging UAF panics.
