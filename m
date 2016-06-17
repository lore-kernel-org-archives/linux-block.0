Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blktrace: avoid using timespec
To: Steven Rostedt <rostedt@goodmis.org>
References: <20160617145849.3771756-1-arnd@arndb.de>
 <20160617113648.69448c9f@gandalf.local.home>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
 y2038@lists.linaro.org, Hannes Reinecke <hare@suse.com>,
 Mike Christie <mchristi@redhat.com>, Shaohua Li <shli@fb.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57646E09.9080408@kernel.dk>
Date: Fri, 17 Jun 2016 23:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <20160617113648.69448c9f@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/17/2016 05:36 PM, Steven Rostedt wrote:
>
> Jens,
>
> You want to take this, or do you want me to?

I'll add it to my 4.8 tree, thanks Arnd.

-- 
Jens Axboe
