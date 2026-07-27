Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1306430319
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171058; cv=pass; b=Lfiec0bvncZnsbref8Rwt1Mf/+x2oBpJVHqjJ+RZP6oKn02nsS8GXTacjmo2Nk4yBB3zHIggdCEwC1H6Gz2A9ER/2XIzTFyqd5wt+rpPU0LXpBXS/Cng1vqlUiMJikRjey/M93hyaUo+TZJ0/sAfxGZbZXZBoSoJp9+agxp1aak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171058; c=relaxed/simple;
	bh=n4t9k+tlKWkoXpmCYKCzl+eRQFrYSw09Edzx/xk8UAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/2IgKqrU/oAWV1x2tW2to8e1ulbWt6LQnxEAMJYqPVr6pXKzYg4NKSw4/kZ7UIhbWorSMLQ2cvGIS4rFPSEhDxMfGAyu34uBfXjMiEzikZlrtIGMODfo30AdD5+SmeMiplrInjdqLmJeJgWZzp1fzXLFgOFZPOR+QRlbWr4L1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knxr6Dk5; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knxr6Dk5"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be76348eso152740166b.1
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 09:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785171049; cv=none;
        d=google.com; s=arc-20260327;
        b=hk9lyIA2zCodzuImW3llDtB1Vr8bfxh0bc3i6FfDUHWsXncVM7Zs5dgP/MbezpVFfZ
         hVoYxqR+j2ihJer58wdBuOe8Kg7P9TvWlmf9xq/9z27zdg8Q3/fRaP8wnhPGmLweOq47
         S3dJA5tuZTnOTNhwsbJ+CO0zbLfY9XJ/VALEEWSxBQtLIJZNIG81nJGv9FvleVF7yMob
         gDbHn+lzRj7baobe/ak8k/kWq1iH/LuodfyWpg/oH7GPcSQ3DMNBrNuZJGyAzmTocF98
         nJf+8/nXowszW8AjziH7T30W9rUQNoy9G0VTk/m3JcqZpjFHjsIa9f/YSIukZUQSxpT0
         wRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wd3Hf9oKNIcHhIQEfQyzKKDphSYMjk3NwXWYoPhPsxQ=;
        fh=NYRr3e7QRe2r55lTrEqxRQq87l3Qshp4zsgISYACurk=;
        b=aBWP1be3hfw1w7qZwZQdgQML9xhOJN9HIiT6RaKH998NYHpU8o9Ajesz+LVHUpBbKJ
         s4nodMF1yW7fgPusqYVtPUra0lNOaIFu/WdyJJWPbqZMPNU+ji3sRbjrVqXtPJKXh2YI
         M4ITEoDEK0vvJTwK3CShRPMfK36M0+kYLfc+ccB6MsZmynNQxvUpoMLPrZa7+LOuuUY+
         bpmdzNjZcgopBLNa4nx5axY+7nZDfoU6eJOPCEKxmiNY1/6CCzNU85L+UrcJUSlkXJmG
         qvgrJQYp7HjmdpxIU5GCzPCcxpDlms/cFnSxb5BJStx4Sey67JJqHtGIkStucG4CMNkd
         0oIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171049; x=1785775849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wd3Hf9oKNIcHhIQEfQyzKKDphSYMjk3NwXWYoPhPsxQ=;
        b=knxr6Dk5woPkD1B6QA7jgxDNacW4rvChewaxEHzPPMUdI5JrH6jVcPGjqUbrmpeBwB
         wmyPPSpqq0EVUV8QGXRXWYl6RLSWIZ5y7l43j4lQ7I6iGYpXhAJcaHoEQAqK1Gtlyh+j
         jvUM/F6ZtVTQlBfNY6kUpLvcS/w8mhuJBVIZdiCT5Cnnvimn6jXPANOylyTw4YRTsIB6
         E9DT3iM8yAV2cBQtf1c781r+YXIjpigoDjnEOnGazGEIKhFexQU4akSY53xgwfqNcXHo
         G3WFQOfC04Vml1aavZeOgp6YaRC/p2fP5evHQh+EvNuvzEYGYglzAkcDPvTACdlfKBdv
         Qtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171049; x=1785775849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wd3Hf9oKNIcHhIQEfQyzKKDphSYMjk3NwXWYoPhPsxQ=;
        b=d/qam1OVM0Mal3RISlxUQWQroBhuwUfRkHjt+fo5lpagEvoXSBrGXtWGoyeolO36i8
         WdxLfdJvgATbqXVeD9K3GyFtF2e4imbWBROgVHEi43Tuo6X7viwD4u8SX4VXpgLOFbLH
         t7PGHnCzU9DXerRpmSFm/QdC4u+BeDoamlM2ArNBk5J2ePF5AYyt/BrZEJVj5VTDhwLc
         Ld4YX9aeftgnCz2uzpjrO0ttt5b1+AdFI12XXz4NMxW5wSHyKdgI1t8KqZqe/ytS1oAL
         DLUYK6DkirKzrcEVVys4fe68J8+scTT0TRwzo722REqU75B61uFo4RDM550iGLOoNkEU
         MOsA==
