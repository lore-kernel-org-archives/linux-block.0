Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD033A01E
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753537; cv=none; b=lgYbpoiJuT6CqcXz9Lm8e6eoDx4lfsTKMol0HA16gFEMspeTsrSwltMPzx870LAJRS8WBpqUDY1W1pm2gnGSxGihBq1di1pVVSkNVIX9kELSaGO3QEdaGnzPnDbdV7lm8Bw+Omu0W6LdWPaxwGywSQFSuxi4kBbdojkdykADkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753537; c=relaxed/simple;
	bh=tPzwOV7GvDpR5Xi6HBtXCUHPQBBKe8WKMdp/yKCjpiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgkgx5v1DzrK2HK3pGXB6II7k2FSv9ctd5f6DMLAzzmXo+VV/Y1Ng0MskJ+RWEnyXWc2qNZ8v+Muo/XpPO/lWI74l7b6MXpu4bpraPZRLi60Tu6s986oHLMaOzpsT8Uf85EzvMBXx42yYtkOi1d1pyiz4q1v5+9fjZOnN0iLIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQJSL0c; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQJSL0c"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so76049b3a.1
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753534; x=1762358334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwxrExpiKXBKK+ITlQ6foefTYgM8fnPgsDyzvsZJuN8=;
        b=dqQJSL0cde3zct34IDioKcpml5cSDJiX5DBjAXwMS5+O10h9VSDCTp231V+o50yaHa
         /pEAmUzsxxh0yxU+NO+wQ3YMejdtnq+unVXWVITg+SnfBTmen5K1jQo1W4MMi4xda/+f
         U70SeIvuGan9MrlgMezrcsrJm4XJ1mVPtSrP74v4SfvvJi+dBeLA0Df7kNbKD5MHrOYk
         Tg9f0qZEzUsFJmrzc5WO7JJ9iBqwgRt0+nffaBMkQP2+CPCzyDdzH5d6jf8NY1csfH8z
         nZOVk1Gy8393qfno8c+cUaa0d+LWBpMMOKnw2PWD+LIlcNz09xwfhvrrpAXrjvqMzsOf
         nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753534; x=1762358334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwxrExpiKXBKK+ITlQ6foefTYgM8fnPgsDyzvsZJuN8=;
        b=kXVxOYSQaTOIJiWX7Thz2wniFxYjizWrLo0v/gpar65rOLGj1GaLv9f14XuReArY+1
         Jk8jM9lZRUd5cL89mRI8ppyPvryZDhWdt9EWC3DBscKHlHluZBVxFELVTAHQc3ljWjhp
         yzSLbD2DwIvLVkZYUDxqpnNYXwQdOUig/Xbox7F8XMqnYJTwEctvfIno8X4yOpXVmhJf
         AGfHpNAE7OAHwMYWUJzh1ro3CUojxn0/yvRMenO6b3bDWqKeDhSYI2ykax9A/ub4BWvg
         egMfB0XObRCOxtzqvw1/TzLHWjsQ3TxH5HpK6DCN3UevvPy/q0z5tjOiEZiihG1AfnHp
         oEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7JEYzA9GEIVdzmXW8F1Qz8Uq3H4RaiUZchE2ju5CSRPiXPPItSl+xL5AfnoCPgnub4rTuWgOzt2ft8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGz6/XVpANmMvuU06AWqBQsTtNKKw0lDVSxkLla3esmCFOMOML
	SqPxL1fn/yoMwTot/f2lZadn/zSeJ+9cJ2/SDbrZqW/DIYQHgKfQ9gGj2E2dG4fA
X-Gm-Gg: ASbGncvNLLOGOKtkNNU8r0cNGlcHP1Cr09BsF75dAiV72T6caEfK/I5wPINiGnfQiVB
	bubrDfqgEgJ+Okahs6m/6ZMS8wxPW2NCewSV+yyaBgXwrJnwjSmfH6sA8T8PuGDbFnPj8O6AYWw
	aEUGlF8FdiOc2oi+34M8355l28dD4a6iheAL8zY4fAF1IetHQgo3OOejWwyu5WlCmhWA6899Zxz
	Y0KRstDCHZHEDQQwMFLq+U9M3uEZDqZCt7/QWuLhG0BA/0HXac4x/aa8Rg48j7g47hCd6ECdRnY
	7cmNGphIQp1NkQb6/Rp1JYeNVxtE2YlNfrB+SH3RqwIJ9e9sJ+a6MlnCEyd2k3d4ob/UOs37FL7
	EV4n02mPO2W3oQ4HG1CafEyw9Jk/OG80bgDgcAehs2Jij5oZngNfXWkfcDZv86IAU6y/xBgQYTO
	UEKCVLOIrc6YFAJBgmRuopDtFAGkLvuFVPpG3nYCn7zrY4xSnvIbIb2deyMD9HpQWtbRKmZdmU9
	nxAbaqlCOFVsEHriDrBeotajR3665nKIT3jbBYIQAQWZEhGYStqUXT4pKaBsHVLohEI
X-Google-Smtp-Source: AGHT+IEDUOVYU4FbtZmNjoIisTx8ifKNOJtO/21KsW1AgRzDGmjWuA4/mf+B5T+NZ/lyYpe4qwFN0Q==
X-Received: by 2002:a05:6a00:7589:b0:7a5:396d:76af with SMTP id d2e1a72fcca58-7a5396d7d19mr2988818b3a.18.1761753534501;
        Wed, 29 Oct 2025 08:58:54 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:8b41:6bc3:2074:828c? ([2a00:79e0:2e7c:8:8b41:6bc3:2074:828c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm15874564b3a.45.2025.10.29.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:58:54 -0700 (PDT)
Message-ID: <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>
Date: Wed, 29 Oct 2025 08:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 12:15 AM, Christoph Hellwig wrote:
> we've had a long standing issue that direct I/O to and from devices that
> require stable writes can corrupt data because the user memory can be
> modified while in flight.  This series tries to address this by falling
> back to uncached buffered I/O.  Given that this requires an extra copy it
> is usually going to be a slow down, especially for very high bandwith
> use cases, so I'm not exactly happy about.
> 
> I suspect we need a way to opt out of this for applications that know
> what they are doing, and I can think of a few ways to do that:
> 
> 1a) Allow a mount option to override the behavior
> 
> 	This allows the sysadmin to get back to the previous state.
> 	This is fairly easy to implement, but the scope might be to wide.
> 
> 1b) Sysfs attribute
> 
> 	Same as above.  Slightly easier to modify, but a more unusual
> 	interface.
> 
> 2) Have a per-inode attribute
> 
> 	Allows to set it on a specific file.  Would require an on-disk
> 	format change for the usual attr options.
> 
> 3) Have a fcntl or similar to allow an application to override it
> 
> 	Fine granularity.  Requires application change.  We might not
> 	allow any application to force this as it could be used to inject
> 	corruption.
> 
> In other words, they are all kinda horrible.

Hi Christoph,

Has the opposite been considered: only fall back to buffered I/O for 
buggy software that modifies direct I/O buffers before I/O has
completed?

Regarding selecting the direct I/O behavior for a process, how about
introducing a new prctl() flag and introducing a new command-line
utility that follows the style of ionice and sets the new flag before
any code runs in the started process?

Thanks,

Bart.
