Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846151AED5C;
	Tue, 18 Feb 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878872; cv=none; b=qyPUkJDdascEDk7SVCsGqbnnwQpzqK6j/pHWF6gomcUDap7cjT2e+9yE89UCJVk4S51BzqkXqMVnbNX5EfP6c3DbNWL23WRhZN/wSa9hK+RSrGx7YOYxmvAsya3GWxREqDUCWyRoG7rsXP8G4gGzZRao7UQZUAy2gBDAvc2V2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878872; c=relaxed/simple;
	bh=i88/DAhPDp0DA1eD5zdWXBqGIYBq8cyjbmbzVlj9+dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eA1SdolxBTB+coTSBaeom8t8Usxemr5ZIejDE2YBJ+nv8BScBUTSbXLu3WEtZxnbmceOBQRpSKU2KvySi6b0HRxbinElj7dLxLt7HP1oThUmXxZeh7ha6NVGIoFabQ7xTqXrGcqqXB7WanSQ/7WFKQxzNQyaOYqqzKELaNT82Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7pg+p81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7pg+p81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E3C4CEE2;
	Tue, 18 Feb 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739878872;
	bh=i88/DAhPDp0DA1eD5zdWXBqGIYBq8cyjbmbzVlj9+dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s7pg+p81nDT2hsjUcvU/KWZlBXw4yv2lAE4WeA2QpR8IAo4VR/fHs5nHqV9UQoUCs
	 ROnzKSlqFV1JCdH7v1waIcz2S8SsdR0wRJEMA3tPlIqB05VbC/Mrw2h/RmZeovvkS9
	 qiHra2R87iYBHazSTRwI1xnyPkztQCLF6arVZqEBpeXxtZTpXZ07YkUoQj6IzNiCNc
	 OS1gZf+x6kMhxjdVdnkytqoHU9JByV5dgWII2cgMRedhCCn+zq2d27DI9LtJttZWMR
	 E1MVV0MEsHzQDKERMkwya11bDxLO9+ojB8JorCgC1qJ9O5IzuruFIEz5G5PnvcfB+6
	 NfGks7mUUQ9Iw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "John Garry" <john.g.garry@oracle.com>
Cc: "Jens Axboe" <axboe@kernel.dk>,  "Oliver Mangold"
 <oliver.mangold@pm.me>,  <linux-block@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
In-Reply-To: <f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com> (John Garry's
	message of "Tue, 18 Feb 2025 10:40:35 +0000")
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
	<KP4HxjAbrINQTT05XxqLFD7bPj5ONsT3hTQJYUyXtoHBYc7-xFNDZUN3R8pWT-Cd1Q5fguKy97Oy8UJv5Nj1Cw==@protonmail.internalid>
	<f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 12:40:57 +0100
Message-ID: <87r03vfpkm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Garry" <john.g.garry@oracle.com> writes:

> On 15/02/2025 10:58, Andreas Hindborg wrote:
>> When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
>> problem if users want to perform bounds checks on the `bio.bi_io_vec`
>> field.
>
> Is this fixing a potential problem? Or fixing a real issue?

It is fixing a problem I ran into in rnull, the rust null block
implementation. When running with debug assertions enabled, a bound
check on `bi_io_vec` fails for split bio, because `bio_vcnt` becomes
zero in the cloned bio.

I can work around this by not using a slice type to represent
`bi_io_vec` in rust, not a big deal.

But I am genuinely curious if there is a reason for not setting
`bi_vcnt` during a clone. As far as I can tell, it should be safe to
set. `bi_vcnt` being zero does not seem to have any effect other than to
puzzle developers debugging the code.

Maybe I missed something?


Best regards,
Andreas Hindborg


