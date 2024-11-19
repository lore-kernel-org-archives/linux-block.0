Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED71CEAAF
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028159; cv=none; b=bBxFWufEKSJgw6MKdpu8qruFWkhN9+gBQuUjJW3SSq/ZJzBQEPJaWj5peqCryH8DKRDU3poUYCWHZ7Ay5Hs6XRbuG6+SXPP2x2fR+2zXtTT5FEZSdXkCoYk+6nIJ1dnbtGz3sYOy8QO4JBldLGEYSMBgjAfYNe/0jgB9DUUkr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028159; c=relaxed/simple;
	bh=OxVU6fdvRJM870VsECfjhS9jC8VVGbQfVK/nb2bH0oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQ7+C4w127ugkleAt3uSNVbm7XbMzB8QaJHV2oFCUdVHseqUL5NZ+jRRKoJtLx4AzxBQh3he1IqaknRxM1T7bi4CDGtxL9nNwx3z497kIQvzsEgX2MlvQxu3ciq+b3WCtQD57kIPggeUpug2PTGHea4NU3Q2oWAae0WX+taeb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ONhr9nXX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ONhr9nXX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-296252514c2so3919371fac.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732028155; x=1732632955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LktkAfw5nudE6nbrJhBTzWsrFqXjzNWNBN7QeProhEc=;
        b=ONhr9nXXl/GNIVIsXNX7aOZFj5/0YRzBc1vBUGl7zlVfu3cr5gmjw8jyGTpa7TkSgk
         EG17P8mwQrm4TnWayLIn7XXsXIn4KQszq1Xm+S4lvL/CmmTR/TPDTEHhm1s4aZ2OkcVv
         7PEtWn5mLZBOy42VLs8G1W3FTKMWwDzW2XWNFDECH9E4huhnhkPvzF4ny4xTIWhXOR93
         GuDEsf3zUMbkbkcmHXwnkBXG4hU8rv+Ldb6BK0K9fynJXloXslxIPODZdNafdyZBY5Sk
         eJbN+T/RqwfwgOO0PEvk7/fxpDfblm7I6ywZAuSM2irNgzivFHdtZRduGT64v21QQDgG
         QYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028155; x=1732632955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LktkAfw5nudE6nbrJhBTzWsrFqXjzNWNBN7QeProhEc=;
        b=DO7TZEtIZ6tNc4aaT2GeA3hjjzl8GICYOUzCO3BIMrwThZ43OTKHT/+MOjombBnU+E
         ZfEMwlECENFn+QOQ0qaP41ezHxHEHkTKfTfyOPezie4O4OUeDiulkqA9Bp7Hcyr7fCqM
         hJBv0fCsSkpMZqsDdneGCBZbbUSniVQ775FsxWIlDLPwb+x/aNwmKv8pt0XatbDBbmLL
         kGvqv+TH3mcVltxlyyBC5Bc/iQowz66o1SmWrxNEobmpo/s2f6hGZWX2iChCbPMBFMxT
         FIdwcmTijw1y+1SOmjRJUJtkYpscN+FsS6lZ4NiVz19o82X5ykpMrdmaKT+LVTaPWE/L
         9tjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhoH9DAfceV3sKXA+q5jFsucqryci9oQug7GfZbi5cvcAWKfb+HD0+L0JbF/xeYSnp+gNOtl61UmhZ7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLas268ukiwalREyX7BLuXDNUSV8Lz1HQXDN1GSu1lJbnVmGa
	GkJ9W/L+Y3zc+rR9ZapLbV2mvW1o3/fPTA24blTGXKFI1o0K4YuYoHDrVKrNOts=
X-Google-Smtp-Source: AGHT+IE8qzEXfnTPzwb0PqKCnhNPR5defBoMubruiOmwQhR+ZOIqjwCGNRFKeFF3MSKLGnJcwhDaZQ==
X-Received: by 2002:a05:6870:32d4:b0:27b:7370:f610 with SMTP id 586e51a60fabf-2962dd498f2mr14226298fac.10.1732028155354;
        Tue, 19 Nov 2024 06:55:55 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac87cfsm3523543fac.39.2024.11.19.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:55:52 -0800 (PST)
Message-ID: <85d1c1bf-623e-4b93-9e60-453c0bfa7305@kernel.dk>
Date: Tue, 19 Nov 2024 07:55:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
 linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
 <8734jxsyuu.fsf@mail.parknet.co.jp>
 <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
 <74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk>
 <87wmgz8enq.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wmgz8enq.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 7:46 AM, OGAWA Hirofumi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 11/19/24 5:10 AM, Ming Lei wrote:
>>> On Tue, Nov 12, 2024 at 12:44?AM OGAWA Hirofumi
>>> <hirofumi@mail.parknet.co.jp> wrote:
>>>>
>>>> Hi,
>>>>
>>>> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1621bd87980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
>>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> [...]
> 
>>>
>>> Looks fine,
>>>
>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>
>> The patch doesn't apply to the for-6.13/block tree, Ogawa can you send
>> an updated one please?
> 
> Updated the patch for linux-block:for-6.13/block. Please apply.

Applied, thanks.

FWIW, your outgoing mailer is mangling patches. I fixed it up manually,
but probably something you want to get sorted. Download the raw one from
lore and you can see what I mean.

-- 
Jens Axboe
