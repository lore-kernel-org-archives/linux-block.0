Return-Path: <tytso@thunk.org>
Date: Mon, 6 Jun 2016 09:35:39 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: "Barczak, Mariusz" <mariusz.barczak@intel.com>
Cc: Andreas Dilger <adilger@dilger.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wysoczanski, Michal" <michal.wysoczanski@intel.com>,
	"Baldyga, Robert" <robert.baldyga@intel.com>,
	"Roman, Agnieszka" <agnieszka.roman@intel.com>
Subject: Re: [BUG] Possible silent data corruption in filesystems/page cache
Message-ID: <20160606133539.GE22108@thunk.org>
References: <842E055448A75D44BEB94DEB9E5166E91877AAF1@irsmsx110.ger.corp.intel.com>
 <A9F4ECA5-24EF-4785-BC8B-ECFE63F9B026@dilger.ca>
 <842E055448A75D44BEB94DEB9E5166E91877C26F@irsmsx110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <842E055448A75D44BEB94DEB9E5166E91877C26F@irsmsx110.ger.corp.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 06, 2016 at 07:29:42AM +0000, Barczak, Mariusz wrote:
> Hi, Let me elaborate problem in detail. 
> 
> For buffered IO data are copied into memory pages. For this case,
> the write IO is not submitted (generally). In the background opportunistic
> cleaning of dirty pages takes place and IO is generated to the
> device. An IO error is observed on this path and application
> is not informed about this. Summarizing flushing of dirty page fails.
> And probably, this page is dropped but in fact it should not be.
> So if above situation happens between application write and sync
> then no error is reported. In addition after some time, when the
> application reads the same LBA on which IO error occurred, old data
> content is fetched.

The application will be informed about it if it asks --- if it calls
fsync(), the I/O will be forced and if there is an error it will be
returned to the user.  But if the user has not asked, there is no way
for the user space to know that there is a problem --- for that
matter, it may have exited already by the time we do the buffered
writeback, so there may be nobody to inform.

If the error hapepns between the write and sync, then the address
space mapping's AS_EIO bit will be set.  (See filemap_check_errors()
and do a git grep on AS_EIO.)  So the user will be informed when they
call fsync(2).

The problem with simply not dropping the page is that if we do that,
the page will never be cleaned, and in the worst case, this can lead
to memory exhaustion.  Consider the case where a user is writing huge
numbers of pages, (e.g., dd if=/dev/zero
of=/dev/device-that-will-go-away) if the page is never dropped, then
the memory will never go away.

In other words, the current behavior was carefully considered, and
deliberately chosen as the best design.

The fact that you need to call fsync(2), and then check the error
returns of both fsync(2) *and* close(2) if you want to know for sure
whether or not there was an I/O error is a known, docmented part of
Unix/Linux and has been true for literally decades.  (With Emacs
learning and fixing this back in the late-1980's to avoid losing user
data if the user goes over quota on their Andrew File System on a BSD
4.3 system, for example.  If you're using some editor that comes with
some desktop package or some whizzy IDE, all bets are off, of course.
But if you're using such tools, you probably care about eye candy way
more than you care about your data; certainly the authors of such
programs seem to have this tendency, anyway.  :-)

Cheers,

						- Ted
