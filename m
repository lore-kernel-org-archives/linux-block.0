Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22715303C9E;
	Wed, 13 Aug 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106593; cv=none; b=aWV0VYyS3TTPkaNJdUqn7QerYInVdBMbOVLqemiXlKBydFo3pjMmoH9qQhh70LN4EdiOWmhKttR89NqoneEvuMmEwkbKtczkpMZIxR+a1VI3wCX/4TV3sC0CRfgstwBnhPM/OZv+yfPk6d9ZSC1bmwPNYCpwla1TQ2lM4r6e9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106593; c=relaxed/simple;
	bh=W2jykzk9vNeNBwBx8h9jq52eg5q/V2UCf23FXsVydAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/gYzrpEkwE7oP9sfubv3c0KueMysYx6WYktm+ps3BDgEiBqAIBqTmZ5dE3TaDSE0gf9B0cnigPtbokb6cfR/fkCKebuOa/8w9F98pDwBlOe9AY0BvdTYA2m0I+oF8zCGBGi32VPvo9npGq/NVXEhUBVFRjfhmCC+RgtaUv7CJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxTTRcaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxTTRcaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E29C4CEF1;
	Wed, 13 Aug 2025 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755106592;
	bh=W2jykzk9vNeNBwBx8h9jq52eg5q/V2UCf23FXsVydAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TxTTRcaQN74NBGexr3vAgCXOTDdj4soOkBd6ymoC6+sgQVPd+Uu76F6gYrMQ/ojg0
	 VSt4TcPaLXPnG0uqIrQNu0FmrXoi1rPWst8fDVZq9auz2aG2XjOOJ+OJ8HHLsyJ8kG
	 dp93Mt8kpc5oxYpYLHDbhYGKXJHwOXTyEfyFpbOWi9CvDHY0eaqpahdZLOERoRmA7R
	 7DC4cXiUukVUR8UuWnQ9N071KsO8hArWkcaM0FgCu2NJcrOj/DpTmyNK0Xw/X79d55
	 GXVsM2t/XyvjaKsaGA5Rnc6O+9i3ybYWgLcusf4IDfrbWW/manDFCSvooPmhehkNMC
	 CzyWAkwkELztQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
In-Reply-To: <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
 <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com>
 <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
 <WporCpRrDB_e8ocWi63px_bwtPWqRjDL4kVPNNXFNoI6H-4bgk5P_n4iO0E4m-ElwkiNTyBITwgdMXjREE8VXQ==@protonmail.internalid>
 <CAH5fLggraEP7bwzJ+4ww8-7Ku-Z+d0Em3=NDUpa7r8oTLQy81A@mail.gmail.com>
