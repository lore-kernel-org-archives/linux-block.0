Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdATJYJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 04:24:09 -0500
Date: Fri, 20 Jan 2017 10:03:57 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Jan Kara <jack@suse.cz>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "Vyacheslav.Dubeyko@wdc.com" <Vyacheslav.Dubeyko@wdc.com>,
        "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in
 filesystems
Message-ID: <20170120090357.GD14115@quack2.suse.cz>
References: <20170117143703.GP2517@quack2.suse.cz>
 <20170117221421.GC4880@omniknight.lm.intel.com>
 <20170118101641.GD24789@quack2.suse.cz>
 <x49r3406r2i.fsf@segfault.boston.devel.redhat.com>
 <20170118210241.GE10498@birch.djwong.org>
 <CAPcyv4hd7bpCa7d9msX0Y8gLz7WsqXT3VExQwwLuAcsmMxVTPg@mail.gmail.com>
 <1484776549.4358.33.camel@intel.com>
 <20170119081011.GA2565@quack2.suse.cz>
 <20170119185910.GF4880@omniknight.lm.intel.com>
 <CAPcyv4jZz_iqLutd0gPEL3udqbFxvBH8CZY5oDgUjG5dGbC2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4jZz_iqLutd0gPEL3udqbFxvBH8CZY5oDgUjG5dGbC2gg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 19-01-17 11:03:12, Dan Williams wrote:
> On Thu, Jan 19, 2017 at 10:59 AM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> > On 01/19, Jan Kara wrote:
> >> On Wed 18-01-17 21:56:58, Verma, Vishal L wrote:
> >> > On Wed, 2017-01-18 at 13:32 -0800, Dan Williams wrote:
> >> > > On Wed, Jan 18, 2017 at 1:02 PM, Darrick J. Wong
> >> > > <darrick.wong@oracle.com> wrote:
> >> > > > On Wed, Jan 18, 2017 at 03:39:17PM -0500, Jeff Moyer wrote:
> >> > > > > Jan Kara <jack@suse.cz> writes:
> >> > > > >
> >> > > > > > On Tue 17-01-17 15:14:21, Vishal Verma wrote:
> >> > > > > > > Your note on the online repair does raise another tangentially
> >> > > > > > > related
> >> > > > > > > topic. Currently, if there are badblocks, writes via the bio
> >> > > > > > > submission
> >> > > > > > > path will clear the error (if the hardware is able to remap
> >> > > > > > > the bad
> >> > > > > > > locations). However, if the filesystem is mounted eith DAX,
> >> > > > > > > even
> >> > > > > > > non-mmap operations - read() and write() will go through the
> >> > > > > > > dax paths
> >> > > > > > > (dax_do_io()). We haven't found a good/agreeable way to
> >> > > > > > > perform
> >> > > > > > > error-clearing in this case. So currently, if a dax mounted
> >> > > > > > > filesystem
> >> > > > > > > has badblocks, the only way to clear those badblocks is to
> >> > > > > > > mount it
> >> > > > > > > without DAX, and overwrite/zero the bad locations. This is a
> >> > > > > > > pretty
> >> > > > > > > terrible user experience, and I'm hoping this can be solved in
> >> > > > > > > a better
> >> > > > > > > way.
> >> > > > > >
> >> > > > > > Please remind me, what is the problem with DAX code doing
> >> > > > > > necessary work to
> >> > > > > > clear the error when it gets EIO from memcpy on write?
> >> > > > >
> >> > > > > You won't get an MCE for a store;  only loads generate them.
> >> > > > >
> >> > > > > Won't fallocate FL_ZERO_RANGE clear bad blocks when mounted with
> >> > > > > -o dax?
> >> > > >
> >> > > > Not necessarily; XFS usually implements this by punching out the
> >> > > > range
> >> > > > and then reallocating it as unwritten blocks.
> >> > > >
> >> > >
> >> > > That does clear the error because the unwritten blocks are zeroed and
> >> > > errors cleared when they become allocated again.
> >> >
> >> > Yes, the problem was that writes won't clear errors. zeroing through
> >> > either hole-punch, truncate, unlinking the file should all work
> >> > (assuming the hole-punch or truncate ranges wholly contain the
> >> > 'badblock' sector).
> >>
> >> Let me repeat my question: You have mentioned that if we do IO through DAX,
> >> writes won't clear errors and we should fall back to normal block path to
> >> do write to clear the error. What does prevent us from directly clearing
> >> the error from DAX path?
> >>
> > With DAX, all IO goes through DAX paths. There are two cases:
> > 1. mmap and loads/stores: Obviously there is no kernel intervention
> > here, and no badblocks handling is possible.
> > 2. read() or write() IO: In the absence of dax, this would go through
> > the bio submission path, through the pmem driver, and that would handle
> > error clearing. With DAX, this goes through dax_iomap_actor, which also
> > doesn't go through the pmem driver (it does a dax mapping, followed by
> > essentially memcpy), and hence cannot handle badblocks.
> 
> Hmm, that may no longer be true after my changes to push dax flushing
> to the driver. I.e. we could have a copy_from_iter() implementation
> that attempts to clear errors... I'll get that series out and we can
> discuss there.

Yeah, that was precisely my point - doing copy_from_iter() that clears
errors should be possible...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
