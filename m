Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BB1F17E5
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010752; cv=none; b=jPAh3NV03SsmgX9Be33W65gtiP3ydVxHDzx+KKsZP3dscmFnaubgsKGz+C/9At3mVLbWmvcgWRMRrEXJseeEAKVHX0rm36kqG/jVOPmeaNOTaqx6a2IzfDxVCW12jxAEWeEvY3x1QWQErn9UuARvxvJgz3kGl5Cw96VYTlhzwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010752; c=relaxed/simple;
	bh=BgTjlk0ssfrOdUJvdVt6sfp5S8EHOMKIXTKRzMbgzvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htSIwQosLyaHF2oeQGqxZa52o7KX213qm/d9ciAUVEM2G6eGD3KRsR2hP+worSUhXQ+5ZiGG6b39zQ5GceDsDuLnbppwQEvfwhI77G/WIcMCTQDZsACAPymqEYlQbivTqi9JCvyniy81jp/UYGyNcKtaGTwMVceBQFw1Nt0PSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LPMGKOzQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LPMGKOzQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43994ef3872so28927305e9.2
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741010748; x=1741615548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUm+IuBgB6APWPl7lSqAckaEAweKyxvMr5gEa9KGLtI=;
        b=LPMGKOzQhFZFH5iWjqbpV2NrmU113q4HmtExM8zkw6dK5bKT2Pevlm/dR+uWaJHuDy
         McWsZZwL4ekLrv5piWvPCiYoDs5iZqGJCovVR7ejVmwygPLPBhA3FlKXIlzJqC+Iyk3e
         /syKX6EHWqsyd0OYh3ziNzcw4WlUhN08bWIKU1vr8oe9YZfAgJzQEzKExGm68thhPZXb
         1TpiNfAVN4gHqdVSAhBTNcPOIF7GWAasZnoMlj/PsZuzXaY6BG1bVbwiYX0fQHrbTOOs
         CdK/LnLDJ2baERCnywc/kTzen91C3gu6m/isMUOtnbtLKH4wooNKSy1SRo7LAujQwLHd
         asTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010748; x=1741615548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUm+IuBgB6APWPl7lSqAckaEAweKyxvMr5gEa9KGLtI=;
        b=RWRIvGLeP3VEnF0OrPFXqwYaFINGO9CVAEe4L3lJZE30fq/JX5kzUYDGJqUfCxn6yR
         c0o7BDZE/Tc5R8xfZJQGxya4vvYswGYv409LJIXEukaqP9HnMDG+nbda6tWi0a0YH7Wm
         MbIlvXIt+Pc8MkfGdRkD9GDSEe7Xea8XH96S1LiQS44yksOJct1oe9xVDDPNSSJsTFk2
         hv4WjTSB22kK8zkvS3KS7gyCu9Tgkt9afxrz2okROpKTuikhXnnDHoPErD+aWoiBzumQ
         a30AUkXXAlsvRzPmfJ/8E8ykxotJTXKUoKea9JeaCUIWIVSXPPq/sRTlsAJaKXb8+DtU
         4Skg==
X-Forwarded-Encrypted: i=1; AJvYcCUK7Cfyo2Fko/y0BuYtIAy5vS124U4S5qi7mRs7CQL1kgvIeRnhkel7gik+csHsm/1d5pBreD1HqNb9ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VNm/vxWiJtBAoLOUYts9XtguGYIGmC6jBGZbSpsiL/F+WSMq
	VjxTQgZ/lxrgLKhn11ctSPWvCfSTaz/9k86+xhqBPIkezxSI0XPp/P5P6C01jXk=
X-Gm-Gg: ASbGnctHgqlvxM4u+v0pvrqD4Dk6goiKP3+wYsM2CNa2sVZdhu35QzdyJJ43J3bKQFm
	aLOB4Lopxk0knx7km2OqhTBkjP9MU0NPNyQNTxalmUksX0FvvfdHRs/TCTUFTVHN9gZ/FBkf/EA
	O+VGM55ahX7i5JgFaGDmPViK+7J0CfW/qEbxPBiiOTGgUo8FKWvD39Qtj0E6BX3H+oZt59ODo5E
	157xxSUtPUq9YTeCUOMbzudPUrk2u2Xk7g5GpNL7j+0VPP5HLy9dHc+h9SaGClNtb05TRfID2JM
	zcR9/36vgJ9o13j5MJUUU/w8NONxG9q7v/MFXqPtEGl9+WM19ejHZQmeMeGKtJHPlFoEmg==
X-Google-Smtp-Source: AGHT+IENZYGAKhGGuX+reg/HEx/v9egLPYmiHrtkAc8bPgbK1X7fR/YecuxaGJgrJpEyFaOmZI5/VA==
X-Received: by 2002:a05:600c:5014:b0:439:9a40:aa09 with SMTP id 5b1f17b1804b1-43ba730d731mr93722455e9.25.1741010748204;
        Mon, 03 Mar 2025 06:05:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539450sm189870885e9.21.2025.03.03.06.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:05:47 -0800 (PST)
Message-ID: <edb23775-1688-4804-86c0-eb5615871b0f@suse.com>
Date: Mon, 3 Mar 2025 15:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
 <Z8W1Z7m_fWse8KWz@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <Z8W1Z7m_fWse8KWz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 14:57, Matthew Wilcox wrote:
> On Mon, Mar 03, 2025 at 12:06:18PM +0100, Hannes Reinecke wrote:
>> On 3/3/25 08:48, Hannes Reinecke wrote:
>>> On 2/28/25 11:47, Hannes Reinecke wrote:
>>>> Hi Sagi,
>>>>
>>>> enabling TLS on latest linus tree reliably crashes my system:
>>>>
>>>> [  487.018058] ------------[ cut here ]------------
>>>> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719
>>>> free_large_kmalloc+0x15/0xa0
>> [ .. ]
>>>>
>>>> Haven't found a culprit for that one for now, started bisecting.
>>>> Just wanted to report that as a heads-up, maybe you have some idea.
>>>>
>>>
>>> bisect is pointing to
>>> 9aec2fb0fd5e ("slab: allocate frozen pages")
>>> and, indeed, reverting this patch on top of linus current resolves
>>> the issue.
>>>
>>> Sorry Matthew.
>>>
>> It's getting even worse; after reverting above patch I'm getting a crash
>> here:
> 
> If you revert that, you also need to revert 8c6e2d122b71.
> 
> But let me dig into the original problem.  The fact that it's
> kmalloc_large might be a clue.

Let me know if you need more details.

Incidentally, there's a blktest unit for TLS now:

https://github.com/osandov/blktests/pull/158

which should allow you to recreate the issue locally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
