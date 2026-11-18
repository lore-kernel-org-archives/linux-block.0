Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018060;
	b=yXlSI04rMYcX+AlY3HfPsviV2H+bKzDHDGD7TzkbhyKw1nPg31MXHKVyzwQ0Ee1Pe7Gt
	 fltPWf9YOQzrIdZ3k0A9aZX6VPwWQsK8I/vourVxWwi69cPJ9BLR7QUOFACkV9sZ5IbCd
	 MQga4hf1lKUhkKMtbFulOJ5V/oF9f39jfFw230T6qgSt0CoX3+BG/30JP9qSWqOmSrFJ7
	 6Lt9pdslwSZpl6ibNiFCRBFlplTzUof6DHECQNNKndTaODQsCe/g88X48RW+ReJdiyW+r
	 6YtVoZy5sH0bPf75B56JXbxasrY1arD8qIsfZ/sOTSmOmzbjQjTkP9vvJPFQ+cIZx+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=GmuWkJzh1iCQH+rXKDpsn8JTG/S53WJETWtD1300bps=;
	b=4ZM0rKRXbGy6IYcfemXTRDPnGA3MQHpQYJ460l/P1DRbvGyDwXmuj17srEFzMUrTYEYA
	 D2xDPGdsftaT4dsivHyV2y3gY8vTqUa77spveTpc5xDbbMbhK6ZP/GqOQdOW09aiodnVx
	 jCxR2GzShc2j62i/7r79tDE0s/ZooYf++Y0ipaXRfZf6xwJkBXRoKzzpjYzpyq+e4e/QY
	 qGAFJIBQREeUd44S8pAsy6U4eVLpJ8uKDLh0pJJpGlC6aBCsUlHChlDAax7tQ5dwmAqzG
	 UFlO/tvEMzmz4ycHzD60we4YWt94ssgeBZb3q40Dhjc2pjpSUZLARWrhmlmDt4I0M+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="aji2d/Kr";
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BC60A2601
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86BC60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aji2d/Kr
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-499f20c7054so639694fac.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018059; x=1795622859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmuWkJzh1iCQH+rXKDpsn8JTG/S53WJETWtD1300bps=;
        b=aji2d/Kr8V6k7QQba0rRBp0IMiEQuDL0q7D5u7T1vwWrBP5XLREHI/CF+dOabfJmNB
         UOywoE42CQSdL5XDF02JyLEPcCoViE1p4a+M+FSykcnW/mR8VYwJiZpALoIX2O8E20Xg
         9UlYN/D3K8nHSSVGmyvrVUAIUedI075J/bBSALiqxa/lXI4gKMNw2HS0YJQKMRZRvkB/
         EXbiNZ0if/JrI/DZ7K9PLIYcx6y8mSvTtViSJLsST0yXmp0LQs2epcbEnIGrZDRab5bx
         F+T+9BqbHZngk7FahaUQ/HuKZT/wEYbDSNBrONJhAI7sDxgEaNWmmPXaX27w7QYft3E5
         S9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018059; x=1795622859;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmuWkJzh1iCQH+rXKDpsn8JTG/S53WJETWtD1300bps=;
        b=qZyKHElmIyiJtGLCtjcQQ9QM918rMnMtlxlyxve5qRmuY9wxR5R3GUgl69DypM7/ro
         /FYd67xbFkGdjaO48WZAMybywmWN3E849oRU5mZL5k3UCGPUUEWIaK3V+a5jU0L3EQyG
         BMYMD6C4rYoqg6I2Ys3RYAA8Joo2WuL1bAZjf37UoCxeL/AHZtCYh1qD9OQR9fGb24q/
         qUnV1bQoMOpyT2IqhvwR1hzvyg8P7RzUrmwZ6IZDvyCLI5zH9K0/oTpAryVIybtUTaUG
         1Pz2nEXMfWqOdNk7PmCvnbaL8IcYynxSv/r4zbReBcFH9ut9sq7t66YB42GS2T3nt6Z9
         7cIQ==
X-Gm-Message-State: APuU4Z94cnWkBD/RQcEbVTsw0ZijbmLZTubDwRSL608r6zGg8w5bnc13
	j9uzFEtVRQaul3OVQccQY0OJgz5tJX1Z+94vSqCzhNC60lo0TIQ0oxaiGX7JPlNCgGo=
X-Gm-Gg: AYBFou0VDId+x7DFZ3eTDb/gs4ScuR3Flx2ElewTFQ3hSqXE4EFpupgWtB3turJ1NLH
	MOgKUsMKMNB3UsOGLVerVEjzYyqbn76K3NsNMXf5oo7/7Wmnz8EX0FbFhZ3pPUAeN1OeK5iRxGi
	4XWADpaj237exAVCWaovL2upIUS5HuXAa1VIrseVCR7ExHHiTGd4Ke5AlhQmlwQIBTilI72kEHp
	szQETZYdrZ59b4TxetR4Y9hyx274TzBbccgaciQlHprZdfEETjcl6vQHQ1/0GdsySHJuTpfdKWy
	JV08GzcH5ewAzG0BGZdWf+sKUOS5whJZLnxeO1deJ8QhMocpuBz4BCaJITu47bfDOnXq+I6xtD/
	DsoYqmDFZQcah0GneLL6qc38fre+byq63hPMj3sBlABDntdQ5OSAVR2mKJvjElu0fBgg7DRyE/d
	bejPBjJwqrSTz039gvzCN5uFgAWdkYIIFfKMVjHLjVn8JAn5ffPB5bY3crpszHbcIiywbStOGHH
	HJ4PhvAkKBA4oNKdlNqSumSSp1Fi5LE3jGLbwBSQ2DBFxp7f5vx1JhYZ6XIjL8xMOUH8Sx5taVW
	2dV+GDAy42jH20QgcdF8J/Nnc3918a306M1MCeku9roMoiEpKlVG5xJ2xhnVq1YZexzJyZWFX8b
	A+YL0epwz7YjWtS+1f9XvAXJ6/Dq0HAhZVa2TEOolnNwyODODwndyUEWEwXpf4Wr1nLh8FHfc
X-Received: by 2002:a05:6870:2e90:b0:468:2c18:a031 with SMTP id 586e51a60fabf-4b75f029d72mr2362162fac.12.1795018058604;
        Wed, 18 Nov 2026 08:07:38 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
References: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
Subject: Re: [PATCH v2 0/2] block: make changing to the current I/O
 scheduler cheap again
Message-Id: <179501805754.17649.16701221943802051712.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:37 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 14 Nov 2026 20:58:31 -0500, Qiliang Yuan wrote:
> Writing the scheduler a queue already uses to queue/scheduler takes
> about 10 ms and freezes the queue, which stalls I/O on live disks every
> time a udev rule or tuning tool sets the scheduler unconditionally.
> 
> Patch 1 stops requesting a "none-iosched" module on every write of
> "none". Patch 2 returns before freezing the queue when the elevator
> wouldn't change.
> 
> [...]

Applied, thanks!

[1/2] block: don't request a module for the none elevator
      commit: c85f570121c94679854b570cae2c0dbcc0eae43b
[2/2] block: return early when the elevator doesn't change
      commit: 375a88c6176ffe05e521c2df31b1ceaf4ae5fbaf

Best regards,
-- 
Jens Axboe



