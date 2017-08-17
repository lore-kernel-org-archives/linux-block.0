Return-Path: <SRS0=q5lJ=7T=goodmis.org=rostedt@kernel.org>
Date: Thu, 17 Aug 2017 16:56:52 -0400
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
Message-ID: <20170817165652.5eeca878@gandalf.local.home>
In-Reply-To: <1503002469.2615.13.camel@wdc.com>
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
	<20170817093444.3276f7ab@gandalf.local.home>
	<b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
	<20170817163056.19ea42c8@gandalf.local.home>
	<1503002469.2615.13.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 17 Aug 2017 20:41:10 +0000
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> On Thu, 2017-08-17 at 16:30 -0400, Steven Rostedt wrote:
> > On Thu, 17 Aug 2017 12:24:39 -0400
> > Waiman Long <longman@redhat.com> wrote:
> >   
> > > On 08/17/2017 09:34 AM, Steven Rostedt wrote:  
> > > > On Wed, 16 Aug 2017 16:40:40 -0400
> > > > Waiman Long <longman@redhat.com> wrote:
> > > >    
> > > > > The lockdep code had reported the following unsafe locking scenario:
> > > > > 
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
> > > > >   lock(s_active#228);
> > > > >                                lock(&bdev->bd_mutex/1);
> > > > >                                lock(s_active#228);
> > > > >   lock(&bdev->bd_mutex);    
> > > > 
> > > > Can you show the exact locations of these locks. I have no idea where
> > > > this "s_active" is.    
> > > 
> > > The s_active isn't an actual lock. It is a reference count (kn->count)
> > > on the sysfs (kernfs) file. Removal of a sysfs file, however, require
> > > a wait until all the references are gone. The reference count is
> > > treated like a rwsem using lockdep instrumentation code.  
> > 
> > Which kernel is this? I don't see any lockdep annotation around
> > kn->count (doing a git grep, I find it referenced in fs/kernfs/dir.c)  
> 
> As far as I know the s_active lockdep annotations were introduced in 2007
> through commit 0ab66088c855 ("sysfs: implement sysfs_dirent active reference
> and immediate disconnect"). Today these annotations exist in kernfs:
> $ git grep -nHw dep_map fs/kernfs
> fs/kernfs/dir.c:421:		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
> fs/kernfs/dir.c:441:		rwsem_release(&kn->dep_map, 1, _RET_IP_);
> fs/kernfs/dir.c:468:		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
> fs/kernfs/dir.c:470:			lock_contended(&kn->dep_map, _RET_IP_);
> fs/kernfs/dir.c:478:		lock_acquired(&kn->dep_map, _RET_IP_);
> fs/kernfs/dir.c:479:		rwsem_release(&kn->dep_map, 1, _RET_IP_);
> fs/kernfs/dir.c:1385:		rwsem_acquire(&kn->dep_map, 0, 1, _RET_IP_);
> fs/kernfs/file.c:1000:		lockdep_init_map(&kn->dep_map, "s_active", key, 0);
> 

Ah thanks. I was searching for the wrong thing. :-/

-- Steve
