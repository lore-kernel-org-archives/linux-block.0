Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED649224F6
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905125; cv=none; b=HEMoBAOu6BawQ37jJloKyutLCTow/zjGyY7dxjjRCm/UTFJNUoraeoypmG3U48BPcYu48cMr8ieREg0mP1VxGdgwv5hmgKAKxEO7AXKhP1PxTG1Sz3bPESRQFil4PTpbpqZYEA0MLPSkb9Uw19AWxdwMRiyHeJ3S7IFZwATgIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905125; c=relaxed/simple;
	bh=+I4UYBWcwhJuQk2jbmrhxhAevyQ5poHB9RKqjTuPWGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwitIHrPW0Q2gxVgZQ/GbXv7P/c6sTCUy7MV49h5pSJOSqfPdmt8DpCGS+ei/Gp1emtopQGxq7mDJ2atyKVfL5PfvNDsC/hnCg/2FZY3P7C/GPaiwLowI7NEVJ7g3bqSomAqrsMELXw4f03x/WBLhAKBdPY2fBjUA2lycR7hP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OZ54oArT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OZ54oArT"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313290ea247so91313a91.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750905123; x=1751509923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I4UYBWcwhJuQk2jbmrhxhAevyQ5poHB9RKqjTuPWGo=;
        b=OZ54oArT5ol+daDtkP/U/UZN7WjzvKjdVn6yN/HfQrKLps+8o2I15eQtCeUeOCE7LE
         IYmzk9gdWbY6CFxTwWDkQt7LUc9lbd20klCtGWA/dJKmLcEDpCNLmlQ7prHUh9Y54SJc
         4UHfsvSf7L8a7u4t4/2fMVAFY2YVA7rAemMT8VOnRS9bK34k81Q8lbIu0zYFOBmZgpUS
         TGWWgnfMRAs/tvwpTym2pk+wQntqK+FiJBtSn+kZEjYSVQ4h0G9IESTv1eoTQv6Wk0+k
         CaIOBPWnwv0PdufXRKfVA+dfGNYb8n+X+sZ6uNq2H6LPfgAJybJOIlzzYScBfJa6b6Ar
         y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905123; x=1751509923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I4UYBWcwhJuQk2jbmrhxhAevyQ5poHB9RKqjTuPWGo=;
        b=BUOl9Z10G89OCYs05+2bm5V+QZ3/S5d6r9Z7E2SPbB8HrWJPepfBCR+Sk9hauJ5qDD
         OqOCVriHILa8UPnd21U8YvQqTwmX8uCXX41kZtjGWNDMtjOnuDD0LXwcL26530sqg6DI
         bkziXRrZ8gz2J8a5tcoPr5jHoYYhUq/KGRaOu3z3wulcPUsKpXr7OqUsnJkEAjakSGGh
         h6B8eDWTh585+5Xa+mvt0ENb5aMmXDvJLBwdLJPX8NT1sLUSe2cSLOtWb6B1io+NBiP+
         s7iaV7gsNpQbeCP0cwyog2he+adiMI+97et8OxjueoihQDUE1LhlwSIdjjCyD0WvUqqN
         17vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3pVUuOBa1sQT+JkAsmEx+CM3KBCQ8rUjI7kzTVvLSkz5UXehTvRAlE6ROfTNCgPZNhwgK/hkFmkmjAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6RxVv6Uz6Be2mTkK9JhinYNvkDruGg72f6Vh1SUGBALjpItG
	Q/v7eDKKxZS6giMxNOYCQrcLvNmq1pZVwEVtiJYbr6YsnsR8ALwwE02d3l+Snj5oCGulBJ2r1Nl
	Irx9FJrS7MyD9RseLX94nlpFyw8sQ9M+3PLQtfetUDA==
X-Gm-Gg: ASbGncvVmZ1m9iR90cODLGv8vtYBCShceqovqkBjnv/yaHzMAvPfFAlJHR+N11mxzwY
	+TrHC2FEw0JyLebp73Zphcwz+QCxYELyMw8KXjmHwr1a1SHTjVhLKQU2OpC82MUk63uv6JoigmU
	3pP7XGrsE29BYIbviLPq90PwNMlBgXUKs1NR5nVIpPvEvDBE61Q2ODeKo=
X-Google-Smtp-Source: AGHT+IG82qdRcP/lJBQIO2WCKfHvF7DdvrHFafyrgbR1sVEdZIk3ozfgLAMeYDWSCSoguG0q7OtTVNXmz6k1WcRg62s=
X-Received: by 2002:a17:90b:37c5:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-315f2687544mr3108924a91.6.1750905123059; Wed, 25 Jun 2025
 19:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625022554.883571-1-ming.lei@redhat.com>
In-Reply-To: <20250625022554.883571-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 25 Jun 2025 19:31:51 -0700
X-Gm-Features: Ac12FXwq9LlfIKvcBoa-IqwqpUZYeSiy7d7OVvMAjoBLYXmsfU3ykkkjU7RhtjI
Message-ID: <CADUfDZqhJc_q1nSkug=Hxbi_m_tQfemDmB=Eo69_avtCnsiywQ@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: build batch from IOs in same io_ring_ctx and io task
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:26=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
> work via the tail request's io_uring_cmd, this way is fine even though
> more than one io_ring_ctx are involved for this batch since it is just
> one running context.
>
> However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
> of tail uring_cmd's io_ring_ctx for completing all commands. This way is
> wrong if any uring_cmd is issued from different io_ring_ctx.
>
> Fixes it by always building batch IOs from same io_ring_ctx and io task
> because ublk_dispatch_req() does validate task context, and IO needs to
> be aborted in case of running from fallback task work context.
>
> For typical per-queue or per-io daemon implementation, this way shouldn't
> make difference from performance viewpoint, because single io_ring_ctx is
> taken in each daemon for normal use case.
>
> Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
