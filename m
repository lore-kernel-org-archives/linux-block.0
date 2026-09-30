Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B64483A9
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798133; cv=pass; b=J9XSiwVq7qBujvmkl/a8XF2VvPTljmgJBpNN9VnU+f11m7iMvrBEqy9BhXt2pIzJC5T4qJ+39OXr5V7Gs+TXp/qR72nNUhX004RsrLQnKk3EJBmggM/s8NdtuZqXCTjEEOutNgvX39MJBbU3qlahImdesIs9O//oX1b5Heu66Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798133; c=relaxed/simple;
	bh=WMUdy7tDiX2awRwToea1X/vv/AICGI82qmsgusMQ2+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j00V7mB6SmJMIPj0PHNB/zkyQp2MaLvkpWGBiRnXKQp7qFAoeEwCrd1yKnLwJxo3jPRP8fgrEoiBUQUtXBVhBzVS4qfpIopXKSfDRLy3/o6FE3fSO4j2GMWyVrnBrhpyuD7GZmZxvQVy9V66kZySsJsu+RpHHdqXNL4mEvhERH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nks9wCrA; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nks9wCrA"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso2973808f8f.2
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 12:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790798129; cv=none;
        d=google.com; s=arc-20260327;
        b=UitmMzrLmJ9MDbsSTCpfq2GXvRUvSwW5evUSPhYF6O4t80AfqNg8d36vcEHvBYrJwu
         0kmG+74UrSpgGzmPTemau8M7c+cbcQUSi0XK6kj4vh7ks7d8+G1q/1D6JF2pY5+s/sZC
         pgTx65c8wl4j4CBr011MbW8EnmEwoHEQukDcbhaGMHekys/+k/eFtnCO+jsujF6zbnqg
         G1pgPwbtOijdrzqwKt2nit0/TLCmdxvZAiXu0D4kFv+tcasybbSBEhRmTBqYHGsjJQn7
         ylHTejBARVX9HfD7R2GhZ/Od3VjbjJjKmGUFj6LpiNVp5Xe+VEwNn46pvF3vgRr2pUTd
         LuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WMUdy7tDiX2awRwToea1X/vv/AICGI82qmsgusMQ2+w=;
        fh=5YAJkEiRxj4ssb9f36MUm8lTdtxpnBqj7oCRsUKe8AM=;
        b=g+XU0FpzREbpu0uDTbjdLFQQunZflum114vh77kGC6z+yYhV3wnX2Kr8o+ZQ4aqP+Y
         kEwZ/8D/mkwyJC5ia68EJD760T1yWCdyz6XwOY6Gk/18N11KEkSeuqCKvnCfq6iDZ5FW
         KQEZDfiAYBSsw8fiBve7Rg4ej2kGNG24xiTXqwtnuyG7EhMcYfz+QciFllP8/qllRWtr
         w6KwttKG6pphVOj41arDheYI05kfNRCqXVcGJyzeeoswcFTCJO+0POCgiKkgwe3IFWze
         m2f0TArRzZic2lxNZE03W6DEbucGozkYVEHrDDvgIUXLRNYE7ixKMI9CPTMAAJhyYOkM
         3WbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798129; x=1791402929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WMUdy7tDiX2awRwToea1X/vv/AICGI82qmsgusMQ2+w=;
        b=Nks9wCrA5hSPNe+bsn7IpJBxvnjiwsE94ni+sfjtmBbWrEamXuR5NGcpaCMRri2qwz
         U1KwDXwd7FE+6Lj4nbt5cIdddTNOuVhrwUmxX9Nkv70Ixexd5oVOq4cADSaTUGJUiyMW
         Xj5iPLHXqyFc+PmrKONiVb05nwe4wCo7So+jZ4z+dG/5vGxleDcaMd8btLR4MZV5QMO1
         qJXObhLGYdzdJVf70V3iUkOHc510tz1zZ0MbFh9NdUxDFhXuhNf4F0gfKO04vTmPBXvS
         zyIn/8FYS5XESbFyjhNRFEcHpe9rXObOyGvGTWELpCIUfJDdqIztLlG+qStuDIUpsbjb
         ITqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798129; x=1791402929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMUdy7tDiX2awRwToea1X/vv/AICGI82qmsgusMQ2+w=;
        b=iU/rmnDUAcoyZLPcEpJs4utefAh62vdfQaws8vmAvD3m71ls/TxPkeRNoVY65PVMjh
         bI2WyOPA//kg6SzMgPB5UvXbdNxvv5oBp0NCM6owrkNXndW3S1l4G9EJQXCSXhASk11g
         KktiqWUOu5lWOjn67frIljO9VSydJnkMO8EPLZf0ViE0p7si4c80qY6PJ2G/Rb35NFca
         bMf4gTl6PDLjBCV9RUwf6B0PWjK7awbvGoDs+Z16JKkv1G6enrxJcqMPmGxQFni2ldUX
         p2SwW2gYW8pyHFq/xJZBxEpaGg+ysJoCg5nXtK9FBWGZhcvZQgQIa1zvR0tooMrm2qNs
         QwMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsr7wY04BbR5sla1yiu+fp0w/zSTwOCW9onoAfpGWCMLibLyK3tDHG4rTcsoIeXc2lLaDTQoc1WSd1RA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJK1FecW4pIUvcSCBk5ST+iB/9QSdPB6bYHaL/uP0kMPOhGRB9T
	V4quKeSz1pvvMv+6kIKP4Ua4cZBs3aRW/1nx6IGuPLe//gXok6Ek59kBSLXFxrktKDp7z3CC/a5
	gWyzZ6KVSBmnASEDv/SDKRcKbMTsMbm9iLfXV1B4Y
