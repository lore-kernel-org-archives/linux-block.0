Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411F21E082
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100053; cv=none; b=QuFVSSm/+HGPMTbtI7XhD9/6qYdPTiD0VxWwr8uKvmv+oIMJZajC8Cj4lBZifp461qxYlGFr2zBIzSjIQrS3VjnyiP5NvjQ4LgGdDav4+G1/ZHuEEuPfUYLj60V5fdF4wM7jBeeNXVek8SORhAdPZ5rzfv3i9Ovsd7N4nJtLCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100053; c=relaxed/simple;
	bh=A+P0s8xM+ovp2iCRdR2wm/nwAd8dNmdnn9/2R/2q9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1tlMLYouApvWy6jUi3PHusNML4lqritlO+EnbSjlDtNc4W2HMQYlB4QbVixvhH2eNzSvgyfRhtq6jpmmvkZsXQpuXlHN/X9FHMt/uC4iCKRtZhEvZZTM15OKulY0mG5ouNyxhC0sM5HmJ+kvlQ4O9zvPlrTaYDZGH/A6w39Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKlNqAj8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKlNqAj8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33d896debe5so4316215a91.0
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100051; x=1761704851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=aKlNqAj8jXvvWoICbfNwKUqLGP/aPJt/n2SESZe6VHiyTTE8J40WagoO4bVRrT+qiX
         OgTdYRYckYQlquqlWtROXxhAwy+utRm1jmHF5SAROzafg4jUZ3LaXBg12KXTsMoK2QTy
         MhoEL5kohuLJmswz8GF+RPKgG6gVOPrXt2mWXRituP26sm0KzzdVtDXj1zcQB0fCMvoV
         EWFQ4s/bvRvRkPtHqWB0VAwv5CQ5QwEyQAtaIx/wbAK6O0V+wsI23tum/tKi+cZZ8nm/
         MU3CXKwTo1bA2ndzRTVmIVKL7gBE9yBOelXsJxfxoEncwWtTZfW4pUjNlmChldVCbrmQ
         vEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100051; x=1761704851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kynz5f6kQn3G9h5f1VDmHPl6BLtsPQWnOh0t3sfi0M=;
        b=xS/7W0D35BYEGLebcw5Pi5TycofdN/Q5vaatMIjIVvu6oqTN4TE5O5WPZHd1xaeQ4G
         /TzNhFOSozljE6BKb9dhvq9hM+bDiIxHze7qchyTKbDe6EQtDHPpVqg67xWdugVkHb7c
         VWYlRfgt9AKmsz6Xs5mWI9d/nf59UJaT/ew8Bfg6GkKQHKjWYS0tj0VkOaqRnRb/kCMj
         jhCwyWp919iw5vADuTVPDxMzz13c+DpIWOeZD5T5spVL/aiFwZiYEYxNfvBApk/5M7a1
         QiEndWBuy4t0zEMQjVfsFsCiSempwrf72sWTFeoPtWfGLd59BMZuQHO/4yX7aAjKzdMZ
         eIiw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vcHML5HMfgzxfj93yJBrZcbU0u9xLgUXXGlEDlgZQwU+IIP3T59tByebppldQ8FRUVXUcnoOY7lRBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNp2gKskd++0pNWggJPwghujNt+QGIR6vOOsFJMhq0Nx54tZ6
	wE7YdAYG+DPSvw9Z7DKxT7Ij/6sgM7IAJ50J/sMShGd/hvswU8zDTnIlH8ufw8Up6b4=
X-Gm-Gg: ASbGncsA+U+2H2WWYJTnu51zYaFs8eXIV04xIFh65CvSa56a8P35Jffj/iPzKEiRdK0
	CwKSxQpc1jf8zk/yjq2N6XL347eydhMnZ0QKgQM7uFC6wcwIrazdbwxSXPIX4Y3HucSoI7bwclb
	G+IwIqhXnQwWrIRnJdKZFHJriOB/MPbqyvalirdW+szRxWI390oqlsQgtINTjRofzLQx7/FdOaC
	msyhlK24Di/+IwrUIHqdLdgMFK08mGJ3hmPZgaQnFVeI6wh07UVivyvQQvtvw1LYNCjTWmCHrpr
	mp/pVOObHCn1RyHy8H5LeN4NouMBDbHt5zQx3QKzHVXrU0iM3mP7/OpvxUVKe73FRh+auURqg52
	38i7RMXozyr7a27YzVE1IIe8hxttgIGq8/8c0w//cYgCh2nTuDVHlOjU1347KuRTZXVPc/xPFy3
	O/V24C7g3lJdlA95ZxsbTlg5c=
X-Google-Smtp-Source: AGHT+IFJLVFpIR1aWCyZCFOIKnAA6a58lXYXHZeAFELxfkfneTEN5uN4Dh2U6O2etE9y+Y+gRJvc9A==
X-Received: by 2002:a17:90b:1dc6:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-33bcf888575mr30106334a91.12.1761100051119;
        Tue, 21 Oct 2025 19:27:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11e1sm981092a91.12.2025.10.21.19.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Correct the spelling of "CString" to make the link work.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
