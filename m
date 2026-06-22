Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773039EF2E;
	Mon, 22 Jun 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121544; cv=none; b=ZvspWtOyfnFDPgXUfFGO2aciCgsB5sRV7AzgFYuwuWnNPEQ7HewZ9KbSyMsMnD5Ai2HE5OI7rdqjUh8EnAVw1301WFrGKjzOqVJZZgU5sN36EFk9HootHmSLD6HdpepZbx+gAj/EHkXZojHGdVMS1Gcb6zWrJtVF0D4bdwT/XaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121544; c=relaxed/simple;
	bh=camQzgX11b9RtBketnhIwhWiN/pUYT4PY/SigoZT4oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJTieW0XPv6WbusiuzLd/MzWc5sHS7YsNFIOEiaTZdEAHkLnGPVQ2isBYom9pEzI90J5YjJ7jDxLO21MSua+09eHTbIrJFyJaf+bvEO6C8A21KamR25ZQPcKvMGunPgTBpmgbQvGerzpZCs3rEiBhkPNHCqwwUandS1JuUXccF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7Z5h8QV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7Z5h8QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB72F1F000E9;
	Mon, 22 Jun 2026 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121541;
	bh=camQzgX11b9RtBketnhIwhWiN/pUYT4PY/SigoZT4oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=H7Z5h8QV+Sgm23uxmGgab/3yuerJJ1o84Q5vIkNHMPGKE124NDuRJcJQbp9uqpnvf
	 4heRmTjxC+6YaMZxQnMPNnz6z6n25qWsk6+B73HtLKm5PERaHOzZHnVabMRED5DAS5
	 10gh5H1eiG2pqQh6dAyzxKa5LwBXYYVqUOvpRo5jiI/A7e0UCyLCRuLUOqzv0VXcxG
	 PWqsUdkNzMZ1YFudTQqXkqsyEPR9GKa8Rks7oRyGSNGQJFW1fyJI+aYYG9Y+zv0gXI
	 YTA9qyBvazvUO5Eghahxj39TkvpGrXeX45cP6kGuiUr39wt6bRzLfncfFk7GdVes8E
	 ATuJiK+e2T7+Q==
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
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 5/6] rust: miscdevice: set fops.owner from driver
 module pointer
In-Reply-To: <20260622-fix-fops-owner-v3-5-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-5-49d45cb37032@linux.dev>
Date: Mon, 22 Jun 2026 11:38:33 +0200
Message-ID: <87mrwmewyu.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Set the miscdevice fops owner field from the driver module pointer
> via the `this_module::<T::OwnerModule>()` helper, instead of
> defaulting to null.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



