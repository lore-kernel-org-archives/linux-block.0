Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A82381AD;
	Mon,  8 Apr 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616072; cv=none; b=mKOIp4M3opmCBEE6VU6ex8VJ7aNE7SqM2IPTsJyPgUydlZdxgY9iMrv+9VCKFcHAMvLyiMJ8r88un1OGPirceHmRd4hUnnMcFWaxZdws6sv/vKvNm1HJeHNCfjGtv4yvpfNkVb6LbM5niQzJnnO0uN1px1gFVzGO2xGJnfndPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616072; c=relaxed/simple;
	bh=uq+iuZWFJeFjkBxY9LAE5aFyS6mStouA09bvmO1Xduk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwl0glV8XOqkOT7OpFkq9iwQ5Z7KPOvWpLE87rqFaoZ6qk8BZp03wjNSFDQr5uRrbRMf+NnLF8v9TFllhmPk9eg1bMcdIWUtBqzUer9MZ3guW4QW2GubZu3tc29goa/9NiYKy1urbt63m+OH3GoUcVzrN4obDcURGvXEgZhgZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEKHOMvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEKHOMvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5515EC433C7;
	Mon,  8 Apr 2024 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712616071;
	bh=uq+iuZWFJeFjkBxY9LAE5aFyS6mStouA09bvmO1Xduk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEKHOMvYUum8eYAsZcQaVxVMVx/WPybI5+LjUwRKgwoGCBYs2NiqfITsfLF4GRg3j
	 jWAR4EygzbUY1QA4UGSEzrD+NJ6/z62iXMf84eFyoIS+Thhla8Yi+U3Z02J9Bj+Uge
	 RF9hQnEgU0PJu6lTl+lgJPX/X3rs0ZLPJ5QueHi9EE5pyMmB7NT4WZAB5SX2q+ULcV
	 vTy6EpqL/qEXpdlP/DlBG+fQJC6UYxv34rGaPThX9gPCrGxclzl7mZIZq/Z8LZlnMY
	 yq0NU0O/sj12i9qFtSaVeJkpHzU9X7+c7nVKNzaQFO2nGtUQtBOsx1ps4hy16VHp3x
	 lclfJetttHdaw==
Date: Mon, 8 Apr 2024 16:41:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhRSVSmNmb_IjCCH@gardel-login>

On Mon, Apr 08, 2024 at 10:23:49PM +0200, Lennart Poettering wrote:
> Not sure how this is salvageable. This is just seriously fucked
> up. What now?
>
> It has been proposed to use the "range_ext" sysfs attr instead as a
> hint if partition scanning is available or not. But it's entirely
> undocumented. Is this something that will remain stable? (I mean,
> whether something is documented or not apparently has no effect on the
> stability of an API anyway, so I guess it's equally shaky as the
> capability sysattr? Is any of the block device sysfs interfaces
> actually stable or can they change any time?)

The "ext_range" attribute does look like an appropriate proxy for the
attribute, but indeed, it's not well documented.

Looking at the history of the documentation you had been relying on, it
appears that was submitted with good intentions (9243c6f3e012a92d), but
it itself changed values, acknowledging the instability of this
interface.

So what to do? If documentation is all that's preventing "ext_range"
from replacing you're previous usage, then let's add it in the
Documentation/ABI/stable/sysfs-block. It's been there since 2008, so
that seems like a reliable attribute to put there.
