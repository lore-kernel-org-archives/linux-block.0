Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C923EAB3
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976924; cv=none; b=Bh87O2dwtBU95qIUwu4DUeNO2kobLef43mfPi/2zfhZkKtgypFKhyfUkDZAxNjtmfuAiTFLvvt/xgiofE3ucSWk9QlEU6tmueFQNe9SlYtof0ElspkVoyvy7XD+dB86C2S+fOcf7H3529ZijMp/6C3fY18EGEJwAK9m4yzPE0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976924; c=relaxed/simple;
	bh=tNvWcRoPqJmADdDuPWkDyH/P9AXSfH8VPQdU3mljt+A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/Q0JTk/I5drP7R7enGQWCa6jQ6JAFDo/g6XSUe1wJm3RHWeZPaYLnj2314tPNqIrQzxqSuZZYkLXWFFxcKx+UM6RZ8ElMIM44IMPaxOgYa3SFBX+uVOQiv9zQ0d0olYP+6Ki/rm3RNSq23C6QlGtwALYaLxCs1dy1fzauI1Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=liSR0cAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="liSR0cAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF34C19424;
	Fri, 20 Mar 2026 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773976924;
	bh=tNvWcRoPqJmADdDuPWkDyH/P9AXSfH8VPQdU3mljt+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=liSR0cANMTwkDMdoW2FjbpUZyrAwXp0H7o39UOLvlz5l7mbord9p9g8vzASgXFXwv
	 VkeS2vwN2zmY9Ew/2dOjyqcbOXKC1yHeFyp9mmdPLEmS9HqQ9ofT3qeeqlfZPZAuRB
	 7vuEtGjVkgN2RvYYb9ab8BrhOL2IOBrvRgDgOva8=
Date: Thu, 19 Mar 2026 20:22:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
 Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] zram: do not slot_free() written-back slots
Message-Id: <20260319202203.710aa4a4c111f12f802e425e@linux-foundation.org>
In-Reply-To: <20260320023143.2372879-1-senozhatsky@chromium.org>
References: <20260320023143.2372879-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 11:31:31 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> v1 - >v2:
> - Updated commit message.

thanks, I lazily updated v1.
