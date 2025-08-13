Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC62EACE0;
	Wed, 13 Aug 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092818; cv=none; b=Y6axaw5iot/dumr7cHQQ5egPffo7TK58BH0HBdAA2zZick0yXGwk+i5uOb7n3Xu2tjZiJzFd7jza2mR9zxfbFwtvw96vD3fYjrh0cSEA14UX9kh7DMRHe9/n9W2nUHov/746fw11G19orvaXpIUlAXc9RDLncbY8XsRwQQXnaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092818; c=relaxed/simple;
	bh=UAO9FvzDnoYfoDrmrGeQdcrb/Ul+p/dFDaH44bIxgT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0LZbyXNgn6ls5T+0VaGRyLgl10oImRpDcDR72wHhkQ4ewfWCo98EzZuTKDkwj7A+d76e2RVLsrnuM2RSEqQEir+wPgOPbU5iENHSgaLr7QKp/ndXI9FpfNqZmvLQ17yYCc1FuCTLBwR3VWWhnK2YfGEpwjDArK/L9U9K3Pv0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/cHBPZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/cHBPZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332B3C4CEEB;
	Wed, 13 Aug 2025 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092817;
	bh=UAO9FvzDnoYfoDrmrGeQdcrb/Ul+p/dFDaH44bIxgT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d/cHBPZkrPeHH4eUrpq8GM07OApm1BfM5L1mK27jh1X4278IaHMdpzE+qr9TxzjTr
	 L8TpgaEWHxcihTfRbBhMCHTeejJpHafcq6GmksAxlvVxNDOfQNMCbY+q47pPRgjXTE
	 nd//EOi/PQptWdkO5j94smJX5ErkSpXfzSLTlbYgmiPLZ761Inb4cLWFp9+s8GdufM
	 I8oPYBUDhY7ZbObOZ+KcogQyYqcuKw52tTp13O0RwVUes+VU5Z4/5p+jP7gVow7u/g
	 Pn8EDU6iVOIhfZpp4qCbugMY7BvERMdVmT9S7LtLSXmQ5hRnc+SZ0CpAS91CpzPR+6
	 3q+7Q+iQzUF5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/15] rust: str: introduce `NullTerminatedFormatter`
In-Reply-To: <aJw88P7K_6GFmWvW@google.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-4-ed801dd3ba5c@kernel.org>
 <vtPB4JcsqY753m500Pb4NVZEAxlKfEEzsrWBWUcEJcxqmhWrWYNqJDH8PFVm03IUm9nEweDNcYeaY2SbKHUOOA==@protonmail.internalid>
 <aJw88P7K_6GFmWvW@google.com>
Date: Wed, 13 Aug 2025 14:34:20 +0200
Message-ID: <87frdvflir.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Aug 12, 2025 at 10:44:22AM +0200, Andreas Hindborg wrote:
>> Add `NullTerminatedFormatter`, a formatter that writes a null terminated
>> string to an array or slice buffer. Because this type needs to manage the
>> trailing null marker, the existing formatters cannot be used to implement
>> this type.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +    #[expect(dead_code)]
>> +    pub(crate) fn from_array<const N: usize>(
>
> Don't you delete this function in the next patch?

It slipped through the cracks. I'll remove it and respin. Thanks.


Best regards,
Andreas Hindborg



