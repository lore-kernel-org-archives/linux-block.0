Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92157286891
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183906; cv=none; b=RIdMuVNaWpVHuUl0WYKsaWLdwZ2OQgKcFhFzAfeNkPKox6rVIG6IalXKBKNCLsTLid/CjrOqOSq0LNYXHOcyyNU8g+MFV+LTK8Osd1WG7GHvxLmpdV75LtN83SIPKHAB96onm509kXdsriFPbuUNaNSjoodnqnqtiDAm9Sa5TXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183906; c=relaxed/simple;
	bh=wXqRBILaE55JdL+E9B9wbUTmWAfxB6SrR/EgtwrIOKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SbXWXAMUmSzUeTtR9TbM+oe8L57XTU06hgy0nVsGahfDl+MtfP1/Ya67CYEgS6TEHmYIsPBfJZHKBYOW+bG/6baTPRnlHudpdqC6iK6F/7OUh4yIUGg5ZAGa5qG69/bZUxomZ3yCMmxZP85sV2kPQjkjO1D5SZWeIKqv2wewnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DqhkjNNA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DqhkjNNA"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-945a5731dd3so179558339f.0
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183903; x=1762788703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=DqhkjNNARmUumWmAELJ8kG6aFkYpyL/osO+/82gX7guXvoQcO3WYgmnk0LRFkp+G1V
         CtkXa974DGFYOe/ezzuhTCW6iAJwZWTsanKUwVfoFS59vuiRDWIQDY10V6l7ZQux9wHh
         T8qeG2ikGlRb4C8bY23BPled/bsUr2+ZA5kK81m42ZkGrZE/dmbAht7VsbdLJkMIfULU
         dUFftII2zAGIBfkcb+R2MlRwe6+R8mSFgzCDULDdLOIszUwyF38q749EsAIM9vTW2nPL
         Uj9tH21ZIMuXrJTCqSKmPgrmYF7cJf8ZmJz0FzcKrMrRnxCASka4eQNhOo4SdFQYHUtq
         i62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183903; x=1762788703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=piVoNggdJBEIMWY1iRSk87oN5/ABO0kBrtoF2a4zq/884pwq0YM4dpGI+hQSwaoh/7
         X/unTdFrMnhI9rzxAB5lTksMcdUuPvdKUirPSy9DbSzWxrTHytDdwuPyISLHtP8L83ch
         OkDAfTf6YNL4zE0fuLBn+0V6ddh5CV+0qyFxsGuLkF6GY3sCViFkg/kkDn5MmjaCwm2c
         X8CfS+6t2yvGoeg5IAOCL/cFPCsueJ8XwetbmztakM1ZPkzqndXZmvTxTwHfPUYXWoM6
         d0j0whzOFkCZVUcD72rz4RWrL5+ad05obGGjkxmiX/TWqfiQ7djov58WrP9A8Tgay2vQ
         RMIA==
X-Forwarded-Encrypted: i=1; AJvYcCUv1Mq1u16ASBvIrDF03BYAQYGD38EGWGu4D+glD/DZrvKXMI8mLIbBOYhGLmUD7bHsFWzPq48e4LCrag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+rZi7Q51bR0CCMGaLeSttQ3KsyiD3CfeTsGmblQj2C3dMHo1
	n2n9vC8IRDkIId92RpVQcnJGLAgVdHuw1yHJOiguefJeUOzLknc/6GJhBnEmRB06eAE=
X-Gm-Gg: ASbGncs8LR6gS1P4Z8cmSfG0iz1MOA0GCkpxuGDvfSOfUQ+Di/2U91bxvwiwRL/WuIG
	eHRFzYv2FijdbISqP1uFrp5dtdNJhzeHDxeD8XflMIqe5J39OsFVRVOKGuBV3qexZujAz5PWZ0B
	JGHEcjDtxoB/JuHGwZmeFnxiFevOc7CcM17LkAXIHKxq3dR9FjXrrNZXtjksdCvZAgRMQHieo6L
	RYAxUjs920TsFvDp51zYgKfKtDVHVfPmIESjNIZsiQx3a5hylUfuZ+M6jOX8BMpsIwZoPBRL/3X
	jsEJHJr0EZGvY35cChWiQKZ0CUDz6zHjQM41rI9+O5SDylMqjs5zM/EZCAqJJQVWa6yMb/A8HpX
	4jRC6kyZlm4HVcpEv74Y14SDipLtDInV8ztWZbJuHOHSmf/MZ+kBIg68HJkhf1ckpJ35k/LGO/n
	MA9Q==
X-Google-Smtp-Source: AGHT+IFTIBxUfn46sYZ6hbUJrbv86bqFQPF02qtQJk8t7o8hAHovGW6C2GZKwz2eeRA4AwfjgvTr9g==
X-Received: by 2002:a05:6e02:3110:b0:431:d093:758d with SMTP id e9e14a558f8ab-4330d1f5a08mr177643355ab.22.1762183903343;
        Mon, 03 Nov 2025 07:31:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b5a92dsm2754945ab.28.2025.11.03.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Subject: Re: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-Id: <176218390170.6648.16490159252453601596.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 14:34:27 -0600, Caleb Sander Mateos wrote:
> Define uring_cmd implementation callback functions to have the
> io_req_tw_func_t signature to avoid the additional indirect call and
> save 8 bytes in struct io_uring_cmd.
> 
> v4:
> - Rebase on "io_uring: unify task_work cancelation checks"
> - Small cleanup in io_fallback_req_func()
> - Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
>   is only used once (Christoph)
> 
> [...]

Applied, thanks!

[1/3] io_uring: only call io_should_terminate_tw() once for ctx
      commit: 4531d165ee39edb315b42a4a43e29339fa068e51
[2/3] io_uring: add wrapper type for io_req_tw_func_t arg
      commit: c33e779aba6804778c1440192a8033a145ba588d
[3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
      commit: 20fb3d05a34b55c8ec28ec3d3555e70c5bc0c72d

Best regards,
-- 
Jens Axboe



