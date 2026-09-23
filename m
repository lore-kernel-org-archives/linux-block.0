Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B82560AC2;
	Wed, 23 Sep 2026 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195529; cv=none; b=SRMB+dRFnP09+S1PN5wOKfjy2U9U3EboNjnegQLTgziJUIhGVh07wTH7eq5J0jHcLi8UjIl05g/pRleCRUMHQNv0/QtyHbW3JyqA17q5aWs1e6bs2OOBG5wgwGqmm2r+8+SPFPwPuJcaUps9Kutu2YUgGcLD+182mYDEOygVCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195529; c=relaxed/simple;
	bh=penjlBlTgqB2kWrPtgaOvaogZg7i5pf+p8NYD0/I4as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSREArKe7c6h3IV7OKHc6EP58qF3MaaOyISdnhRxOkUWpW4bHRecKt2EDylDkbId87s8c1z8rave+UYQjpsdYWPpy+QjnHXzRBB9w2Z8idkeRzdXur+SGnOdD6gVFpOQ1eKJITobmy00OIwaq7tp/FY6hQahomKGEqWOOeV+gbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr3Q4IbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr3Q4IbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236DC1F000FF;
	Wed, 23 Sep 2026 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195520;
	bh=penjlBlTgqB2kWrPtgaOvaogZg7i5pf+p8NYD0/I4as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Yr3Q4IbWQ+1R28k2uwHIxPOX/hK23qUPD2ZBKdzN63QtdN/2CDQtedx98IMEGVvKi
	 S5A+E9RM3PD1i40dbSqegp8LwkPRdO0RKLnRlmFPPMYDMl+vkdpYj0oDCBhNtO2W6K
	 AfJCx81k4wuKtmhKX4J4MBH0a+bv+F+AubebBpnSWNIc4IbynZ8Twjq+YbCYWmJ3aF
	 UUP0Ndh/VuO3eQowmn5jD54PD13WRL93bCj09cWdp8FqbLqRk4a1P2yg11I8YUsyZg
	 pb2gx2CJGKophHx7AQJd3nq+S4tGb2+GdNBdifh0Hd5Uh1MxZr58U0/j3Mn5oZn8Vp
	 Xspd2kUlDktKQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Adarsh Das <adarshdas950@gmail.com>, adarshdas950@gmail.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, axboe@kernel.dk,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v3] rust: block: set GenDisk
 block_device_operations.owner to THIS_MODULE
In-Reply-To: <87fqyz3etf.fsf@t14s.mail-host-address-is-not-set>
References: <20260806083655.23161-1-adarshdas950@gmail.com>
 <20260806104027.83940-1-adarshdas950@gmail.com>
 <87fqyz3etf.fsf@t14s.mail-host-address-is-not-set>
Date: Wed, 23 Sep 2026 22:31:50 +0200
Message-ID: <87cxu33e15.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Hi Adarsh,
>
> Adarsh Das <adarshdas950@gmail.com> writes:
>
>> GenDiskBuilder left block_device_operations.owner NULL. Set owner from a
>> const block_device_operations table using this_module::<M>() and update
>> rnull to pass NullBlkModule.
>>
>> Add ModuleMetadata::THIS_MODULE and this_module() so the owner pointer is
>> available in const context. Rebased on Alvins fix-fops-owner series [1].
>>
>> Link: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/
>>
>
> We merged `LocalModule` [1]. Please use this feature to set the owner.
>
> I don't think you need to move the operations vtable.
>
> Best regards,
> Andreas Hindborg
>
> [1] https://lore.kernel.org/r/20260811-fix-fops-owner-v10-7-7e71776f9dbe@linux.dev

Actually we are going to pick this one instead [1]. Seems like you have
been trying to do the same thing.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/20260811-fix-gendisk-owner-v1-1-c0fe4a449ecb@linux.dev

