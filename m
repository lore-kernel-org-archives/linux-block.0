Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D962857D2
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215186; cv=none; b=rfDzUXs1ZcIyu+rh/Yfe9qvTbqriSH+3O0bhO7iODQ95xl33pups7BIgsGinTxVLbSubnKpeo+Gr/TcmUAnpSgvkH1Fttg5maBtz6HWs3WrgEbBdS0VEHDkQzBYEytDKxOImrMIUK61WXSmnUFYhNrxKk4ao1yld7pRcIaI9F2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215186; c=relaxed/simple;
	bh=oWw9E1ARf/liDxi+bd5estjy09+4qZSi69zGI82k4YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIt4VjnAMrg8KZXA9SmBRNl0PtgzgJtAYCmM8ax/brcpjiq0QlYHX8Y4c1b6FJkX+w9/BSHYGsQ20Uj0q4kMWWTK9Oagmpkn3gWf84kP0SV7RLqvuTDb1sZfZ5j8wJkdkcJoWfTFWH27Z3KW8bLFr8r4hkMFiLCbdcKEF+ttbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0m1reDW4; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0m1reDW4"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ef6866cd99so970255ab.3
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756215183; x=1756819983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTDpa33JS2qApYszgwNnpSK7UHfHjgv5egclBQN5xTA=;
        b=0m1reDW4hAfva0Q73AZIZFTIW2ixbvSgs1vQSkyEGR71DEPrhBuJXaQURutOBynY1v
         2vRClAv4jZk//2U1ABvIoW9v9pGCEjVPeKeR+P/vYwGUnPmsYJ+9pqOPBMvOiGAzGRzP
         aosWWb4mReYkYDqE5H1PeLiJnRbxcS0Qq0SyAjn/fjYVFcHVzlhXddXAE9U4XP3AW4+r
         QnLjmrPENmFKAcl7mweDO5NL7ch0MnNzF8xhgTcz5DAjI33bNIZdZSSxODvDi3NoFl0E
         BiLZ9l93jMHK8lYXw+QEIJKdi4QL95i8PbrXjnVnp9oFJBpIu/nukcCslWqa/rAaYuRa
         hDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215183; x=1756819983;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTDpa33JS2qApYszgwNnpSK7UHfHjgv5egclBQN5xTA=;
        b=Jsj+SUuhpkRL+FgbtF+PTWvuiarqkK75XNuleMSUaU4DGhb2hd/cATBYYWyRs07trF
         LMUAUoRqbdN411j4haf/nnaBil0U4OpLzZyUgUCFCbpQKAiLs1XutsdOe5zG8D8GFFUj
         gSMICFvfv6uiGV4X/qwvmnHm/NqhnkB2BFVfgOOEMsIoQQ7W0GjJhU9J8zRcbswVKo10
         ivxdiyO8CUeDQZZR+KGzrvAKPVTHrTxt+BSnLny0ySaXWP2FaX3cdePBJUeQ8Js0lN2O
         jG0MQF4OCN29k6ELrv3tfA4eEtaapyIAE10CplxMsulxeQzRGyGBg92SF4qWWyS/MAHA
         dkZg==
X-Forwarded-Encrypted: i=1; AJvYcCXABa0sq5ShFK0a/USRyVu6R5ftaV1ON09N8pLiVva4+9pt3NlVD1xzSAS4E02f8ZuEKgeCQqQ13fEiDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxMdLo3OdsZlro3UYQVWbknAdPeRqz1eLxNiosBvKwqDg2LCV
	TtTEm8f8gD2f38VzHtlDGYW+xC1Vj9tCs2ypaD4dt1/7dcAkXIHu0gReZ1R+pnymOMM=
X-Gm-Gg: ASbGnctD30udx/KXetaMgMnHmsjupClXEUWUewy49u1mAcZjcIrBRPrjuxTFQRNJEK6
	+4Xdj9lFvNI4cpFHHrgwSNKauXEJB4DEp7ujnSs9Ai8sgelaKTCoF1k1lPDdsAmtEt06socP3gT
	67KsVAternK1QrIbY9bYxSJoZwc9Yo2l0ROJps/iKhrOD2Mnf3H/GnuhopsRhyHwFvxIgMcEUWa
	gHwgMWIpvI/pkMiDwEeGSPJ+9i/X4OG3ItJpLmN/9zccGIGxMI4jNk78RbL9ixnfp5/OscdwL2+
	3+xDU44eVaNiQKtq7uUNIYm0HEGtGrl6vItqLchrm9JsK2Z3ZEclOqQ4RvsMurl8C/bSAwn29GC
	EO03tRbVDmekHvdH3+S/zIAaq+hSPuA==
X-Google-Smtp-Source: AGHT+IHyeNqFLofJtawZSGlF7nwnpmwOET4pLDhklPZVdBrPT2USiWbLxPrFpiB4fDQsUH70NQxHfA==
X-Received: by 2002:a92:c244:0:b0:3ee:7c7a:c880 with SMTP id e9e14a558f8ab-3ee7c7acb24mr41586495ab.28.1756215183022;
        Tue, 26 Aug 2025 06:33:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8fa63casm630889339f.17.2025.08.26.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:33:02 -0700 (PDT)
Message-ID: <4d8cfe65-a8fd-4f3d-a324-8873f4016ad0@kernel.dk>
Date: Tue, 26 Aug 2025 07:32:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] floppy: A couple of cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Fourier <fourier.thomas@gmail.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Ian Molton <spyro@f2s.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Denis Efremov <efremov@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
 <175615490112.25116.3742797696959119744.b4-ty@kernel.dk>
 <aK22kUhlxlyvVLax@smile.fi.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aK22kUhlxlyvVLax@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 7:28 AM, Andy Shevchenko wrote:
> On Mon, Aug 25, 2025 at 02:48:21PM -0600, Jens Axboe wrote:
>> On Mon, 25 Aug 2025 18:32:54 +0200, Andy Shevchenko wrote:
>>> There are a few places in architecture code for the floppy driver
>>> that may be cleaned up. Do it so.
>>>
>>> Assumed to route via Andrew Morton's tree as floppy is basically orphaned.
>>>
>>> Changelog v2:
>>> - combined separate patches sent earlier into a series
>>> - added tags (Helge, Geert)
>>> - fixed typo in the commit message (Geert)
> 
> [...]
> 
>> Applied, thanks!
> 
> Ah, thanks! It's good to know you can take (and actually did that) them.

I've always been happy to apply floppy fixes or cleanups, I just treat
it like any other orhpaned/unmaintained block driver.

-- 
Jens Axboe