Date: Wed, 13 Aug 2025 19:36:19 +0200
Message-ID: <877bz7f7jg.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Aug 13, 2025 at 3:47=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Tue, Aug 12, 2025 at 10:44:29AM +0200, Andreas Hindborg wrote:
>> >> Allow rust null block devices to be configured and instantiated via
>> >> `configfs`.
>> >>
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >
>> > Overall LGTM, but a few comments below:
>> >
>> >> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/co=
nfigfs.rs
>> >> new file mode 100644
>> >> index 000000000000..8d469c046a39
>> >> --- /dev/null
>> >> +++ b/drivers/block/rnull/configfs.rs
>> >> @@ -0,0 +1,218 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +use super::{NullBlkDevice, THIS_MODULE};
>> >> +use core::fmt::Write;
>> >> +use kernel::{
>> >> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>> >> +    c_str,
>> >> +    configfs::{self, AttributeOperations},
>> >> +    configfs_attrs, new_mutex,
>> >
>> > It would be nice to add
>> >
>> >       pub use configfs_attrs;
>> >
>> > to the configfs module so that you can import the macro from the
>> > configfs module instead of the root.
>>
>> OK, I'll do that.
>>
>> >
>> >> +            try_pin_init!( DeviceConfig {
>> >> +                data <- new_mutex!( DeviceConfigInner {
>> >
>> > Extra spaces in these macros.
>>
>> Thanks. I subconsciously like the space in that location, so when
>> rustfmt is bailing, I get these things in my code.
>>
>> >> +        let power_op_str =3D core::str::from_utf8(page)?.trim();
>> >> +
>> >> +        let power_op =3D match power_op_str {
>> >> +            "0" =3D> Ok(false),
>> >> +            "1" =3D> Ok(true),
>> >> +            _ =3D> Err(EINVAL),
>> >> +        }?;
>> >
>> > We probably want kstrtobool here instead of manually parsing the
>> > boolean.
>>
>> Yea, I was debating on this a bit. I did want to consolidate this code,
>> but I don't particularly like ktostrbool. But I guess in the name of
>> consistency across the kernel it is the right choice.
>>
>> I'll add it to next spin.
>
> For your convenience, I already wrote a safe wrapper of kstrtobool for
> an out-of-tree driver. You're welcome to copy-paste this:
>
> fn kstrtobool(kstr: &CStr) -> Result<bool> {
>     let mut res =3D false;
>     to_result(unsafe {
> kernel::bindings::kstrtobool(kstr.as_char_ptr(), &mut res) })?;
>     Ok(res)
> }

Thanks, I did one as well today, accepting `&str` instead. The examples
highlight why it is not great:


  /// Convert common user inputs into boolean values using the kernel's `ks=
trtobool` function.
  ///
  /// This routine returns `Ok(bool)` if the first character is one of 'YyT=
t1NnFf0', or
  /// [oO][NnFf] for "on" and "off". Otherwise it will return `Err(EINVAL)`.
  ///
  /// # Examples
  ///
  /// ```
  /// # use kernel::str::kstrtobool;
  ///
  /// // Lowercase
  /// assert_eq!(kstrtobool("true"), Ok(true));
  /// assert_eq!(kstrtobool("tr"), Ok(true));
  /// assert_eq!(kstrtobool("t"), Ok(true));
  /// assert_eq!(kstrtobool("twrong"), Ok(true)); // <-- =F0=9F=A4=B7
  /// assert_eq!(kstrtobool("false"), Ok(false));
  /// assert_eq!(kstrtobool("f"), Ok(false));
  /// assert_eq!(kstrtobool("yes"), Ok(true));
  /// assert_eq!(kstrtobool("no"), Ok(false));
  /// assert_eq!(kstrtobool("on"), Ok(true));
  /// assert_eq!(kstrtobool("off"), Ok(false));
  ///
  /// // Camel case
  /// assert_eq!(kstrtobool("True"), Ok(true));
  /// assert_eq!(kstrtobool("False"), Ok(false));
  /// assert_eq!(kstrtobool("Yes"), Ok(true));
  /// assert_eq!(kstrtobool("No"), Ok(false));
  /// assert_eq!(kstrtobool("On"), Ok(true));
  /// assert_eq!(kstrtobool("Off"), Ok(false));
  ///
  /// // All caps
  /// assert_eq!(kstrtobool("TRUE"), Ok(true));
  /// assert_eq!(kstrtobool("FALSE"), Ok(false));
  /// assert_eq!(kstrtobool("YES"), Ok(true));
  /// assert_eq!(kstrtobool("NO"), Ok(false));
  /// assert_eq!(kstrtobool("ON"), Ok(true));
  /// assert_eq!(kstrtobool("OFF"), Ok(false));
  ///
  /// // Numeric
  /// assert_eq!(kstrtobool("1"), Ok(true));
  /// assert_eq!(kstrtobool("0"), Ok(false));
  ///
  /// // Invalid input
  /// assert_eq!(kstrtobool("invalid"), Err(EINVAL));
  /// assert_eq!(kstrtobool("2"), Err(EINVAL));
  /// ```
  pub fn kstrtobool(input: &str) -> Result<bool> {
      let mut result: bool =3D false;
      let c_str =3D CString::try_from_fmt(fmt!("{input}"))?;

      // SAFETY: `c_str` points to a valid null-terminated C string, and `r=
esult` is a valid
      // pointer to a bool that we own.
      let ret =3D unsafe { bindings::kstrtobool(c_str.as_char_ptr(), &mut r=
esult as *mut bool) };

      kernel::error::to_result(ret).map(|_| result)
  }

Not sure if we should take `CStr` or `str`, what do you think?


Best regards,
Andreas Hindborg


