Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A01ADC68
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795823; cv=none; b=ZxEQg2a28Hh7WbXcwfT5u3AlhEyZNio8kaXRzGTdtasFrO+t4XUcwmV+7dtDgM3Ae3G6td17kVpXaZX+V+JKQavsFVYphAhesNCLgUj+HiXDvqRChYV41/GKUa7VeL7fcVnps6DoICvTwmiQljnEAR6KaneaaS/TMJvIgz46p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795823; c=relaxed/simple;
	bh=pKwkVTSQJ0aAuAlftXppJmht0Kot7MxlbY6yGzg7bVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VYY5xyFid0oI+N5NgjJq0lE2Z/np0JAe9owCLokq9l/Fhn5CklrRRvjJauvSdVzLOutoAaO947YYViGGcVpHm2DnEsFOi0147NlUklUHyncJSJzcLJRgVxVgla3YfDrC7Q/sxQoQRkN9Dabllrf3QrUtc+ySufJ7upVi9WBjCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gD4T4Vuf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gD4T4Vuf"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef9b8b4f13so23456237b3.2
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 18:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795821; x=1741400621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BLBwQOwrrYQIN7raxU+No/2e8DfV51qZaSaJee9wDc=;
        b=gD4T4VufIzLXAfDpNNrVvusy4WZ9Vu4BbV7h18EDY/Pq7V27AuxzScRtJPvDQTZYRQ
         vJc3SD8IAUYnXO9/whnJC5v13Ue7pdLhAI97/RCSEzpTFX4wPkuopZ86Q7YuseS4OI6t
         XrnkI74oSNTWzx3NTz4j6gOX2iFgTc1mt9PbE+19m6dLNHbhmGqKdpHiNeA313z3eAki
         n3Bvk6R1RFULa2KBpxxaBXGXpWTY9EDJMz2xgDm9uNstRn0LyhRISkvWWyj2EiaVnfnl
         T4KX9kyx9GZCUuKIXT0i5/ZDl7T6YsqRwLQ4Fqf6d9XsimiPTkfW0HcvRnmeWCMfrhSI
         9Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795821; x=1741400621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BLBwQOwrrYQIN7raxU+No/2e8DfV51qZaSaJee9wDc=;
        b=O3FK7EVB0CoFTRq+VrQYYx7JezqtMhz09ki12PQg9DcPv22JjMlWo3FOvoiFlnAANm
         AXIgSdmNNGXelmBQWWHcHVi59mdOrnfRjBUZPUJbdXS3TuJ88ik12DJz9yx6UAObmyTo
         007JSIilXllC4D3yhG9u3NZ+R5gMG4Uicma1gThVACxiYX95lSv1gOnvZ0EAdHTFgm6f
         sHFOr5tyyBlO6YdJovBdIIXLrnrschBp/O9XuGzPq5vAn4vYsxRU7nUA2fyar6BtqbvD
         rdxgzvuD3NkWX9/7G2em6gUi2eMr1jgSrKVNuph92947S4n/ybHze+Hb8ZP+CTia9y6H
         1ejA==
X-Gm-Message-State: AOJu0YzxgIrlvFAyjEgCAx5LB89CDYa7QGP3SDgi4JwD+u1CM+yrxog5
	NNCGiMNrMgu6P2Lmhcv6Dnu25c80QesKHvah3ljEHJS2yDTQ/LmePqy5NsTPW8M=
X-Gm-Gg: ASbGncubKynL+19jxSWaOiT6i5KgS81ggPZdWLZJsFhsPOVkb38wNEZmNr5ODb4mYqd
	WoGAzwxTjHYXKKU0RRNgZW4Cu5dI8UUHCM6tfsu9KotWLLc4pTDtRvYrrcJMV0f0yRuYfhWPRV4
	TFFCvHsBeJnxsn2njT4dbP2Ta4EC9D5EYedhM4pHFKqMxctTGcR+BpoLHtrVWPptJnrrFhc9L6Y
	kvEFJErNFdIoHsZuWjEQ4Xkkf+JzJGZOEmaRo+bFW261X3u1FilWbEuQv068Jz2H1Yrf3A8R0ra
	MmqgGqLlaeYo44Ls3xyyy6Wb2mHQQvQUnVN8Pds=
X-Google-Smtp-Source: AGHT+IEAfgFEonGI7v81NxkPZsf+pVyxnn3pBYJKAcjf3ha9OznoVu7uywfX2gEhdr3ETKKz7Ff3pQ==
X-Received: by 2002:a05:690c:5719:b0:6fd:3ff9:ad96 with SMTP id 00721157ae682-6fd4a16d0aemr55511127b3.37.1740795820960;
        Fri, 28 Feb 2025 18:23:40 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20250228231432.642417-1-csander@purestorage.com>
References: <20250228231432.642417-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/ublk: report error when unregister operation
 fails
Message-Id: <174079581972.2596794.14825315582480664341.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 16:14:31 -0700, Caleb Sander Mateos wrote:
> Indicate to userspace applications if a UBLK_IO_UNREGISTER_IO_BUF
> command specifies an invalid buffer index by returning an error code.
> Return -EINVAL if no buffer is registered with the given index, and
> -EBUSY if the registered buffer is not a kernel bvec.
> 
> 

Applied, thanks!

[1/1] io_uring/ublk: report error when unregister operation fails
      commit: e6ea7ec494881bcf61b8f0f77f7cb3542f717ff2

Best regards,
-- 
Jens Axboe



