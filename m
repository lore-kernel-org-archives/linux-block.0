Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A0FaZ5VP"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54710C8
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 13:52:54 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db539f21712so301965276.1
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701899573; x=1702504373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=A0FaZ5VPghmIMOFtE7VI5ktxGozz3Olwlubi9g38u8YjHjJ4FQqmsMbHx5O5owP402
         MCvGx1UDIadD/hB9HuYVtFRO/iIwo0dNq0lSiw4mz8KYluLoEdNgvKuQQgFIuh8Nv1eB
         kYposvN9K5OwVDmbRa3Gv9n912+wMYAeAfqA632ImawSese1WvEBzRAEmcBfENMmAHDE
         LJudlvpdo32+Q65nFFXz1GnhCjH075c+xgvoc/efJW9ZJesqy2nIpO9HcSJ8dBAPDRyQ
         yZGac/GZ9q3ZVNEXO8rmyC7iA0zgf+Vwi80FNnTTU73Q8ksqhIGRg/Y6vOxjZt64WSWi
         yKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899573; x=1702504373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=nMeUeh0/CAJjHWbJhRxNczcXL8yvZk89X5qn4JPWPwB+7UIxNa9qAG8barlAg64ujW
         VD8kj9d5b2y3/mdKkIonSEVdx5ZRb9CaEIXc+PepawuBc3mHsxKuBYwJQpaMd5ZvWY7l
         ATSoSmP9Icid/ZjqAWc3c1vH9SMRbRHHJzlDjnXVikMMMBUf8u+sy95w72InoHRV9MFL
         2Dd8ksZEMqhn388S46HWwYWE3MZAbNIwvZ6371Kxm1jCjJncwGt2GMcx1YKKTC2knBJ/
         TC7Uhu1x+X+0POZA6Prk8Z5zG/mptEtVKZehFjiJ5R84/R3ObiXmE6oTXqADOv2SPtx2
         jmmw==
X-Gm-Message-State: AOJu0Yw7HdJTlFkWW11Ikj2LvEKKlQWtoUTbyPH5kuJiCkiw8Rijjnl9
	y9cb/AqJYzI+IqMdRSKZFrW2Nse5fOHRkDKvgVj/
X-Google-Smtp-Source: AGHT+IEj7nPBQx69pTJuIU/DScLOgVaCvMx3IAuTkYQQJ5vMAh2Hehp1yFZ/6ct0anbgpUrLprVHp8nDNRkJVZqoN6c=
X-Received: by 2002:a25:ab66:0:b0:db7:98ba:2468 with SMTP id
 u93-20020a25ab66000000b00db798ba2468mr1505130ybi.28.1701899573074; Wed, 06
 Dec 2023 13:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206060629.2827226-1-david@fromorbit.com> <20231206060629.2827226-6-david@fromorbit.com>
In-Reply-To: <20231206060629.2827226-6-david@fromorbit.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2023 16:52:42 -0500
Message-ID: <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev, 
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:07=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Because it's a horrible point of lock contention under heavily
> concurrent directory traversals...
>
>   - 12.14% d_instantiate
>      - 12.06% security_d_instantiate
>         - 12.13% selinux_d_instantiate
>            - 12.16% inode_doinit_with_dentry
>               - 15.45% _raw_spin_lock
>                  - do_raw_spin_lock
>                       14.68% __pv_queued_spin_lock_slowpath
>
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/dlock-list.h        |  9 ++++
>  security/selinux/hooks.c          | 72 +++++++++++++++----------------
>  security/selinux/include/objsec.h |  6 +--
>  3 files changed, 47 insertions(+), 40 deletions(-)

In the cover letter you talk about testing, but I didn't see any
mention of testing with SELinux enabled.  Given the lock contention
stats in the description above I'm going to assume you did test this
and pass along my ACK, but if you haven't tested the changes below
please do before sending this anywhere important.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
