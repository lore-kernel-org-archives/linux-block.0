Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbcEJPpu (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 11:45:50 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Shaohua Li <shli@fb.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 2/3] blktrace: add missed mask name
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
	<ea5ffed7a013bf524d3576cdff8ad00d11a68bf2.1462838969.git.shli@fb.com>
Date: Tue, 10 May 2016 11:45:47 -0400
In-Reply-To: <ea5ffed7a013bf524d3576cdff8ad00d11a68bf2.1462838969.git.shli@fb.com>
	(Shaohua Li's message of "Mon, 9 May 2016 17:22:14 -0700")
Message-ID: <x49eg997w7o.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Shaohua Li <shli@fb.com> writes:

> BLK_TC_NOTIFY is missed in mask_maps, so we can't print out notify or
> set mask with 'notify' name.

For the text-based interface, yeah.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  kernel/trace/blktrace.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8ae9ea2..9aef865 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1552,6 +1552,7 @@ static const struct {
>  	{ BLK_TC_COMPLETE,	"complete"	},
>  	{ BLK_TC_FS,		"fs"		},
>  	{ BLK_TC_PC,		"pc"		},
> +	{ BLK_TC_NOTIFY,	"notify"	},
>  	{ BLK_TC_AHEAD,		"ahead"		},
>  	{ BLK_TC_META,		"meta"		},
>  	{ BLK_TC_DISCARD,	"discard"	},
