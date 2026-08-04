Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E54A3411;
	Tue,  4 Aug 2026 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873331; cv=none; b=sda79S1MOMw3TmbAI+XEgqMFEolWqrOrMgD767/ANXzH4hIJOKEwefkXgqY2hDnprY8+c8GvnHNfrpElra0l/9tpVgLPrgnrYwgd7ZtSoOjsEyEQJOraFyvr/B9EeSuGv0h+XjfbJVkWp652EJOl9+Ewm3fO+yGLQ9sf8AeiZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873331; c=relaxed/simple;
	bh=lDuUMQTbW9PRQQeybOwZCSnnT506NF+OPFkR1I56pb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sVITh8zQSJkoH6VO5FccD1OsA3uilemCYxF5VptYoWMHfukFcnn9J9i5WoBVjnaMCCEDgaeFmDhUuCIuKddSK/W2TgXkkigH+LQpcFRMVCeOG0P4JVnZM/IalOSFVaPbWVlvTJftCCt3JADzsyLtlsmVPynVljd316Wub2+yx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g8j/Ludm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g8j/Ludm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AAB1F000E9;
	Tue,  4 Aug 2026 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785873330;
	bh=oslWyb5iJtG7i9WrbcI+LJJtiRjeVRUq5jFsai//xKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g8j/Ludm7rq5c+8S0rLys1kGBCOd4Epx0+UO6ybYaVE7DVtYM+xzv7E3r/u+8p5HR
	 tw2Kngoqy+XiMGizHF4ck6C5HeThNNEkpoBV5+BgiMjZeOveI1BumE7tZykSaQjaD9
	 OL1oyJcDPpy7rg8OvUf4gmPBXpgsAzFkZaL0HEO0=
Date: Tue, 4 Aug 2026 12:55:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell
 <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Haoqin Huang
 <haoqinhuang@tencent.com>
Subject: Re: [PATCH v6 0/5] zram: fix zstd error paths and add parameter
 validation
Message-Id: <20260804125529.0f905e23176cc07fbbb32261@linux-foundation.org>
In-Reply-To: <20260804093841.67920-1-haoqinhuang7@gmail.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
	<20260804093841.67920-1-haoqinhuang7@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 17:38:36 +0800 Haoqin Huang <haoqinhuang7@gmail.com> wrote:

> Patch 1 removes zstd_release_params() from both zstd_create() and
> zstd_setup_params() error paths -- the former is a layering violation
> in a per-CPU callback, the latter is redundant as zcomp_init() already
> calls release_params() on setup failure.
> 
> Patch 2 rejects zero-size dictionaries and prints distinct error
> messages for sz < 0 (returns the original error code) and sz == 0
> ("empty file"). Currently errors are silently swallowed.
> 
> Patch 3 adds pr_fmt to each backend file so that pr_err() messages
> are auto-prefixed with the algorithm name.
> 
> Patch 4 validates dict and level parameters in each backend's
> .setup_params(), rejecting unsupported combinations and out-of-range
> levels.
> 
> Patch 5 resets per-priority params on algorithm change before init.
> 

Thanks.  AI review pointed at a few things, most of them pre-existing:
	https://sashiko.dev/#/patchset/20260804093841.67920-1-haoqinhuang7@gmail.com
