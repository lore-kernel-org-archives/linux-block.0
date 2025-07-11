Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832827F00B
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228155; cv=none; b=PN5tzdog+VOjJGYd82iVXnMcEx1KoGc4ngPm/2QlxG0QXdwOIb3Dq1gCWEGoPDLaIZ+nR5PcnaayI6XWMZRqJk9Ny2PfdbHnU4Ak6nAgdkHe4PCPwOLlcXnlTjiyd1PlOIhnDSRT/C7T/2nS+hJovJowTHqUHYuUDlUCexd7oJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228155; c=relaxed/simple;
	bh=YykaaxSK319lKEMyhZZtukxic2rJfvQhL2mSEvHDGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fp2Ce/38SFPlbOQqs+q1z/LR52xUZy84IAHm9id0RV2HrQTGo6kFz8oxiC6YVUybkAiKW16O9jnhCIIjmVe0Lp7H+SDBaFUZb7x93/Hc9hHsic/DK7Xy6p6xNggDYtEZwKB6XE4x63QzY9RDPNKCjlWHL7O+lcBDRzDUsLWOqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDHjN/0H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDHjN/0H"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453398e90e9so14546825e9.1
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752228151; x=1752832951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3XCYABFMBC1fHadbt0BASB51W8QW6xg/j/nDStR70c=;
        b=sDHjN/0H436DIaUwFDtKqxFiNEY5bCr4/RD9eW0eJfAbOTfUA3Xnjb3e3FAEg026FZ
         clfiMsBjvkdeIk9XPMbchUEVY0sKomrzXxTCKkz72v6GEPcUkF3c672BriYsYhaXHgeg
         Nfdn2DzpLEeavRwG3E7Pf0sM/uVhg+tC8O9eh9owMLMIHiF8lsiWfI69Fs2JB8D0MeA6
         LvNPsaSDaA+zSyIz0zrh14BjfBDfaeuJp56CfekD8qrdGcDjVPAOrhcbfoFss4BRZppT
         0HjFXM3j5/Mm8xIGsuP9ljRYyXgP6gf3TrVWGSXIq5R7dsI9eALB/U3aKD38ulzw1uey
         EKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228151; x=1752832951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3XCYABFMBC1fHadbt0BASB51W8QW6xg/j/nDStR70c=;
        b=JSJ49iDhvJ0/YwxRbcjjxciFjcHoN2kUsmjZKJTApzOU3uSqnA+dXe+twnl3kxWXVb
         nAmsMQVPG6TtWqlHsAVxjPuiaI66szOLoxZCIOT5zGHghTuPxRVYmhsC8PHPOgJu3XJy
         ai0QYXLlS4iTpL83hZM2Ruh/8jBduCrKc38Beb+b4jKufapb6+8fsmZEaJCPR6USmFhl
         mjO7VmcQZD5TinLxyqi275lB7bJL6LEz57vMwmVua6gncx+cCOaiWyDPLuF3I3DWGsVz
         fZF8e3drISoIuBmnSXDtLUok5jmpP36igJMzazIDpFKMkhAJA4ZERzKXjB2yY8LZ4Yvk
         jxqA==
X-Forwarded-Encrypted: i=1; AJvYcCXKzcbtGfua5j8CHyiIvQ0rt4hKKeablhQvH90kRKX5gAxClNJBoP4D2yDiiVcXhg5LHZ+kbBirZgitOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFgj54Hx2TOQ/ufw7rIwgsXQbI7GUs76w/977+SN1XklsNlRp
	s5MK/pA6UgQezBxZffMFC031lASuN2AldRWZuC4OBUWFBaAYwB96URZl+FPy1N7tihcl0vpW6Wc
	PeLITXOqWtSQxmSXnx4VUhyuo08zTaFBQ+t6fK662
X-Gm-Gg: ASbGnctxexLfq38OiUsUaqxKIzMoTHVqFi7xT4GomBvtEOAwemayeR2JNxfbn+WmgiS
	vJ1NNjVAndZATEhmZKrGgWWTvLxes+ImGSAi4b03jIMTrxalswPXWNV3mi9ML9PL2a0sewwOKa5
	kgQP1ea0SsLIGpRi3c1QPVTCGZ9NBxpA/UCA7BnV2E8Xe6yJkALOFFoub9O/gt0PoX07ASLOaH3
	9IOKm32e51FRTlvIQc=
X-Google-Smtp-Source: AGHT+IGUQIrtfVItwM5tfYsJuZwsz9X67ZfbXHpoiNYzH5FRyT3WE8B4aAME5Tzz2IbykJRHbQAYa9NR2ZyDDp7Ds+g=
X-Received: by 2002:a05:600c:468d:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-454ec151c5dmr24053175e9.2.1752228151317; Fri, 11 Jul 2025
 03:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
 <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org> <1RnkSkM82_BGKhOM4PKNTPqEQdSFQhpr6UlkVOD7EDhmTJxZ_hlNFhVuiqpUtKKW1uFUFSB7Ow3LJ31nvHUnDQ==@protonmail.internalid>
 <aG5ttHBYW3SQlSv7@google.com> <878qkvhy7p.fsf@kernel.org>
