Return-Path: <SRS0=q5lJ=7T=goodmis.org=rostedt@kernel.org>
Date: Thu, 17 Aug 2017 17:30:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>, "J.
 Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
Message-ID: <20170817173004.263d2891@gandalf.local.home>
In-Reply-To: <20170817171007.1ab33b8f@gandalf.local.home>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
	<20170817171007.1ab33b8f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 17 Aug 2017 17:10:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> Instead of playing games with taking the lock, the only way this race
> is hit, is if the partition is being deleted and the sysfs attribute is
> being read at the same time, correct? In that case, just return
> -ENODEV, and be done with it.

Nevermind that wont work. Too bad there's not a mutex_lock_timeout()
that we could use in a loop. It would solve the issue of forward
progress with RT tasks, and will break after a timeout in case of
deadlock.

-- Steve
