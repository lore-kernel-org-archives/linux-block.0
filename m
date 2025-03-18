Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C7204C16;
	Tue, 18 Mar 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298499; cv=none; b=rb1J91hh1EqUN+yD1DllNZKk/fvJ4B/s7lYtjt0NIZ6BXWSqVlMOoFXZ825uuzcNSRBYXS2FsrD7SoGbjvKu//36KgV76LNN3WjRyMa32ICh0pNQB+obKS1T3ijl3oekHPb9eRfm+9FEeCMmVkqttZOyLdqhG4977V+6Ad/oTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298499; c=relaxed/simple;
	bh=Pk0YeZsqFpV5qbswaCfZFCWsRkM+y5cOrF5i5TWk0Kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwB9KnIaP5ZJZ/Vho3xNQFO3KFy9e+RKPs1+8dcObshpgTC8iMzo0kGRiInKTJDps0TlTyk81A/jXgnTMMWFymD6rQictgBPguuJ4pNbPeBOZp+mE0Ne/IB6ZIz/yfjPmtrL1C+fFQSC0egclw9+hzVbTp6VuLS/2x0ft8+zdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDvIOwaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDvIOwaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D1C4CEE3;
	Tue, 18 Mar 2025 11:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298497;
	bh=Pk0YeZsqFpV5qbswaCfZFCWsRkM+y5cOrF5i5TWk0Kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cDvIOwaJq5u43XqTtJ59GXyVfRvN0Nj1MfcFp0k6TtkYlHSLoiVU/6EGKX1eByNv8
	 +3ujACTopuh8XXuiK4gbVJriFBL2FqJB5mvaZJtHTNM5Vq6O3uH1/A2Nk7OwwHgRpK
	 5Y5TTqhzHJtPwo2qear9veMLBrIDgpxadPAXUjO/gKBgcF5IaBESZTZQg0weEhmRCl
	 smVy8nnhav5gfnFYAsEVexrRtIuFUbf29xTH3iiRuHHRpusl5T8j33eNxZXEO80m2Z
	 0oQ4c62E0naW5tENIwyveledh+9rhBWw45hVYEdVMAtE9it2V7TVeKrmIaNgIsUWBc
	 g4BkzasrP0PkQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Peter Zijlstra" <peterz@infradead.org>,  "Ingo Molnar"
 <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,  "Waiman Long"
 <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 15/22] rust: make pin-init its own crate
In-Reply-To: <20250308110339.2997091-16-benno.lossin@proton.me> (Benno
	Lossin's message of "Sat, 08 Mar 2025 11:05:09 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<XuLpVmtP3s3Sv1qUY358XwtAOwMy1jwIsoRC1Q8Jj2MEE3Y75gCD4DQ7OOz1NQrZuick63mOMJ9uh6ynDjaYKw==@protonmail.internalid>
	<20250308110339.2997091-16-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:40:31 +0100
Message-ID: <871puulg7k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Rename relative paths inside of the crate to still refer to the same
> items, also rename paths inside of the kernel crate and adjust the build
> system to build the crate.
>
> Enable the `lint_reasons` feature for the `macros` crate in order to be
> able to use `expect`. The feature is stable since Rust 1.81.0, so we
> only need to enable the feature for older compiler versions.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


