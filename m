Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37830EF92;
	Mon, 22 Jun 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096945; cv=none; b=qnvNXVP+cfNhfxXEr/4YxzzlaxxYAzGj2lnAhIrEMgRr4Ccgi4R824A5IqtBBOC8nYsMAd2XBQze98o4E6WrnsXUjG9kjhRs+OhRZovnC1kgzXr671EB0pcbPsBpmPuiC5tGtmljEvqIrKo0tw0bPP8Va4GpuRhweWfNCEsiszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096945; c=relaxed/simple;
	bh=xPT6DAdg86ekeubsFUyJE8zxGgUJMoz3jyqa9JhEVkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJDBqDmEwMkMH5Ro2EhWWwn4cY2zFs0cjrEhLHa5pZXs09EiYEkLEjx0A2LFzyNQyuMDjLJkxaQvBQ5aamFOZPqPfMAu6anOxMuCnaejVVeg8t4Z6dcd/hlooZP8oayCvSwQGIaZa0nwtHBleeMjd7ZppgCJsOj7V148gQndUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tto3Rx1j; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tto3Rx1j"
Message-ID: <02e9be5f-8dfa-4a4f-8a70-627ed1124b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782096942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPT6DAdg86ekeubsFUyJE8zxGgUJMoz3jyqa9JhEVkU=;
	b=Tto3Rx1jAaHFtdkhawr4dGV2oKUQ+FH3oxDMEtfUe30AqTgIxxAqLJzSwSTl3FHaQCi9kl
	8DSHCQJxWmTNAgouSdXaK156DzQRkSoeITF8p9plSxjrB2oLwl/FA9EjLfTd3z4zp8l83i
	Ss3MyZcgf5r8XpkmwL+rT4BP/ncSct4=
Date: Mon, 22 Jun 2026 10:52:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
To: Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
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
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-3-fd99079c5a04@linux.dev>
 <87fr2kf3m2.fsf@t14s.mail-host-address-is-not-set>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <87fr2kf3m2.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/18/26 20:13, Andreas Hindborg wrote:
> Alvin Sun <alvin.sun@linux.dev> writes:
>
>> Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
>> in the doctest harness, so that `crate::LocalModule` (auto-inserted
>> by `#[vtable]`) resolves correctly when there is no `module!` macro.
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Does this need to be ordered before the vtable auto insert in the patch series?

Yes, you're right — this patch would be better placed before the vtable
auto-insert patch to avoid a temporary state where the doctest harness
doesn't provide the LocalModule fallback that #[vtable] expects.

Thanks for the suggestions from you and Gary. v3 has been sent to the
list:

https://lore.kernel.org/rust-for-linux/20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev

Best regards,
Alvin Sun

>
> Best regards,
> Andreas Hindborg
>
>
