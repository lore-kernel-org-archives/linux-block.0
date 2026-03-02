Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE24219F4;
	Mon,  2 Mar 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467144; cv=none; b=A7nhRRrU3FVGubEtzcx/aWyOYdM1EDVaJi3DBiPGQa4uNhC/Hu4W1gLWYYkAxW98fHphyuHyQzsrwq/Apud6+07mgcEW6sNxLYdA7/uMMikFux67kA5aK/xH/mkSW4Zrh0F/5bUhtno3P/0m0kzKilppjQr/Vd4v8E9tUteliEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467144; c=relaxed/simple;
	bh=hbv8TFwB+VvUkN+TGc+AsYyEUXbEg9n5W9mHnasaK3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BILV3cyBzzclV2U2G7G4nqPfsDCaoZjM2ycQmsHkihsaMNXGNEqwe5jTPOkKq828mZ9+2ayA0AwyiFhdwcImjlV7XbxC4UUsxchBKX3MQDpdLRcLQoiNNIvJfu7vmnvJlCtIdlcAeGKIFjdxKSNueNiUUEyR24oGewe8DQ9fiQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 318DDC06DC;
	Mon,  2 Mar 2026 15:59:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3ECE517;
	Mon,  2 Mar 2026 15:58:59 +0000 (UTC)
Date: Mon, 2 Mar 2026 10:59:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: <axboe@kernel.dk>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shinichiro.kawasaki@wdc.com>,
 <linux-block@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible
 context
Message-ID: <20260302105930.5d5a55d7@gandalf.local.home>
In-Reply-To: <20260302002207.12165-1-kch@nvidia.com>
References: <20260302002207.12165-1-kch@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wxo1ughsotswcrw7t6sts8n7rygzd3br
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3ECE517
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18OZbLZE7x/Moaaj1vj0lVnk/q1EiBdNcM=
X-HE-Tag: 1772467139-301120
X-HE-Meta: U2FsdGVkX196L891LQlrBDnIlVPgPHKqRY0BK6G3M0x4k1ENQtTZELYHkg2BEWdKl0+z2JUly6m5Ogag+qjghP7GrmjsMd3DTXmlR/7IKOt9Ac7siEEqcCP69XFPpic2W6QXb1UpXCRVvZ/ALv2/kWT46AilFuo5jen5hPniP2VOocyJ1PIn9F7/VhBfXgPhBKgdik5fgto1KSIfuVeFkU2LExNj+6ZRPvVZ167T6P+1eEdhQYZH0oX1VR1eYjoBO8AiZYfZLv3AklCueg2ENsT5x22WPCD/d1pDWZEsEpGw2+yZM00NzsDOVAPqthuTU3O1NLGSa2uiEcAw0TgGSu5DTHyClFa9RJfgQOLTIENlZ3AQAA8xmxVBEx7jWEVZV/CUiMDVaSZlq5rY6joBzzgWX/ZI7RQNQqMksv3aGnKngoDoNHQl0tlPEcE8YUUgyMWtiH7sXby58jJk0ALoWA==

On Sun, 1 Mar 2026 16:22:07 -0800
Chaitanya Kulkarni <kch@nvidia.com> wrote:

> With this fix blktests for blktrace pass:
> 
>   blktests (master) # ./check blktrace
>   blktrace/001 (blktrace zone management command tracing)      [passed]
>       runtime  3.650s  ...  3.647s
>   blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
>       runtime  0.411s  ...  0.384s
> 
> Fixes: 7ffbd48d5cab ("tracing: Cache comms only after an event occurred")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
