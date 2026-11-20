Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176047;
	b=UWSaCGLFWgx10XO1YrEQGwoOute28j22KFwh7s9bFC0dsbkNQSIKyEn1RH8UpuwWjT0w
	 NJKxW74LjeMWB1ogfYRhE7x5/aFFTwYu9L4P/oJ8OKmcAG2ROOfhO/J9tmKJ/6Xwa1uaX
	 c9L18UYBYIs3/RvndB1WlvSP+wQGTWTgKJHei0Qbs+TbRclQWx/90Xg0eiXqFxrw3HA5q
	 hWkc8BWRkJUG1pAcliSJBOHTojs56RkC9fD7cURqjxc6d868N9rosxhq3ucZS6qC2ZE7c
	 PAjoa/MZxjGf4MWhtn7GqN2WDQ3fEcXBi1ZHLxGFUljolUaAGZVo86R7Ti+wJ2Jhq+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176047;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=beQWb4LoAtDg8Zy+5AKtlfFZLus+EPwyn9DYxNFG6mU=;
	b=nY8fMPcLeErqjvAYNJVx1B0AWZNWZG+kJcoPPkkvHYEQ/GwVzjcdE2tagt99qhVwy1h4
	 OwQcRMOGLUlgnp302kgbrnoocubc2eFTgfPQtLSSoe0TgGM57TDboEzxuRLt3giTd/ryU
	 MHoVlCj6Fj3nlhDmNSW73W7JTndAV+QdX+pB+45C4X3bSO3pn5sNBtC4jUY2loRQEOCYk
	 i/9pC6Xx5+MMGvemVVLVzDduWLLD0UfE2IyVRpEsGLaJ3cLCYuUKczTeaD8g5clHfEv+5
	 Ia8rmu42WHnrUME3R2us90PmLhIuLeisFI2Xqw03GaHa3aYfvH7HXpXUdb1xuu2iyvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIYxJwKV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F3606A338;
	Fri, 20 Nov 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIYxJwKV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5811F000CA;
	Fri, 20 Nov 2026 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176046;
	bh=beQWb4LoAtDg8Zy+5AKtlfFZLus+EPwyn9DYxNFG6mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EIYxJwKV6pKOzzIEBuRXOlDo0Y+HodiAO2ZB2R6VQEfoBQ/HvGlDsgCsZZD6G5Czz
	 6Hw2mEq4W7WWL2M0khcowQ1ijdyhpl4Mf5E6jvjTXU3BGCjU3W7JH3HwTFePuk7BsW
	 Zf0fcxra0plL9c0eF7Yjpx+CYN7bzoUzk/Q+FqleL9bhb1AcVGEf22bj+ScG5xaNBz
	 T66Fe3ePBa9AIlYOk+9jLYdZIJzmgdv7gXFnPj3yOg7RrM21kpYHHujoSPlrAH4uP9
	 arxmZfKtYgbrYZDY/oMy1BhaVWUrcfXk5RMw2HX+ZvgFLWMDcsj5WLUngXGiGzaopt
	 u7hrJu5tbh8fQ==
Date: Fri, 20 Nov 2026 13:00:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, 
	Markus Probst <markus.probst@posteo.de>
Cc: Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v22 4/5] rust: rename `AlwaysRefCounted` to `RefCounted`
Message-ID: <20261120-belichtet-austoben-januar-9fca976c1371@brauner>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-4-12029383206d@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-unique-ref-v22-4-12029383206d@kernel.org>

On Mon, Nov 16, 2026 at 03:21:01PM +0100, Andreas Hindborg wrote:

For the fs and pid_namespace bits:

Acked-by: Christian Brauner <brauner@kernel.org>
