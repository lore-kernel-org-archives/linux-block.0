Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184171A2381;
	Fri,  8 Aug 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646789; cv=none; b=E/8Ad44BPQaKqSXGZqARFlj2db2kNTpyg6GIVrdArS11XLCi30RiW9m3DliRhjp6eup03MqaifJNXJM8MOOUu6cUjVl4Xm9K4fMx9zX4Lz/l1SR0wguVGiumRCaSIXvkh9tdn//xXiVHzY3ALNrtbacAeNE7eZVL8A55jVjX89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646789; c=relaxed/simple;
	bh=yFosrKiB0Ggl9SeGRAA4tB3TRCyF7iVganwUh+tAw6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iYI1lUVvyS3l/N1RSPDqExwubeFDonj/CmQt8Tc5o63b0cH3NpXnSHJsf6eIUwYs/qYDyzwO2nbmf13u3zYokkxchAP3axS4WYnFH5hRfEag9d0iBzcKEA7zx9OIJVqEUuLo+HCboRd+2hNjOerjfa6Pt7MC8RS1xvnKUJPHCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA5VZvP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA5VZvP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB736C4CEED;
	Fri,  8 Aug 2025 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754646788;
	bh=yFosrKiB0Ggl9SeGRAA4tB3TRCyF7iVganwUh+tAw6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rA5VZvP4xUl4hsOhDnyn3wZhBLG1E6euyWLD9AHobBOij13EUhVfU0ILTXPdcgNBH
	 UW+1hKLegM7mTmVxAQpeAfGO3WbmSdr7/4lI1vvBahsBVYefb2ESDug+hCQbTse226
	 YhYTK5k78V2jgFDR5T1g6QqgH6+O2tLxo1bJ3LsIUne4Fd6pg1LqZ05kePl7neYKPd
	 jbgkgRVd5SOyjiWb2fuK6P1Y6vhAWvOBPLYaws4CrbVTQKxqrFlJqgPt4GUpLmOPQ1
	 TbpgspnH/UGcApCNBwXZg+8zlhKPEpSWXvF2pd/8MTCfTF0oW/Blm19cJ62pJUYwO+
	 kBLHR2ye1bh5g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Shankari Anand <shankari.ak0208@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Shankari Anand
 <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted
 imports from sync::aref
In-Reply-To: <20250716090712.809750-1-shankari.ak0208@gmail.com>
References: <KnSfzGK6OiA0mL5BZ32IZgEYWCuETu6ggzSHiqnzsYBLsUHWR5GcVRzt-FSa8sCXmYXz_jOKWGZ6B_QyeTZS2w==@protonmail.internalid>
 <20250716090712.809750-1-shankari.ak0208@gmail.com>
Date: Fri, 08 Aug 2025 11:53:00 +0200
Message-ID: <87cy965edf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shankari Anand" <shankari.ak0208@gmail.com> writes:

> Update call sites in the block subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