In-Reply-To: <878qkvhy7p.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Jul 2025 12:02:19 +0200
X-Gm-Features: Ac12FXxr-8pN5bwGCwORG6U45Emsz82nZAIPI7oH6OS8Ef91_XrzptO86C551CE
Message-ID: <CAH5fLgjwmXJP2LcE8UKP1gdqbsTA5QyynLcw5iG93hXeLuOBAA@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Tue, Jul 08, 2025 at 09:45:00PM +0200, Andreas Hindborg wrote:
> >> Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to =
the
> >> name buffer. This new formatter automatically adds a trailing null mar=
ker
> >> after the written characters, so we don't need to append that at the c=
all
> >> site any longer.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> ---
> >>  rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
> >>  rust/kernel/block/mq/raw_writer.rs | 1 +
> >>  rust/kernel/str.rs                 | 7 -------
> >>  3 files changed, 5 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/g=
en_disk.rs
> >> index 679ee1bb21950..e0e42f7028276 100644
> >> --- a/rust/kernel/block/mq/gen_disk.rs
> >> +++ b/rust/kernel/block/mq/gen_disk.rs
> >> @@ -7,9 +7,10 @@
> >>
> >>  use crate::{
> >>      bindings,
> >> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> >> +    block::mq::{Operations, TagSet},
> >>      error::{self, from_err_ptr, Result},
> >>      static_lock_class,
> >> +    str::NullBorrowFormatter,
> >>      sync::Arc,
> >>  };
> >>  use core::fmt::{self, Write};
> >> @@ -143,14 +144,13 @@ pub fn build<T: Operations>(
> >>          // SAFETY: `gendisk` is a valid pointer as we initialized it =
above
> >>          unsafe { (*gendisk).fops =3D &TABLE };
> >>
> >> -        let mut raw_writer =3D RawWriter::from_array(
> >> +        let mut writer =3D NullBorrowFormatter::from_array(
> >>              // SAFETY: `gendisk` points to a valid and initialized in=
stance. We
> >>              // have exclusive access, since the disk is not added to =
the VFS
> >>              // yet.
> >>              unsafe { &mut (*gendisk).disk_name },
> >>          )?;
> >> -        raw_writer.write_fmt(name)?;
> >> -        raw_writer.write_char('\0')?;
> >> +        writer.write_fmt(name)?;
> >
> > Although this is nicer than the existing code, I wonder if it should
> > just be a function rather than a whole NullBorrowFormatter struct? Take
> > a slice and a fmt::Arguments and write it with a nul-terminator. Do you
> > need anything more complex than what you have here?
>
> I don't need anything more complex right now. But I think the
> `NullTerminatedFormatter` could be useful anyway:
>
>   +/// A mutable reference to a byte buffer where a string can be written=
 into.
>   +///
>   +/// The buffer will be automatically null terminated after the last wr=
itten character.
>   +///
>   +/// # Invariants
>   +///
>   +/// `buffer` is always null terminated.
>   +pub(crate) struct NullTerminatedFormatter<'a> {
>   +    buffer: &'a mut [u8],
>   +}
>   +
>   +impl<'a> NullTerminatedFormatter<'a> {
>   +    /// Create a new [`Self`] instance.
>   +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFo=
rmatter<'a>> {
>   +        *(buffer.first_mut()?) =3D 0;
>   +
>   +        // INVARIANT: We null terminated the buffer above.
>   +        Some(Self { buffer })
>   +    }
>   +
>   +    pub(crate) fn from_array<const N: usize>(
>   +        buffer: &'a mut [crate::ffi::c_char; N],
>   +    ) -> Option<NullTerminatedFormatter<'a>> {
>   +        Self::new(buffer)
>   +    }
>   +}
>   +
>   +impl Write for NullTerminatedFormatter<'_> {
>   +    fn write_str(&mut self, s: &str) -> fmt::Result {
>   +        let bytes =3D s.as_bytes();
>   +        let len =3D bytes.len();
>   +
>   +        // We want space for a null terminator. Buffer length is alway=
s at least 1, so no overflow.
>   +        if len > self.buffer.len() - 1 {
>   +            return Err(fmt::Error);
>   +        }
>   +
>   +        let buffer =3D core::mem::take(&mut self.buffer);
>   +        // We break the null termination invariant for a short while.
>   +        buffer[..len].copy_from_slice(bytes);
>   +        self.buffer =3D &mut buffer[len..];
>   +
>   +        // INVARIANT: We null terminate the buffer.
>   +        self.buffer[0] =3D 0;
>   +
>   +        Ok(())
>   +    }
>   +}
>   +
>
> If you insist, I can write something like
>
>   fn format_to_buffer(buffer: &mut [u8], args: fmt::Arguments) -> fmt::Re=
sult
>
> although I am not sure I see the point of this change.

I don't mind. I just thought it was simpler since you only need to
support a single write instead of having to support multiple writes.

Alice
