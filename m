Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4502FB6;
	Tue, 10 Sep 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927740; cv=none; b=d/yS0G3yEOV45Ibhg3wpHbqEctq0XS86CMuloo+HDyVJDmLlrF7LSrIQIswf+O3jayFpMkoz3G+DfU+HMdH2s++JjmzUY8g+Vqvm1voJdGhq41Px21+9L2W4W4jkpL1WErGNTC6dOvJNT4wndSiDlOu23T/mu1hsKwmVnyurQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927740; c=relaxed/simple;
	bh=fhFX+DOHOqvL8dcXEVkQv1gYzdBPaSCIh9OdMv6ptfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtqkH64U4ndqkEhgziTVICdhUES8nZobgttMf9f3/Z1o7x6Y/g/zNIxKxyEEEnwnzdn9mxYbu8flq+MPKELms44+rJ/qafR82V7hqorbRrae/vGBqoYYO4c0sYN+XcBspGTa2XLe56teoSK6Cbs27rSYv95UiUEeyaTnifN2w+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E5C4CEC6;
	Tue, 10 Sep 2024 00:22:19 +0000 (UTC)
Date: Mon, 9 Sep 2024 20:22:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: syzbot <syzbot+list692d096cfc0c03673c30@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (Sep 2024)
Message-ID: <20240909202218.6edb3d4a@gandalf.local.home>
In-Reply-To: <20240910001512.f604fd970f2be1ef6e7f9189@kernel.org>
References: <000000000000e69f460621ab50f4@google.com>
	<20240910001512.f604fd970f2be1ef6e7f9189@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 00:15:12 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > <3> 31      Yes   INFO: task hung in blk_trace_ioctl (4)
> >                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c  
> 
> This is a bug in blk_trace.

[..]

> 
> > <5> 11      Yes   WARNING in get_probe_ref
> >                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160  
> 
> This is a bug in blk_trace.
> 
> It seems blk_trace does not check input parameters of ioctl correctly.

Added blk_trace maintainer and list to the Cc.

-- Steve
