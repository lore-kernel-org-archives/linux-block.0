Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623E2D0616
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318320; cv=none; b=ksoLy/x726OeOpJboYgCoEvuDZ+1VWsC8yVoPnoY5dc1Alm5xDfr6jJUDNHSZ7Qqyvs6CSmJHAFgB4GGVIvySPNuGCBRyz1vMQplr+etCECepYjaJ3KxandDkZCWkrLZMi5bnp6irLXJhqvG+RwuL1NIk/XmxDTcOxuD6tGjvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318320; c=relaxed/simple;
	bh=REN6IsvRicZH2zHJHP8psuaeYueQBKwjAKqF2qn2PJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOZSi+DEnL2ijxtUKiPtWQG9Ahc8LgcChkkja6joufgoqPmNYsKNwvyolw2pDrVl0pC/g9ie9fyTwYeTGrU/HdDYkhydO1BtMCdJju5H30J3sEc8YWRH9ZHsBYI8CM2yxT3eSBfqdq+apKphyY7oE5FQVE2//PcSX+GgwWAeJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mmwT/47p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mmwT/47p"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298145fe27eso94102455ad.1
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765318317; x=1765923117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqFhNDaYF4f9OxVIm/RuWC2DKMLmwn9IMlhIeX30R9M=;
        b=mmwT/47p4nz7gFvhaCCLv4ZVjhSeGoltznzuGdnteiKaKv8zmISpi5tSJga9NT3WQo
         Gx74bkyDOoNBfLosB7uBNTESUSCy8YQtNfUq1JHjYDsjC70VY31t/ZfpmdOomDynrVSo
         V250jYhecxVHoXvmHCnKtQj0E9etpoF+pvv94oDHR2irPp8swhmBPfxfOdgpZHAg84Ry
         OWFHgjtbX4B7xrY9HeqsQBE1WD4Teyxju3EAhsRhHD9DZCa1j6dSD9255icsI+2kObPg
         TyjtVi4km8jyYkU4MGu3slBYds9a9kzhQUxOawzpJ01PkRAeTUwn1Wtxz83wch1utRMM
         EuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765318317; x=1765923117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqFhNDaYF4f9OxVIm/RuWC2DKMLmwn9IMlhIeX30R9M=;
        b=kV8hLbESa4rrOKaLROqnINyojKxMrd3q+EOF0mIYdgHpjvoavsaewK2us1eN1FeIG6
         7RDVWJnRko7WNswWNQZbJBMOtG4rzNPvvbYk2cRA9Mdw5wN/uEysBNi11r8g91aDX+Nh
         umxOOIveaim2bwHqtwfFZh84oZZp1WshhPmfCEF8IconIDzzCh6mgG8qlaCsqaF9A3yO
         aBgsk6VoElZXan0R+07rMaS0QtheCiSzbNVX190w+fvqDnBQ01XOLiYGTUeMhRYcS5T9
         U13tiW9kMMMz1D/r8z1FE6N6fcRolgvbUEyPx3XrAnXp0n8xIAusG+vl7DkIB8vHmJwz
         qWCQ==
X-Gm-Message-State: AOJu0YzwTXF6vixKEnB+V7l90c7s8GxIaicrfpqhtjvqVBDhzq9EQlxx
	A2AB79+d2fETkw07Ozx/IE0a7yyb0pAGS6LjKqcSql+lLkIkLQ8jDN3wXjs1G+djGhg=
X-Gm-Gg: ASbGncupfdAALmuHWQqc+Wu+hHAfFtDXKj79FObj8OOk3eRl2AW8ILineOkw84UZLl3
	5tEKfR5a/m79B7JiYjt9embVOYTDojoBD1YLXoHDy59PmFqdkvdZVJpwazdctzLhd8EwGaagff8
	/uoX5aJm7Hs/IRP5OM8dRXt+WE7rOhXullXrx0MTwEQqECLn8HWF09sYuMG0sBo9Sw/3Bvx1oSh
	Do61IluQtwdjw2keXg6y5BNk0QMH0TLgHf+29mI/WzgHX0Jd1UncIfxzdbcTylDdkj6JDrNW1nl
	ykYgsjAj5kX5fjOhywohKZh5Q9cbGSXZhD9iWn8BC4D/Hnc1WOsOkedytYaBFZJqtIkrgHWnpCJ
	5v4as5DfO6VN7I/7aeiv9sydskVQcunv4vAVIPDa8NTGcZ6ME8VUMdDnykHHYJHC++SHSwT8OfH
	IVKMdnC3Qj/KoaWaotzH01a2TnYNWIu3e3W3LjQ4CGfPQ+2pMQ5g==
X-Google-Smtp-Source: AGHT+IHznUrSukTwV6SXsJ5M553OOyfOSfw8AJ7VkvBGy8nN0npTtOxGL+uyEJkDrYCciUn1L2ZZWw==
X-Received: by 2002:a05:7022:412:b0:11b:9386:7ece with SMTP id a92af1059eb24-11f296ecc70mr134841c88.43.1765318317096;
        Tue, 09 Dec 2025 14:11:57 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76edd4fsm71897034c88.8.2025.12.09.14.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 14:11:56 -0800 (PST)
Message-ID: <4acab1b8-f67e-454b-a493-ac4c00193c51@kernel.dk>
Date: Tue, 9 Dec 2025 15:11:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mq-deadline: the dd->dispatch queue follows a FIFO policy
To: Tao pilgrim <pilgrimtao@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251208110213.92884-1-pilgrimtao@gmail.com>
 <33dcc737-1419-4f3e-8952-2f34db47a087@acm.org>
 <CAAWJmAb0+Xhm7Wy2kqH7E4VGLUqZa_2ohBYP4ttw6zzjD109JA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAAWJmAb0+Xhm7Wy2kqH7E4VGLUqZa_2ohBYP4ttw6zzjD109JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/25 7:06 PM, Tao pilgrim wrote:
> However, now all requests in the dd->dispatch list carry
> the BLK_MQ_INSERT_AT_HEAD flag, and I can't find any justification for
> continuing to use a LIFO (last-in-first-out) policy.

What if a head insertion requires another TUR or similar before being
able to be processed?

I agree with notion that AT_HEAD should generally be issued in order,
but let's not make blanket changes like this just because you can't find
any immediate justification for why the current behavior is as it is.
It'd be different if you were fixing a bug and came across this. But
that does not seem to be the case.

-- 
Jens Axboe
