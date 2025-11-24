Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E9306D5E
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991699; cv=none; b=OXc7T866xMo9+CkIy/94rDMC6GetFMMvS0KiQxIlqYQYDSIwE5H9JTbzSQXIPoWXZqn9J483VqmboQNlEL50Yj9UsFqoROAQvOX+v6s4679sNZAxnN17BT+cfmEKHXszFGjkqEsod4insuGOz9NnqUaplXsHzKA1iB2sCgmjeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991699; c=relaxed/simple;
	bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6yjtvnuu6I6i/5esuMT5nugNoVZ6iNaObEhmIHCCML6l5d6jaZZ8tpcZtL5ZgOEZKaRRHKq069BX4atu/VlLbhFqW1F2wnCgD1qAJxmeMyS/PQmmQF27JITJZJvw8ng6nAnkiKf5lCqWv88Z3lzK5gCpva6nSI82/wica7qErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G84ohSJ9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G84ohSJ9"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso203507a12.0
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991696; x=1764596496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=G84ohSJ9uqlCBpS7MBbqr/YL36fjhY1ZyjWDCD6dh2h/UEv0o/yfBYjoNDx+C2uxqy
         +bzkC6NOiQ7LVTn91GiNSTWjt9yYvDOEvYYXjVHaznESOx+LkzPN/VToc4QRGBUfgHVL
         +pnwJCxSU4MctdYhAKY+yQM/VHx80d/6JXFZKOs5clJTjBZPrF7fUzpyY6wvImtb8T4n
         BhLPHeAV9DVmzZn8KswxgJFLOu706/wJ8Qb1sKx6QV9WXlMt7Nd/JErThmj+/c1KNzYx
         bsr8IvFJ9pon9vZh+NJuiyCulL3XXQ9TbPR46uzATV/yUDCrQPnXqr+amjvOjU5UFw1g
         tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991696; x=1764596496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=iT7VDqvyAsdnaxHVyJO4M/YVzOPblsF8P8sl/jns+f3I8VSScDlWRY8yPoKnWrSArf
         JG+fsttJwRQj8uV7iXeBzkxL2BnSNx00ekgQ1ppzTtajr6jej+8vzDqWReXZINTP+e8d
         tvR52Zz1D38qBeGlo7IWZFAkm9U44ydqwksMCS+9EJqpJ6SjGazwkCYh2bNSb/E/uP9q
         eh+8gpK+ecskchUm7GNe8bpHTG+KZpObl+DjFUwQsQJrxbkErGtrc/GrD8DGj+M2ArXe
         PYU8rhkGC9176fpkJl1ISsT/psZKBQ6D4/CPo+Cm/SvxBv0ouHLGeTqX3lzuctlWFdlL
         NDWw==
X-Gm-Message-State: AOJu0YwuGKpBfyZoxnxNs9Uslrs3aVA0IZFkAUXMsf4+u5AowXVTMIuX
	mNafwxPeW6UNuv/p3OF6qV4jNgckqYnua5ml7IZp9zJzdHdMvGARW1x/HuN83P6Wt0sugLJJUU7
	ImQENQSCJRQxSwlQ/aBYrLPmWErA6Kw==
X-Gm-Gg: ASbGnct7LQglnwBQPNCH2E3651CdqqaJw865Y5yKp1KXWHqE80wiKOrQ+ovLNjQjkKa
	0qcTwEmcwsvdZdpUKjctSLn8vlDybJMeHo0wUZj136MI33WCt+UTPpaDTiD88witAQLVJ4o4XD7
	/XvAdkBV/byErlqUbAV1mm0aC/p9JkmK8tobZ3Ekhix1nbVhWLvoqGAI66KEZI9J1N/R4cW+xsb
	Ve+1/r2tE5dq1fs7FDXZ0BSEgMzbJkV0KKOg7Rv6tqkEDJG3TQa9s2UkztI566+ov11i7kBP3zw
	788HXtisKagv3ShsCNqlGFeMgZ9mfrrFAHaydf112tb7z6aDtrcd+/sa
X-Google-Smtp-Source: AGHT+IGfVsoGjX5Sxy1dySCnIJESUxRCyabV8O63iUc1Le7y4o1Ai34RI3broPwT+Hj5nWquSwgUdOuJhlEdpZCZaGc=
X-Received: by 2002:a05:6402:40c1:b0:640:ef03:82de with SMTP id
 4fb4d7f45d1cf-645550809a7mr11399195a12.4.1763991695708; Mon, 24 Nov 2025
 05:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
In-Reply-To: <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:10:59 +0530
X-Gm-Features: AWmQ_blM0KWu7aUv8ArY5r4a9fsKMGwJG-SFJqiYxWiv8fYwoMfNFeWPT1HOzl8
Message-ID: <CACzX3AsXD_C50CY0KYNjt5yMY4hm-ZDLQU5dQSJAmP3Duerauw@mail.gmail.com>
Subject: Re: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

nit:
s/reggistration/registration/ in subject

Also a MODULE_IMPORT_NS("DMA_BUF") needs to be added, since it now uses
symbols from the DMA_BUF namespace, otherwise we got a build error
