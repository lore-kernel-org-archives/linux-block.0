Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64D28E57E
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456740; cv=none; b=XqXsLFH3vhelU3rRaIdk0vG0gEuveth1ZsXXSCKeFPoraWRtj+oB5kD8nTueE5lYlCD5YJsyMUbCDZpgSMZow+BfSSEraXEoqXmHNJ6v18RP3WzG4vmfrJUMstIKnA+ujhAK/tdim4kH1ZFpK8J3TEUecaVoOoGH6XE2GEgzl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456740; c=relaxed/simple;
	bh=2c4RyGcyTBBIaHhq5vhbuQx07DTDPoo7PyvHV+koXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBb/2M9khttFqrlPPwROkv887+QEI0EQ9eNBG59T+bAqtjBeUqsAtaGCjf+SCbu4vgEaUpUow5jUEQOeRL+bE6T4H4itjbZRO6CCjnmXoQxk77nKg8hPJNLB1hrl7x6FXU5tBNwBQr8UwsUJiYon5FIpHM2t8CLWpedxRnRpYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DI/xfSLk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DI/xfSLk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311f6be42f1so8960a91.0
        for <linux-block@vger.kernel.org>; Wed, 28 May 2025 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748456738; x=1749061538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1DgNtNfVgtxZCoAyIGz18OP4Bo5orqBMpRuB4iTX3k=;
        b=DI/xfSLkwhD9aAt4kDul2oUw0gTKuCrXvB6WHkm1SqcP/WsGxfkH1KQKcq2+30nTWL
         H183cIIig3Z6cDaqylzGpk4g4xyYdc9AwKTSROa+/le3geGgYMTqMRAtC2Na9KsigHsP
         nNwGCZVADf9g773SF/gM6mDOwU8gsMarp63m46ZfWyCu1o6T5vEdiaGY7SUNNFkdnE0d
         +1l9z/Kt2Y/N+w0UxcY1jhcZDzJ4zt96VwmVrxjI/0+AYty/duSEiiI/VL7scj7LVVVq
         1UtPja1h7tdsLI5KkKCf+BgYIbEhhlb943vga9rjLqhUu3m0wxfzHtfefzBJ9aopIdrg
         d0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456738; x=1749061538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1DgNtNfVgtxZCoAyIGz18OP4Bo5orqBMpRuB4iTX3k=;
        b=vmCM5g4v4DlmbZ6aItO9KPhw4ikaiYYaInM2JAwLHplpH513Ks7LZ/ju6prJvR6sDA
         nvCV8cqO1XtOk445pNhSg0uqLg/7gzQII5xh85xUFk7bYJClrh2CzDm7qjPOT17ZppHd
         cad9rpPQmoujG8ZftdzQX06q82A9i01kBxamNHI1wrnK/FoJT6uyGCz5OeT6RMbF4zwW
         +8QKp9KwMA9lkN3c/6CqcSmE2bYieB4As13iMOvwKuMF2lPrIrbI/89eHgSBfNW7th5M
         yOuizid+QgMoDPrsF4YqnqyEb9A4EzD0mMGKFyBoDItV/ttkQst2r9rPQzIbfJ306AMZ
         vQtA==
X-Forwarded-Encrypted: i=1; AJvYcCV3yS6/BxNEb/vLJR8L3055q/s3vj8cjEv1bkQubD1SsUamLhNySRgKkTRjqxFfTop1b2cB4FmwhFzSEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUg441SCy8P0SNoEDl9Y1kApcfnWBN+ryylKE/4XygbcaOBxS
	ZHWKzCbXKkgHeJhzVfBJTxIzG1+IsWxtieAiuloArIO2CRNeroPJxvzMdGu1w7pNr5x8fyMcI8z
	yqvUG9XXcPiKEPk75/9+zhzaWZSQ6TeViSUVv8kdB5A==
X-Gm-Gg: ASbGncvtEfuTycyE7PQ5msuM6DqkL5FMkHEcYxYHl/oUUz8d7GSU6CITzaPA1auFKfn
	lseNQQ5oiRyw3pNKySCWZYT3cWSYMrjR4snb28M4gQBINtGMa6v5H56F2pg3kkbvtlIbHb5PWsr
	4jGRQuO75sZrRtMPbAlnXsr0ydVHSYGKQP
X-Google-Smtp-Source: AGHT+IEL1ZmsyEu0mOM9uUeenWGvWnw6r/IpkOg2ZOyaSFG+h5gtxxKjC4pS8VpZXgUHmiU0tBsXCbt6CaOavzqbLmM=
X-Received: by 2002:a17:90b:384a:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-311e18132a2mr2095484a91.4.1748456737764; Wed, 28 May 2025
 11:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com> <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-1-cbdbaf283baa@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 11:25:26 -0700
X-Gm-Features: AX0GCFuRsiYqORRMNhWkxx1ChAuVZ4WWAaGZPWCcLkLjY7VGBp6_rK8DXEjxOFM
Message-ID: <CADUfDZp9CpghO7vXjhptPoxHgO8HFEa5WF=oyiKS=BoPn8pirQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] ublk: have a per-io daemon instead of a per-queue daemon
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:01=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
>
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
>
> Therefore, address this issue in ublk_drv by allowing each I/O to have
> its own daemon task. Two I/Os in the same queue are now allowed to be
> serviced by different daemon tasks - this was not possible before.
> Imbalanced load can then be balanced across all ublk server threads by
> having the ublk server threads issue FETCH_REQs in a round-robin manner.
> As a small toy example, consider a system with a single ublk device
> having 2 queues, each of depth 4. A ublk server having 4 threads could
> issue its FETCH_REQs against this device as follows (where each entry is
> the qid,tag pair that the FETCH_REQ targets):
>
> ublk server thread:     T0      T1      T2      T3
>                         0,0     0,1     0,2     0,3
>                         1,3     1,0     1,1     1,2
>
> This setup allows for load that is concentrated on one hctx/ublk_queue
> to be spread out across all ublk server threads, alleviating the issue
> described above.
>
> Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk servers
> can use to essentially test for the presence of this change and tailor
> their behavior accordingly.
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Still looks good to me.

Best,
Caleb
