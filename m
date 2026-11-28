Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795835782;
	b=tvWfDYoYKUnvhYFLkf1vs/CtvYhNXUcxjit3MzWwV7hL59Wvr5PyVVeGI1Ez0u/3bjc2
	 wSlpnTWDNY3qKQBrzIUCJ/OwtbJHQI39JsR8XUbxKyWxjrXLSQ9yzjm60MODDWywdbmDj
	 qTm+ZhHB25nXoXahZ568KGEYZqnPBvbJeKY1+rYRuO+WD+tpOiALE0W+YAB9EuLJygvJ0
	 WJu4ICuUYQxJbmgR4pxBkn12Y+IvY7Z3nmshpflEFaCqETqZ3eoYWLusDzMUfAbqIQXrY
	 31V1GsQ2Woi77GO/chCl6/+F7j+pcIWEUiHAwgtWzpDL5RFEdD8l0EVMt/ybi8vQB8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795835782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
	b=og1Fcn1Hy3TLggFEsnqAR9bg2qxItR7PZcol48w5LQHQ+C0N3J0iewkJWHG3BXBnq4rf
	 1MJ73qEJMS6yuWiB1KqLm0oUQljjps/W0zgqcHaU5G88dW4rBoVxQ+WoeI0EuudiBoVK5
	 WEdKMgoLStbeNouRiKsQPAVgwF7DIsp9jnY8ZTAfeYd4i1c/eLxSy3I/tgC6AP8S00HuH
	 34oOw3o4sfxRfkrTktQFmihMjipZpW4bHIBWxRTGDkWMeYTNTpV4cSYsDWMiMguXSIJ+s
	 Bjn8JKlxsCGC2cMj4JUv6OzVqPl5CuO3Odutu/BczEftYgjYUY5cn2m6gq5lIyZiA2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WR3iI+MZ;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E8606A31F
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 03:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D2E8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WR3iI+MZ
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3863db981d4so12283562eec.0
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795835781; x=1796440581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
        b=WR3iI+MZM8Sx695G4+b7/SPK73hGU4cE4Qu1+7lznzVRy9uR5PJ35VG6f5pTrbRFyY
         AIVQjcLeImXwpU8a+tF/IWC4L8BIhkXR/j3cTsB4AKSNdyAEf6y07NrQ4xW7C4Y5Jwey
         tdUuSSdI7epNQciLkyqg45/y0f0f9n9lYSa7JCftlaQYlIZ6iwyHLqEdJwlujqcQFtlg
         nrYoxbd2x7LeKtljtZqE3S8Fy0gRmiwSGLkYTfgcx6jz/E5B+KAwO4fhqs8dcGezw1jL
         Hry9F2MwN03ja63mizJg66neaADF7CYPIxRS5+14C3mK4xZZd35pUou7h+UqUUyRtTo1
         yFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795835781; x=1796440581;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Ok5Lrv8H0htPRrt5HaRVW8ZGBYCsHXaIAgQkyhQ8Io=;
        b=rEQre6wxJDMTOy/2HqTFhaAW6Da2MsOhDNxs5/Ru1Acheqx6hr0bmtV06G0u+Sc1NX
         W/q9QQBp9d3SzlnM7BbqtTbuQ6SfI1yhYnSLH05aa3llXZpO87TAd5dQl+8MqGwrx2Ka
         nwh1uPeel0ivROMPyXxBtzSIiIia+g20dgsbQGT6L2HOWFDu+p+ysS7Y48Kg2zYYsr9s
         Ql0B0Qs5NXRVbD7F9nrw7+81V9AnJ3y5rFOP14lz+FzzJoPJjegerTH8X6a9dA15BZkk
         3jeD2KRcVO0mSxLBEPceciMsWJTXcF5l3mUW1uwvFeq3Z3xPB+pi17WpXEP4XCo9EH8L
         THEA==
X-Forwarded-Encrypted: i=1; AL+hErE60YcKfffq6w53OUo65bZ0V+GDCz3fmznDIyqvXP0/BXZ8mDZCMc4PfD9N7DHkrFPjEtyuzqAC55QoLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ic6mLIwhZXnw5mojDx1gv+Lzzzv0ylYwOKWXwkgc8oM46OyOq
	8GFT+cGfQdXgPH56YSKFDjeEL7v+V7cngcbI2XDIUPVinVOUZfXUFQW1vIOzTpVUpus=
X-Gm-Gg: AZFdTZdLMGeaM7KsBxxXPpTYAXwVUzdHSfGSArF3I4ooutH0R+L+/+dGGcVl+eIlSID
	CfpWPGM6mkAsKtzl2l4mtt7HXnnU8DiJ4u4GKd7kM1ohX3lFzIygnAa9T/Zc90xMur/DYGcAdyy
	1YcxPPvQXH/YKdUKNs5REqXXTwSctMZPdkbCO0tALb0Tb+V3YXX6xue7aEcLoAe+CN4/sHYVSmm
	YM9QvzxJiYOZmDMwNmkzZP6K70hAIPlbrRtX9ogZYN8zvCiEFcTgdLglo7n7nHTslXTkmqAacEX
	PYCyhn4RladklcnNDcRJXjqH8OtPWYThnsru7oJwygNkyiTROEyPVmNc5GlLalyquG4JCBo11oy
	Y7nhiAGFW+ZKmAPjjWNydnNJ2zsrR35ePfeehrqhG9J/dXgT1wJtUhn9kjhzaI7v9Ew4LsOGA46
	Eix3LwobqYshCGfphkx/HZVHxbEO5tonl+lZFLp5tbyJa2c0qBDa9I+2c/yQID7TsnE+kEVb8XC
	R+c0m29yjebVmf5eZRe8gw4yo3V2W05c3mQCk1ompxWbWJS90wD0XqyyYOFtbLC97D7X/0eNfYz
	4jFz3oq5SNA74QHAs4kwHE+0c0wrGa619AtZLLwximTzqZzlAeE+bRrybKNIAa9TVJ6pinlBOpC
	Cf7l+ckcvnNvCOXlyATHSsejWfi4eJjlq4IUxEo/4rv50AEIQ
X-Received: by 2002:a05:693c:69d4:b0:386:5adb:ac25 with SMTP id 5a478bee46e88-3865adbb1d2mr20378523eec.22.1795835781504;
        Fri, 27 Nov 2026 19:16:21 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm36623124eec.17.2026.11.27.19.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:16:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 florence.schadle@ssi.gouv.fr, frederic.tronel@centralesupelec.fr, 
 louis.rilling@irisa.fr
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap
 reference tags
Message-Id: <179583578039.94675.216278078774861873.b4-ty@b4>
Date: Fri, 27 Nov 2026 20:16:20 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 20 Nov 2026 20:56:44 +0100, Zakaria Belkadi wrote:
> On an io_uring O_DIRECT write, bio_integrity_map_user() can attach the
> caller's protection information (PI) buffer directly to the bio. The
> block layer pins the pages for reading, but reference-tag remapping can
> write to those same pages.
> 
> A caller with write access to a block device whose integrity profile
> enables reference-tag remapping can therefore modify a page it can
> only map for reading. In testing, remapping changed a tag in the page
> cache of a read-only file. With a PI buffer backed by the shared zero
> page, the kernel faulted during remapping.
> 
> [...]

Applied, thanks!

[1/1] block: bounce user PI when writes may remap reference tags
      commit: 348d25516523c3edfec477d56abde2b2491dbf9d

Best regards,
-- 
Jens Axboe



