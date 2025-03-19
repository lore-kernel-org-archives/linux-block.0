Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A9255E3C
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387552; cv=none; b=C70xYCuHLzO04oMJmhZy60rbYyVuLflfA06yPPvx1C8eaAM39TJwZt+SuHrYSdbfpxezfGs8XIP5XBCHSZAKIKuxoDJ/Rs8DFIEvf4J/prWLSTgq36yb4HDY8jRY0gXIBLbe+HtcM8UfluKGe1RDkM7nIdXtGdZgLVhyxI1Kr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387552; c=relaxed/simple;
	bh=3sLaeeRb8QGUs2qP+ok9FxoUFnt0ypcwPX8d19Uwcyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uYa1MmzD5kSKJ0GyZeyfQNzFhU6JVbxmTpK5yh1QSFuIwqIhWMifiM6rfQgy/S7rxueigZ/lMyvAERGrNJMSDyjCwAFLMgdt7uDUf4rS9IEvmdNi4895XBjAzeUD4mBxEsySGkAHedWetSlpA934yTgwpENA/yUHL/HLhBJQZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IrTx7OdE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IrTx7OdE"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so286490139f.2
        for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742387547; x=1742992347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5O/QbKWxunF8Y6I3M+WlpXJ/TuyTQEPMHlqnEWvQ/s=;
        b=IrTx7OdEil4XXzjmAbrEx6TcbL9w4H/eQdupsWwYos8aLIHT0zqp43bRJN98132wqc
         TaI5dOGTiGn3WV3fpnXu56lOOwH/+z44iAwR/EhVNYKOs/cNKrQqm5WmgfNYOQaIrWg2
         BXLz0VN0u14Y1U+wVqQ5wd4OOSh4F5XuVbkcu59Vap/wZWv03dGLuDgclyRF9M96XCKX
         sCgc24Y5ChJd5XhI/UCPpHAglDJ8x8lhAZAWHSG6JUky10Wt5lJsLFRDa/Cr3fo26U4q
         whI4Z/r21T2ISy7kUo7gNwsF9nB0iiFi80AMRC2+GkyoNljuOmVnHlFS5jeqgMGZwaW5
         HgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387547; x=1742992347;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5O/QbKWxunF8Y6I3M+WlpXJ/TuyTQEPMHlqnEWvQ/s=;
        b=qTqxoi7ddlr1PcUeMQJGAKLFoNa5S/A944mPqF8T3MyC6mh9whoAB7GHE1/WXiSra4
         bNYLDeyzyqLqwZKyZgZezqpZ0rXnErUErIM7c+j+JWskAEcOxvKrDgGwAYDbQjixbTJO
         qauoofyt63Xc3WRGWpj0mbLtLBCpcrdVuoEk8rUcAPSO2J84CAFCSPYJnvKOOmuFfPop
         T0tvMnUIoKeVBMkzWN/em/hAoYjHtwkO7BWsGUnhvlrrqYG/wolXGD9tkGUwvaVi/hs4
         c6R3sF3DNTt3M0GgVOM+o1teqeEmRRV2izZLaiHYWMBkXfh/sofI0O3+3Ukdk+FfDWr/
         8yWQ==
X-Gm-Message-State: AOJu0YzysHP7Mb/KShVXqGwhR/gqT4+SSmPxTZpWOqVtlt/Oz/9tAoyA
	+d6wJHWxkwVu0vOsUMnZEuYc6lFwDnbV4njhC1hZg7h5mSw9/r7Lv7b0+m4e2DVWllEtKNfE+s7
	+
X-Gm-Gg: ASbGnctXdmUqsYwqUdljQBbX/6Bb7hN0GrM5A9AuHKfimQvXZv9pI/QwmXT2vPq11qk
	+osp5ZK175eKEGitG+WBx7iTzfeUR+r8/UkbhtxaUL4qWQG9JzwiRM/epGrCn/fbgmHM5nWJqXM
	Xjr2Og8Q7jHyGMUPV6jpLIdZQphoizqQTF9ssryYFWv/CXZMrdOrXY4t0SBKf9m3h2HCGt89+JR
	BgkwmDznxoxbshRA9wnRe12ToY8hMMY+U94HJ0jqHw8lUg6FZXAqGk995+6Qh7gjVmFXCfuRbrz
	XnrEA/TU7NyeILAzwbUsICydB7FacPGnp8de
X-Google-Smtp-Source: AGHT+IHk2B/ooYRCMecare5o4+SvKD32nJBaYeev6PeJOvnzW+gB+hnSyHFoeMRT/jBqurldVQU5sQ==
X-Received: by 2002:a05:6602:489a:b0:85b:59f3:2ed3 with SMTP id ca18e2360f4ac-85e137de648mr297745539f.8.1742387547598;
        Wed, 19 Mar 2025 05:32:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db874a028sm305508039f.4.2025.03.19.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:32:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
Message-Id: <174238754686.12244.10161282968686330237.b4-ty@kernel.dk>
Date: Wed, 19 Mar 2025 06:32:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 18 Mar 2025 12:14:17 -0600, Uday Shankar wrote:
> The current I/O dispatch mechanism - queueing I/O by adding it to the
> io_cmds list (and poking task_work as needed), then dispatching it in
> ublk server task context by reversing io_cmds and completing the
> io_uring command associated to each one - was introduced by commit
> 7d4a93176e014 ("ublk_drv: don't forward io commands in reserve order")
> to ensure that the ublk server received I/O in the same order that the
> block layer submitted it to ublk_drv. This mechanism was only needed for
> the "raw" task_work submission mechanism, since the io_uring task work
> wrapper maintains FIFO ordering (using quite a similar mechanism in
> fact). The "raw" task_work submission mechanism is no longer supported
> in ublk_drv as of commit 29dc5d06613f2 ("ublk: kill queuing request by
> task_work_add"), so the explicit llist/reversal is no longer needed - it
> just duplicates logic already present in the underlying io_uring APIs.
> Remove it.
> 
> [...]

Applied, thanks!

[1/1] ublk: remove io_cmds list in ublk_queue
      commit: 989bcd623a8b0c32b76d9258767d8b37e53419e6

Best regards,
-- 
Jens Axboe



