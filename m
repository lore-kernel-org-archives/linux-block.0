Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8B1F0988
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267064; cv=none; b=OXLhWrLIpkewcRrijA/RA5ATFbMpLGIfG8qGlkw+uuB1GUq0rbfBNQdQEbhW1Ec2tNv6Q7NhePP0CzN3I6VHGs48QTLMZ4ns7ApEX/fG6OGfL7PgUzVvz52eJm+GwL2zSv+05umqJrVczqFcDLY4NYG3TKtcmqLy2ZxPJNzZgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267064; c=relaxed/simple;
	bh=mxCB9SUZBeClGFXURnIsA1QlVo+SMxflm+QReL1PuJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klgRfgrgX8xU3+zDfgGG1n8MWlBnQi8oVhy9SG960aeouK0DNbbDCZ7NbwlJq+xFYM7hIJ7PJ1UgPoGsB06rvwJTlOPbA21FaMPweFn7gW9faxZVRG25ZoOXp1sRfgSs6NA0LoeDKEtEkVDUKVzQomWEIjuLk5y5fuIub1iMaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BSGpcK1E; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BSGpcK1E"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d813c1c39eso35307615ab.0
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745267062; x=1745871862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5maUrh0KQzV6aymom/1/wBhMZfCX557JEuH/6UWgEI=;
        b=BSGpcK1E9kehKVWeS1u4FrvaxcbpR70yuBIt8ZKzz6wfAgr615mX+SiGvKb1JZTPNW
         pcMqoEudqnyrHyP1Izrcu4X220W5mjiXnrxBAlLI4FnHbWaadFYHKOKW6Hkl5gbBa+lW
         7V6Zo6cMa4jdKRiZGysOSlRfc2RFkt2oEbpDL84EuGDWKvEFasItc030PONi02fhAVcO
         +v1ly+9UXuz+fKh0TXN8PBAwAAoEk/6fxRuwbai8kuMMHJuOZ0njEtWBpUE+4LLJGBkW
         Vyh4MGJ1CJKqfEvKKPpGPzMuYk8r6TzKIHBXGBOuNOKys72mVlcCYNb47xq5HyMG+IHh
         dlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745267062; x=1745871862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5maUrh0KQzV6aymom/1/wBhMZfCX557JEuH/6UWgEI=;
        b=fqNGLHplw9D5YZiW345CJ4Lvqi/vY/vFanyUUGbzjCTKLqo6fZ3fpPm8GoatAKYII9
         Lk/IUcv3Rvecsc6gTEl7rtK7yFhYZH3JP1cxTCq74G8x8Ki+zid3KXcqqM/lwKyGU+03
         J0lY5DNRMud9B//gJgFEI/UdQ1rvJEHaaIhkZ3suMF3tEUeAALEbfNfg2i8Xfn2mVugn
         jfg2Cgsos6b1xoWuPQdgrFMFQgtW4Rq3zotsJAUzQtOuuhYwoP2293qM4dtq8byxFD0N
         2xgflPjXopaCcTJD6KPwATDv9JyBz1RvDoenT9QfVuaBDKqg4NezytRaRUVHL8OLOB3r
         8UNA==
X-Forwarded-Encrypted: i=1; AJvYcCWFu9FnWlTudq0FVzf5YSfxfdLrwlf9eqQwnQftCgmObXL+tuvOZR7oMUZaECQSgVRzG/LYsPD7+wINlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFV/nco8ID41c3pMqIoAWyWW/VQrYxQr1XBy1o5IJFhtCyQvh
	lHQKNRze79GJbYW2fWJqPTD8uA00Jzb75FVNTGcaxnvPPapYEBjsQoxWZsI70AA=
X-Gm-Gg: ASbGncvt//Nd+JIuwtgIrqSuaqzM4MOHohkYoz5713d6HPv3f00f4ypYy3KzjWUTDSW
	D5Iri0FkMt95mqpo42y1VAJkHZf/ZRxkhBw2mNSlDP/LS49ytghYJbFtoIi/GpVgc+OcrsG/oVi
	2uZHuR3ul18osoNlKY7CKoQwmCpq5eUzlMYsRMXdd1RCXAi1ILOKKXG8Fa9qkQ815PqvGXLCpA9
	CpL3hIXI6hknLadENO9858IAd32F+EFPoYfHLWsezFODVyPdvFnXAwU35td49RbLKDuc/aKt994
	XE29KxH+Eguk5HiIU2MwXoOdJ3vUphJIkuckH0UEVkUBa8E=
X-Google-Smtp-Source: AGHT+IHcj28bFOGSxDo4d9yAdQ8hZG+yV0Gef12wOsVNjjXhehkX2IN0lP6ew3bv1S7erAzJ8u78cw==
X-Received: by 2002:a05:6e02:1b08:b0:3d8:1f87:9431 with SMTP id e9e14a558f8ab-3d88edc33f1mr125756165ab.12.1745267062043;
        Mon, 21 Apr 2025 13:24:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a383345bsm1909134173.61.2025.04.21.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:24:21 -0700 (PDT)
Message-ID: <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Date: Mon, 21 Apr 2025 14:24:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
To: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org
Cc: hch@lst.de, shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 11:18 AM, Darrick J. Wong wrote:
> Hi all,
> 
> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> between set_blocksize and block device pagecache manipulation; the rest
> removes XFS' usage of set_blocksize since it's unnecessary.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.

block changes look good to me - I'll tentatively queue those up.

-- 
Jens Axboe

