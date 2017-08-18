Return-Path: <SRS0=rtO5=7U=goodmis.org=rostedt@kernel.org>
Date: Fri, 18 Aug 2017 13:26:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "longman@redhat.com" <longman@redhat.com>, "bfields@fieldses.org"
 <bfields@fieldses.org>, "mingo@kernel.org" <mingo@kernel.org>,
 "jlayton@poochiereds.net" <jlayton@poochiereds.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170818132602.68a104e5@gandalf.local.home>
In-Reply-To: <1503073304.2622.5.camel@wdc.com>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
	<20170817171007.1ab33b8f@gandalf.local.home>
	<20170817173004.263d2891@gandalf.local.home>
	<5a5d0743-d2db-89c8-59cc-542835baeccf@redhat.com>
	<1503073304.2622.5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 18 Aug 2017 16:21:46 +0000
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> Sorry Waiman but personally I thoroughly detest loops around mutex_trylock() or
> mutex_timed_lock() because such loops are usually used to paper over a problem
> instead of fixing the root cause.

100% agree.

-- Steve
