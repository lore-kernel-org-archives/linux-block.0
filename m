Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B771B85C5;
	Tue,  3 Jun 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993732; cv=none; b=jsaYmHDKUiB5vzSt7op5WRbyramAyhEqBacmyorJIKjgqoC6fFb5RRuavfR+1X3tdeWMH+x8l0RHgM+1yKvJV71g3U2Tmqn/kFeR/+zYkvGK2RWmAYoXnH9MxKVyUDxWfqLTA4jKBQHn5QiD0U4fsWGba1bD/dmWF2E1EZ6I9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993732; c=relaxed/simple;
	bh=t0KpelJy1brI0PdSV0tquosufqCgodzIbtHWJX7ggjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOx8b+eINm30nTpGkTniK+5m+O79RWEgOwb2tghOOI7Tk0mrbZnUG6s7sHCF9HkLix7mqpuAaJ0izYn1hXDhFPyDPxxhprbenLv1c5OYH3LO3yqN0aRvvyxQHD3NW1/a+9iROVWGCxn4caduI1xovPvmBs1KJdGmoHhH8lq2BVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nen2m4c5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nen2m4c5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so2267891a12.3;
        Tue, 03 Jun 2025 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748993729; x=1749598529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0KpelJy1brI0PdSV0tquosufqCgodzIbtHWJX7ggjs=;
        b=nen2m4c50Pg5vTWSi9SAqNg7/1suSJFutOto+bOdERIOReJvI6UE1KjYepmwzfeK3t
         vNN3j48w59rkGvu0W00Dd1SgNA5Uy9SmOBqBKn5wQuEHfm8dWRe1sYCjs3IQEj6wswhi
         yGSnQLaCOAMQ1aV6DZgihay/MAdAE1mDmsjdJQNOCTIxcO9p0DhTdLGgzZX+erWumRxo
         UcwTJdpJF2buIRj+WCkci5Zu4F7u0R8tu44k0EOSEYXbrZffZNseVEhl2n1wFpuwxH2M
         6uyMpA43TSFvmOZCxqDYiPLMywpLQSKLwwB2eiv5mUU90QlwgKWQSewMOYEKikQ8CAy7
         qJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993729; x=1749598529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0KpelJy1brI0PdSV0tquosufqCgodzIbtHWJX7ggjs=;
        b=ns+6wH1tooeXZa5vWqiSIlJnMSTb4bmE8EwtiIV0tz36MNs65PsJRQQ5CxL8/DoSjp
         mINuipsseRqorYze1a7uI8btCkhS3Pa2+ERjSPrsRqLfFM477S3ZuAmp20DsXTR0/KJu
         YbwpjPcQ2Jh5EdqqRVpzqqRb3liCFapNWhN7JbvTiAUGjwbat9INpqS5cziSwTwDo1BV
         KXo91U3db6NL59D5NPmOhyOYkMQH6CpdukOypS+Mz7KdYhOZ1RRT8KPAjmpgXKw8K44x
         6s+qj5swFc9zG46Y+BXU95jwYfgErEtiT9Xm/PItKZLHcfLJSqwAJGZONXWuD/337l7t
         r/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWP05kfepinDMsrPvYgD48gvNv5eUdhTmCptaHaBhxJKiVTWN8wYGfcyQMm5p5CBnyJHbGNcL3iHSNFtA==@vger.kernel.org, AJvYcCWTFrJxTIRrxUnBb+U694LV4P7s03CujZGFqrlNsTfXYdl3iFhsG717VJMTM7K2awBOH2Rpw1G3J8y5+vyV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5+lrMA5lPlYAFHasWP5bNWjhVGz4ntCOeNJUqrMa++EJIWz6
	Z4+CscdFMCDEZSDWklizhj3bC/7zZc5T9gDdwTApkiK3rlrmTilIi48IZsm9nVgQ0tPgv6dNgKP
	SW6VfGudO+ULjorC/xYIUQJP+S24hvluz6YSn6idO
X-Gm-Gg: ASbGncuD3++AivELSbirQIB7FcZpO5yJagnU1irpmHYCoct8ruazTHWJPWQHt+CcKNT
	CXs4aazHEATzxCE9KYqH7vCmb7c5QkDch1JYP/uREeXd7/FsZ+LBZhVD7+Gu9bkW3ppNT4aKBDc
	ltmXybNu+WEem8FPi9H/xvpnlK//qFuUxv4Zh0uhX9wqi6QRKXIuqwQpvml8Y2RWQ=
X-Google-Smtp-Source: AGHT+IHf4ZDDTwY5um0GM6BCfOmMkeaQfNjEp2j/F3GThx6iWoCNTnMMsDdAUaKv4rEbF7+XKTVlekc2mA154zMZx9k=
X-Received: by 2002:a17:907:80c:b0:ad8:a935:b908 with SMTP id
 a640c23a62f3a-addf8ea6a0dmr41725266b.30.1748993728708; Tue, 03 Jun 2025
 16:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603184752.1185676-1-csander@purestorage.com> <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
In-Reply-To: <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Jun 2025 05:04:50 +0530
X-Gm-Features: AX0GCFsIYN3Pe67xG2mlX0CR7cISuvsEqB5MNOM3N77_ymVgF2LZgVW21JlGNdA
Message-ID: <CACzX3Atwuv5RNqk5vah8J3Ce0i6sZdF+Tmnbw1K9qpDLU9bXxQ@mail.gmail.com>
Subject: Re: [PATCH] block: flip iter directions in blk_rq_integrity_map_user()
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 12:24=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 6/3/25 12:47 PM, Caleb Sander Mateos wrote:
> > blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
> > write-direction operations and ITER_SOURCE for read-direction ones.
> > This is backwards; writes use the user buffer as a source for metadata
> > and reads use it as a destination. Switch to the rq_data_dir() helper,
> > which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).
>
> Was going to ask "how did this ever work without splats", but looks like
> a fairly recent change AND it's for integrity which isn't widely used.
> But it does show a gap in testing for sure.
>

Yes, you're absolutely right. blk_rq_integrity_map_user() is currently
only used by nvme-passthru, and Keith recently added a test for that
path [1].

As for the user block integrity interface in general =E2=80=94 it=E2=80=99s=
 been a bit
tricky to write generic tests so far, mostly because there's no way to
query the device's integrity capabilities from userspace. But that
should become much easier once we have support for that via an ioctl[2].

[1] https://lore.kernel.org/io-uring/20250416162802.3614051-1-kbusch@meta.c=
om/
[2] https://lore.kernel.org/all/20250527104237.2928-1-anuj20.g@samsung.com/
