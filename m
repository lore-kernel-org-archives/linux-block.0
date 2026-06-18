Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D0231835;
	Thu, 18 Jun 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785114; cv=none; b=dkWT4ypN9wTpOuVJ/j2cWjUTp4RmJemzI9D0niRmlUUL8MKM0iZdBxp55G5lf6mrIEJ0BA/tG8mqoaa85IQ4QMCK5vRskVfuKFfu+DVwpbHMYjPmWaOkojIVdyGet1aUEjm+sy8NjX2Qy/JUGOIgeMWoqUsey7t4ts6QR5s3G6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785114; c=relaxed/simple;
	bh=YbjCMA5TYkGRYIkU4h3+DQu1gNQFqhtJ5eNZoJIb5jY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFq1/EauXwV3N48tiBMhKbdj0zQD4Ba9rGKHdMkhavdXoE1x8YlUXfUaRd7lEX9dQ9xU7IqOBwKGb3+sVo3kp5ZVjtmq2HoPfYhLYDfdIRMUU59QsKWT5k6goe3V6aEdA1RtsNegUEtQuMPhuseZpsveZRTj58I2M21kbK6XxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+R6G+9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+R6G+9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60BE1F00A3A;
	Thu, 18 Jun 2026 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781785113;
	bh=YbjCMA5TYkGRYIkU4h3+DQu1gNQFqhtJ5eNZoJIb5jY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=S+R6G+9OqC99ywOs6Z0hxuK2gGg6+ZqiWW4BbjjEPMETtj24mm6d8y/5TsOVSa8S4
	 cvOPHRHEmmE7+frePgq0EvAdssTNa/7p2NRLmsvjPSGTPvf/zGQMG+aN7prLm1moYV
	 ezHedjpEmx48pZE6ECeWnYgjGu22C9iUGrxjsBgKSBqs4Zv3HqEwrxSGdcVrPrHgib
	 Ozqk5f2wdmzl9SQp58kOvZPjpcmA9kdRPH1qKXzwYvl041soJrFrqCFlWfRg3Tvypz
	 9sXJ/P5QbmgcaRgI+iewfts7F+N9MbyTJDlQjVoJRV3dJhshyIVuhkcCbfrEXzqytx
	 aKvQME2MUMCLg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Alvin Sun
 <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 3/7] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
In-Reply-To: <20260521-fix-fops-owner-v2-3-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-3-fd99079c5a04@linux.dev>
Date: Thu, 18 Jun 2026 14:13:41 +0200
Message-ID: <87fr2kf3m2.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
> in the doctest harness, so that `crate::LocalModule` (auto-inserted
> by `#[vtable]`) resolves correctly when there is no `module!` macro.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Does this need to be ordered before the vtable auto insert in the patch series?

Best regards,
Andreas Hindborg


