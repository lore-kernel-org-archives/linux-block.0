Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6C47252B
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118405; cv=none; b=N72Q/3uxmlBpBlYs4SgmoWuSVVpEVl8gIWOxVL1HXoO6df9/mXox9rsGMyG4hQ4oTOVJ6tW7X8m2whBbnnblJmF2feVy0maTNw7CItK7JDzsPP7ETX7HNPQ6R7ncOBSTdJbc9k21WtPZtt4wGCiXyl2S4n85N6sdFsz3L20VDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118405; c=relaxed/simple;
	bh=LQHKUmm2L3VPczAzSrySIOYelc6UVvj0GiEVXj92Iww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p7gdnNyoTIFoQA4/hAudhuffSOopHFnRLYvzN4HT0s0Y2V9l2M3OmQhHU6FratQ0NDgeXZ3hZpKBdpRxFLHk03Xc7agTf+SqQp6MZJhKF82zCB62YxwkqXKLLOQNkFDcoUu/fzEcaiTQpKIgZPieuy8PR2JTHdOZE+Re9r/dsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdF9tVpS; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdF9tVpS"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49b7c1dcc82so4950695e9.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789118400; x=1789723200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZtTwWLqkTlApSCCjwtFSfuFmwluELYL36xqCuH39yY=;
        b=WdF9tVpSSXYvnlrzGgh+P+QcLj5u0AX4p8filA66XSzd5O8vBXYmPSBizgExj6oxwL
         +PmBeHz4t6HSK7AV7IgXCxiDARpO9PyLesXeDRV74ILIaJiw8pgjUKDWW99gqaSTg9PR
         mypblrub7AceAOqE4EVBGXzbeqINNAIlUOhB6RTkioOFhpNWHZWVFRYw2MFH6eoBVSqn
         omL+h/BD6+gLLshheuEdkv1T7XJHsKCulUf7JaARnJbYBE4a2oLTZas0g4C+aduyAhZd
         u2zFNt+Tr5E5wlpz1iwT5lvMsDx57TFBz7QmSnYzDX6HPEh73EvRU/eyhaLMvqmIYSsr
         GkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789118400; x=1789723200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZtTwWLqkTlApSCCjwtFSfuFmwluELYL36xqCuH39yY=;
        b=M4VMy7xpAa+LRk2NpSx2d7+WL8nAxYRbYkFYt0M0ix6JzLn/qOkvNEWI6kevQ56glP
         WDQfFV8J5xzbd36SSNKuqStXV2vXeb/GqGcqSAeLhTfgfNf8Mrk10rV+bo2JSEEdjH4r
         sdFXrHvXgkIN/s35yVm58GoBaHwHsQSU1BNULXV3y6QwW3PoeBNKX73LLXNcKXd6fRPX
         1Y5Sp5RS1fzXxgesuskjDuAJ5ryuUoPoHxFJoFAM77l0tAjgLEc7kyMO2B6kpsawZ1WK
         Co2JBtQ+PhkC7i36jRyKgf/EZ54p4o+bzoqJ6GxE41OI/RnrxGW6hCrEL1UJTZdwmy8h
         dzmg==
X-Forwarded-Encrypted: i=1; AKwUvBzNKenZ/BZ0oBRgE0P3NVNlogEakNXiHufD9WEtp4wz5k/b7R5BjSsiv/1VLRPNkAQ3TNl2cdmKCNFs+g==@vger.kernel.org
X-Gm-Message-State: AFuF++mK6ew3ViXnoTapogQBL5wBfSma3HKtbUrs+YaolQiDdMV4TH/3
	tWry4J28F4wySLIuti+RFB8qTsurZ8HTPqHRBk5tvqoSP9qgZRpxEFJe4BpMLy+HrvBMAC4A09b
	YU/7M4aBDWBYUUbDexQ==
X-Received: from wmga6.prod.google.com ([2002:a05:600c:2d46:b0:499:b8f0:3186])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id 5b1f17b1804b1-49e61983771mr27226365e9.4.1789118400242;
 Fri, 11 Sep 2026 02:20:00 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:19:58 +0000
In-Reply-To: <20260910-unique-ref-v21-6-e83257373062@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-6-e83257373062@kernel.org>
Message-ID: <aqPHvi1xFnMXvYLW@google.com>
Subject: Re: [PATCH v21 6/9] rust: Add `OwnableRefCounted`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, 
	"Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Philipp Stanner <phasta@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 10, 2026 at 11:00:10AM +0200, Andreas Hindborg wrote:
> From: Oliver Mangold <oliver.mangold@pm.me>
> 
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
> 
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>  /// is implemented on types from the C side.
>  ///
> -/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
> -/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
> -/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
> -/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
> +/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type.
> +///  - This is useful when it is desirable to tie the lifetime of an object reference to an owned
> +///    object, rather than pass around a bare reference.
> +///  - [`Ownable`] types can define custom drop logic that is executed when the owned reference
> +///    of type [`Owned<_>`] pointing to the object is dropped.

This diff looks like it should be in the patch introducing Ownable.

> +/// # #![expect(clippy::disallowed_names)]
> +/// # use core::ptr::NonNull;
> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// # use kernel::sync::aref::{ARef, RefCounted};
> +/// # use kernel::sync::atomic::Acquire;
> +/// # use kernel::sync::Refcount;
> +/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
> +///

This newline will appear weirdly in generated docs because no content is
shown above it. Consider not hiding the imports.

> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`] if that is the case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying object.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>>;
> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    fn into_shared(this: Owned<Self>) -> ARef<Self>;
> +}

This trait provides two methods that have very different conditions for
existing, IMO.

The into_shared() method is so likely to exist, that I would almost
consider placing it on the Ownable trait.

pub trait Ownable {
    unsafe fn release(this: NonNull<Self>);

    fn into_shared(this: Owned<Self>) -> ARef<Self>
    where
    	Self: Refcounted;
}

On the other hand, I think try_from_shared() is more likely to be a
tricky operation you cannot necessarily implement, and as such it can be
on its own separate trait like you have here.

At the very least, I can easily imagine that some types can never become
unique again after having been shared.

Alice
