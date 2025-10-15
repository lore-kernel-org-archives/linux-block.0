Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03930E0EF
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556647; cv=none; b=mx9tBz8pMKRr7OPdbKbxfls/eXToAmJdOQVgOJBLoEnX5M8q6t85pfiJ1kdgEzALJ8dBJNrqYhA6RsQ83e6a673tMXIYED+F/ggSm4at0avdZqgtIDlmT54TuGq7+7kSNbDGFi5/zHwYoDOmw2zhRdE016B0rLTy5g7CoWCkIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556647; c=relaxed/simple;
	bh=jzqQsin1H3Ss/7Kc6VHndGMJg2kFmuyjGGetq8PWm18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4+NzOq+ggXSW/WjVTSJU9pNgICbPDdLcGZVYXrfOlaDf/78SPmfLruxiZZJKGwskCxm03kaiwObkUw5OYT0QZNDEaqG+LBVxUmwI0oG+9aVg2nvKDvUtMvkLzjWCZCyXuJqXSx0CPkh64pDSpoZZGswrLiuVf+x2PXyBnTJZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZuJ6Izq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZuJ6Izq"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471005f28d2so4229165e9.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556643; x=1761161443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=CZuJ6Izqoafy+Z3c8IcwuWNDkEvISuUZMjmZWYfvEplp2xJvHbSCSV/XI3TahKzlnn
         2/VSUAuEuifQEPL1yVM0KfUh0k9C9iAWsB4lbp9C+CKgPZiVLIVAk7TfS923BP7qvcM4
         L9P24234xUEN1wYunFdup7vBislGABuirlydlrly/c6v8V/FPefcaD8jRSCERGEyL0i2
         wF/us8aq3okXfYjesPuwlnNAkTU2LsE/MoUvPx6vcCIDR72T6hK/7aIhHH1xyGo5omFI
         u3rWpT8RrLx6jM8VaLgKaersh9nkzIDtc82OCKLSc8wIVbTZsmlQPCLQQV73nu4LEniF
         BOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556643; x=1761161443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=KjuQD7BwdOeKE+IPT/JRINJvY36XZLx+6pEsnIdDawIOg6GRCZTj3Pdp33TIC8qop3
         Dc1WQeYFbiZxV2PDm/SqtpuRXMgaBBUTZ3pLZAvu9SA7yrWvOCzViDq6RdLFdwgCUPcq
         e7X3Rc/w0Hcu3QovCm2g3V5r05Jc/X2g5MQ77CFpR9hah8t8muLovMeX4X14KTmc5lDc
         k3Yo5aZvtQg6a8tffo8m3/iwgvHY3GaRB5gCxhk2QUCcr8bLKuDCC9wEIZBQraCe68HW
         ETGc4J6QyhWRb5Cnp7P6qUsQNrGlLfNSySMJysXQaOgRHyYEsL3NeZQFAm933xFGm76z
         F2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXnfFhykC2iqBGv4MW24+llSrAmXPMYR1amPy1YhxwbIW1ATcLCrSw01SD9tv/17LnwGfxzfb3NSP6jyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRUv5kXxGPzDXYFqM3pwnYQWj64+R7SuWx8yrA0AUJUMaT43t
	CwwilHBuNUTsXWQR0zw5T8nXi1LIJ9Ha3vB/wcpbmVLAs0bPaTnMNtw70anOe8ZDsI895orEYDb
	ITQs8+4NFgBqxvpzW6Q==
X-Google-Smtp-Source: AGHT+IHUcYtq/jysGTUkDJKvl3MbWL3/M7dZBn/ijA0kzgEJ9Y8E6oSL5awGSBYgdY4Z4z9XH540xUv0k/TvBZo=
X-Received: from wmwn16.prod.google.com ([2002:a05:600d:4350:b0:46e:5611:ee71])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr221043115e9.31.1760556642790;
 Wed, 15 Oct 2025 12:30:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:30:41 +0000
In-Reply-To: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Message-ID: <aO_2YXO7C6Jk3EW-@google.com>
Subject: Re: [PATCH v17 02/11] rust_binder: remove trailing comma
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:32PM -0400, Tamir Duberstein wrote:
> This prepares for a later commit in which we introduce a custom
> formatting macro; that macro doesn't handle trailing commas so just
> remove this one.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
