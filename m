Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E617BBF;
	Fri,  9 Aug 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208488; cv=none; b=ILKXbE9eAqb7XjEeeUdVvdQ7MB6OXgfO1ZxS1pOlvhsnDZvhUYcY9QT/PvlXHKoW74A9gXEy55MlMNN3DL1Zc9pPxmUU+O7w08FlJMQh2rLI8DbvfoXDd570ygecsCN+FOjs8d6PjjfvpiJHOnAARpImuuFUOoqwWERpop2aNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208488; c=relaxed/simple;
	bh=Srly1nn1Pswqxc7eF+qKIxUWT12jjZEvXKWt/qP6bYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjvtuQYP8cG1OxHj/6O6YBTqlvj227zjvopfZkQE1XCaWFy9zxPldv5G0lgt9gzHZtCFisuRdiE3DwpH35VTE24hC3hU1NvcGGBRlxHlbsykDGQg9tveAds6jRtygAE+YpDtzf9eHEc6L8E+em+kdDC6Cciv7Bb8cLTD+YB3hNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzSM31Wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzSM31Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14187C32782;
	Fri,  9 Aug 2024 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723208487;
	bh=Srly1nn1Pswqxc7eF+qKIxUWT12jjZEvXKWt/qP6bYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzSM31Wz51Y9HpYQQEEzrzevnhNyHKrd4FuFcvnttIH1QQsqkXPxvq1FrGEoXRBMe
	 yx0lO3AKx5XgoPJ+piszPtCJiQ5A4CDmPHCOiaVy+Xn+TuksXXZUoSym7zlPSFm/S5
	 MAUmP0PdwO++GQt32iv/eruo1cfoLuRtri8ZqLKrkCfn2sXBxXyyD/25liEw5LpcTk
	 TSvH73vuYzLsSxFXFf4exjTiNghUEFZvoeq53rOOTLQvdLq9BmexLfWBhG4e4+7OOy
	 fJ/ERO5Rx1519xJfoeem6Ttthp5zCfIhwn4F379/HbMJP5Rtw088BLXg7BjU9vdhkc
	 WHzh2RSaAkqLQ==
Message-ID: <7f38151b-9c9a-42d0-98b8-345c4513a8d1@kernel.org>
Date: Fri, 9 Aug 2024 15:01:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>, Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 8:42 AM, Alice Ryhl wrote:
> Dash has ascii value 45 and underscore has ascii value 95, so to
> correctly sort the includes, the underscore should be last.
> 
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

I don't think this patch needs a "Fixes" tag, it's usually for bugs only.

But it still makes sense to mention the commit that introduced the include
in the commit message.

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Generally speaking, unless minor style issues cause compiler or linter warnings,
I think it's better to leave them alone in favor of not messing with git-blame.

In this case we're not hiding something relevant though, hence

Acked-by: Danilo Krummrich <dakr@kernel.org>

> ---
>   rust/bindings/bindings_helper.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index b940a5777330..ae82e9c941af 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,8 +7,8 @@
>    */
>   
>   #include <kunit/test.h>
> -#include <linux/blk_types.h>
>   #include <linux/blk-mq.h>
> +#include <linux/blk_types.h>
>   #include <linux/blkdev.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
