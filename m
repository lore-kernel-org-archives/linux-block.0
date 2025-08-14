Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95F31985A;
	Thu, 14 Aug 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196137; cv=none; b=IS6Ze/IJDByOJRUwUKEkM3ISTjoAlSiX3F2S0fNM2ata2FbJD4h1NhY1HGRAMEiGbrItrel3Mj7Kw1i4QuMD7Alw1VQU4wq8ITezByAoS6MDBJF8/L0Dhk/dpJ/k3RVPPoX5mtxh8xPQguh9QQWNSd/xy30wcb4ZiuxMUc3JTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196137; c=relaxed/simple;
	bh=YyxSOyx0RIjAWT3RJn4fvQbNlD0pJ5CpvN1NLGbhG1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7C/LvUxTQMudnM0fLPmB1373taXPtY1j2F6PJvf2eOAZgN50WsfM1uEvj5u+ti2VNiL2Q38YWC3UIOcoe+R2bH+ePXXStkwVlHJDwRasKaPl57OHLGmMGu/Ctw7mqGs2TFIgAhD8JJFL9Pr2hscNj35RCSoIYGJMm8ZLjm/caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU1z+L07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU1z+L07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEFC4CEED;
	Thu, 14 Aug 2025 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196136;
	bh=YyxSOyx0RIjAWT3RJn4fvQbNlD0pJ5CpvN1NLGbhG1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pU1z+L07cKR4SHXEGgBQOYhs8/saK2s1JjELxRKTRxseQwpHD3Tgd5PGxAXnRiydE
	 qi4BUQ9utvm7OHu1QamiwOTr6vpeMwOMmD6UOZySgO5vO/gc7ePbaQsgHX9pMLGSHh
	 h0w6hCG7T74BZusMuUA4sfsmUjcsKBBMbMSftrvl8X93k3ySM4xff0gUVlLUjnkv9Z
	 /3WmSK9420wWm3vZObg75X5c2xe4FVULMo+UtE3hAinKn+vHRnvCpoZnBuFdUG5gXg
	 v+RbTY26QcnR643sLYB21icaxFLb8GXkyrZ0CVo8dvciHf5vT1QwHAgNlB2W5umuvF
	 cu0HtkQ2HRqKA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/15] rnull: add soft-irq completion support
In-Reply-To: <aJw_iJZLXPml4Abl@google.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-15-ed801dd3ba5c@kernel.org>
 <wfn_oaXnBYZPI5xzdlZ4O8MoXu3rKutfhrHS3ph_tEWfWnKNxFotrCTnjini9dUrOehYWGyjSoy5U8JQ5uittA==@protonmail.internalid>
 <aJw_iJZLXPml4Abl@google.com>
Date: Thu, 14 Aug 2025 20:28:48 +0200
Message-ID: <87wm75ep0f.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Aug 12, 2025 at 10:44:33AM +0200, Andreas Hindborg wrote:
>> rnull currently only supports direct completion. Add option for completing
>> requests across CPU nodes via soft IRQ or IPI.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>> +        let text = core::str::from_utf8(page)?.trim();
>> +        let value = text.parse::<u8>().map_err(|_| EINVAL)?;
>
> Same comment about kstrtobool here as on the other patch.

This one does not parse a bool, it parses the `IRQMode` enum. I don't
think we need to use kernel C integer parsing functions here, if that is
what you suggest.


Best regards,
Andreas Hindborg





