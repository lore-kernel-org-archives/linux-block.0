Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444273180
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445282; cv=none; b=syEP5iQrRGEAYhFXsMc0f/oFaCb2j4Bi7AoqJH1W0DjGireqjO8ZnAwiMHGFfEkxIY4qO0kwIVHTbi+P2w1rqvMDBRGBD33FoT5kWk3Al1WbV/OU44fG2hzLESFfKoIBrMlrOElX/vWuzJn2IOW/ppHwVlpgaEUOJRrhIp4gMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445282; c=relaxed/simple;
	bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwDqUKlLsHwiKf92PqPO8hILoNqhutle7yWiDzzJRpVojNS9rKEg2x+dLo1OilbdlYoVv5vovKololQgs3xLo7f23LzIjq9elr6WJ5h5uU8V8MB8R9IzZZaxn7r5PC8qblCbj75SrYeGZZO67cSZ+XRiRFFHyOyCP8/8+xcQLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=oelIcVXH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="oelIcVXH"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a36126ee41eso167410666b.2
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710445279; x=1711050079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
        b=oelIcVXHmAxAgJy++hRkxCKVyUb5JZiFiSwX6PT+K54sa6aWdq6+QmNCPY2vjzOxVB
         BImHM41VK05Bc3zhxrNYknDQNjth5ZliXoGozxhwA59IZSy1CBuAR6XYnT7CT2fL6jCM
         V3sbwrtJ5Z5NJ1KIhyEzbilcM0EBtXbCAV5/BEsvzGnPk9W0bqSGRIVyJT5+dQEf+00D
         d2X/8F/SqKPztERzQ2A8CndAXCWMcPcHc+R54eaVrRYaFCvtXsPNio9ENcThnMzTmhY+
         /9E8VctpEGb384dNrS242BoPCBSlkHE61f/8fB6eO7PPZS/KhTt2IfJ9T4KT7A5fjmmg
         mMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445279; x=1711050079;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
        b=WttEW3Y167hDinyITV3q4MbJdIGiP8iuIjdXm2wvrr037WgizdDB1GJw0tIrD3mW12
         WqGzKT66VQAwh/8mjfj2e0j5skACk+AfPpsS3vmQzxy1fel5bLluPod0TtKAg2d95bhP
         ENRb0+mb2tLZv5/j2BwYKRqcQYIgSxJHKrmNm6u3Qf7j0EFSASIplx9chov71QwGD0Ek
         jPWiWM831A1ZR5jcb+hgFAgunPVA7HDAfSNSuApErmjrO5WLd49rs3Rh6O1L3DA1W93P
         ZpPWl76+s7S44OFNNstne2aC6/eLTRFGXlGxQ+920rxPkydiM92VSxJntB2A58hbOMaC
         1wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAREY9h8L6mrKaHmX7qgd1xIR4h8OmWuNSFU6LHO9iksdbHdd5l46tdYMXhD+dnUYUs4UUiVeCrFeZHmp3PWE+6myYbYoHjpLcqlI=
X-Gm-Message-State: AOJu0Yxo/OOW4GrDIOq+AJRD+qLyG/woO9T7YNb/V0TkFSjHwtd5OAhU
	6G87gKKJYpPrsGfR8sefBAAbkXeQPDnD2TauB2N2cjlz4uyCE5gjfPMepKvtlWU=
X-Google-Smtp-Source: AGHT+IH8czNlNagx2kXUJ8xAoaQoY9sfM4cx5YqDd4DehyKpFMZ6MjCDM1M528wBaOxegt8hCWznIQ==
X-Received: by 2002:a17:906:c0cc:b0:a46:2100:da56 with SMTP id bn12-20020a170906c0cc00b00a462100da56mr1804417ejb.55.1710445278810;
        Thu, 14 Mar 2024 12:41:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061b0b00b00a3fb9f1f10csm972383ejg.161.2024.03.14.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:41:18 -0700 (PDT)
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
In-Reply-To: <87plvwsjn5.fsf@metaspace.dk> (Andreas Hindborg's message of
	"Thu, 14 Mar 2024 20:22:54 +0100")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 20:41:10 +0100
Message-ID: <87h6h8sisp.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <nmi@metaspace.dk> writes:

> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>
>> On Thu, Mar 14, 2024 at 9:58=E2=80=AFAM Andreas Hindborg <nmi@metaspace.=
dk> wrote:
>>>
>>> Yes, good point. Another option suggested by Miguel is that
>>> `__blk_mq_free_request` need not be exported at all. We can make it
>>> non-static and then call it from
>>> `rust_helper_blk_mq_free_request_internal()`. Then only the latter will
>>> be in the kernel image symbol table, which might be better in terms of
>>> not exposing `__blk_mq_free_request()` directly.
>>
>> The helper is not needed, i.e. what I meant was to make it non-static
>> and add it to `include/linux/blk-mq.h`.
>
> The way the current code compiles, <kernel::block::mq::Request as
> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> appears in `rnull_mod.ko`. I didn't test it yet, but if
> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> this would be possible?
>

I just tested what you suggested Miguel, and I get a link error for
`__blk_mq_free_request` being undefined when the module is linked. This
is even though the code that calls this function lives in the `kernel`
crate, because it is inlined.

BR Andreas
