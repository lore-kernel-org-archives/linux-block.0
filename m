Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A62248B0;
	Tue,  5 Aug 2025 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431405; cv=none; b=bJ1HuGOeorUoD62TIVWNvECNqHbwoeRBsEDWEkPaDIlFfZfq6WnOsJCcbEwHbXwkQumF8zyaB+3MtqGDU9mSJ92YmCd7IXKLLonE+Z0/EN2Q7BlHEuhxAzpg/WqTax2aLeN/QB4b+aED1GnPURc99S2rPGDmVNkEW6wxRAEEyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431405; c=relaxed/simple;
	bh=yBM2AB2FLCmQ2F8GkMMvqGFnvCukcNMZSzX4iOqkSmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RnBIUlK2Q6NjTP9VmHfGcjUVSh5W9HD6DA08F64rxt7F0o1G1aktZE4VYyQDAv+s0NVgcx7i/S5RG34DBzgF/qrZs9sThC77DFszE7+1cFjaLu/JBv5EAcIZ2Q6vSVNnvkhzNx1bXMOODZvftb7EgVDCQcTqYdetL6NVBvjbh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DHP/X8YB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DHP/X8YB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF097C4CEF0;
	Tue,  5 Aug 2025 22:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754431403;
	bh=yBM2AB2FLCmQ2F8GkMMvqGFnvCukcNMZSzX4iOqkSmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHP/X8YBD9Ic6PfRME78TfYo7hzQdJkZDUaPZ24lFIwd0nKELpsZ/9W5G3joIyzSk
	 5245bOUQfN64JvPbdS1kj6GesfW5lc3RTxXzvRIdlxxgvjmWh8i1BbhC8KFZ/PFQa/
	 /KjRAI3sqdSOKsAxqw/cd8myd67X8YVJk5s3PYAY=
Date: Tue, 5 Aug 2025 15:03:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Seyediman
 Seyedarab <imandevel@gmail.com>
Subject: Re: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Message-Id: <20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>
In-Reply-To: <20250805101946.1774112-1-senozhatsky@chromium.org>
References: <20250805101946.1774112-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Aug 2025 19:19:29 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> sysfs handlers should be called under ->init_lock and are not
> supposed to unlock it until return, otherwise e.g. a concurrent
> reset() can occur.  There is one handler that breaks that rule:
> recomp_algorithm_show().
> 
> Move ->init_lock handling outside of __comp_algorithm_show()
> (also drop it and call zcomp_available_show() directly) so that
> the entire recomp_algorithm_show() loop is protected by the
> lock, as opposed to protecting individual iterations.

As always, I'm wondering "does -stable need this".  But without knowing
the runtime effects of the bug, I cannot know.

Providing this info in the changelog would answer this for everyone, please.

> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reported-by: Seyediman Seyedarab <imandevel@gmail.com>

And including a Closes: for Seyediman's report (if it's publicly
linkable) would be great too, thanks.

I'm guessing that a Fixes: isn't appropriate here because the
bug has been there since day 1.
