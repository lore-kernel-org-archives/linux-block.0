Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828F1EDA1E
	for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751211887; cv=none; b=U6vhW64kw06fLaht7/LyRt7HU1MQ1WtYEi6WJ7hNGrJ7cEBoS18yeJn8wzdYqVZRcy5FnjPcNR76mG0TM7dDoVc7cmaIp7FoxLSJbho1ePD6bzbi1htrxEMLhEdDIgHKZkGxqSMdrRzyDm6ZNRV4iW8TDXFvjFW4fb5rQRiKDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751211887; c=relaxed/simple;
	bh=GuaFWEmbPA8c0ThuNtDljwHIrWLU8pVrdkDtdxjijhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L36tG1IHCcqqxcKXzvuNq++C0gugH5b5StbGnzbvojlHhnUaTLAFMMP5aYGmcDAvaKzMATef6X9zyg/2dhzeywbFbYSiJA5Ju5u0MdVSLTFvVE3BrQOQ4HMjczKX8JxaUUyy40k7xuqr7yWl9GBKJR31kePpxnHN5MP34Y314Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SlOTtTLJ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SlOTtTLJ"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df34b727dcso36705455ab.2
        for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751211883; x=1751816683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1SQMfCCkWtMp5SFqkFuPM+z3MSmdXjh3y0P3kdRdkI=;
        b=SlOTtTLJO3M6r/6QtghovsJ8Up2KSs82SNMxMDtDBhAG6DNwbyz3PXfgRVb/CjVTbx
         RzRC3EXxj20MiVgxopS6NoPxTBxxFT3ucdig8zVtoYP9WAYPBYwCmxg6zdi9Ec8QDV1U
         DnGPqHG0mDWjyh+MGf1bVNG47rcLmUEvY8GizppwWzBKyIUyIGpeTRtla6V6H8uIcW8k
         gdDF14smJC7zvS2yj8sR9x6v16H1Id1XiqqdUUB5iwaLpARoUZ9C71KIEggrzDijttvu
         O1OrFPrN11x8oZXY8vhp114s3H6lTVd4TY1keCUE0T1rzq8E3nr5ccvXCQigOQ6yE9gF
         kblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751211883; x=1751816683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1SQMfCCkWtMp5SFqkFuPM+z3MSmdXjh3y0P3kdRdkI=;
        b=CAAo8mcOdHDK5NN6bDwvWYggULI5EUl4QlEfB89oA/GCk7pZDD+m7Rsi6u853Tisj5
         FiWBiCcJNJvDolOveS9WgYf9aueLlFD9ytvqFV97ksq8C8BhZ9/nd33m94gF11SqeLE7
         RtMIJwt3df7RStbDWVgoWs7HPL31W9PVYGolONjE04fQqjiHRuuNVnQre7gd4mizt/mf
         LqzR7xfUTJN3/9xp6d4RpkUX7kQJ620CWCuPivcDCQwHIyUebBMnyvESBJ7eemA4QIW+
         9NZvleuql/Fldy7j4gmQGuNGexRw0FawfL5LhStdyqwJbhz3CSyM7VPW8AHe6h+mxffg
         ytcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOPnNZwYvEwaFfrudkvwCww5uSLky5uc6rvTMjAYaSNAc9vdWU2MXYF001LcLxUuRzwktpDHjAKqPrrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySPHx3GLYD9sOaumUrMczcHXJf8KZ5xXLovqRwGySNOtW2mJM+
	tg71WczYtGWxOTalNRm31Zrm3CdNmeOiehP+CMf3bZMGs7/J91cdnlGCFPcMYhkqei4=
X-Gm-Gg: ASbGncv2VnGB6FqwHlJTivCRcum2TqCCxH5ne5sWKhr1J0QCPGqrf3JN3imjex3JEGV
	I0SmxPxZCc6TCNDZbsm4o4Crah+gjqXmEhWS5XSXAo7CslARpzFkbU1rMd/DyVKmXIqYKgvUALM
	P8QtdgyjWO7Bd8+uOoc+ktSJbwttko6l9/0SiQLB5MjsOivQ8KxtJXfXFEYqA/t/e048cGaQTvr
	Q3gV6+KJduNz6VWPQl266wA90qY+t2G9d032Zv2PGyuVX01raCojxwfNsMj2w8v1Fe6A8peF0E9
	qkK6B092GT/u+x5vHWoCGLLUq8BrN0vFaTngQ4Jb8Ha8OGfcVjTKr2gFMx/plRRG5pay7Q==
X-Google-Smtp-Source: AGHT+IE3JBp4BXwTTIkSqF9l1IDB3uwXEgbJQ/8C4KY52qBwZ5jdQVl6a+lDxeulv3OYBpHW+poNAg==
X-Received: by 2002:a05:6e02:370c:b0:3dc:79e5:e696 with SMTP id e9e14a558f8ab-3df4aba3be2mr106042125ab.11.1751211883517;
        Sun, 29 Jun 2025 08:44:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a0a5346sm17654555ab.55.2025.06.29.08.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 08:44:42 -0700 (PDT)
Message-ID: <568feed7-1e1a-43f1-8ad3-01cfe76f6e27@kernel.dk>
Date: Sun, 29 Jun 2025 09:44:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Roland Sommer <r.sommer@gmx.de>
Cc: 1107479@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>,
 linux-block@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Salvatore Bonaccorso <carnil@debian.org>
References: <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
 <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 4:26 AM, Uwe Kleine-K?nig wrote:
> Hello Roland,
> 
> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
>> [correcting CC recipients]
> 
> Huh, how did I manage that (rhetorical question)? Thanks
> 
>>> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
>>> explicitly, the blacklist entry doesn't help for that. Without the
>>> kernel module renamed, does the 2nd DVD-RAM result in the blocking
>>> behaviour?
>>
>> Yes.
> 
> OK, that makes sense. So udev does in this order:
> 
>  - auto-load the module (which is suppressed with the backlist entry)
>  - call blkid (which blocks if the module is loaded)
>  - call pktsetup (which loads the module even in presence of the
>    blacklist entry).
> 
>>> Thanks for your report and helpful testing,
>>
>> You're welcome. This is the way how OSS should be treated (at least in
>> my opinion).
> 
> I fully agree, still this looks different in practise more often that
> not :-\
> 
> I created
> https://salsa.debian.org/kernel-team/linux/-/merge_requests/1564 now.

I tried removing pktcdvd not that long ago, but someone claimed they
used it still... I haven't worked on it in decades. The original intent
of it was to support the 32k packet writing devices. DVD-RAM doesn't
need it, it was for cd-rw devices.

IMHO it should just be killed with fire.

-- 
Jens Axboe
