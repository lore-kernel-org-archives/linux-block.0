Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46529 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdASILg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 03:11:36 -0500
Date: Thu, 19 Jan 2017 09:10:11 +0100
From: Jan Kara <jack@suse.cz>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "Vyacheslav.Dubeyko@wdc.com" <Vyacheslav.Dubeyko@wdc.com>,
        "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in
 filesystems
Message-ID: <20170119081011.GA2565@quack2.suse.cz>
References: <SN2PR04MB2191756EABCB0E9DAA3B5328887B0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170114004910.GA4880@omniknight.lm.intel.com>
 <SN2PR04MB2191A6EDB7203AF86600FD25887D0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170117143703.GP2517@quack2.suse.cz>
 <20170117221421.GC4880@omniknight.lm.intel.com>
 <20170118101641.GD24789@quack2.suse.cz>
 <x49r3406r2i.fsf@segfault.boston.devel.redhat.com>
 <20170118210241.GE10498@birch.djwong.org>
 <CAPcyv4hd7bpCa7d9msX0Y8gLz7WsqXT3VExQwwLuAcsmMxVTPg@mail.gmail.com>
 <1484776549.4358.33.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484776549.4358.33.camel@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed 18-01-17 21:56:58, Verma, Vishal L wrote:
> On Wed, 2017-01-18 at 13:32 -0800, Dan Williams wrote:
> > On Wed, Jan 18, 2017 at 1:02 PM, Darrick J. Wong
> > <darrick.wong@oracle.com> wrote:
> > > On Wed, Jan 18, 2017 at 03:39:17PM -0500, Jeff Moyer wrote:
> > > > Jan Kara <jack@suse.cz> writes:
> > > > 
> > > > > On Tue 17-01-17 15:14:21, Vishal Verma wrote:
> > > > > > Your note on the online repair does raise another tangentially
> > > > > > related
> > > > > > topic. Currently, if there are badblocks, writes via the bio
> > > > > > submission
> > > > > > path will clear the error (if the hardware is able to remap
> > > > > > the bad
> > > > > > locations). However, if the filesystem is mounted eith DAX,
> > > > > > even
> > > > > > non-mmap operations - read() and write() will go through the
> > > > > > dax paths
> > > > > > (dax_do_io()). We haven't found a good/agreeable way to
> > > > > > perform
> > > > > > error-clearing in this case. So currently, if a dax mounted
> > > > > > filesystem
> > > > > > has badblocks, the only way to clear those badblocks is to
> > > > > > mount it
> > > > > > without DAX, and overwrite/zero the bad locations. This is a
> > > > > > pretty
> > > > > > terrible user experience, and I'm hoping this can be solved in
> > > > > > a better
> > > > > > way.
> > > > > 
> > > > > Please remind me, what is the problem with DAX code doing
> > > > > necessary work to
> > > > > clear the error when it gets EIO from memcpy on write?
> > > > 
> > > > You won't get an MCE for a store;��only loads generate them.
> > > > 
> > > > Won't fallocate FL_ZERO_RANGE clear bad blocks when mounted with
> > > > -o dax?
> > > 
> > > Not necessarily; XFS usually implements this by punching out the
> > > range
> > > and then reallocating it as unwritten blocks.
> > > 
> > 
> > That does clear the error because the unwritten blocks are zeroed and
> > errors cleared when they become allocated again.
> 
> Yes, the problem was that writes won't clear errors. zeroing through
> either hole-punch, truncate, unlinking the file should all work
> (assuming the hole-punch or truncate ranges wholly contain the
> 'badblock' sector).

Let me repeat my question: You have mentioned that if we do IO through DAX,
writes won't clear errors and we should fall back to normal block path to
do write to clear the error. What does prevent us from directly clearing
the error from DAX path?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
