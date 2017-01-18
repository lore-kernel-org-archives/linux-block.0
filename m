Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43383 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdARKQ5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 05:16:57 -0500
Date: Wed, 18 Jan 2017 11:16:41 +0100
From: Jan Kara <jack@suse.cz>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Jan Kara <jack@suse.cz>,
        Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in
 filesystems
Message-ID: <20170118101641.GD24789@quack2.suse.cz>
References: <at1mp6pou4lenesjdgh22k4p.1484345585589@email.android.com>
 <b9rbflutjt10mb4ofherta8j.1484345610771@email.android.com>
 <SN2PR04MB2191756EABCB0E9DAA3B5328887B0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170114004910.GA4880@omniknight.lm.intel.com>
 <SN2PR04MB2191A6EDB7203AF86600FD25887D0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170117143703.GP2517@quack2.suse.cz>
 <20170117221421.GC4880@omniknight.lm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117221421.GC4880@omniknight.lm.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 17-01-17 15:14:21, Vishal Verma wrote:
> Your note on the online repair does raise another tangentially related
> topic. Currently, if there are badblocks, writes via the bio submission
> path will clear the error (if the hardware is able to remap the bad
> locations). However, if the filesystem is mounted eith DAX, even
> non-mmap operations - read() and write() will go through the dax paths
> (dax_do_io()). We haven't found a good/agreeable way to perform
> error-clearing in this case. So currently, if a dax mounted filesystem
> has badblocks, the only way to clear those badblocks is to mount it
> without DAX, and overwrite/zero the bad locations. This is a pretty
> terrible user experience, and I'm hoping this can be solved in a better
> way.

Please remind me, what is the problem with DAX code doing necessary work to
clear the error when it gets EIO from memcpy on write?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
