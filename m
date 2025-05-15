Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCA25C6E5
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332893; cv=none; b=iHM6vvyvRiyGhm5okSW+IM1Q60KRLwgKHd9OQwbwKh0XBBjlETEqnjLQn7BvBJ5vAiCfs4XOqcoo4lOThrhksjo3m3oGTneesii1km7vf6WP9lZuD7IMCc0V71OcOQTBW42Ci+Q6XiHtzTZftZ5qpd7xjmmkWfvR9Hd7FPSLa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332893; c=relaxed/simple;
	bh=ZezEdI5zBdFdJv95StwuqYzISHG7jU4JXZpnSnd3HYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E8ACnL0H73FaKV7g4dzd359+4fsnzEIyzh3UuiK/73EcQEIONsoEyTkDcaF8TH+bW2xyzeIf2GAbZWu+Gkfjr+KWTIgejX8GnUwTWGvju2d6czKj5xHjCa2TeEES27V4VDeEixP4JRErmI3S/r2vNMoyvIdC0lnC+eGhcqZ5Wlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OVpAyD3v; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OVpAyD3v"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da831c17faso4162815ab.3
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747332889; x=1747937689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUk93zwEAV22Yme6WWfyA16vg1NUqJQQlbYAiCn0ePY=;
        b=OVpAyD3v6QWumVgAQDWUjLP9XJlUZaQNMS1+gAEFme+H3vuqMqfGXEziVgSTN0jroc
         XLx0GbN4z8bXMfyKy8XEcqXdGkl1BCDuozsMWsE8fiI7QeN8oCfnk6ATMHSbukUTDIGU
         6RTuP4jqFIYpOHnaPbARsvBcWScOLgseU74lXTE4Os3Krm7rtkZm/KUfo/Rcl/p8vD1J
         gVka7LoVriazrjAT3ZXttIWVGhZPgqftOB/rRGVxaF2jOnHCdft7NXyU6DtBmu7uzYYM
         pskFeH0WGehVcY2IZYvRu6fSju61E8a7jL9pvLkc111/UHiWxPqQgKYrAEsnNLlORqUn
         UdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332889; x=1747937689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUk93zwEAV22Yme6WWfyA16vg1NUqJQQlbYAiCn0ePY=;
        b=Dukt6LbgTX9iEGPgqmnBkZw3zVLE3swoBXtlASo1ZdGYU2bsY2QuNA53bfGq2HYKir
         1vGBYv3mfZZOX1S+sQvNUUx8MZPoR1XyBaIonmcvsrmX5xcQ0DT8l+Y5nRoag+6va7vW
         RPJQ7HqdQsvBGnwJhenJUOP8jH7d7WRmYQiPvdJaHH4tZZvzhAyTvmcH7QKWIs4nMUgg
         Bq4jgGBPUVKFUPfEnnP159kzJbYTsdusYeLR3LDRnh7UsjcKOtVoZUmglkcmHsUc+0IR
         LOQ0m++NWXUYojvvUB5efmLKmGTBr3+WPQ6wVzhy0NKSAsNnvItceUgkTjpeiCpdiqSM
         X4Fg==
X-Gm-Message-State: AOJu0YzBMdiaT4iWERM0ajgOFkv7LifF1JrietZ0NBH+qzkJPCnB8M52
	fq9+oNoCkdjuEQ8Hao4t9w4iYwH/r60eZeNh4KuGkqhXYw8bNy3TEgY9qEFDwAz0iTc=
X-Gm-Gg: ASbGncuw8BQZ7bQ7Si3sYpk6vBgbsbLzSwHZTGecoeyfYKxa7dNvIJCcIYp1s2OEh4P
	2Cc1SXMLsewhVsfxdrTswI1sCrlJwMCxfDZD4nezpOtQ3+fc6XW1zgYMQPVy0B5QXfBPo8+0Bro
	27ec5B5z0iCt1xNrqwcKTiF1KYgJwX6rPK8B0YU16dQB95sI0N0y68MffmP/1qfiXkgQencR7uK
	d17t8J9YVOpZwIcftz19asrSuUrMOaMKjocEvQmjX5QNhCKCxeXHo9r4kPkHBqUf2KZuA4JRbfy
	lD6wgMFJTabvS0vA6sR7nIsujgdZ83fgrpmt04fCLKg+pKMQjulW
X-Google-Smtp-Source: AGHT+IHY7YuqridCl0ICN177h8gnOYdnUER7dTLqKcIK826/PEUrpOfL6YbXCXYQ8i1XApauPhWWCw==
X-Received: by 2002:a05:6e02:1a48:b0:3da:7c22:6817 with SMTP id e9e14a558f8ab-3db84357436mr11373485ab.18.1747332886709;
        Thu, 15 May 2025 11:14:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4ea64bsm27642173.139.2025.05.15.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:14:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, hch@lst.de, hare@suse.de, gjoyce@ibm.com
In-Reply-To: <20250515134511.548270-1-nilay@linux.ibm.com>
References: <20250515134511.548270-1-nilay@linux.ibm.com>
Subject: Re: [PATCH] block: fix elv_update_nr_hw_queues() to reattach
 elevator
Message-Id: <174733288585.300508.13607812776003416400.b4-ty@kernel.dk>
Date: Thu, 15 May 2025 12:14:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 15 May 2025 19:14:39 +0530, Nilay Shroff wrote:
> When nr_hw_queues is updated, the elevator needs to be switched to
> ensure that we exit elevator and reattach it to ensure that hctx->
> sched_tags is correctly allocated for the new hardware queues.
> However, elv_update_nr_hw_queues() currently only switches the
> elevator if the queue is not registered. This is incorrect, as it
> prevents reattaching the elevator after updating nr_hw_queues, which
> in turn inhibits allocation of sched_tags.
> 
> [...]

Applied, thanks!

[1/1] block: fix elv_update_nr_hw_queues() to reattach elevator
      commit: 532b9e11b8540eb543ebec9cba851c5691e10b5b

Best regards,
-- 
Jens Axboe



