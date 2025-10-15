Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89083074B2
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556786; cv=none; b=tqqB5Z3a/hiAy1ODPQUdBjnJ2eFPTxJYHf02cVkEvp02eQl31GP5kqeHZHGG5ZHYy3A2EeW2grkoMk1uTCC/G03C8uGtPXcKz7P4SD3AWgxNftnFp4cD4yDMrPctAmOnp+5nAFRviE5+heQf8OmjWBc2P2dkapSFq+ahy+lY934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556786; c=relaxed/simple;
	bh=ScQQFFkpeGO6loW/Fw6rKSCOy2E7ESI95v/KoWzWsv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLQBqXnCcuOdRx18uY38XpSDLzo/x7Of7HUJP8o8VeuhuPnLAe7jSVlxTUeomhhJnmkWnWa1TpOnzESxggufkHjS+LP9VYcIBXqeheu80RdJ9AysmO7BdRN/6iPe+S0JD8T65BGQbS5UisdzRXixYnMUnHXVshwb3RCqULcXsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USuqdtMg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USuqdtMg"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so5580055e9.2
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556782; x=1761161582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAevwT93im92Z5B9wqQwoYCZ5JIudJs6adex10E8WZI=;
        b=USuqdtMgPc86vu+Dd8mgmkCVDdkSEt5FxJ2HvnGcj9DTcpEEXBbhFGyg24pYDTpjQ0
         wzIdOr2D0MC0oReDEyQ0sUeML3MkfO1+S+t/AqjcUKl/V6IQP0/GVSpnmR9dJDvLSouk
         VF4FbMmEUQnCgPNp66Y5UTBccCwTYds+0a1Rp/Q3kxsAah0oJryCu3uoz1Hk18lN4nVF
         D82Q5gIy5EMXQX2pYL43MYxJ4NJfcRoyh8eYD4LXWtXB1Ci7M9uibI2tn3DDJeLkhM5G
         LJfamWA73nVg1dHg9+RL8exd3hSJl+Abh3EbVfltQ9JDN0s66HpccPnIAmMfZ7n2morh
         MoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556782; x=1761161582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAevwT93im92Z5B9wqQwoYCZ5JIudJs6adex10E8WZI=;
        b=g4hKXTUklYi6c08j+p2IWIDwafKcDzOWY4CLvzbXzJ69CxA8NdtNxYe1PZYoX+jEkX
         hj7NJrAlGwEA/MqMow98m4ZHAK0WgCGEA5Mf8OUhpMjt97hsMBmUGnatemF+E+oIq1Jm
         4toYMmUvsy4leEEjB4g5aP52KPPUvbRvlBPYZAPXrFYFyBpG7yczt+/uFEPZw0ENS9/+
         kufLodp2B/XxnTcZVAjojfK52zS4gNY90p7BnXdYPNa2H+QDODZqZnGUHTgoadsOmo+j
         7U5gRDkM0Gi0u3Lb1l87WHsIIU5ejG4iZgzKGwOpkC8cb4Ziy8i46Bpwx4ApPqXWMIKt
         hl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7/feIGU0qdaLklJJCbDtXuFrFLyjU7djZ3fIOmtIOiPvecGAQVWyVc1Xeyd+60vgv/uEeho88cwY4rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnwLsoW9brNlaN+3uA9LsMK+T9PlcTjbAF6oToJ6hG19g3FTX
	pPYX3W8XEAyrCSKQiaeQi7THLxMdfvQSVe6/VA9E90U8Gk7yCSHRMZTHUmFuAkqkG7tlAGP0R37
	Ut1cnsxscRylU+dFKIQ==
X-Google-Smtp-Source: AGHT+IGwzEplF/i+o3IChMoByalJPkPhIN2u4u73RuMgfnJGb89VTvklkfzoM/vxf4PIDBos9Yu+r9TLw3kNcog=
X-Received: from wmbh27.prod.google.com ([2002:a05:600c:a11b:b0:46e:2f1b:4ceb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d6:b0:471:c04:a352 with SMTP id 5b1f17b1804b1-4710c04a443mr1959265e9.4.1760556782126;
 Wed, 15 Oct 2025 12:33:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:33:01 +0000
In-Reply-To: <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
Message-ID: <aO_27dG0j3zbnBCX@google.com>
Subject: Re: [PATCH v17 09/11] rust: remove spurious `use core::fmt::Debug`
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

On Wed, Oct 15, 2025 at 03:24:39PM -0400, Tamir Duberstein wrote:
> We want folks to use `kernel::fmt` but this is only used for `derive` so
> can be removed entirely.
> 
> This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
