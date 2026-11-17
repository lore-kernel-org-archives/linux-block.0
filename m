Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925863;
	b=PaBzE7WmgXe9kMlQ/GLKOW17laOZlhMQArDEP2JQtiJYAjcO0xNlGqXWyMl7lc2kJd36
	 Eg7F237CUvS5tfNWPLbtLRdrVNOHfrPmLW6YLXU0pLKjJnfrhHjNWuiKtxjwqxUSrc3Fv
	 7MLzLnRPXTJKb78c4zDyfNEo5gcfvQ+0I9si7yx0NOL6W9wH4VX9/qQ4Rm7Z5rY8oWu2Q
	 EXgaHS9+U/zDHhAM1I8dru4NxvbIjCM5MP19mYGMWxsNN91nIr7vzFLs8Is1ina0ksZCr
	 GKgdN7iNc2caV8yx3BvMcxZ+ze9oPiwPezvnsVTFyTdHVjSptYkM/0c/hG37qAWG7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
	b=tPJXLrBSQFRDg0aC5ouMAhbssx87S32W/ljW0IDTredwLWIwGxVEy2VXTMvu9YfmVuf/
	 cninJR+84pFdgSDfg3SR5WUX5T3ExVnRMbOeyjb+xamDx53dgz1NPVVImmXz5H7R9Nayh
	 KeG+ioNNnqDYCCX/mEC56VmpI8F2mZ19E0ptdHdVExrMaijw12hePXU4dHB06t1SlCDVq
	 seOxbNJpEIG2z16xGFQJ4Fw1ebllJhKNJAVjnduxrMMPZcwxBLGd0b83d8Ki/T9S+aSZw
	 Wf9tx73NqwLpjBNRnaAZjj96Y25F84ebRwtWwJPsa3uG06I1jx5lvA4xY39CQ9jnL7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=dkZwvxCn;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF34606A334
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF34606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=dkZwvxCn
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso31724495e9.2
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794925861; x=1795530661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
        b=dkZwvxCn+HSmhAh2arRbuUnjflLbwYkcqJ6vsT3a843aQrKbK4v6U2ckv0sjj87sRm
         Q12htFrZ0zRZZ1k9gPt3MntpwX0oqMEkcsD5Mb7B5JG/OZV5nAWkdRdU4JMMIIkVqKCx
         VqIJNo5Ne+mBvDlR4eqkSdxg8SBhQYFnRoKr3nJs7JOeLvKrNtRY+2GVY1AaqtKRYM3/
         ko7RqPZbWHYSEjgXYf82Y9jUo6Mgx57XNzvuiuXBRMUOuXsMR2xgAfftV8GK99zRXJ/g
         22FXnWLxdWdJovuDvIofejBHuiJzramtuaXgKgNABE8ntCXwrHZ0yEJsJCwR59GKB4UI
         xqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925861; x=1795530661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ph2zl6rwyEKg3O5TgI+UXa3FjOJ6TNy4j3lJzs1fJg=;
        b=ueOt09yF0wkf5/ITXuHbdsM7ws3izNQ94VvfvYUsmRrFFiP1GYow4NL7fak5WRzbte
         1NMtoxfLzvISH1T+2A/dbZ1wOhZXC+5mcssZy1O8NN5boyhKbYXYFxGfid+eMPYXdnB+
         MBA2Fa7h0eQOi1/lLbfBZ+UIHLcCt+4sixLDB4P7eZYU9VH5BXxWB3kZAYIQkU+FnsQV
         RNOUU77o3okcYkb3lEfaJ6rzSltNUL7gc9Q39JIPa/zGGHVmB04t8xh8hT7epUwU9yIy
         cqoHcNRwRmWBolVuFfdR3IsotUGa5BZPbxKCyN8Dqhz5IQaWfyQho8R97PChokP0SZEW
         jN4A==
X-Forwarded-Encrypted: i=1; AL+hErGs6aoUzSg7oUT5QyDK4YxKvjo/zIUpLv+dzNPc/Dr5ObKCpvpDE1dc92LQvyNe5A8c6JY/sX/b/1Rg2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hKV7yfsegJDBHbRPlu0sWTbRTrDVMyrMkRQLIxlbVQEl5SFLI
	C2NWliwUpCe3unzqJ2zlxetfSJJgGlCwmGM34ScUsACgA1VhCO5zep4PfoeCe7Sn1zA=