X-Gm-Gg: AYBFou1i+ezh6XGYWde08ZRI+7yqxAaG+zD4XxY+ySJOTZPnjAbBVn10JVpkuwUHlV3
	jHolAmFUF2UG2rZJ5jsMaJtqbL0bnQxYh8W63NWT9c1eL8SlR5dzvJ9W5s+VH+zwv2lHyT4w+kf
	+G1+GwWH6K1rB9U9vaViBSO72xW/qpejyFOfHRmKQFJWHJ+m3nl1ubssmnujaG+nBmw/43op57a
	IiySX7gbZmwzNJE1ZP1eicwG/Lpf6Gololh9QxGD5C9l/SyqOcsAy94nwUUgdxczT+fa/nWmuVd
	ZKQTvKzLXhxtUSD9R4/nddUi7uFf45HHmtMZhc+dPTt2KrHdFaooMshBgoL6DuvPODYU9QF7smA
	dLJ+S0MRge/J2nxFtRZkT4DtehEgOeIk=
X-Received: by 2002:a5d:588a:0:b0:48a:fc9d:fbba with SMTP id
 ffacd0b85a97d-48b02457162mr5782247f8f.1.1790798129262; Wed, 30 Sep 2026
 12:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org>
In-Reply-To: <20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Sep 2026 21:55:16 +0200
X-Gm-Features: AclHuK_sfXYw15I6fJGf7REWaiGXo9FpiV5-U-o9glg31QFqn2PhckzyCf-vAyA
Message-ID: <CAH5fLgim+vLu-92B2vCi28cd7xOkwAPTVtuGqDHF=cj5VmpknA@mail.gmail.com>
Subject: Re: [PATCH] rust: block: implement `Send` and `Sync` for `TagSet`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Thorsten Leemhuis <linux@leemhuis.info>, Boqun Feng <boqun@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:44=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> `TagSet` never implemented `Send` or `Sync`. This did not matter until
> commit "rust: block: fix `Send` bound for `GenDisk`" made `GenDisk: Send`
> depend on `Arc<TagSet<T>>: Send`, which in turn requires `TagSet<T>: Send=
 +
> Sync`. With that bound unsatisfiable, `GenDisk` is never `Send`, and the
> rnull driver fails to build once configfs requires `GroupOperations::Chil=
d:
> Send`.
>
> `TagSet` owns no data typed by `T`. It only wraps the C `struct
> blk_mq_tag_set`, which can be dropped from any thread by calling
> `blk_mq_free_tag_set`. Thus, implement `Send` and `Sync` for `TagSet`
> unconditionally.
>
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/r/d1381ed8-eab8-4fd7-8b15-1e94876d7099@le=
emhuis.info
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
