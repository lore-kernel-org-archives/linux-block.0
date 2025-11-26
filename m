Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E667232395
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189182; cv=none; b=lArcPBJffkxFhmNpAe+STMHY90+EYPDD0UGtCxU+GnbhfgrjesQWfaHIdIdJQlpGgUGa+l1i3N0msXXYbz9JbqSgFMd2wxcqKK1B0AyPziqQ81wP3fZn+a+J7ijf9/HP6j/BosMJVd6PvDfhdwnx1zDQt9L5M8ZOcv/5RrLsaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189182; c=relaxed/simple;
	bh=Ta0Z6ecZ1xEpHRI8AxdSApMBFh5bPltks5hMVeQPQC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7raBd1nIUKm5oLQX7h30NvVCUBxHjpSOMiFVSjr+tBniunDjWiNIfePvbww4sQVwamcgTNDj7IsjAR3KgyQVsBtFUj8RNZIEJiJjD+ANArvTk0YAIhm9f7ws8sDVd/PMtzynLTXIY5rb3wBOwKvzRL2okWtwKItGkLIqWmPHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qUBmE0JE; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qUBmE0JE"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9486354dcb2so7393339f.3
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764189179; x=1764793979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbLU2KxSL+PVmyfGbl6AHNj5wIoRz/QnY/WOuyHFnk=;
        b=qUBmE0JEqMFNqMV3bE3gL+HxLp9nIj1FNqk6SUfj22EZIbbRxvORuQbCbhpyLP5kjO
         SDruFXJkdCgKXBUCjZF+H/bXaHLeOjtqvI7YNNfThLBIZ8J4B1+XmdBl0mqdH1f8YxDA
         ZVCLWk6QaClRV8GvE0Jv+SYCCk8QAO13x0gq3m32RzLYoyNpJiBu7BoQ/dNezPI91jc7
         3Sco6CGDo9mtShd6JFni43Wy7EyaYscsvUVM+Obqur3XhL4MR0P0lCiq98Vls8/JS+CJ
         xwqLhyp+SNnIhR5PqLH0p2gY3SiBp8Cpz54thYmyXwUqyU+snmPjD2E2o6pYGU+s+/ex
         Z97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189179; x=1764793979;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvbLU2KxSL+PVmyfGbl6AHNj5wIoRz/QnY/WOuyHFnk=;
        b=GicRKIAxYf0l9tX9OVI8sJlyBpxi2iuQ+cYGWmOgcXNfvVUSJYcaoxVJQjZrKTAPIC
         G7Uq7A9sGiEuEctoXGTNdfk/XHaldCEGi2vxpO9tUWfViNeI8JDN6XOIZm+bYIOph/DU
         l913YG7MAtzgqLNsuKyCz4mKneTD71W0JUQ+SrqFvv/3fZnNZVCDdjRSk8f0wH8nZANi
         8fimGT0hqvanPlhWZRzuFlsvO57t7dSBmVhNweH4qJa+Jlk9nPbot5t6ZnlDu3nG8wMr
         iyZbxrOKhgQfKyLr7xSwE2jDehV0W7tPazazaA/zuE7olIKcLOTfJ1CAyNhFBzvkYK/I
         KHlw==
X-Gm-Message-State: AOJu0Yx8ZzK3v4oTO2j2vTnX7ttNNHiw6yaJ0q3ds3sAFUKei1Y9cX/k
	Pjr4E/1i+pr4jL51+3MSXCSH8CadJhPYq5bwl2iS5xPL+13KvQDcWJGAYxmKgDg7haQ=
X-Gm-Gg: ASbGnctnAyKN1NpArLCXJg2+1ywzJIdjZJDVGRySGvsBcJ0e+FjfKXpV4+dMdHMnt9W
	G6aUl8Q575kyaj6zr98epLHLMD8vXA43WM3+02phfM8qUZ5CO/pIuc9iQ4KZ5mAK8ue/mmB28nb
	IpOr7WcKjPMB31zCHephrJTB6E6W+Nzx8aAw1W9T4W6t8gfId6tVO2dyqgRyAItShz/yIOBRrES
	UHxrZwFhnXydpOS6Ih5Fq6eCyt6vx7w0heCPYIk9wA7YFxT61FlxjT9FG5TyGAlucZH45XmzeWx
	pZufbrdBJJhsJ7iBTU5gzEDG/Zb+9FLPBp5I1vGIjn57NYI1OtRVv4NrzxUYMyKRBFGhpQgfQ+h
	HvGNrMbthuVd2SLPU7e2zwPuA0JKKX7Zu0LOONwMACyO/gVWLeopvPRITVIcsQIW6R961KbGzRE
	sXIg==
X-Google-Smtp-Source: AGHT+IGxqTDO11S7cEKz6FB96hhQqVC8TnmsZcNrAUt65WKunZ+dWDgHj7t2MvpitI0d2AW43rZKYg==
X-Received: by 2002:a6b:580c:0:b0:93f:fc9a:ef0f with SMTP id ca18e2360f4ac-949473f5f17mr1500397639f.2.1764189178708;
        Wed, 26 Nov 2025 12:32:58 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949386d8f05sm765869439f.19.2025.11.26.12.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:32:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-kernel@vger.kernel.org, Ali Utku Selen <ali.utku.selen@arm.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20251126124835.1132852-1-kevin.brodsky@arm.com>
References: <20251126124835.1132852-1-kevin.brodsky@arm.com>
Subject: Re: [PATCH] ublk: prevent invalid access with DEBUG
Message-Id: <176418917794.112345.305526865203772039.b4-ty@kernel.dk>
Date: Wed, 26 Nov 2025 13:32:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 26 Nov 2025 12:48:35 +0000, Kevin Brodsky wrote:
> ublk_ch_uring_cmd_local() may jump to the out label before
> initialising the io pointer. This will cause trouble if DEBUG is
> defined, because the pr_devel() call dereferences io. Clang reports:
> 
> drivers/block/ublk_drv.c:2403:6: error: variable 'io' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>  2403 |         if (tag >= ub->dev_info.queue_depth)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/ublk_drv.c:2492:32: note: uninitialized use occurs here
>  2492 |                         __func__, cmd_op, tag, ret, io->flags);
>       |
> 
> [...]

Applied, thanks!

[1/1] ublk: prevent invalid access with DEBUG
      (no commit info)

Best regards,
-- 
Jens Axboe



