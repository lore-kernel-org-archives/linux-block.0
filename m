Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E81EB36
	for <linux-block@vger.kernel.org>; Sat, 28 Dec 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735403513; cv=none; b=fSaksgMJgixHsZqGzFHClJdfiKJgU3bMM6JXxCv4F1OfDcgt53lcnG9INdKN6EZUg3ZezjgLIJOfHwpfQn9X7e2ykDqa0w3JLkrlfAl9IRx6IeNVCtpuJOfLq7wCFuemCcAlvgKzCnoufJusdsYExqUSpZwbEDn1D+i97GiOhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735403513; c=relaxed/simple;
	bh=BmU5G2MY4Tl1Ofv4pOhN2zZ+hhxgWiD5UwSoB8ElWUc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nCo1t9VnQFX+y6RffXA2jFr1o4710BIGa1/h/11DzbSnuKFMiuBX7SATK1QufPK44b54fwitsBMqkONvZvu+fuxa3EjYbrhAgfUN4LncQYMAcjbdTnkKClLrgLATiPnqCsnFRDUG4jo8Ha+2Q+xtrxzMhwNGI4v0AEjgdL96Cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QrCXKeWm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QrCXKeWm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163bd70069so99345995ad.0
        for <linux-block@vger.kernel.org>; Sat, 28 Dec 2024 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735403510; x=1736008310; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfcC2fNOAzFztM/bUxucpGxZ+jV2A3He7R30x4VlyTQ=;
        b=QrCXKeWmVGiinFPZi56PJ/hozJQnWJgGDewiLOWDOIFv5RNPgmp0vzIPSxcbLPv97m
         vDZV/UC7+W9rT9JgZjd7Bo/jZmdF0puRtalqHcw9pBR0+nFgOY3Ib7iLUjSvEQlRDhGc
         K1W8H5MAtmtlXR4TM9bk+VUUJD0h0cS+ICBVgaaw7StJqpr+gczYGQ5dkGenaO4WGrb4
         H1q4Yb/Aek5qAQww+lBasTAdR0uA2mWJs6iQ9aZEAssFc9FB6KNN2mhTrPtxmpnXUBf3
         k7y7sRHhLbrwbdytbRQVA6irT/vliZI48Zit8eXrxD+L31lJ2GUfqycWp+jZq6ebR/iD
         BIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735403510; x=1736008310;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZfcC2fNOAzFztM/bUxucpGxZ+jV2A3He7R30x4VlyTQ=;
        b=IlZkia3Dl8fmTbVnzDqiL9guWj09hXhPRiSgF/FZt/XwEHNbtH00y5fIsigGhHjYzU
         kiP+6dlt0OgFEIcHAENmBhNKzR42dK2QNwDRGmUHcqrffB/KwYlgmgzO+sRMfDInwl+z
         fOmIgFQZb7AyhN4b+hu6lW+6EbtbWrq4mkSFHPlzHphGcUpqude0povZzfvgGoUPzOPV
         VERT9VDVcUm381R3yRHoFsS0v5vpx+gd+NoP4pDDIKweOG1tqDuQ5a3uigLzlsyqnFye
         7JMGzYWtPDNjt4uDHueDgRolYtEUW2uFPSTO1vrsMApRs7voRYBTB16DNR3FlvPzOhvE
         dUeQ==
X-Gm-Message-State: AOJu0YwoN/xFW9+TZJK7XjRbRE6ew3lAUehRNYtnoirR9Klif6pS0atv
	nf963RB5J7+kHBIPEMf3WUWOnJYpprQtym3N4Ft25K9l7YkBZotTAw9MDFNlnZznIIne5/K5KaJ
	T
X-Gm-Gg: ASbGncvkUecS46fFkajs0UV1LZaB5YzjYKnaqK52o8Vrh3CJnHk2eV5guWnjR3IYYg0
	aHLciZuGXrsAJh4TFXoj4gjLfh7owaFg0c0/7dWzd3B5CUxhV01/ssyv27tay9FCQ1uvM55wAGJ
	1LASwf6PFzTT89xWGKtcyJIZNyciUWUnzcouV1QK0pr+Eqm+b4dr3UGEwu9EY+eGk7XHNf81AAG
	mC5aB6+jq8r2MfGLMNssbbNxMrv8II52EyIzJqfgDG1gxn5hNSK2Q==
X-Google-Smtp-Source: AGHT+IFPpezRXZUDd+esGQ/qibuCS8L6Cc/Ik3s3ANYVu4hsKpFVIs4WxhR8/Z6rNCrnOnS4CLnU1A==
X-Received: by 2002:a05:6a21:998b:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1e5e0484570mr50115866637.13.1735403509752;
        Sat, 28 Dec 2024 08:31:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c18fsm17007759b3a.184.2024.12.28.08.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 08:31:49 -0800 (PST)
Message-ID: <02b3499a-a9c2-4c0f-bea9-a9a5c7c3cf96@kernel.dk>
Date: Sat, 28 Dec 2024 09:31:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.13-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix for ublk setup error handling. Please pull!


The following changes since commit 85672ca9ceeaa1dcf2777a7048af5f4aee3fd02b:

  block: avoid to reuse `hctx` not removed from cpuhp callback list (2024-12-18 07:25:37 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20241228

for you to fetch changes up to 75cd4005da5492129917a4a4ee45e81660556104:

  ublk: detach gendisk from ublk device if add_disk() fails (2024-12-26 06:42:55 -0700)

----------------------------------------------------------------
block-6.13-20241228

----------------------------------------------------------------
Ming Lei (1):
      ublk: detach gendisk from ublk device if add_disk() fails

 drivers/block/ublk_drv.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
Jens Axboe

