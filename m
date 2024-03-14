Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6E762D6
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444187; cv=none; b=bEDHKpzfi9mvZEORElOsgo53gYMfXw6uFaQPx47BzP+itcZOIwaPSXwke6cSs4iYGntGSVc7LNAIro/iF0ql/YX2zszaapuVj7gSMEVGj0C6GAGYTGOmwIfclAk8IaomUc4EDIcQOCXYyWMduKBltEWaVIAieYuXheCfQpK7jSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444187; c=relaxed/simple;
	bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRG98Y7Ln37d4w6PJA5HTu9lHsfY/6rMAnvIARsbQ9LkpPTiNze1oXpDedeU6POaTOIJedZ7Bd84qmHeeCulTg8G67mZ2jV28QVIiP3UBrl7GXco7zhnez5HMj6KpzrlCdKWGxNqdO5HXd9u1X5f+0Ht3qpgx0fwi0byuQF2/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=zJaYdoR6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="zJaYdoR6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5684073ab38so2470359a12.0
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710444183; x=1711048983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
        b=zJaYdoR62LpQZ4gmNRiW90HBcvll6kmkTT0I8yiYizL+rgm1f1h4XvDJDWfVbvVfs9
         esDRZVRZzuOaGHudRXs1mK796AoaHv9qfKxFDCMe/0m9vKPx9FCx4y+XffTxMMk1VYcy
         QvsFIIWRfGERdJhPGSujmoYhnU2g9Hpl1KRlD06yUzjYOUGkvvPrd23xHZCi9DT3fKie
         f1EaIgQ/HuXV4PgDSc9d7T2RHRYeIL5LAacRvrjgZT8XDlL6061WKUFehGSGtmB1tuUE
         bBuzON26u2FJx+fgX6U2aQDufjqwUaZDwxsYK64lyATFA0GgcMgIeRc8SrYRi1z8m5PA
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444183; x=1711048983;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
        b=ly+fJznCP76YFoqKNrtSTb/2gZUhJp0NEQjSu8CS8hz6gsUVoKh3zE/4n4k4+JmmkP
         PwMnfcEaqtBqU6UwuDLDzmc+uv3tVo3bRfDNZ/UVOC9iD9bm8cKSH+dT7TyXYR1V44bq
         lzmni05fuEyCgy2NNrP/S1JooTvk1182aGoPXMhdsbiDR+LJmDbZj6IBp3aaeYkNsi4A
         JR+Pg5IaHVPeFdqvk7Kr/hqlIJLsePYKIN1A0h7gVutQqN00078WP0jSv8n8GK4PJT2y
         +WDPrTW/5Ml5tVERQcj99zYCNfZ7DzzNwAPZcNx6b8PDgD9FxVtXyTLcsBhpm82kXPca
         FLNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpbfb25MmH5sioL9EDHHcmrEgM5y1seYV3paVc0aMtgVLubN+n8bttMlD2UyRwcrBQJZnjOBIVSEU79cfW0M3q6cWdMz2KHnQc87k=
X-Gm-Message-State: AOJu0YyRKY5AxgdCX2FsVFJEYX5yca8QFmpiVQvpBsjw19q3QqNX4AnH
	HH+4A4WJ1hCTIDQHsBb29NdhwK+rAXeqiu26S1+C706S5dbv6wOeFShuefaloa4=
X-Google-Smtp-Source: AGHT+IEQiBoHqZGzF80uJgL2VLJfYI3sQXzz6qKOOI7PtZ2ZTkI1WY3DSt46ADJnk/nmochY/RgTWQ==
X-Received: by 2002:a05:6402:4493:b0:567:80c7:33bf with SMTP id er19-20020a056402449300b0056780c733bfmr3038848edb.7.1710444183353;
        Thu, 14 Mar 2024 12:23:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00568a15b063csm799503edb.2.2024.03.14.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:23:02 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Keith Busch <kbusch@kernel.org>,  Damien
 Le Moal <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,
  Hannes Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Niklas Cassel
 <Niklas.Cassel@wdc.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Alice Ryhl <aliceryhl@google.com>,  Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan
 Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Thu, 14 Mar 2024 19:55:49 +0100")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 20:22:54 +0100
Message-ID: <87plvwsjn5.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Thu, Mar 14, 2024 at 9:58=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> Yes, good point. Another option suggested by Miguel is that
>> `__blk_mq_free_request` need not be exported at all. We can make it
>> non-static and then call it from
>> `rust_helper_blk_mq_free_request_internal()`. Then only the latter will
>> be in the kernel image symbol table, which might be better in terms of
>> not exposing `__blk_mq_free_request()` directly.
>
> The helper is not needed, i.e. what I meant was to make it non-static
> and add it to `include/linux/blk-mq.h`.

The way the current code compiles, <kernel::block::mq::Request as
kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
module. A relocation for `rust_helper_blk_mq_free_request_internal`
appears in `rnull_mod.ko`. I didn't test it yet, but if
`__blk_mq_free_request` (or the helper) is not exported, I don't think
this would be possible?

BR Andreas
