Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712CC8CE;
	Wed, 24 Jun 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307366; cv=none; b=qxjecyJqkwSa+24U83noAQdFF+mTXU+fV7A+jT4kvy1UMjijCJIv68BaBk6c35IDIyi4E4O82OcCp95Zh8/buSynmjKjHwtOq10f1SMfrYVNeWXAiz07pf7mPDJfk4CYK4sG7eQUE/8fip1Imn8Z9ur/O/WeJTArJKpDEjWxjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307366; c=relaxed/simple;
	bh=44R+BZSIsweicSJqp9wx8D1cQbcqJ1zfO7984BPZ/PY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MnVv9T0ra3Liwjzcyu0LmfCaMTTTwZLZrs0Bu5spH69Rrv9eDiI0uelQI58KpxPHrMYzAsOkmh9Ft1ph3ZKv133N97MS9qdkvGjKeODD684/vwhR7bYEL4xUcN5JuhK8jsqqF0XFhqpdXrbTK6KxgQzVapS7QX6eempXV3cRSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ5/QveK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ5/QveK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5231F000E9;
	Wed, 24 Jun 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307365;
	bh=44R+BZSIsweicSJqp9wx8D1cQbcqJ1zfO7984BPZ/PY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=FZ5/QveKGQFn3WVkLPk9UJeaNGMAG7EW6+VV3KqOkFGQhY5xET2NDNeCNN+RCjOHK
	 YOH7zXLoxOcrKjFO6p0Z1yHvRkrFb97Eiw6jQFzRC5ru4qRQ/S++JXruKjhw8HUMgC
	 zjFiGWXpAon/29jA/jgWPPD+PYUNFeArP1MekuMd9vfGwUkaTPgR/IGSu0gsZ63lyx
	 pRnR+kXvj0Czta/VPfCCM5Y23MON104DArBz84VBrva2OVW4nSNyQZZlE/pXajmcV1
	 jsxTJHociyo9F9fgFC8QgEz4bKoohVC9TVoXFZZ5r2TVl5W1heaOU9QyRMVzDSqqhE
	 PnNek7mjhoRPw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 15:22:35 +0200
Message-Id: <DJHB87KG4HZD.3A8GGTU13MZSF@kernel.org>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc
 abstractions
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin"
 <atomlin@atomlin.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Arnd Bergmann" <arnd@arndb.de>, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "David Gow" <david@davidgow.net>,
 "Rae Moar" <raemoar63@gmail.com>, "Breno Leitao" <leitao@debian.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Dave Ertman" <david.m.ertman@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>

On Wed Jun 24, 2026 at 2:57 PM CEST, Alvin Sun wrote:
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Acked-by: Danilo Krummrich <dakr@kernel.org>
