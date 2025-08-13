Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE472612;
	Wed, 13 Aug 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092824; cv=none; b=kJpylb+WQLP5103vgoCsB58i0Jl6os8Pe2LJda3Rn8CGELSZylSFnBEnOmO6UjCHlfITpQrbqNfXpUpVPZRh4lvcM8aHR1ikli1fLyekLMzZ3dN33WTIDehHFll2ZiNcKxV+89fgg28xwf7/LGYWG2EqhNfZDDSws50QdJXGato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092824; c=relaxed/simple;
	bh=skTD0SI9AspNlQ8bU333//dSbcnveCgVWNlXOLVrO7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnrNzdLcQb6ZjK/gjHWnaLjrc5Fg/uWeSsQoAgmXdWH9GStEg2Xzgs+8OIpU0xSByrC2B1OzJKPZXyq1FaWri5JvgQVu/JkWxhRDWiUVy3UB4BmxT+8UXp8v9G/ZO+ewI34nv/fE+ktGjNm/AszNskIN4170OW9IhA1JReUOBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M18xxNYe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M18xxNYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87871C4CEF5;
	Wed, 13 Aug 2025 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092824;
	bh=skTD0SI9AspNlQ8bU333//dSbcnveCgVWNlXOLVrO7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M18xxNYePA2ppj61JQedKnSEcULx0Cbsb6JDG4xh6cNaw077TVzJgecCyFohttpHj
	 1tPTL5MS9fQYth99e+6CXxPlLpgA/0jiskAJrzIcMFEruapXaSMwb/Y1oXNdFwiSb1
	 j07UINH4E6YUZFwuRAYyizwo1GtaRIMttrupNVEFOot+hm8FmRSAjeu1Wan/mrVlU9
	 YqHRPpNiRb/xzR8qmIkB+p0SujAnXbfRzVlxzIdLBAOVCqUmxcRAzv4jm1P9OJU8Fs
	 ehF9OE/OMdJ7riJOxadaIU/NksaVWKJl0qXeV1aZKAQPBnFjTkaz9u67muFDWOv4ms
	 +8+MV+bUznEFw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
In-Reply-To: <aJw-XWhDahVeejl3@google.com>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
 <mACGre8-fNXj9Z2EpuE3yez_o2T-TtqrdB6HB-VkO0cuvhXsqzECKWMhsz_c43NJUxpsnVpO_U0oLbaaNhXqRQ==@protonmail.internalid>
 <aJw-XWhDahVeejl3@google.com>
Date: Wed, 13 Aug 2025 14:47:54 +0200
Message-ID: <87cy8zfkw5.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Aug 12, 2025 at 10:44:29AM +0200, Andreas Hindborg wrote:
>> Allow rust null block devices to be configured and instantiated via
>> `configfs`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Overall LGTM, but a few comments below:
>
>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
>> new file mode 100644
>> index 000000000000..8d469c046a39
>> --- /dev/null
>> +++ b/drivers/block/rnull/configfs.rs
>> @@ -0,0 +1,218 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::{NullBlkDevice, THIS_MODULE};
>> +use core::fmt::Write;
>> +use kernel::{
>> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>> +    c_str,
>> +    configfs::{self, AttributeOperations},
>> +    configfs_attrs, new_mutex,
>
> It would be nice to add
>
> 	pub use configfs_attrs;
>
> to the configfs module so that you can import the macro from the
> configfs module instead of the root.

OK, I'll do that.

>
>> +            try_pin_init!( DeviceConfig {
>> +                data <- new_mutex!( DeviceConfigInner {
>
> Extra spaces in these macros.

Thanks. I subconsciously like the space in that location, so when
rustfmt is bailing, I get these things in my code.

>> +        let power_op_str = core::str::from_utf8(page)?.trim();
>> +
>> +        let power_op = match power_op_str {
>> +            "0" => Ok(false),
>> +            "1" => Ok(true),
>> +            _ => Err(EINVAL),
>> +        }?;
>
> We probably want kstrtobool here instead of manually parsing the
> boolean.

Yea, I was debating on this a bit. I did want to consolidate this code,
but I don't particularly like ktostrbool. But I guess in the name of
consistency across the kernel it is the right choice.

I'll add it to next spin.


Best regards,
Andreas Hindborg




