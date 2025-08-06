Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189E291891;
	Wed,  6 Aug 2025 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492472; cv=none; b=ic3mny06y/ia0/tuUBlbkMG2PVVQd3s3R6aOttabVA/cwghiyuKnAAHukXpXg4bUkI4jCz73jBi/Fkrz+NDmsfNisxgw0lSHkh4/Us6iWHbCtoVCmzD7sK53XeLCM4VaG5ifUOpM4HP39yKffZbYotR+YAPIFQ+rygzEd/M1k3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492472; c=relaxed/simple;
	bh=mnWYMh0PdBIo9wnkX/skX4J305rjw8krePIvdGdb3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q3H/y7xvJSad0oL2ga2RJH+WD7GPaciVOHbvkewq7Cutu1rt3+/vn/uf6/lqLbcXar+DBgmBICzn4NqaLpU3cWDBns6E48G8quQUO4M7vMf48F+VP9SDF12deFU0OeYwu80eXgHNzGYUD87+1r+nZsEXDoDm+9yA0zZhLB4BYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX7fS+/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX7fS+/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C0AC4CEED;
	Wed,  6 Aug 2025 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492472;
	bh=mnWYMh0PdBIo9wnkX/skX4J305rjw8krePIvdGdb3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PX7fS+/t+d9ZNyU490Wss0uC80/8LydurEUkKhVRWz/B9zcypuBWOKGyAZOfLViRW
	 z4Eix/VQFJvBn9fnlP8MA40TnxvVXaD53L0BHiMEDUJ+oAZKProy3he15nlpYZn0y/
	 CgX5FcQri5dC/Ju94MHGsR9UlziTFGh9yvFTKS58qWlIBZkxZ34lj92C9debGUW139
	 hU1djZqq59nhr5BH56Jj4nBXP7JgKv8S2bzNWrezxDCpjfwjbyinS084O5aVMeHDRz
	 4sb7ayLyqo+n9juPGkVSico6J0iW8C1dxf5cU3OWQBdtv+M7akYtXfbZ3eNgPIfqiF
	 rnnxls7xfatGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] rust: str: allow `str::Formatter` to format
 into `&mut [u8]`.
In-Reply-To: <37C6B308-202A-48A3-9DD2-5997E0EE73C1@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
 <WW8rvpPmL4xHgDorFAQ5UrdGMUWXYOH_h1c3uzXhne_7E-l_Sbe8npJDfwE6fAcLWShbTjn5Oxn-dqxC4ZLW4Q==@protonmail.internalid>
 <37C6B308-202A-48A3-9DD2-5997E0EE73C1@collabora.com>
Date: Wed, 06 Aug 2025 16:32:49 +0200
Message-ID: <87cy988qr2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Improve `Formatter` so that it can write to an array or slice buffer.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/str.rs | 19 ++++++++++++++-----
>> 1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index 488b0e97004e..41af456a46c8 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -6,6 +6,7 @@
>> use crate::prelude::*;
>> use core::{
>>     fmt::{self, Write},
>> +    marker::PhantomData,
>>     ops::{self, Deref, DerefMut, Index},
>> };
>>
>> @@ -794,9 +795,9 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>> /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
>> ///
>> /// Fails if callers attempt to write more than will fit in the buffer.
>> -pub(crate) struct Formatter(RawFormatter);
>> +pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
>>
>> -impl Formatter {
>> +impl Formatter<'_> {
>>     /// Creates a new instance of [`Formatter`] with the given buffer.
>>     ///
>>     /// # Safety
>> @@ -805,11 +806,19 @@ impl Formatter {
>>     /// for the lifetime of the returned [`Formatter`].
>>     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
>>         // SAFETY: The safety requirements of this function satisfy those of the callee.
>> -        Self(unsafe { RawFormatter::from_buffer(buf, len) })
>> +        Self(unsafe { RawFormatter::from_buffer(buf, len) }, PhantomData)
>> +    }
>> +
>> +    /// Create a new [`Self`] instance.
>> +    #[expect(dead_code)]
>> +    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
>
> nit: the function above this one returns Self, and this one returns Formatter.
> Perhaps this one should also return Self for consistency?

Thanks. Not sure about the explicit lifetime either, I'll
reformat:

@@ -844,7 +844,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
 
     /// Create a new [`Self`] instance.
     #[expect(dead_code)]
-    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
+    pub(crate) fn new(buffer: &mut [u8]) -> Self {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.
         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }


Best regards,
Andreas Hindborg


