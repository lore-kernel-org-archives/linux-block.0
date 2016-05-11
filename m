Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57689 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562AbcEKNrM (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 09:47:12 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shaohua Li <shli@fb.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't enabled
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
	<b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
	<x49a8jx7vww.fsf@segfault.boston.devel.redhat.com>
	<20160510193345.6243a503@gandalf.local.home>
Date: Wed, 11 May 2016 09:47:09 -0400
In-Reply-To: <20160510193345.6243a503@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 10 May 2016 19:33:45 -0400")
Message-ID: <x4960ukogf6.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

>> Do we want to return !!(bt->act_mask & BLK_TC_NOTIFY)?
>
> The return type is bool. I would think that gcc would be smart enough
> to make the conversion.
>
> To check, I compiled the following function:
>
> bool testbool(int x)
> {
>         return x & 1<<3;
> }
>
> and the result was:
>
>
> 0000000000000000 <testbool>:
>    0:   55                      push   %rbp
>    1:   48 89 e5                mov    %rsp,%rbp
>    4:   89 7d fc                mov    %edi,-0x4(%rbp)
>    7:   8b 45 fc                mov    -0x4(%rbp),%eax
>    a:   83 e0 08                and    $0x8,%eax
>    d:   85 c0                   test   %eax,%eax
>    f:   0f 95 c0                setne  %al
>   12:   5d                      pop    %rbp
>   13:   c3                      retq   
>
> I get the same by adding !!(x & 1<<3)
>
> Looks like it does the conversion.

Cool, thanks!

-Jeff
