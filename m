Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77B192590
	for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103307; cv=none; b=jRAlXuNG9fv0aPzJGbZMoQr5e3glc3oYw+fRI55gDoHfv40fE2mH9XlEOvU804DzRZdTa6Z+nh68HRngIkhmFm8fWGGaDS51fGOyz+18cPYY/osDF48ZlzidY/2NX11b7U6UhjQkOkK3gBx0gzZgQyRl/MEcadyElomg7NsNsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103307; c=relaxed/simple;
	bh=Ljm9lHSWHJuvEOaPyKMhOHXf0fTCsJ/D9lwyKKoju7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je9MF04GuaqHsIOA8RlQeBiAMeLtxk5cz2AQaqB5xMx0v5mHg8d8OQWTraHTwQDs0akMHJa2KKjGN84U8duPnypvu/2Gc7hI//SjsCl/RoWJ2bYZWKKr7Bopssxit38Ach0IEFmYVNeoFSq2CCwImnT4OMdHukAQcJPe0TCPlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D/3B61aJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D/3B61aJ"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-467161c4ba7so1814411b6e.0
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774103304; x=1774708104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=D/3B61aJ8a8WPzCw5ztDzz0FSJUiv/Qr9mA2lG235GydGFjAmzb1xZQeGuOxmxFYxx
         9g/O2OMTTMLLOaKS+Kkl7Mxi4zlKIngC2tIdx3fTsn56oaaaUMAFWhVEse+CmNAoWJWE
         n7rDD3EUYIA0GnTI+duQdSCQ06hHgD4Fdy+ptJC7B6EXwcDPmeS16DnBsXzBiewmKmkq
         RXCcD9a9Z1fvapboemM+kMRBzjQ3uikJbGtTP1jVe+LvytJSy9Z4QxfJ2DBOYzmkyUP4
         vcOYFMkkxoA5qQhsKyiK/HutQhxhEhM1LFAEqTtQCY3/6mJb4T+wRZNryQ/Yg/A6ytIL
         yjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103304; x=1774708104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=RQ1/kG7iqWYAo3oazidvGKod3zhp/GGmx2kONixyNC4JnBZpz+5c79PV7QMIMuo0Yy
         yYdaDxiMzXq/yJQPWWCWE64dJpm07TKAYyMMbWoiGZ2JooRsKxBOAscaRuKue5tkCN9U
         l7YnoO5BLJqn9OeoMiASKk6WxkoA/Ce1R4YGgvp5uF6DMstVbVYImDm5oV+yWxjmhjgl
         cKCDmooNMSerl9OF/bur4cHEqilAVHykB13TX6zXJg2a5pidAeyW8+R3MU3kaqsQCkco
         h9ZeTl715Gc3bSAHvkrwfR7O9TvI5adN5qscFUPhcWBo2tT5PtVNlfXEaL/u63xX1ZZe
         ZCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUttTspyMrJvt5O13S1nBN9Exv8zlhbal0KSX+TRS5snjTFWrvpcnr08RM3Db+ZKZwB3DnApFfNS7/V2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVF9aEFt7Y+fU3YpiD6vn2UAXCFDXkQDauT0m3iM7zKtw+stmi
	x1wceSa25NjpMafzEvvQCB1MCwvu2tK6cSbUxVEg95gLUb3pJuJPS5dGO13AVUGRwBM=
X-Gm-Gg: ATEYQzwNyBeVU9bUu7prpxUo+OqAd3vlNWQTy/XVwgDToKtnz8dGfVX5b8O0qXSqhs9
	keAj4rmKUHXgmkmoBaX+NOWzaHQNCXxGDwXj0y+P2fKUOxrQZ1VFzkyHR2zxP/GEs91gHaiwTnV
	5/GSJHEQ5W7HptH46MEGLzalyt+Vq7DFkjf/HZo3xob50ACqI8JWSTUDvJlO1WvuWkLFL01cDaq
	97VXoiRXzVxqcx0y61DhYd9tBR4K79pQZksk7OYO9MbXMvV3PeXsrv2cdQOfhWmZTJ2dj5UBcdh
	MKzX5Gk7lGCsXC6kDwnXlL6Q/jEzdk+7DLxyI7oQT/0RM5OWkUesdIXOeFdWJaupoUmflM4liqU
	XPilRfBsshGokHAZ6eVLVUaotBjLUTJHHbcD0rIHjAyOjSAZth3cO+fUOodHk3mCq85+FDtea1a
	/XcuqATBem/HqeFJfP2pTOsGnpPJMMxoUCmJf2LuWPMPnZv2qfQnNDlxIPV2jjF9tKy0tfoj3vz
	ME9O57bYw==
X-Received: by 2002:a05:6808:a607:10b0:467:f56b:5267 with SMTP id 5614622812f47-467f56b6c30mr1978974b6e.10.1774103304390;
        Sat, 21 Mar 2026 07:28:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddf9d4sm4797944fac.16.2026.03.21.07.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 07:28:23 -0700 (PDT)
Message-ID: <12bb0db8-e8a3-4e08-89e9-db9a1348bea3@kernel.dk>
Date: Sat, 21 Mar 2026 08:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
To: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Stefan Haberland
 <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Richard Russon (FlatCap)" <ldm@flatcap.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-hardening@vger.kernel.org
References: <20260321004840.work.670-kees@kernel.org>
 <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 6:08 AM, Josh Law wrote:
> Reviewed-by: Josh Law <objecting@objecting.org>

Please don't quote 1000 lines just to add that, that's somewhat annoying
in terms of scrolling to find wtf was said, and it's hugely wasteful.
Prune your replies.

-- 
Jens Axboe
