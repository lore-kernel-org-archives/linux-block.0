Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AE2561BD
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912231; cv=none; b=VOtdqVSxLnkQE7HKR7Ou2ZRNqc2EnqtlCxqCUeoLrYzPHyspbMDpTsb2IiEVRTz920ND+3YDJOUFdrVTQnHdSKGlSTUIKEIq+OHTJ8c8VgWugo72xlmEB5UvHPedSVKP/HJI6HNaEBVwQWfbhTfuCpPrcajCR4eKFOrUoxmqElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912231; c=relaxed/simple;
	bh=CqC77qzw3ISauG488MUFcYMb1b5ZZBc3dwKApmWkiP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vawlleiw5heMb+RWNO2VC3jD0lV7n8alHFUmt/nssDjy0q9OgAl7008EdWTE4NhpOWGklsyBWxKQJ8D35q0gc+xGPjcjW+fKPcSpU9oUtK/vY8vITrNyL9SDoK4Kgh7oqQoQNKUsALkHl81bHQCFiVpdxoLIPWcKNOIrrE4PKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DONDrQ9d; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DONDrQ9d"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so93325939f.1
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744912227; x=1745517027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmlweCgC3tEg18/x6WTowxIDIcAJ/W58hMDL+eujvTM=;
        b=DONDrQ9dccL0kLeuEP/tQmbHUMLm9/E/AasLauiU8PTG8/pppZvbzFzARWQl25iazM
         smU2cLgbnvrQfMVjOmqMlDxkYC3zXPw4W5sK2J79BuVy3/XAgqQeQqPOCxt9huUbjgXJ
         GkqMQvwa/MEOgjpAvZqct/PAWX+IvWOBHyaDtPsgv6x+UrQ8/iIxobpLxbSVFoO5c7Mu
         Nidfdv3IvqPLRt28eCSrktZccjfTXDkaJ+n0guAKge8VhxFaHhV+Uaqn/poo8ypZvav/
         vqjb1D4bQKmmkkjagcoqEbKqBWHe2lA4xOMh938d/AZLVtoXu+vZ8MmygU2uj+NeQpw4
         HbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912227; x=1745517027;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmlweCgC3tEg18/x6WTowxIDIcAJ/W58hMDL+eujvTM=;
        b=I5pwh/RtsyxJUPS0J5tLbh1FiuDlwJMZ0nYZx3ZPU3hV2dn8/556W6GA8ROWSlXE1c
         PVfH3mNWZ+Y30nkP7GJC6ikZv3FnkLqA8aVvpn42IdN+FScCQvmlX4NcQdJ0e6lENUWS
         bsDfjkVzNU+OYaN2nwTm9epLSoCqAeGm4RIZ3WaDZ8q/Mer108ynigBGb72f9FeUG9VT
         QEgkZjOBzMnQJGOV1Fzm3n52TrsJkFI1KmUrDPhqD7+HXW5Pj2g8wTc+QGzb/+f6cLK0
         L/r2KH/AcmJ1zNBDhW+tZqin4VQFkvVluBgZmTFNA3uEynVgMjrLGfiK4lgzGjPVGTYp
         BZRw==
X-Forwarded-Encrypted: i=1; AJvYcCUszYYSo1Ptb6pXWcwpQ5TyZpm4yOaFsfpCNtR9ojo5iiAOuxDZV1WKVeXt4cifxJVf6YRiKbVTy2vfQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4N5RRKLBKkXZ+Axwq83s+KyxuGgX2UiLaVr4TDYgKLQLWAXY
	IBPHcUTey/qu+WWj1ZgH5JG3iAQZdm/fbGULx+cAEhuYriY3tFs0Y5su1QWCeRzuoES3l75LiBg
	2
X-Gm-Gg: ASbGncuQ+lPH6QJToDD42ZPTL3MxLkAfpfsZW2Pd6t0kfEf+5USAxey0ppzrs8TXHEr
	NOeRERwZCL2FhpYVW3OvilMuxkIfvrgFzpGPgFDUpMif/sBjI1S5ma4n6vrJK0KjkCY5PSER9/l
	8Zj8zL4uRjNnO5qx0gwlnypCkuNJhoOrRVyiHehdS+e0S5EhORdYWozCNFBjn5ruerJCaLB4wzD
	1UY2SZZsEdKgKo8xoGHHyRxo8UIogh42F+n2PVIKNsJuARjQ60knw+Yxpa835fgJnlV/g74Zha+
	M4rxiSTFgM8FKTOWlnwTpWrkYog656K3cxuEPX3Zd+EcTRyZ
X-Google-Smtp-Source: AGHT+IHMxA903rWfd0wrzPuQ3rzCmjN/YuyXoTaBlLaKe3sVrxietdqCbWIiU+ps3KHrniKmVPH5CA==
X-Received: by 2002:a05:6602:4885:b0:85b:3449:faa2 with SMTP id ca18e2360f4ac-861c57fb422mr911123239f.9.1744912227544;
        Thu, 17 Apr 2025 10:50:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861d95de823sm4127939f.7.2025.04.17.10.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 10:50:26 -0700 (PDT)
Message-ID: <da093de5-5c7e-4f97-a2b1-9bd8e9f31552@kernel.dk>
Date: Thu, 17 Apr 2025 11:50:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>,
 linux-block@vger.kernel.org
Cc: arnd@arndb.de, ojeda@kernel.org, nathan@kernel.org,
 martin.petersen@oracle.com
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 10:34 AM, Prasad Singamsetty wrote:
> When CONFIG_FAIL_MAKE_REQUEST is not enabled, gcc may optimize out
> calls to should_fail_bio() because the content of should_fail_bio()
> is empty returning always 'false'. The gcc compiler then detects
> the function call to should_fail_bio() being empty and optimizes
> out the call to it. This prevents block I/O error injection programs
> attached to it from working. The compiler is not aware of the side
> effect of calling this probe function.

That's working as designed and is what we would want. Rather than patch
around that, why not just enable CONFIG_FAIL_MAKE_REQUEST for whatever
you're trying to do?

-- 
Jens Axboe
