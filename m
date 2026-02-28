Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD0430B99;
	Sat, 28 Feb 2026 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309117; cv=none; b=qKIKNpMYaikzUClKB1hMQtFUW2dcgXLytS0F9vyBLZgCXDKagpMS8U1B9zR+Fz6px/06KvGG3kLsYvSyjrJ0VgMGeCetIVHTimipZbztdJnqg6lbtkdhtdc8UL/+apKQQ9OifZdzwuJoYnWL2vw2N8VEEbO9QRvoxsg5RZ44F60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309117; c=relaxed/simple;
	bh=yAzpckg+/nraiNZj/hjeJPRvDIkg3E8fCM1z7tnwQJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DSECL4ncKxJ+JxQ5OUCCLWj5kAM/6AEsBkYp2mW2odNqN7QMaEHcEYC9frSKQjYxmGpqvu7pAU6tNLBGH4Wg5Mlj+UdBD0BpuOdOlCWeDpJrGBBizA0JO8eDOyWa4o4voif8AI/7tqbLncXHOnyB3pLOe2ZO9cJCK79HYI9xkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aAF3ulMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aAF3ulMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DFEC19423;
	Sat, 28 Feb 2026 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772309117;
	bh=yAzpckg+/nraiNZj/hjeJPRvDIkg3E8fCM1z7tnwQJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAF3ulMeOoKPIs13NZj80nOWPj2MQSAWuRgFnXpmnS0zWc+FNOKK3A2pdi/hQShu7
	 mfAek3HflaUutbGk2VU+pJYepH/YYpSfAfZXdZsj7XX5B+vE4MpHLuGrYiZEAvFBCm
	 RgRarKWKmFe1lL4+7ulHulg0a2CyTtNU+BgY9Qrk=
Date: Sat, 28 Feb 2026 12:05:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, Brian Geffon
 <bgeffon@google.com>
Subject: Re: [PATCH 1/5] zram: do not autocorrect bad recompression
 parameters
Message-Id: <20260228120516.e5323a704d4a26bda041dd4e@linux-foundation.org>
In-Reply-To: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 17:21:07 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>

A nice [0/N] overview would be appropriate for a 5-patch series, please.

> Do not silently autocorrect bad recompression priority
> parameter value and just error out.

What are the reasons for this change?


