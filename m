Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6323AB8B;
	Fri, 15 Aug 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249033; cv=none; b=BSDSApyLk3ucCrNOtI5wYOEANEECBp1pjIisi9TzAHBKIGIqpChIOG4cIJtiiTDNISl62yO05t1O2q+qr8r+O4/HpBjbtun4cOao+E8xn4KeFKr52HizsXuecAuLaMkEh3CyeRBbvmE/6iIw5UcIwRM5TckiNghWgooQ/jURAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249033; c=relaxed/simple;
	bh=30vV9pXBRs2HMe5d6GPdXEani0gIO+FipecKZyNwFv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cz6ykvEbfwVqfiQSvHnHjLf9AYbqQ1UPcYxdiOOCn4vL8m7cLrlml4DffswVUOuft0bheUaFyvemIkqDGLgOt5fVyvkHw6ZBZYXY3h8koW+9U2EfioZfgmwyp4Kg8Z+ng1ovTTGnn8GPdqvosaUINZCIu7iP1JLCBOy2AIBiF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBGuIDA6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBGuIDA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBA0C4CEEB;
	Fri, 15 Aug 2025 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249033;
	bh=30vV9pXBRs2HMe5d6GPdXEani0gIO+FipecKZyNwFv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kBGuIDA6F0jog95YtwShwZjNbtnHMv6V0gQfSdAD6dvoefE9kpcaYIxTrk1kOvKY4
	 oqJjOe66RZ6hTd29WQeq86NhwRCtMqGQIrRxHlQLY9tLQx/+4ER1q6L0CdNtakanZ4
	 1ooWlBJifUfc/rJBJrnm6i21Onc1EQ/pS0EUgr21cpApXzw6kPqhCrXfv6tYOBJ4nP
	 uDLnDQbpV6A+MLDdQfCAtV4chQLGS0OP4AlWfJglD3kn5WtYsmN7joTSA0LnAApJz6
	 t52zJBQHfwFtSzI6Wz69WJnvFLAVWh8kZPWh4EiUb63olT9hdeH/h9XGeF1G6tMBGw
	 cmTMOSy6unB+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/18] rnull: enable configuration via `configfs`
In-Reply-To: <aJ7tFulqpuF481Wg@google.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-14-581453124c15@kernel.org>
 <PJhsfpOsp7EkWugCN65OhC9eUuui8Lt7SoAjHDCXqdUn59sTZrrZiopgyhYIVD5l5JamiZ8fXWRpM7E3dtORfA==@protonmail.internalid>
 <aJ7tFulqpuF481Wg@google.com>
Date: Fri, 15 Aug 2025 11:04:09 +0200
Message-ID: <87frdtdkhi.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Aug 15, 2025 at 09:30:49AM +0200, Andreas Hindborg wrote:
>> Allow rust null block devices to be configured and instantiated via
>> `configfs`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +impl NullBlkDevice {
>> +    fn new(
>> +        name: &CStr,
>> +        block_size: u32,
>> +        rotational: bool,
>> +        capacity_mib: u64,
>> +    ) -> Result<GenDisk<Self>> {
>> +        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
>
> GFP_KERNEL is in the prelude.

OK, thanks.


Best regards,
Andreas Hindborg



