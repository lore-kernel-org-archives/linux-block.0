Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083021B9C2;
	Fri, 23 May 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967986; cv=none; b=dpre4YAuE4KxcUzIjwKBqHnprTFjCT+C/O5wM0h/4YF2hY0ybvLNTwFda93wdDLOJLUC+i5/BQLQJrqRhOpaMC3diIon1BTloqr1/DRsoOJQdO4gdLSJDut5pp3BZ1row0Psmv+mcBCOyevM/XZne/NM7sbtbtnKf5fCoeJDT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967986; c=relaxed/simple;
	bh=H8/wjXRVTuirlqKTBTuysDlyjNJhoKFrI6uQDrksrSw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GFYbjeOc5PP5levHgbLzjue2U8BBbrOBxTrqniWyi0WZZJceZ9JVmM4Sj4la+LlMEX7JlN0nBfW+g4NxSMrZLBYgRHhz4WrtsvV7amJxAD35rFVRJx4eVvL3qnnddzbHvvqtWgdM5gGgkwCn1oF3qHgk4BPcbHSp89LWqpZNlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/wnbW4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/wnbW4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BF2C4CEE4;
	Fri, 23 May 2025 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747967986;
	bh=H8/wjXRVTuirlqKTBTuysDlyjNJhoKFrI6uQDrksrSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/wnbW4/q5rgwudMS2+ZRCEpCEMwCFMCy5GZpTDXDMS5NCjgjmusX00JHvNu4+HHf
	 5DLO5RamEjxjXb285bOErRFDFuzYTfDM9B8E889B+0BtPTVMLmvQCq+m6lern6f5R4
	 iLEYm9PHzG+dsWWp3xjQsPhoebwNRLthBkYCl5ilMjV/JumAXmMdPviXdgxBvxocaC
	 DZ0CnCMbMfdizUMBVyJiWYsO84V/oTHFSET8+CpbtGNGEkJVByhz4oVw19rdxMlKPL
	 BTvPY3PjDgaXkQpDFDKcOiFWfvu5UD5+++iBItkgX/Um3o8A84VS72JIo2bqqylcaW
	 LlYNcCEVHYYhQ==
Date: Fri, 23 May 2025 11:39:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH v3 0/4] relayfs: misc changes
Message-Id: <20250523113943.8739b65347b3ccacdea7e4c2@kernel.org>
In-Reply-To: <20250518025734.61479-1-kerneljasonxing@gmail.com>
References: <20250518025734.61479-1-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 May 2025 10:57:30 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> The series mostly focuses on the error counters which helps every user
> debug their own kernel module.
> 

The series looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> Note: this series is made on top of this cleanup[1] and unmerged commit[2]
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
> [2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/
> 
> Jason Xing (4):
>   relayfs: support a counter tracking if per-cpu buffers is full
>   relayfs: introduce getting relayfs statistics function
>   blktrace: use rbuf->stats.full as a drop indicator in relayfs
>   relayfs: support a counter tracking if data is too big to write
> 
>  include/linux/relay.h   | 19 ++++++++++++++-
>  kernel/relay.c          | 52 +++++++++++++++++++++++++++++++++++------
>  kernel/trace/blktrace.c | 22 ++---------------
>  3 files changed, 65 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
