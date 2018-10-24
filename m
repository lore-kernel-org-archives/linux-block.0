Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbeJXVm5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Oct 2018 17:42:57 -0400
Date: Wed, 24 Oct 2018 15:14:51 +0200
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/2] loop/006: Add test for setting partscan flag
Message-ID: <20181024131451.GB11237@quack2.suse.cz>
References: <20181018103147.3567-1-jack@suse.cz>
 <20181018103147.3567-2-jack@suse.cz>
 <20181022225255.GB10074@vader>
 <20181023100512.GA4695@quack2.suse.cz>
 <20181023185750.GF10074@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181023185750.GF10074@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 23-10-18 11:57:50, Omar Sandoval wrote:
> On Tue, Oct 23, 2018 at 12:05:12PM +0200, Jan Kara wrote:
> > On Mon 22-10-18 15:52:55, Omar Sandoval wrote:
> > > On Thu, Oct 18, 2018 at 12:31:46PM +0200, Jan Kara wrote:
> > > > Add test for setting partscan flag.
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > 
> > > Sorry I didn't notice this earlier, but loop/001 already does a
> > > partition rescan (via losetup -P). Does that cover this test case?
> > 
> > Yes I know. But the partition rescanning on device creation has been
> > handled properly while partition rescanning as a result of LOOP_SET_STATUS
> > was buggy. That's why I've added this test.
> 
> At least here, losetup -P does a LOOP_SET_STATUS:
> 
> $ sudo strace -e ioctl losetup -f --show -P test.img
> ioctl(3, LOOP_CTL_GET_FREE)             = 0
> ioctl(4, LOOP_SET_FD, 3)                = 0
> ioctl(4, LOOP_SET_STATUS64, {lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_PARTSCAN, lo_file_name="/home/osandov/test.img", ...}) = 0
> /dev/loop0
> +++ exited with 0 +++

Right, my bad. Just discard this test then. Thanks for noticing this!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
