Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0E1CF83
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673332; cv=none; b=YEh/11J/cPrJPCjDSUeEOlYhOYtSuFv/BX0bCcXEV2eHKwMOjYlpdURfx/qOhTwVc7jjX4MykSt4DilzLk8OEGUNk+bELLxI8LMlBm5Lj2G45uliyUqnG6yRn3JrFXn8yS6KNeUob28vuM0qPEZveVcXDVZkh1nBFw/i9ip36F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673332; c=relaxed/simple;
	bh=1YkRfjJYK+v2WeTTZB/f3vz7KrZOC3goeVcTxWDizWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh74YrQZiZDfPTwiJENceRP8doPggh7A4evGTu8TzVN5fLunurqKNmomwgnXYmmP3geZ9PpWVuLKSSf+hVJOvphPTU32o82EC9md7ZlYDXmGuBU+qt7r1rFXiZgHP8Ds2MbDRcFn81sotxg3a6hJsgH7G+jK/VckIfW7tLUImuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v8iprpZo; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v8iprpZo"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9db1eb9e1so351454b6e.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721673327; x=1722278127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy3kNJM/AIcd/f42JHEVSdo0AihN0SXrXnST2xpsoU=;
        b=v8iprpZoHthD2JWfyVWONQmBBLW8OB3ieNNcnKli5FxiV/Oy3UbEnDbb/Cx/JXm9Ey
         3nAoxR+ayyvUTkt2pctJTq0f9uhzVGLw1GTe6ikdJhfm4FHol1T8gyABVmkzLxr2UIzA
         GJPqM3e3KnorpEAECo46DdRY9dXuhek6zOAUpF3id/slT2g78jxwsOB4z/zUKX5xgu62
         1Xy+7s2l33Vqs7CCY3t7nnjomeeY2qfkE1ovbYIfPT6qgmWXnbD2rUENZJxEP1s1q+cJ
         ZA2ykJPB6d3Xow7o2gF2COsUqzNHCp4nv0jlLhfLuZCat4ZDxWHPUK4FIeMbd/DEOaaK
         afQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673327; x=1722278127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy3kNJM/AIcd/f42JHEVSdo0AihN0SXrXnST2xpsoU=;
        b=NWPCdsje3h8MtYPXt3qZOrpRsBUhTdyALENP8URlsGwf6KpJerf5ICiqJaJHtfPOWa
         E9hbWg7tizmP7o5kuUjoniT+dMGNMj58LtYXpMRZojOOE4cboyJqd3tDKxKjwhTEDfNI
         WmedtlTbqvp3zoFwxknYsF27/7y2cgC3WNl6gtbqKkA4TyPdQ6Y4NPl/IVw8rDdarpPq
         rEI4sUlJNQOAzonvSz4D3sIcD5pBaCHEPVCWH27I6uXTKYajYUOQyMwHrsM10TsZZY5L
         4LomQqnqhbMt2V8z6A7OXHtYo5LIf8kLajDOUgJZI3/hgTjrnMmA4RhxkqwRiGtipwVB
         bKaA==
X-Gm-Message-State: AOJu0YyK++f7PaitTIeZd7y2QG4vYb9zKySWEQxcMZgyqfV+4aPyIE0y
	oH+Kl3cJpcHa+5Ki0whqkYAgVu11x4SU1+pY+KfAmyhSMas6MV+0Zx/TWEcoXHmlxhFyd15oZGq
	V2QQ=
X-Google-Smtp-Source: AGHT+IEoQU7+Z6txbdlB186vto4v/00swp2Oa5fVCjOwu4F+pG8NlWyQ6tSrkMvQgWH/rQA640gBTw==
X-Received: by 2002:a05:6830:63c5:b0:708:b80a:de0b with SMTP id 46e09a7af769-708fdbb972dmr4049433a34.4.1721673327507;
        Mon, 22 Jul 2024 11:35:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a4b4esm1639136a34.15.2024.07.22.11.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 11:35:26 -0700 (PDT)
Message-ID: <ba203fb5-9bde-40e0-9cb8-7026a49dc1fc@kernel.dk>
Date: Mon, 22 Jul 2024 12:35:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Follow-up block changes for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
 <CAHk-=whqD58W_cn_2vE12ZGTJHboT+iQ4SYC7YPTP6ApXjB8bw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whqD58W_cn_2vE12ZGTJHboT+iQ4SYC7YPTP6ApXjB8bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 12:33 PM, Linus Torvalds wrote:
> On Mon, 22 Jul 2024 at 06:57, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>   git://git.kernel.dk/linux.git for-6.11/block
> 
> This is not a signed tag.
> 
> You actually meant tags/for-6.11/block-20240722

Gah sorry, yes that's the right tag.
> I've pulled that, but please check your workflow and correct whatever
> went wrong here,

Thanks. Looks like I inadvertently used the branch instead of the tag
for the script :/

-- 
Jens Axboe


