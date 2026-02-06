Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522E3093A6;
	Fri,  6 Feb 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409476; cv=none; b=lkcDKktx5TajYhyPs8CBA8c9iokRaCasPfHqfpXBKo3aiPFa5fcmNh3QWOLNbIHbHqO0ESuTY+TOXoZkmghxS+5wybRmsJ8UHUtwpwmkX2CVCYFlRv3adDQEHJwPe526OL7ht1dBUwvtDq6dt0w739CO4xIDOSjOcPekc2PBRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409476; c=relaxed/simple;
	bh=n/iTIQYM/a6Wvm2n/dE4h+iuqiMFAw+ik1llocMg9iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoYHT7xJ87xZla8x9K5aQKZMe42zn21Skniw1OBd8LUZHC5/CyMId+aKEdRAkC3a1OdgfX+/81pI/rOzmgFsc8NtneCwnJ6pHEVOcEGQicbs2UQwarqFbFma4yg5qrtWw7yLa2SEE8wzOK9ceB40+Y3y4QgL2vWgG/Co+xi3/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3FB488AF65;
	Fri,  6 Feb 2026 20:24:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 5F4C92000D;
	Fri,  6 Feb 2026 20:24:33 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:25:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, axboe@kernel.dk,
 mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Tracing: Accelerate Kernel Boot by
 Asynchronizing
Message-ID: <20260206152511.41782db1@gandalf.local.home>
In-Reply-To: <20260204191552.881a00764093cf63557a372a@kernel.org>
References: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
	<20260204191552.881a00764093cf63557a372a@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rgbuu136u5j54e4ejayn6yep3htcste8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5F4C92000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19MgqobEkL2eHN6yLa46iwgbi3ESEYUeNw=
X-HE-Tag: 1770409473-486381
X-HE-Meta: U2FsdGVkX1/G98fef1wedSk353HdnHXfFHQLpLyFPARccYyT+0YMdmwz9NpXg6PlqA4uL35wQq1AaLHV+ljkkWBMpCkfGm75zRvgk5vrDqFfIf2RLqC8R9N9koYpMpuKj5BGXSIx23tdytTYC0FC18CdwXp8LKhZo/y6KJ5FFov1T1QJJK6xravpnQ1POsklLyoIlNRkIz5ei3XP933y4OC9FxACyWk5i6ID9gN//Q/jsvy1pLC9JxayoYKEC+WpMcCfPwPjSP6mijoegBbOvYQGtJsPIRJ6rlhjrtnftzk4d00DvFpZ93BXWysfoysWYWXKYjoXShJjiDVBgEPeBauCoXxw43m1fmoFhFeqizTc5J+XYy83lA==

On Wed, 4 Feb 2026 19:15:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, I'll add this to tracing/core.

-- Steve
