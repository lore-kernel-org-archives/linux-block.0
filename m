Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1987E792
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456483; cv=none; b=j39KNIqlSMYD37iyr0o93xMg5La2DfkAlJIyP91n7ZSMfICB+qaXOM+BK5XdArSHhVDZyiFgFlYuZt0OMWyU9N0ifCpT0M4EoUzfVrbyxyY0BWcSWN7rlK25mbhMcQsx47DHhjR4zZA3YyUse67fUfqBgcGSXX5KRLmMadXATOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456483; c=relaxed/simple;
	bh=Xfejeg4Iec1utRNIJGp512yhLQzs5hTDsCuFHWwB+a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibz2X8txG3BJOLBtPzbYXS+azakCEPOjwMj6FuDw4lCwZnnTlmRC2rRVyLlC5+rxZCyo/OcW5t6iXF91aMrtljNcFbSb+1pMc1CP6DLsLGHTli/cjUIoE9fux41QFMyDtOXLC4Hl/K38I6IuFlMaAKVG8HZH3t8c6OUCgVRu6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WGFeETY3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WGFeETY3"
Message-ID: <15a4a6c2-1806-45ec-8293-b868a584bd25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786456478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xfejeg4Iec1utRNIJGp512yhLQzs5hTDsCuFHWwB+a8=;
	b=WGFeETY3xgMprhXkmaZK0Ch/HcSl484NBm4U1R8hItFhXDqS9q3CSUfxatlJXL4ijvBFLr
	FE9qY35lQy8asf24rMtwU5FAInxQqsBydXy0l1ISdIg9bVn2Pm84ptJCOTflV+/5LsZoTE
	ey1rm4ZQyCb10x2DaQek1BlF8Y5bIjA=
Date: Tue, 11 Aug 2026 21:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: block: gen_disk: set fops.owner from driver module
 pointer
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260811-fix-gendisk-owner-v1-1-c0fe4a449ecb@linux.dev>
 <CANiq72nmthEu5HQG9B2yOgLvhEJ+PMO7OBG-ki2uUQiUTTgciw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <CANiq72nmthEu5HQG9B2yOgLvhEJ+PMO7OBG-ki2uUQiUTTgciw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/11/26 20:20, Miguel Ojeda wrote:
> On Tue, Aug 11, 2026 at 8:51 AM Alvin Sun <alvin.sun@linux.dev> wrote:
>> This patch was meant to be sent separately, but I forgot to send it.
> Do you mean "not separately"? i.e. in the series?

Hi Miguel,

Thanks for taking a look.

To clarify: when I sent the fops.owner series, I did indeed overlook
`GenDisk`. After the series was out, I realized the gap, prepared this
patch, and privately asked Andreas (back in late June) for his
thoughts. He suggested sending it standalone with the series as a
dependency. I then got sidetracked by other things and forgot to send
it out.

Best regards,
Alvin

>
> I asked Andreas for his Acked-by.
>
> Cheers,
> Miguel
