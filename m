Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A32500DF
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498030; cv=none; b=Cakpy6FzRkgOV6OagzcZyDEaTp5Iqx6QY5e76/GAKGTE95V83UxQjqktzRdFED6UO5/8stO3jTW+P3ocTZXYU91DeL4WW12o3wpPnR54BcFApPQyOt2I10Dpr3EXPsMwj5lj6YbFuGl0cxVtp4fQ6iNI/57910pzRTXjC9B+6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498030; c=relaxed/simple;
	bh=4t//YxVcDPg1q/FN9i5PfVZJS87FviwIzvUeK8WrMM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6l7UHq2EW6du5LuGzYSmFOndz89O7USfoyUBPl8weFk+drn0qFMOTA6iiymVPuGKQ+iSBjd0o5/ZjvYwj4wO4JGnrjodxEV11zn7mvNh53V21J/Na2WweoZf9HhUKVgW0eRqXtQLqxwCIsZQFqBy/SXKSWgnGNgBjy8cC8Ihpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1QAklwJl; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1QAklwJl"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso16948025ab.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751498027; x=1752102827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOJzmxOEnDLRXJQiG5FS9FO9RJPlD92WnCxOvg2+9+Q=;
        b=1QAklwJlsIXDlnPRKb4f6j8YVy5mqOZAxt7h8LdYR6j4IS7JKhWS6B6Uz8UIpp0nEt
         koMXmL5q7GrDFTGTFlFHVqeelVakGUfJGHXVxDunt8+DMjq+9SpAOyyd/h2JgxjGec9/
         wFinLzTc0AOe4SNsu/iPeDEnt9yEaUK1MLhzVGOnmu7x3GGSBcQh/ewEm1iEg+tYZZZX
         gopbuF1VAkto1zz8T4RIc7g57Lb7WFBG1vuZN80ejfX7GoChldWKNLZZmb2vBE30EilU
         7jb17v8mVNz5UmmZA3+TJKj6bG4viyaxKqecKpNUkzFwiwX7mx9OJuqHJo7JWXza5Q6p
         W0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498027; x=1752102827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOJzmxOEnDLRXJQiG5FS9FO9RJPlD92WnCxOvg2+9+Q=;
        b=X+1DE/p781aSBe00BepF4dQLWNpLzsqiRCPIbWBmyoA/81Lwv1MNFYsP4LZ7iB0ZFc
         XggxVOk6Fp4DqBeOIj+b5Pu3ywNuNyhvf+BpF9cB2msWRE2ULsY7d3QYYoSMuDsdhJD4
         UIy6wXuLtG51CelewK3Z01nOe3a3Ntc4U5xMEcw8AWdhtmOD5vhdry7TS0vDemm9EHaG
         5EXXz7oMLrdUBHgYGgNbuITCQXglkNasSZ/iv8P78HAxVFdKoI6wxhD6ApgI/I+tN8bD
         oLrF6qK6Xd/SGsbw9hBl2kzg8jc+PbZkfpebh0lyRQdPzPeXOWM1V5iVrXmyD4psPg0S
         sVFw==
X-Forwarded-Encrypted: i=1; AJvYcCXwqecEtyWonhQxcTDg3CC12N4FoWvuSV8xi+eP4MCvrfurvj/xscaAvWfQZknr0pvlzXXHHzYwc0rOag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5nEmxKS0etT3Td9m3p1P/X1r/9vcKiX025XjrjsBQK3TQneK
	10g0Y9OzVFSTpR5cT+AcwZeldfj3EfYWu2jTnoc+QOg5LkJ4Uk0w5348JbD3IezV5sU=
X-Gm-Gg: ASbGncuWJp0Y1Mg1aUOIci+4VJaAP1ZNnHoi/6UsW2Hxnj20kdN3tEH0J4JH9OlfDg8
	pHP7h3bzNPEVCAgjVPNQJ4a36bSjco8Pk7LpF4rufyLCVCbnh0s1w1gyUkg0NvUQASqZSTJ/law
	pyvWKDc1cewQvn6652lc+lDbHR8DEnW1XZlbSZz0iwBw8owEBmzeECDHfJqg9QFpe1fBd30+Mzs
	5e1eCmSjEwPtF87pxPZnWvUhd2CkQCyABaOqsd1a6K8p0BR8DjR8zFAxGBjLMhCnjhl3y/0YFcn
	B4q9W5ddkMIH+OU6HZdYKS01lKF9g4ouKB08qqdruebyuX7XS7eHvE66y4E=
X-Google-Smtp-Source: AGHT+IHuFdeYEOTvtjMBMVoT1HsQ+ZaJohF0AMiu/jr2MVFddJ4E/DylKomkMPoqEdRp/wzscDK4rg==
X-Received: by 2002:a05:6e02:17c7:b0:3dd:f4d5:1c1a with SMTP id e9e14a558f8ab-3e0549f29d8mr55652195ab.17.1751498027241;
        Wed, 02 Jul 2025 16:13:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048a8ee2sm3212749173.44.2025.07.02.16.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 16:13:46 -0700 (PDT)
Message-ID: <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
Date: Wed, 2 Jul 2025 17:13:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
To: Ben Hutchings <benh@debian.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1107479@bugs.debian.org, Roland Sommer <r.sommer@gmx.de>
Cc: Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>
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
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/2/25 5:08 PM, Ben Hutchings wrote:
> On Sun, 2025-06-29 at 12:26 +0200, Uwe Kleine-König wrote:
>> Hello Roland,
>>
>> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
>>> [correcting CC recipients]
>>
>> Huh, how did I manage that (rhetorical question)? Thanks
>>
>>>> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
>>>> explicitly, the blacklist entry doesn't help for that. Without the
>>>> kernel module renamed, does the 2nd DVD-RAM result in the blocking
>>>> behaviour?
>>>
>>> Yes.
>>
>> OK, that makes sense. So udev does in this order:
>>
>>  - auto-load the module (which is suppressed with the backlist entry)
>>  - call blkid (which blocks if the module is loaded)
>>  - call pktsetup (which loads the module even in presence of the
>>    blacklist entry).
> [...]
> 
> I tested with a CD-RW, and the behaviour was slightly different:
> 
> - Nothing automtically created a pktcdvd device, so blkid initially
> worked with a CD-RW inserted and the pktcdvd modules loaded.
> - After running pktsetup to create the block device /dev/pktcdvd/0,
> blkid and any other program attempting to open that device hung.
> 
> My conslusion is that pktcdvd is eqaully broken for CD-RWs.

Not surprising. Maybe we should take another stab at killing it
from the kernel.

-- 
Jens Axboe