X-Gm-Gg: AYBFou3rDDgsAZPhmu83FrbuhGP7QTAHx6wLnqnG4bLkg2KUQVx/FPEL0opZIjlKqbU
	WjT/i69EXQudftFDYvtxpqZHJAdDOkTMSI43Nc5OmwCfgCctvGhHx/Htuq6xYI2e+8P8N1D6rzA
	O3wHTplGmL40oUYx41lQX2dnzVVcMnhvOA3C+kTSdRaBDJyCLUWp94vYXRMuhI2B8RhWuK3bEcA
	PBf5JcRNsIi7R1gUnbhAQW9yZ7A1mQ+JgIyr1AHdF34N5bCD6j8zBXAOlpnGkVL5igpRDoyMkNb
	30Yk7OdflPf8ntl3/9q61idtdDt/m3qGGNjhkjtMpRp5/pNqfFZcY2APQIaAf4QfiDI5IS6TKM9
	/y1m8V0NhsWForb3SJhG2KEcdt7VuneQNv4ixza/kEM+t3aBX1qja26WKQNns+bGFDMVToAc81v
	7Q7gYGGBe0/uh0ZIZ5eyRxGHlzv9vtTvhqf1S+TnrORuZb2Kvf4lIZqX+BPAyqzL5v3G1Qrk0nR
	uciD7McVAECs2kvsY6hQLcpZXkOA83N0v9o7HzL4Q/p5SCQsgEb3CTuTwZy9L8MWHipKofaal+i
	AAiGAsp3utXl1hKJfgzeFDkLhitPYeh8yBICCXWcL4jo0YZma/EKaB/fdMyWK34ysfHcLRf7
X-Received: by 2002:a05:600c:512:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4bb55a5d7bamr222461205e9.6.1794925860901;
        Tue, 17 Nov 2026 06:31:00 -0800 (PST)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783e9288sm73541775e9.15.2026.11.17.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:30:59 -0800 (PST)
Date: Tue, 17 Nov 2026 15:30:58 +0100
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] drbd: select CRYPTO and CRYPTO_HASH
Message-ID: <avxkfIwp5tqxpwoX@linbit.com>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org
References: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>
 <20261111212245.GB41158@quark>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111212245.GB41158@quark>

On Wed, Nov 11, 2026 at 01:22:45PM -0800, Eric Biggers wrote:
>On Wed, Nov 11, 2026 at 09:35:05AM +0100, Christoph Böhmwalder wrote:
>> DRBD uses the shash API for the data integrity, online verify and
>> checksum-based resync algorithms and for peer authentication, but
>> BLK_DEV_DRBD does not select the crypto core. With CRYPTO=n, a kernel
>> with DRBD built in does not link:
>>
>>   ld: drbd_sender.c:(.text+0x137f): undefined reference to `crypto_shash_finup'
>>   ld: drbd_receiver.c:(.text+0x58f): undefined reference to `crypto_alloc_shash'
>>
>> Select CRYPTO and CRYPTO_HASH.
>>
>> Fixes: b411b3637fa7 ("The DRBD driver")
>> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>
>Looks fine for now, but you should consider what algorithms DRBD
>actually needs and consider switching to the library APIs for those
>instead of crypto_shash.  Presumably not more than a handful are
>actually used in practice with DRBD, and you don't really need to keep
>"supporting" MD4, Whirlpool, RIPEMD, CMAC-SM4, etc.?
>
>The "pass arbitrary string from userspace to crypto_alloc_*()" strategy
>has been problematic for other kernel features using it.  For one, it
>gives access to algorithms that are obsolete, insecure, redundant or
>make no sense for the use case.  And it makes it more difficult to
>remove unused algorithms from the crypto API, since it makes it harder
>to prove that they are in fact unused.
>
>Note that the crypto_shash API is also somewhat inefficient and
>difficult to use correctly, even though it's better than crypto_ahash.
>(And the DRBD driver got it wrong, so just FYI, you should expect fixes
>if you keep using it...).
>
>- Eric

Noted, we'll work on that separately. But I think in the meantime this 
is better and more correct than nothing.

Best Regards,
Christoph
