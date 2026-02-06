Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522529ACF7
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392041; cv=none; b=kHQkT9EriUxfvHzq8aXTZ0m6EGcwg9rxwQD+KRO4YWqTIHFWyu/9SbaDAKSeESGx+5DfkubGuN3vXKd0BBWxU6xnPBJeKjdOp4Fp1579rbCHbLmHd2s9IVs5RbpvFmXBzyLZt6pZ4QO0LFJAPacWZMzjxcijN13aonDY9Gs1+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392041; c=relaxed/simple;
	bh=ZfH9HPV4D4gLTNXhRnWVo0LRswRQ2U4/RdvMjsDc7zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiMAYa7IgTnJfwXu0Go0Wv2ITfKHpOd8ZP2ujYrsWXirOr39wCVXmZuFVeSWaQhTRsGeRJ3wI/Lt3iOPYw24eSt6uN+k5XG0gEdc+knnhRN3/EzCnw8tmJr6Z6sXEw4/BTK8DwVHObqzttfATGUVJmzxBq9HCRjYJvibt1D69W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAlrPT/J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAlrPT/J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so17641435e9.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392040; x=1770996840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0nyb9gSRbYF+JCXJne8YIqeWZN4AZ97HH7ruXtTGy2U=;
        b=EAlrPT/J5/vBhRqUkDJaPLDWi3JZzWs62H7UMrRBRlrKMUjc0saHTBB66qQ0cf731H
         0mOxNKHhbMGo0mWCzFdjMHOMFDhrHgV3wfDSicUXBUzfotqvNQvhbH+bbMB3F5eUEKl9
         8oVuKg1nb11+co+97mHE0tosankzZZvU1zf2igl3fov9rS1ylfjH0WzaTi5nrdwRs3vV
         xjkBNljvXUNR3LlX23uB9LjvEldx7dwv8yMGoPUKKd18chA94uBlql+WXOMR03Xa9/6b
         dDLPrNEABzCdqcoX7euNB1H2Wkea77/8UmyL0xaGtpP63Wz7/4A2iJGYcY4fyW4M/Q/p
         Tc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392040; x=1770996840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nyb9gSRbYF+JCXJne8YIqeWZN4AZ97HH7ruXtTGy2U=;
        b=aKQiLkDlEporggkshs6IKtsoeBkIP0jIjoaUemZKIGwhPujclf/fNg9lgWyBywKSEB
         UuL4olVpssGCpaWFGhjU+tsptmlD43QQBCywUOid4jj1+Y35paxU8OIN5L0CwKJOKUqQ
         KiQ4ui6FYdjAfjmDFTd47evlhwTtkLzkpWL0nuRN9klHfniHTYGmYEOPfn+YZKFVgpyi
         AJgVZo7k9Zg3KGUVnc7sLITT33vn3jpnzvV5DdBNnG0ZiLswrUTsI3TXjdAtcRvlCRSu
         y1uc5zxwksrLDdw9EuxdOiM8X+EJunpXGwcVUHre0H8Eepl0Wlwp11eH3/VdwXP3jk7v
         tCcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpnnyFcF39mP2WnqVTV2REcY9snbi6UQJeZurJ4DdJQYCob+R7M/08TsPFtG5tspnmZ8G2nlqytfsU9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbN9kkIfL3yQyKfbXbXDVdVn3M68Ldr9YdIhBC19v4mnq6WlQ
	fhu197E6UXOqDnaYp9mIDucXZmzNDP/1Yn/JOyHBN2RA+asZDLM+LdLi
X-Gm-Gg: AZuq6aJaJThvRgZbhRRekKYX5osIvV0fbUVLGVlZ/3khi7QY3bLwKsFq42Ur4rTrmuK
	E5kyF4vM80IRaqzWwNAX56K/ziSJ9aHvPc39n1gy2B0mIdDIyWDE6Wg0B5f4yDeOtN84rAN0Dh9
	hS44tBwWBUPU3HY8gYLXYl6kSBElDAUelHTlRV++33VroFJAElFsrF/pO+QusZnDJEmwW/Yarw3
	5nmLw7Y2Rla50AUUO7JFDeLPQZ+47WSgvmvvfBStJeSNYTqffT2Mc3KXhjKpNwNcIjDB0nwb7S2
	vwH0EGOaFfNh64+MpKi1mgh6Ol6FXRAiSqGylVBGWGDsX+vFL2VnRl2ZZN5L9BKAJXFN2EzAhQ2
	7QTkW2prGO50ajiwh1Fz2d1c8oMNlggx+KO++LkOQzNTjzSV30pbpGSLtUgN2zvCc6zBh3Egxfw
	cANvOj9vFIFtw2XhCGBV8+RhhxnozpLwz7ICbP
X-Received: by 2002:a05:600c:4745:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-48320227106mr45136715e9.33.1770392039359;
        Fri, 06 Feb 2026 07:33:59 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206d8c60sm82261135e9.8.2026.02.06.07.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:33:59 -0800 (PST)
Message-ID: <b9ed839b-4336-44cf-bd66-4a15811cf6bc@gmail.com>
Date: Fri, 6 Feb 2026 16:33:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] sed-opal: refactor (split) IOC_OPAL_LR_SETUP
 internals.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-6-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-6-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:17 PM, Ondrej Kozina wrote:
> IOC_OPAL_LR_SETUP is used to set up a locking range entirely under a
> single authority (usually Admin1), but for Single User Mode (SUM),
> the permissions for attributes (RangeStart, RangeLength)
> and (ReadLockEnable, WriteLockEnable, ReadLocked, WriteLocked)
> may be split between two different authorities. Typically, it is Admin1
> for the former and the User associated with the LockingRange in SUM
> for the latter.
> 
> This commit only splits the internals in preparation for the introduction
> of separate ioctls for setting RangeStart, RangeLength and the rest
> using new ioctl calls.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/sed-opal.c | 73 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 45 insertions(+), 28 deletions(-)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

