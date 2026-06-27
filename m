Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B63A59BC;
	Sat, 27 Jun 2026 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782565884; cv=none; b=QU4HPRwhKW9ZXtTT6RW3DWfL57cLuPCAjoso7TGOgC40auUnxgfOlf3vqrRil0fXgiHNEgWEm0KBIHTUbruudn9BoHRccHW0RJjur29xsqQ7xXAsrTAaGHghvgoUx01T/EI9KSK9yxy3XTun/AQeXe233GCaTUaOPEeWb9xfKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782565884; c=relaxed/simple;
	bh=0D3QtVTQ9/VyZ2GHdi7eh0l4L5UHK8hpuhOW6sOiDcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvyWFqX46yBLbj2ARM9NFjprEWSKQ/ceSF3GWNADi8ViXYh4V8izk5KYNkTVXMTC74av+2W2OOtLx/hMRzNe4nB2PMpLDDgIjyMAbP6EJkkh25G1qDeYcCdESeSJqYU2ge52CwiGHl8YeAbdPxQUfv+jnSHuu7bNlLd/OZBeSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I88UiKZ+; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I88UiKZ+"
Message-ID: <b35c76ac-030a-4458-b85b-90ef7bcd3894@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782565869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTfmCVZgLsQAYxOGmqgi+d9SGTwihp06nkzRCBL0e+M=;
	b=I88UiKZ+5NSVSOCF6J4gIIRkkZToigFcGN3SeLfMhryeUfJLFw4kvfe+NuwObJ0Mm2vtFf
	tpQ1eQi/oIHPtsZgpegcnpq7MyzNRpWpRQ5M3ApzXTndtytC16U3Rb06RVXWdNorU7alQy
	0BGxL8bMeCgEkMhwf/yUBhSRJmUrCN4=
Date: Sat, 27 Jun 2026 21:10:43 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
 <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
 <34a009d9-a1f3-4347-9e92-866ec05ddb60@linux.dev>
 <DJJ25JJ3TDO9.1UFOP60U0IPX5@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJJ25JJ3TDO9.1UFOP60U0IPX5@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/26/26 22:41, Gary Guo wrote:
> On Fri Jun 26, 2026 at 3:35 AM BST, Alvin Sun wrote:
>> On 6/25/26 22:40, Gary Guo wrote:
>>> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>>>> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
>>>> macro with `this_module::<LocalModule>()`, and update
>>>> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
>>>> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>>>>
>>>> Assisted-by: opencode:glm-5.2
>>>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>>>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>>>> ---
>>>>    drivers/block/rnull/configfs.rs | 6 ++----
>>>>    rust/kernel/configfs.rs         | 8 +++++---
>>>>    2 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>>>> index c10a55fc58948..b2547ad1e5ddd 100644
>>>> --- a/drivers/block/rnull/configfs.rs
>>>> +++ b/drivers/block/rnull/configfs.rs
>>>> @@ -1,9 +1,7 @@
>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>    
>>>> -use super::{
>>>> -    NullBlkDevice,
>>>> -    THIS_MODULE, //
>>>> -};
>>>> +use super::NullBlkDevice;
>>>> +use crate::LocalModule;
>>>>    use kernel::{
>>>>        block::mq::gen_disk::{
>>>>            GenDisk,
>>>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>>>> index 2339c6467325d..c31d7882e216d 100644
>>>> --- a/rust/kernel/configfs.rs
>>>> +++ b/rust/kernel/configfs.rs
>>>> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
>>>>    ///                 configfs::Subsystem<Configuration>,
>>>>    ///                 Configuration
>>>>    ///                 >::new_with_child_ctor::<N,Child>(
>>>> -///             &THIS_MODULE,
>>>> +///             ::kernel::module::this_module::<crate::LocalModule>(),
>>>>    ///             &CONFIGURATION_ATTRS
>>>>    ///         );
>>>>    ///
>>>> @@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
>>>>    
>>>>                        static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
>>>>                            $crate::configfs::ItemType::<$container, $data>::new::<N>(
>>>> -                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>>>> +                            $crate::module::this_module::<LocalModule>(),
>>> ^ You only changed one single place. This is still plain `LocalModule`.
>> Initially I wrote it as `crate::LocalModule`, but clippy warned about it. So
>> instead of putting the crate path in the macro body, I added `use
>> crate::LocalModule` in the calling file.
>>
>> ```
>> warning: `crate` references the macro call's crate
>>       --> rust/kernel/configfs.rs:1024:59
>>        |
>> 1024 | ...  $crate::module::this_module::<crate::LocalModule>(),
>>        |                                                     ^^^^^ help:
>> to reference the macro definition's crate, use: `$crate`
>>        |
>>        = help: for further information visit
>> https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#crate_in_macro_def
>>        = note: `-W clippy::crate-in-macro-def` implied by `-W clippy::all`
>>        = help: to override `-W clippy::all` add
>> `#[allow(clippy::crate_in_macro_def)]`
>>
>> warning: 1 warning emitted
>> ```
> Clippy has a point about `crate::` being usually wrong in macros, but it is what
> we actually want here, so obviously you should allow the warning.
>
> It is the exact same case in `vtable` macro, just that Clippy is unable to check
> proc macros!

Thanks for the detailed explanation.

I specifically searched for issues related to `crate_in_macro_def`, and 
this information is very useful to me.

Best regards,

Alvin

>
> Best,
> Gary
>
>> Alternatively, `#[allow(clippy::crate_in_macro_def)]` could be added on
>> the macro
>> definition. Would you suggest that approach?
