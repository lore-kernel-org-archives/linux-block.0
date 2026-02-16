Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E1277C9E
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231053; cv=none; b=QxUFZ1q/ZMD2VzIPxmlcB+Eyy76OoPxfjekSH16nZ9Y30O7aQwzjhxR/6XGVX8w9HLOiyhPmZQD93FYtQL53GHVnxngiFB36TD8QuG7gFLKV8EC8sNJpdjEOhiRsxWda32Y2MKwEIg6qMQqTzZa0vm9cwH7JOjP/jVCpLMUO5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231053; c=relaxed/simple;
	bh=uMNCOiOlUGeNktPdL8qQOPGc05gj9veRiqP1hNx5qik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=djw+U1ouKQgr4ksNcYSjLxjVs+lmgJYaqOmB8So0tGpBELVPSut9b/3DTen+IPueGNHdWwipmdjHgGrjuM48US/OKDTJHyfFzUxfhZrxuCrPu/i3j1bu8QDjEj9kJ3bt7moBgaAPjdCj8xEpdzcuDgfNCg/xTyqZdDGotfGRy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaRsnOEE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaRsnOEE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483101623e9so25955165e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 00:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771231050; x=1771835850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0BUd9ffnQeh6t60I1FOnrZZZ6kFC8hsYBEdO48KYcs=;
        b=UaRsnOEEOaZQlH1bDO5ZMoPbRXzCafFrTMtrsotqUt4OC2/9er66tWB1dnGODe6gPN
         4r9fVhtuYESBuRfMQkIhOx30YCom8gRz5XY8CMr3A6p4VvC0lzlvd8/uE9fvzVLWPn/f
         31QtJqa0xXAaU/oB/RvbAIACHmwJRyxT952YVXTrGZu1xI10gXyyP6hFfJ2lHUV6Uylu
         oAOoW5h9hZopWXfoVRwb7HF425jkpwkHM5Vh2nRtXB0AhFZIX8J/dNgjgqHsfzKOhWaL
         e26QtuhPvVAaWzQMIE4mPsQGhKXxXeLDJKiOzJCXr7sCdIvHrRAWiGvHmmoq1yqnqBdU
         D2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771231050; x=1771835850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0BUd9ffnQeh6t60I1FOnrZZZ6kFC8hsYBEdO48KYcs=;
        b=Y++QpRrQ6GAhufkG/oM20sfHGNGAJbM4oDPwMPJvZ41yAnRjIIWTZd3AhHwkoE1QWQ
         couCiS347ofgc26fsqeUaJWQdpYwxZ07FboRVCuoabCQ2BFBC71URAZlrq2NzCpvsv+V
         I+sePu136Cw5b9HWaVMXigO9o0ufMc5iWMZZxTMEm7Epe/8FpdxqViHoe5eVHQSkmD5D
         YKSXa1hrSvR8S23oPfXOwFWFT6ITClgOz0ov4jpVP0XzPFFeJw70RsPPyY8cM1JPO28q
         hgxPR4x5DOONKi4Uf/GQLJZLtUroDYxXM31svT4bt3INlFx7mbBu07PionukNjFq/dYr
         6kiw==
X-Forwarded-Encrypted: i=1; AJvYcCVZPXajJjinJ809b4VKjFjWwko65IHDmaH89mBxvTkZ7cM6hzfuyWicQ0tq9no6z8sdzD8oORkHRfR/Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxairDGxOokyygo8mr/Uu22Pg3FMh30WIhMy70sJl4A7ncW6Yxx
	NY8RAdTVDh3J1O2VNhm9QqRlBE+EeV86Evjw59P7HsHB37kolv7Z82VSjCuzBUrs4MZ710jOZdm
	VysR9bsqxcfU+UikOBw==
X-Received: from wmtm7.prod.google.com ([2002:a05:600c:c4b7:b0:483:3115:815])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e92:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-48373a5bae2mr162242885e9.23.1771231049850;
 Mon, 16 Feb 2026 00:37:29 -0800 (PST)
Date: Mon, 16 Feb 2026 08:37:28 +0000
In-Reply-To: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>
Message-ID: <aZLXSPk2uO-R0e6b@google.com>
Subject: Re: [PATCH] configfs: rust: add an API for adding default groups from C
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Feb 15, 2026 at 09:33:47PM +0100, Andreas Hindborg wrote:
> Some C subsystems provide a feature to add configfs default groups to the
> configfs hierarchy of other drivers or subsystems. Rust abstractions for
> these subsystems will want a way to add these default groups via the
> configfs Rust API. So add infrastructure to make this possible.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/block/rnull/configfs.rs |  1 +
>  rust/helpers/configfs.c         | 16 ++++++++++++++++
>  rust/helpers/helpers.c          |  1 +
>  rust/kernel/configfs.rs         | 33 ++++++++++++++++++++++++++++++++-
>  samples/rust/rust_configfs.rs   |  8 +++++++-
>  5 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> index 6713a6d92391d..ea38b27a9011c 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -78,6 +78,7 @@ fn make_group(
>                      name: name.try_into()?,
>                  }),
>              }),
> +            core::iter::empty(),
>          ))
>      }
>  }
> diff --git a/rust/helpers/configfs.c b/rust/helpers/configfs.c
> new file mode 100644
> index 0000000000000..7cec8ffcb093d
> --- /dev/null
> +++ b/rust/helpers/configfs.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/configfs.h>
> +
> +__rust_helper void
> +rust_helper_configfs_add_default_group(struct config_group *new_group,
> +				       struct config_group *group)
> +{
> +	configfs_add_default_group(new_group, group);
> +}
> +
> +__rust_helper void
> +__rust_helper_configfs_remove_default_groups(struct config_group *group)

Only the annotation has the two __ prefix, not the symbol name.

> +#[pinned_drop]
> +impl<Data> PinnedDrop for Group<Data> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: We have exclusive access to `self` and we know the default groups are alive
> +        // because we reference them through `self.default_groups`.
> +        unsafe { bindings::configfs_remove_default_groups(self.group.get()) };

Why isn't this here already?

> +    }
>  }
>  
>  impl<Data> Group<Data> {
> @@ -259,7 +269,13 @@ pub fn new(
>          name: CString,
>          item_type: &'static ItemType<Group<Data>, Data>,
>          data: impl PinInit<Data, Error>,
> +        default_groups: impl IntoIterator<Item = Arc<dyn CDefaultGroup>>,

Honestly, I'd just take a KVec here.

>      ) -> impl PinInit<Self, Error> {
> +        let mut dg = KVec::new();
> +        for group in default_groups {
> +            dg.push(group, GFP_KERNEL).unwrap();
> +        }
> +
>          try_pin_init!(Self {
>              group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
>                  let place = v.get();
> @@ -268,13 +284,28 @@ pub fn new(
>                  unsafe {
>                      bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
>                  };
> +
> +                for default_group in &dg {
> +                    // SAFETY: We keep the default groups alive until `Self` is dropped.
> +                    unsafe { bindings::configfs_add_default_group(default_group.group_ptr(), place) }
> +                }

Do these not need to be removed in drop?

Alice
