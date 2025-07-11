Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494C279DB8;
	Fri, 11 Jul 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226196; cv=none; b=jwMXnN61KVHwi4O7/QlxbAjatrBRd+9TuB/ciKzEhXzrXW8XzCzdcm06wo1U2Ugakyx7EOXSYSVB0fgRNVlbcVwksv4MuhTt35tkqCR0IgxJEobQXrZsI/AHcdg4rwYFDUEksJSgCqGmGVogYeTf/k2sXzvXNa39gZYWR7n7JdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226196; c=relaxed/simple;
	bh=g635AuROiIJUsnlRuPb0NpgIXG9FJEv+7lx2i4prxN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DAiWFeVyk14VUyv2uMY+D4Lu5n/duvhneEkyGSQPlOLFbtkgUVJtshKm1bm4UT44104fPpbIvwOS461SrVaML0nwZp328hnVhl+OSVNRwAq+ugC+TGNYVtHEpiUBTHqbegQssyNADj17f6GQCGT8cTvH622RvVJW7U90do6AMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE9NDK9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE9NDK9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D190FC4CEF5;
	Fri, 11 Jul 2025 09:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226196;
	bh=g635AuROiIJUsnlRuPb0NpgIXG9FJEv+7lx2i4prxN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lE9NDK9Oqx9H593Fkd6BUGxrwcePtgfvnCJ4HjUbRKYaTOlnHH4m7zdDIVhH7pJU0
	 bjC70qQg+2NhJvwfgAsO9aGW2BsMASEhzugg6Ysy2RCCBfuXsmZ7tKtYVepA9ADVf4
	 paI5r7yCC4wmNrdH6yvyASgWKIrIjoHqU58pqHcuugsPhVoDYdgkkBz07tFZgZk004
	 eWcQLgZ7+IGRPCfCn+x1tg4vu6Nx7MuiHV3HNu8a09D8ITF3jo8ywkjnw+p3W1urS+
	 jTgCHvo+YD3dzx/JDGZl51bEMGHpgxUnuOBVAFMdq1BrxFOknyxkWNqoLA58EGpFFS
	 JKbeTyJ5VWD1Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Jens Axboe" <axboe@kernel.dk>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
In-Reply-To: <aG5ttHBYW3SQlSv7@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 13:25:08 +0000")
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
	<20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
	<1RnkSkM82_BGKhOM4PKNTPqEQdSFQhpr6UlkVOD7EDhmTJxZ_hlNFhVuiqpUtKKW1uFUFSB7Ow3LJ31nvHUnDQ==@protonmail.internalid>
	<aG5ttHBYW3SQlSv7@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 11 Jul 2025 11:29:46 +0200
Message-ID: <878qkvhy7p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 09:45:00PM +0200, Andreas Hindborg wrote:
>> Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to the
>> name buffer. This new formatter automatically adds a trailing null marker
>> after the written characters, so we don't need to append that at the call
>> site any longer.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
>>  rust/kernel/block/mq/raw_writer.rs | 1 +
>>  rust/kernel/str.rs                 | 7 -------
>>  3 files changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
>> index 679ee1bb21950..e0e42f7028276 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -7,9 +7,10 @@
>>
>>  use crate::{
>>      bindings,
>> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
>> +    block::mq::{Operations, TagSet},
>>      error::{self, from_err_ptr, Result},
>>      static_lock_class,
>> +    str::NullBorrowFormatter,
>>      sync::Arc,
>>  };
>>  use core::fmt::{self, Write};
>> @@ -143,14 +144,13 @@ pub fn build<T: Operations>(
>>          // SAFETY: `gendisk` is a valid pointer as we initialized it above
>>          unsafe { (*gendisk).fops = &TABLE };
>>
>> -        let mut raw_writer = RawWriter::from_array(
>> +        let mut writer = NullBorrowFormatter::from_array(
>>              // SAFETY: `gendisk` points to a valid and initialized instance. We
>>              // have exclusive access, since the disk is not added to the VFS
>>              // yet.
>>              unsafe { &mut (*gendisk).disk_name },
>>          )?;
>> -        raw_writer.write_fmt(name)?;
>> -        raw_writer.write_char('\0')?;
>> +        writer.write_fmt(name)?;
>
> Although this is nicer than the existing code, I wonder if it should
> just be a function rather than a whole NullBorrowFormatter struct? Take
> a slice and a fmt::Arguments and write it with a nul-terminator. Do you
> need anything more complex than what you have here?

I don't need anything more complex right now. But I think the
`NullTerminatedFormatter` could be useful anyway:

  +/// A mutable reference to a byte buffer where a string can be written into.
  +///
  +/// The buffer will be automatically null terminated after the last written character.
  +///
  +/// # Invariants
  +///
  +/// `buffer` is always null terminated.
  +pub(crate) struct NullTerminatedFormatter<'a> {
  +    buffer: &'a mut [u8],
  +}
  +
  +impl<'a> NullTerminatedFormatter<'a> {
  +    /// Create a new [`Self`] instance.
  +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
  +        *(buffer.first_mut()?) = 0;
  +
  +        // INVARIANT: We null terminated the buffer above.
  +        Some(Self { buffer })
  +    }
  +
  +    pub(crate) fn from_array<const N: usize>(
  +        buffer: &'a mut [crate::ffi::c_char; N],
  +    ) -> Option<NullTerminatedFormatter<'a>> {
  +        Self::new(buffer)
  +    }
  +}
  +
  +impl Write for NullTerminatedFormatter<'_> {
  +    fn write_str(&mut self, s: &str) -> fmt::Result {
  +        let bytes = s.as_bytes();
  +        let len = bytes.len();
  +
  +        // We want space for a null terminator. Buffer length is always at least 1, so no overflow.
  +        if len > self.buffer.len() - 1 {
  +            return Err(fmt::Error);
  +        }
  +
  +        let buffer = core::mem::take(&mut self.buffer);
  +        // We break the null termination invariant for a short while.
  +        buffer[..len].copy_from_slice(bytes);
  +        self.buffer = &mut buffer[len..];
  +
  +        // INVARIANT: We null terminate the buffer.
  +        self.buffer[0] = 0;
  +
  +        Ok(())
  +    }
  +}
  +

If you insist, I can write something like

  fn format_to_buffer(buffer: &mut [u8], args: fmt::Arguments) -> fmt::Result

although I am not sure I see the point of this change.


Best regards,
Andreas Hindborg


