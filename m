Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B4446C0C;
	Thu, 13 Aug 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615400; cv=none; b=FmqnWExiEBrr8hiHnwvxXacKFSwS7vMOGnuTzGJ69abEg8Mni6Au1O1Dq41N3yIauIA1XJdzXLAdSboc8Ca6ivgjLR6wQDhYNiIm4pG9z1G6I+9jtOd3l9OGk3qmEed7fNo8soBzMWcvWMbCisCL7hxO70w7MFzUfddwIWZDJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615400; c=relaxed/simple;
	bh=0hWfgSJLC/BSv67WuRi5uLEurUAGh2vlGOP/FZB9TmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qiwcGlgjuL+8BeeTW2IVlurheVsY5nXrz/fH5E14cBTiWv0wga/chX9wSNYaM1ysCAKDjGSjkRjF8Gop2lgQHtduzrHxABxWDb2xJigwlMu4hNTaRQEHiS6SuYclTXglCEteDiRTtA3ZqhMWQ0MZZoEknyO+8pGfL6nN7AgebzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsoJbp7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsoJbp7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CC41F00A3A;
	Thu, 13 Aug 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615394;
	bh=0hWfgSJLC/BSv67WuRi5uLEurUAGh2vlGOP/FZB9TmY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=DsoJbp7DBu9IHvUyUTLxHngQMalNA/+8A7vdBOMJnh61urIsbQx8aitdnhy0dZKd8
	 xirEt13aCZzdzstx8txY2qu+S1489yYcn5bYBI5o6M9/x/KfbqISUWpZ5e2KFrVy5a
	 hiMTYKhPPvRGsYNviaNT5AuaT7825wD6e5w6uKnP1vQCyIY1hC3VqukIxMJMjbGzLM
	 tMw+S77ibc1mdZrtf6xIMj+qawwp5dbr+FXUTSLslxcIMpTxUPifBtk4OtN6hvn43f
	 /dWjYj0h04/r4NJwd2Zclr4LArCrRqttaF3Mb0Tpwnn7/a60WV1xsjGmXsLVRarwyY
	 EybmipaHdM/ew==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:03:03 +0200
Message-Id: <DKNQAOJ6WY9I.2DL6DEDMAN483@kernel.org>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
Cc: "Gary Guo" <gary@garyguo.net>, "Mark Brown" <broonie@kernel.org>, "Alvin
 Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
 <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>

On Thu Aug 13, 2026 at 11:32 AM CEST, Miguel Ojeda wrote:
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:

Of course, thanks!

- Danilo
