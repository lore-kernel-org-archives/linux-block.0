Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64D194C71;
	Fri,  9 Aug 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211255; cv=none; b=Ad5Rk6xlwUU67vzFLg5sixujhbDRDKfpVbE6+5h7Mn6bogIZAwZ5mKMTiiFpk+SZzDeAMDjBE2knlVmoI4lab44/m/57EGa0Ar4yjbSxot2ec9zimBCNAhiV2bXzNXKX2ZayPiqpAN1e+1XVeoZzjatVGJ9AbRRHEpe+S5iieJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211255; c=relaxed/simple;
	bh=1MNJWhIzWODom2Tz5QaO1dr/NQqjqMgDi67m5KLkaEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVrmBHJx7c0f4vcNebsLwiiQB3+nbWbirEkUp9LJpVAVAVj+UkkuexFkvv9qdAttq017el5WhoYKDWOVFzdC2pFSctWU2Wp6hZDJcJPuKxTTjsR1OLi5OORhPAJZhQO5h0duv0fZF+YSgQhAPKTZpWVZnNEWe6VYTzGbrbAKayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcPjEuar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcPjEuar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4895C32782;
	Fri,  9 Aug 2024 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723211255;
	bh=1MNJWhIzWODom2Tz5QaO1dr/NQqjqMgDi67m5KLkaEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcPjEuar40BDRSWM1Lx39kr6krQfsrxy2hEMPXEIaoGQUQawCDsoSSpv22cWtmcOq
	 eJsJU5pNwkcNHZg6V4udUt6b9xIm9rYhlITqNJQSRwmrbL491IOrL6uP54Lm9KYgGj
	 1XlJk1LuhfPZt/Mr137S+m+CK9Br9cAAj/otWn9wGRq19BlWt0Y5Anb3rQ+YeEYvam
	 +5Y/luzFScMNCLawhTk8vS0+hS2STN6DIz5sB4suZsaV2HUiWtU1t3NZ83Pje96lA7
	 qyPORTvCb0VpFIjsI0htTMCmKlPi+WFNISkAvag12wyMclTx8WQpKN8O72u6Rd7fob
	 PpAWA8/vaUkmA==
Message-ID: <016a42a2-c57c-48e2-b53e-fa99b8596399@kernel.org>
Date: Fri, 9 Aug 2024 15:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: sort blk includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809132835.274603-1-aliceryhl@google.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20240809132835.274603-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 3:28 PM, Alice Ryhl wrote:
> The headers in this file are sorted alphabetically, which makes it
> easy to quickly resolve conflicts by selecting all of the headers and
> invoking :'<,'>sort to sort them. To keep this technique to resolve
> conflicts working, also apply sorting to symbols that are not letters.
> 
> This file is very prone to merge conflicts, so I think keeping conflict
> resolution really easy is more important than not messing with git blame
> history.
> 
> These includes were originally introduced in commit 3253aba3408a ("rust:
> block: introduce `kernel::block::mq` module").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Now as before, feel free to add

Acked-by: Danilo Krummrich <dakr@kernel.org>

> ---
> Changes since v1:
> - Reword commit message.
> 
> v1: https://lore.kernel.org/r/20240809064222.3527881-1-aliceryhl@google.com
> 
>   rust/bindings/bindings_helper.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index b940a5777330..ae82e9c941af 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,9 +6,9 @@
>    * Sorted alphabetically.
>    */
>   
>   #include <kunit/test.h>
> -#include <linux/blk_types.h>
>   #include <linux/blk-mq.h>
> +#include <linux/blk_types.h>
>   #include <linux/blkdev.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
> 
> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
