Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17621773F
	for <linux-block@vger.kernel.org>; Wed,  1 Oct 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323932; cv=none; b=c48kHqt4JNkKvHlWlzP/VOeQH44iMAa8/nY0oBpmwV87nMvNV2FxEZ23jrsxksxhKAfIOhBE4lBgU+8joo8r6e5hThAuqILH3GvqkFPQIqirI//ozBegzJSJFcqGdEos24GvAvSthbsLLdj/Pod2uXS2UaitfI9uUh6+ecwyJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323932; c=relaxed/simple;
	bh=jBmuWH0YUH02uvaUnpyESyNBWMLetO9tuvs3IcDBVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5J71BwfPZN2is5hdvy835WtQ0lUqaYFMJWAjC1YNEgyoLJ3pUJ+8oAbF7O3C42oCAq+oK0mcACZS1CPSL6GzCKBv7NCNXznKDIokhce6yh1lWP0acWdNLL4iXROLFNsrS/xY4zXVraOIH72kDlwFShb6qSIf5F1XdYl3r9RPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se7Sz0lV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se7Sz0lV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47174b335bso820116a12.2
        for <linux-block@vger.kernel.org>; Wed, 01 Oct 2025 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759323930; x=1759928730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=Se7Sz0lVmzUHFL7SsLjlQGxP0QJykPNzaNC0heYDRZkQHijNIQeJm8ud/pKzvfPwvy
         s6HOgrWLdXNNJmEjRTrA8cbq0eMzo9kXgmye38cuuxlEtpzulRQGZflPMn3dXl8KEyb/
         w5RzSPChuKTODquLAL6bAXpm433q6Ffi/X5v8czctQ7TjgLTr54mrlWNQ/DLJKmI9Y0k
         ogxI2rlwLCyshPXOHrP/I8wPezbT2E+okvex62ukiYTqb20lrnLcVPJroRox8T8nDO3Q
         2cbKRBF/mpBdpGOBxMWqLBf6feE7iJ0lJg1lQcUEBqNS4r5q4eqzdNcUe2e69BSlNj69
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323930; x=1759928730;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=qFvgKM/SgTpm9OinKzOxpLjW+vi2mHnHNtxP0uGUzMkH9TztZv3yYutsvhwtYNHCF+
         6e9Qpdn8Bs3tCfqz/4MjRifU4zoTRa/AMR912Zy/kfN0tTU97N2Cq1Wyc2JK1uZPvooT
         8CZ5HkBGd8wtEfunuZ5JLwoPrHPDsmP5O1/YPhLdlWXHxs1Iu1nHrGYs5+/ui2+TNU0R
         Jg6fMW1WVNT7uzQwmz1c9cBzFWj53T7eFMG/N3MX5cYO+ZmjIaOysp7nfYbh0F5gbRi2
         qqO9VvZZBhIvHOD5wbvw0UPCv+pT7aoipYzdGNn9FOADyOxPLqiKcIXsFfFvYeB/f94h
         RLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAtXj5UjLuuPJ2kAv8tmZmHfS3IBcrIDnH/FaeFWWGk+Qx34ZOWXslzFHA/5RmVLcH592NS4xZc3pdsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyG+RltqVHQZ31SIuCuQ0BqdQB/uHcWJIzsPqFQwuwX1cmpOP
	HI2E+5wTJq675QMMJ0e6nOrq+EJHQvBwKeDFBcR8gEuzhj3mYErpYCYvoesos7fD
X-Gm-Gg: ASbGncvwplHsGSti5W+I3sSa63h8j+UMZgoi2Wo+eM8MoQ0+lTbrRGUO4NcmecuO7Lh
	rqdAraeit1ag464mGVxO+RN9lO2Fv8Y4NWrGDVgetHnT5R5R3DNZbnokmrkir2xYlWiIBSINuKF
	uedX0umLsOdqXnNoXqpiGvcFKXVE3DaCmwFVKOrI7dW9Oq/7qPAv7u1D5g4suUCovUf01IkhC08
	wsT5vj9DFXFZqHLxK9rzC8nzIan+9t9l8r00aFMf71BXnvYmXHG50bQxfL2KaL1HE5A8bFkyKVb
	R2rrbLf0CO2cedn41pTfMbgEgTDww88oUM43TAKCvp30z+V5dhNnSmopM5C14GIu39Z27yBDT3D
	9gu6BtrcvR2aAGqez5f3yxDaJZRWXN0ZysmeHnMfEJbDL495NMPxsjXIadrIWunsL8fmT0v1exs
	BHjkzq2/dISxf0gr9UAwk=
X-Google-Smtp-Source: AGHT+IHoa5xa4f1XTAIYI78HgS2grI+zOJxKw/L/F6af+N9ErpstXh/VbzIlNsFq6puzwXgpQewq9A==
X-Received: by 2002:a05:6a21:32a0:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-321d882a178mr2574832637.2.1759323929715;
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Received: from [172.20.45.103] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557500dsm16012934a12.34.2025.10.01.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Message-ID: <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
Date: Wed, 1 Oct 2025 06:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
From: Kyle Sanderson <kyle.leet@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, axboe@kernel.dk
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Language: en-CA
In-Reply-To: <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2025 10:20 PM, Kyle Sanderson wrote:
> On 7/30/2025 12:46 AM, Nilay Shroff wrote:
>> To address this, move all sched_tags allocations and deallocations 
>> outside
>> of both the ->elevator_lock and the ->freeze_lock.
> 
> Hi Nilay,
> 
> I am coming off of a 36 hour travel stint, and 6.16.7 (I do not have 
> that log, and it mightily messed up my xfs root requiring offline 
> repair), 6.16.9, and 6.17.0 simply do not boot on my system. After 
> unlocking with LUKS I get this panic consistently and immediately, and I 
> believe this is the problematic commit which was unfortunately carried 
> to the previous and current stable. I am using this udev rule: 
> `ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/ 
> scheduler}="bfq"`

Hi Greg,

Slept for a couple hours. This appears to be well known in block (the 
fix is in the 6.18 pull) that it is causing panics on stable, and didn't 
make it back to 6.17 past the initial merge window (as well as 6.16).

Presumably adjusting the request depth isn't common (if this is indeed 
the problem)?

I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", 
ATTR{queue/nr_requests}="1024" as a udev rule.

Jens, is this the only patch from August that is needed to fix this panic?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Kyle.

https://lore.kernel.org/all/37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de/

https://lore.kernel.org/all/175710207227.395498.3249940818566938241.b4-ty@kernel.dk/

