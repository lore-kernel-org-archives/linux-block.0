Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B914AD20;
	Wed, 13 May 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683198; cv=none; b=HVbBYF+p+UljFw4WdBuShMvSIdeKeL0xA/dhTZVwfqPIcyw3oMUm2l3wn7T7anoS3YZPK8/K2xVhKFzQVKZhh7ZiSqokeDMzjoiVjvX+PSMlWLHSwqYEgYCEM3IR5x5mQvh6MR/SU+RiruApTvSfHMNrhKUCXzfnTCjzvqxfBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683198; c=relaxed/simple;
	bh=/Itz8rUC6zWsgXF2WM8FdHvpSMrY909xTLPghnPN7SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ol7nKg6VrR22XDmNARoRYEylXjJc2Pux1JPrpy7XbR7DXjVbpxw5rHTUg85pOAcz3pJ8ZHL8YGs2NlTVk7qGMat6J3k82Ti2liYmd9NbMd33TIZEjfoE2WR1VfY7Z3YcKBXEsJOuLBPQOirHAT5TkY3wWZxSA9ZnnZpoSVPHZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMrudIA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMrudIA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A89C19425;
	Wed, 13 May 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778683198;
	bh=/Itz8rUC6zWsgXF2WM8FdHvpSMrY909xTLPghnPN7SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rMrudIA41DVasAItRo1t0lWrba2r4J7Hda1pWsT9mVfLFXSrBqMZLxy0KF6t8vdF0
	 9t1YZPczBczwCkC0ODNzcxz/IuPmRFdjR6TSTJJCbv9UhGPOAsMiK3v+5TEYU0d+4y
	 SvvLO/9DPowr2wx7AO7rloL2+frWgVzi3w3ici+TKLravaEAXeDJKKR212XzsERXYP
	 Zajpe1RjRDrv9f0/wFJO7OHKa2kgMW6OCp92ECsPyAozOkXHOf6UcmZpJiP435oCXS
	 4GEzy8Ap0c+DXtCJ6uA3f5H+VYocGbFeKR9jn2if+4ZsJW3tH0Q8E+tYYhkYkZ/BZ1
	 8kuAPvFPqB3Zw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Breno Leitao
 <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] configfs: rust: add an API for adding default groups
 from C
In-Reply-To: <aZLXSPk2uO-R0e6b@google.com>
References: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>
 <aZLXSPk2uO-R0e6b@google.com>
Date: Wed, 13 May 2026 16:39:47 +0200
Message-ID: <87se7v4bm4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On Sun, Feb 15, 2026 at 09:33:47PM +0100, Andreas Hindborg wrote:
>> Some C subsystems provide a feature to add configfs default groups to the
>> configfs hierarchy of other drivers or subsystems. Rust abstractions for
>> these subsystems will want a way to add these default groups via the
>> configfs Rust API. So add infrastructure to make this possible.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  drivers/block/rnull/configfs.rs |  1 +
>>  rust/helpers/configfs.c         | 16 ++++++++++++++++
>>  rust/helpers/helpers.c          |  1 +
>>  rust/kernel/configfs.rs         | 33 ++++++++++++++++++++++++++++++++-
>>  samples/rust/rust_configfs.rs   |  8 +++++++-
>>  5 files changed, 57 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>> index 6713a6d92391d..ea38b27a9011c 100644
>> --- a/drivers/block/rnull/configfs.rs
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -78,6 +78,7 @@ fn make_group(
>>                      name: name.try_into()?,
>>                  }),
>>              }),
>> +            core::iter::empty(),
>>          ))
>>      }
>>  }
>> diff --git a/rust/helpers/configfs.c b/rust/helpers/configfs.c
>> new file mode 100644
>> index 0000000000000..7cec8ffcb093d
>> --- /dev/null
>> +++ b/rust/helpers/configfs.c
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/configfs.h>
>> +
>> +__rust_helper void
>> +rust_helper_configfs_add_default_group(struct config_group *new_group,
>> +				       struct config_group *group)
>> +{
>> +	configfs_add_default_group(new_group, group);
>> +}
>> +
>> +__rust_helper void
>> +__rust_helper_configfs_remove_default_groups(struct config_group *group)
>
> Only the annotation has the two __ prefix, not the symbol name.

Hmm, odd that the bindings generate correct anyway.

>
>> +#[pinned_drop]
>> +impl<Data> PinnedDrop for Group<Data> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: We have exclusive access to `self` and we know the default groups are alive
>> +        // because we reference them through `self.default_groups`.
>> +        unsafe { bindings::configfs_remove_default_groups(self.group.get()) };
>
> Why isn't this here already?

What do you mean. The drop of default groups is not there already,
because it was not previously possible to add default groups. So there
would be nothing to drop.

>
>> +    }
>>  }
>>  
>>  impl<Data> Group<Data> {
>> @@ -259,7 +269,13 @@ pub fn new(
>>          name: CString,
>>          item_type: &'static ItemType<Group<Data>, Data>,
>>          data: impl PinInit<Data, Error>,
>> +        default_groups: impl IntoIterator<Item = Arc<dyn CDefaultGroup>>,
>
> Honestly, I'd just take a KVec here.

I was trying to be fancy. Is it not more flexible to take an iterator?
What are the pros/cons?

>
>>      ) -> impl PinInit<Self, Error> {
>> +        let mut dg = KVec::new();
>> +        for group in default_groups {
>> +            dg.push(group, GFP_KERNEL).unwrap();
>> +        }
>> +
>>          try_pin_init!(Self {
>>              group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
>>                  let place = v.get();
>> @@ -268,13 +284,28 @@ pub fn new(
>>                  unsafe {
>>                      bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
>>                  };
>> +
>> +                for default_group in &dg {
>> +                    // SAFETY: We keep the default groups alive until `Self` is dropped.
>> +                    unsafe { bindings::configfs_add_default_group(default_group.group_ptr(), place) }
>> +                }
>
> Do these not need to be removed in drop?

Yes, I added the drop logic above. It is the hunk you asked why is it not
already here?


Best regards,
Andreas Hindborg



