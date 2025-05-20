Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989D2609E6
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756768; cv=none; b=fNWxHiwqmaIxe4w5QzNmyjnaYi0uXL8cIbSSQuotrG15EjTDqdxMXx8v5MD9Ek0ITLMvrrV9Y8a0KHfwOnelWFVsw4ZD6X676xDaSEeIb/+zI6BtQZ0CphvbPt1wJJaDTTtQJTIg5JU/s/xZgPFoxz6CAg/rhDWtBcU21Bmvgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756768; c=relaxed/simple;
	bh=7fON7TN7jQAdDcJfrs+MB3iFM8C0eGSkz9FF+Cxo/zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf8i/JSlTDir4Z+AIqnIahSSUappOhwRT+zHndg+X4H3tgOJsSDC9TRHEBOq8utyg+hHrAk5xM7UtoBnRH+h5FEmY8+pJ6bdE0fJYNpo1m6vnLBZv3fT0A5t99ZLMp7Uwau+X/RGCM7tvby8WfJ9iMlytauaAKsg/VZAIH3/tMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Sxp2ncy/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Sxp2ncy/"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85e751cffbeso404422739f.0
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747756765; x=1748361565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juqOB3f3EFAzzo89YtJE/wPhoNt5TEljfeEq4uiZNZQ=;
        b=Sxp2ncy/RHlaXgM5sJarSKjcROrmPfY/9t7fvk0xz9e2OQZpX7e9gzNxHss5vG7M4Y
         AE0scKG3GGk1JJWa23N/wlTeEHmNo6Ef56wdXksAslSAS24Nur5+Y+rYXOj+nyCRyvck
         xmY6A0dRoX48CpwxePek9StBJaSnH8rjv0a5yuIATeZ1+STDIKBOofXhWxNa0SirLX5v
         p82G27c4vXdS6VNlX2KUO9uEPvMOK0EMc7pBFmHoSZd1RsEB8U82mUauYkswl/f2oWWJ
         RKkhJN+7aZGLO1Lhu7bL19kzIfRCGn8H9SIclf7wAdWH/P+LLXC2hSja2EXsy7tsg5ts
         /HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756765; x=1748361565;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juqOB3f3EFAzzo89YtJE/wPhoNt5TEljfeEq4uiZNZQ=;
        b=sxGYSnHUyRa+orytl+X6f+Y/a0JFBzv6+qy9irdDsi5a/VdxHuxRTSRmChkFST81dt
         4eUgR3riJTg7MWqvZWThEOWf9bIG8/hQ9SrWzEjA/dRwxvXAdbJQhVmVqF/GUX/OVr9/
         uTnuXcSd7fo2wF3vg9vhhuPWhGH5FzMWh9D2N92PBd/cPOgjXCPm1IyF0qZjMbL0FzO1
         nDXouOSeBAQiiBAGX6vFsj+LwqG8BVK+wT7tfjqsWVlk+GbcgWm+we3WYD1zQvjmWPZr
         atOUMKMwaDizVh8UayalsAy+sDaeeC1GJU/Nqz+a9DUbLdG4yQpHQ/QDqDo5W37G6NGg
         iXqg==
X-Forwarded-Encrypted: i=1; AJvYcCXTsIAS1GlkNI2eioFelR2ZOpmpIRw7DBstNMbcVY4HU1nLa1xnD8e/hjC9BOg2aGDNOoaG3TwVkLNuIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYx6nTaCE5HspYOB0k3f39wkcL3O7SM7TeFxQYgQ0p+M55iZG
	Lhl3PYPIstvTnM5Nsurg1CccCw1J3Stmevoz43j8g80WsoQJSYJsKs7zxPndvH3lChk=
X-Gm-Gg: ASbGncuxKtn0bosLSjeyOvMJmTeslKS0M6FrHbQkfy/TDnqDM7BZ67TSHOd2fwsLlvo
	TchRRDWXJy93oOhZiOLHHF8pwIDMx4onBrbP/0zQ6Ny4EN0ATBNJja5wfxKhTPyiKnBfWr6Kw9z
	KWFu3KiL6qAHQk+8S12/cYO54/6OH1XPtS0KDEYh9dT744n/3vsCLA6v01hFxYT/dqzxD1Za/a2
	swWvbh/ph2Hejn1aScr6nhJJki3cmnGT4KSddhqk/PAKvxMi2a2qonJGRqdFcZ2WoPtFHwBbpft
	rRGFIQskjAUBrO+Ca+asyrOy1KMBTqUBwhKgXb1Iv9AadY8=
X-Google-Smtp-Source: AGHT+IFi9UcErwwDdMtK0ZXnNOLhwueIECkH6y0/k5enmWUX3uHiMG4XVug8UWRrOXL5J4Ukgg1Gdg==
X-Received: by 2002:a05:6e02:3784:b0:3d9:2aa3:fe2e with SMTP id e9e14a558f8ab-3db8574f752mr147921355ab.10.1747756764683;
        Tue, 20 May 2025 08:59:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4b2f45sm2281905173.126.2025.05.20.08.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:59:24 -0700 (PDT)
Message-ID: <d76bbb1b-a7a0-49b5-b34f-3e9acd181411@kernel.dk>
Date: Tue, 20 May 2025 09:59:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/6] ublk: prepare for supporting to register request
 buffer automatically
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
 <20250520045455.515691-3-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250520045455.515691-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 10:54 PM, Ming Lei wrote:
> @@ -2014,6 +2064,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>  		return -EINVAL;
>  	}
>  
> +	if (ublk_support_auto_buf_reg(ubq)) {
> +		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> +			WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
> +						issue_flags));
> +			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
> +		}
> +	}
> +

Debug or WARN_ON_ONCE() statements with side effects is generally not a
good idea, imho. Would be cleaner to do:

	ret = io_buffer_unregister_bvec(cmd, 0, issue_flags);
	WARN_ON_ONCE(ret);

and ditto for the next patch that then updates it.

But pretty minor, not worth a respin. This series looks ready to me at
this point.

-- 
Jens Axboe
