Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E643F0B4
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608914; cv=none; b=ARLjatDqR1n0VbqeJBf2l0GcEDxIWlduWan0iOWzKkMN+C2E8uaA2y5GXHmVHHrKACQdfwyDtjSEinHqGtL1uWlUi6ONyJ09K+ZXXG1k+eQEXjZgXD3oI4XO2hc+NosVtwFanU+WSnwYFQrCQazWz52/uE5LcILJBwgnG/zWOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608914; c=relaxed/simple;
	bh=HJkkjybnc95eKMUgffBgUHHJLr8cPHCSSaxuPE45BEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2v+3I0GTWsH5tYNPor7lxZ8IhsShIRPPya852UXi/DcSfIDdeGMoN/kNhzbXV6JejCYcN6pxMZ21jtAab04cJQhwdk8+Iq7y9ATAo9C18J7ORBFMJDNEzqOXlZuHyQzoA7BhDghiriQewtKyhZ8XLCA4/GnP7fsCe1WaEcWh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UHai7FBN; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UHai7FBN"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HJkkjybnc95eKMUgffBgUHHJLr8cPHCSSaxuPE45BEc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786608910; v=1; x=1787213710;
 b=UHai7FBNVrl0ZSe+2mNdxKwYssAUVvc8lLsNDvxwVJM9F25wBLYV5Nekeg3/FEgeXSbEloJt
 ZUh6B0rVaU2nqJACkfxm66O77x++fBtgRcll4Gv0xFHv1ZqOU6grQX9i/Mwzt/PjWYN5IIfrGkF
 LJ4WiabhJaVR4BgMgGXFog+A=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [10.0.11.3] (2a11:3:200::10a9)
	by smtp.migadu.com with ESMTPS id 549bb4bc2be94b73;
	Thu, 13 Aug 2026 08:15:10 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
Date: Thu, 13 Aug 2026 16:14:42 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
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
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/13/26 00:33, Miguel Ojeda wrote:
> By the way, I removed the Acked-by in that last patch since I think it
> came from an older version as a series-tag that didn't have the patch.
> Please let me know if I should re-add it.

Hi Miguel,

Thanks for applying the series and catching the stray Acked-by.
It was a v5 series-tag, from before the MAINTAINERS patch existed,
so no need to re-add it. I'll be more careful with tags in future
submissions.

Best regards,
Alvin