X-Forwarded-Encrypted: i=1; AHgh+Ro++N2xLIAoYcXo/xk47XKdv3gO9A7wYU4Z5YjDabCPyUoFPQlvKX2noOSLOG0TJRnnvFrYn5YkKJzJ1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VX7HZAbby1xDvTZByl9HMfhA2xvIMBWxTX9L3pp7b9pVyeUY
	RmJcZGlh/l3bBkcJzDMv58ByEIWKmkr+d2o/qpKNfv/73bUj5wA/tsO0SRdqbvgRSfXgi8gQzlw
	n7nN47OKEEFuyYjMY8qv6E15M1jW5oGA=
X-Gm-Gg: AR+sD11f5zAtgDm5YMoDKxs47pskkkVJb4IZl5R5Drefwzp4iS+dIkBkNzr+Ufp9/an
	8aE+b+eGLE7tTyl/7EtH5C1am4JrEqMPSlJT0IG7ZwGjACvSp+kPEdU5SCLH4TlN8nrnZVOsUDb
	kDBCytgOmIvVuakTl64Z818sBcuGH9j36guL5WxpAc4JzRHXDziBCmfD4RII1xhJ6DwKqcRJ9ul
	HdRQXXvqzQhtU5xLsuoP7idkBMhZnSXsXsWTuuwNr80iG1UH38apu9gS62SVTQ=
X-Received: by 2002:a17:906:ee88:b0:c1c:5ec9:1968 with SMTP id
 a640c23a62f3a-c1f1ea8efc8mr393018566b.29.1785171049281; Mon, 27 Jul 2026
 09:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com> <amL1-Q-HGLJj16rG@google.com>
In-Reply-To: <amL1-Q-HGLJj16rG@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 28 Jul 2026 00:50:37 +0800
X-Gm-Features: AUfX_mz4VEtPHFie2fa2sITdEE8yYYsu805lwAkvdUhEk5uHfjogQCHlM0wPMqs
Message-ID: <CAEjiKSknejc9biofmnJu_3xamZj8kuvbxiPuKp6phQJdGwQPCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:28=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/06/27 15:02), Haoqin Huang wrote:
> > Writing dict or level parameters for algorithms that don't support
> > them was silently accepted but had no effect.  Out-of-range levels
> > were silently clamped by the underlying library.  Dict read failures
> > always lost the real error from kernel_read_file_from_path().
> >
> > Add caps, level_min and level_max to zcomp_ops and validate
> > user-supplied parameters in algorithm_params_store() before storing,
> > giving immediate error feedback. Also fix comp_params_store() to
> > read the new dict into a temporary buffer before resetting old
> > parameters, making the update atomic.
>
> I probably would prefer not to add this.  Again, zram setup is almost
> always automated, you figure out what you need to put into your init
> script once and you never touch it again.
>

That's a fair point. The sysfs validation is admittedly defensive.

My thinking was just that without any feedback, a misconfiguration can
be hard to notice. For instance:

 algo=3Dlzo dict=3D/data/dict    -> setup_params() silently discards it
 algo=3Ddeflate dict=3D/data/dict -> same, silently ignored
 algo=3Dzstd level=3D999         -> silently clamped to 22 by the library

All of these succeed without a peep -- not a crash, but also no
indication that anything was wrong.

> The 0 i_size for CD-dict is something that simply should not happen.
> If you insist on handling that then we can replace "sz < 0" with "sz <=3D=
 0",
> but that 0 len dictionary case is something purely theoretical.

That's fine, I'll use sz <=3D 0 in v2.

Anyway, let me split the original patch so the non-controversial part
stands on its own:

  [2/3] zram: make dict update in comp_params_store() atomic

    Move comp_params_reset() after kernel_read_file_from_path(), so an
    I/O error doesn't leave the old dict freed with nothing to replace
    it.  Also preserve the actual error code.

  [3/3] zram: add per-backend caps and validate parameters early

    Optional -- happy to drop if you still feel it's unnecessary.
