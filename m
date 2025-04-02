Received: from mail-pg1-f229.google.com (mail-pg1-f229.google.com [209.85.215.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812C1EDA31
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622874; cv=none; b=BUhsp8lVl4FapQwJGcnbcRHnE0o77E6au1tGu+UErckQ0HAdQPQnmmWg4kyxTixa0q6s7dnzrP08gz8wXvLLryctrBmdqIk8iYEGEtCMl0qQeKrh67+8VwiJUMEW5X8Mz3l0HDPiy1IgXnAOdjS5OQZLUo6r74HL6lO0HKZl1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622874; c=relaxed/simple;
	bh=iDwhdKTHkiVI/kVWHgxcQk682Wh2c/MBtb4WhOisM3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrTn2LtWm4QgMRwwDdB0yDGOq8NqFE0+Kbet76yJlNizLewkzFltb1bvwB4IRWwbsjVgn2yyPVRmI0Dsdpb2rt2P8QObu+8NoKKszjs5Yis2wbGkSU4tJy2z77l5/7Xfw+xEnBhqX+03LGrAQ7tBc25pdabs+EXR7znYC/bB814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XG4C9DQj; arc=none smtp.client-ip=209.85.215.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XG4C9DQj"
Received: by mail-pg1-f229.google.com with SMTP id 41be03b00d2f7-af51e820336so199701a12.1
        for <linux-block@vger.kernel.org>; Wed, 02 Apr 2025 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743622871; x=1744227671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxIY3Gf2m8j6PJ9snlE5RC50f7NMmTNygP+VovwJ4NM=;
        b=XG4C9DQjBmejArNQ9fOyxTiH/xy6NgqJTdyPQmwJBUDLTOQ6Qvq1Q5M153CpisJu4V
         CuuR8zp6XBZ8zHzpa62oO64QFbx9qN4bPtf80EQyOheksGnY5O4gHaB3UWRu6mOHdR9h
         T0ZMtcssfaTu+4KgbgCmPQEZURnjMCfUGn1Dch4cKjxN5jqCr2IhMmp3s3vfdESb2PKN
         ijt5F/sHH1i+Gv9vLuA9OLfbst5LhSF6VTZYHwhhKes5bp7GRCuyGFpjoGZ+WZ6/Uq8m
         Jxz/4xtECvCXNqZzpiPr0j2KFWM3gLtEH30cTwPcwqxIKAGo14B7y9ln3am630KlAok9
         EQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622871; x=1744227671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxIY3Gf2m8j6PJ9snlE5RC50f7NMmTNygP+VovwJ4NM=;
        b=aA+T9zHkPwz2q4hrdFnEe4jWZixBDWKDWXr41GOg/6bWZsztF8rSiIKiOpvoKjNZyi
         xTM7fxloatat+OccB714k/VFQNy47/bYyefwVujFMfoeQZRNDGyG/4kYiF2R+j57/27/
         ud6oQVNFj3A9EFWYetiRzu5T349PWkvYkYhmmqyI67N4K+iqI+LY5ub7A94jh7axLU07
         onctdnnICsBhZdLCdD/D0qpsthyqM3sFSxlm0kfipEl9n36NjaMFUT7zjDBr26CPGWlm
         rzZLvkvbYM3YbMWlm2CN67FBpTwUMJIj/54XZHUC0xg8SNBGi3i77B5tgfnmcZE3NnPj
         5giw==
X-Forwarded-Encrypted: i=1; AJvYcCWvEVM3DEm/xuUARPHmr8vNtZGBW2YREe+WjwtAl8ke6JJ1TlpqWGfO2V4+43bsafvwyQlsDN9Aqt7yzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGykXcC96Z2njC+Ma+1J/uoSFncuvcupAA97T8BBbw8NDz3wmi
	5VV+tWa6cQ2X/XgCEJuT8XJtvnmOTFuCHQJPEFRoJbwCf30rincr1WMuM7Otixe97l9cP10YZ5g
	w/FJ5j7keAU32CwgeY/peOsz4eGsYwmKK
X-Gm-Gg: ASbGncteNGJy1F7jKPFELtvUOcpL0jVOWBnHe3+UwFLk1e9IHU6aBoGXoj3bA06otnj
	vTIsg/EzMruJPXLAYkwB5/wrLjDClyR5dNia/DOlOInUcpihreNnpTXtW6bO6vF6gniihj1aRT3
	JKQcSVYrSXblE4ljRcF5KTjfdYF8U1TkDLACuDdYRhqtFD0cKPV8gpWFeBSKn77LxBJ31YjTvqM
	YiTyFYFI42WuOU4ue87CYd4QAUZxzG/CLHOWRpoYjpQE3+V2dizn81wXW+F0gzXJyatCAW59q71
	f/yMcXfgZQZ1IInYGGsBkmf9CUix6VJSm7eoplTHKfzMbCiibg==
X-Google-Smtp-Source: AGHT+IGPPdi6hp5vbdxdNWj7geNIhxy8tTekIGtN+6m/Tg45W5Kjiga5bCFvHih7NICf+2geQNrTJ/6UhdrZ
X-Received: by 2002:a05:6a20:9f97:b0:1f5:6680:82b6 with SMTP id adf61e73a8af0-200e4cf887emr4972323637.38.1743622871548;
        Wed, 02 Apr 2025 12:41:11 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-af93b8a7c1esm529907a12.26.2025.04.02.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:41:11 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D1B503400E5;
	Wed,  2 Apr 2025 13:41:10 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C312FE4018A; Wed,  2 Apr 2025 13:41:10 -0600 (MDT)
Date: Wed, 2 Apr 2025 13:41:10 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+2S1uxw3/h0EgQx@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z-SoibOdOmzOWB-C@fedora>
 <Z+sifI6fujsc186S@dev-ushankar.dev.purestorage.com>
 <Z-y2JGJC56ZhdYHP@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-y2JGJC56ZhdYHP@fedora>

On Wed, Apr 02, 2025 at 11:59:32AM +0800, Ming Lei wrote:
> On Mon, Mar 31, 2025 at 05:17:16PM -0600, Uday Shankar wrote:
> > On Thu, Mar 27, 2025 at 09:23:21AM +0800, Ming Lei wrote:
> > > On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > > > On Wed, Mar 26, 2025 at 01:38:35PM +0800, Ming Lei wrote:
> > > > > On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> > > > > > There are currently two ways in which ublk server exit is detected by
> > > > > > ublk_drv:
> > > > > > 
> > > > > > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> > > > > >    have not been completed to the ublk server when it exits, io_uring
> > > > > >    calls the uring_cmd callback with a special cancellation flag as the
> > > > > >    issuing task is exiting.
> > > > > > 2. I/O timeout. This is needed in addition to the above to handle the
> > > > > >    "saturated queue" case, when all I/Os for a given queue are in the
> > > > > >    ublk server, and therefore there are no outstanding uring_cmds to
> > > > > >    cancel when the ublk server exits.
> > > > > > 
> > > > > > The second method detects ublk server exit only after a long delay
> > > > > > (~30s, the default timeout assigned by the block layer). Any
> > > > > > applications using the ublk device will be left hanging for these 30s
> > > > > > before seeing an error/knowing anything went wrong. This problem is
> > > > > > illustrated by running the new test_generic_02 against a ublk_drv which
> > > > > > doesn't have the fix:
> > > > > > 
> > > > > > selftests: ublk: test_generic_02.sh
> > > > > > dev id is 0
> > > > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > > > 1+0 records in
> > > > > > 0+0 records out
> > > > > > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > > > > > DEAD
> > > > > > dd took 31 seconds to exit (>= 5s tolerance)!
> > > > > > generic_02 : [FAIL]
> > > > > > 
> > > > > > Fix this by instead handling the saturated queue case in the ublk
> > > > > > character file release callback. This happens during ublk server exit
> > > > > > and handles the issue much more quickly than an I/O timeout:
> > > > > 
> > > > > Another solution is to override default 30sec 'timeout'.
> > > > 
> > > > Yes, but that still will introduce unnecessary delays, since it is a
> > > > polling-based solution (very similar to monitor_work we used to have).
> > > > Also it will add complexity to the unprivileged case, since that
> > > > actually cares about timeout and we will have to track the "real"
> > > > timeout separately.
> > > > 
> > > > > 
> > > > > > 
> > > > > > selftests: ublk: test_generic_02.sh
> > > > > > dev id is 0
> > > > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > > > 1+0 records in
> > > > > > 0+0 records out
> > > > > > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > > > > > DEAD
> > > > > > generic_02 : [PASS]
> > > > > > 
> > > > > > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
> > > > > >  tools/testing/selftests/ublk/Makefile           |  1 +
> > > > > >  tools/testing/selftests/ublk/kublk.c            |  3 ++
> > > > > >  tools/testing/selftests/ublk/kublk.h            |  3 ++
> > > > > >  tools/testing/selftests/ublk/null.c             |  4 +++
> > > > > >  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
> > > > > >  6 files changed, 72 insertions(+), 22 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > > index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > > > > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > > > >  {
> > > > > >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > > > > > -	unsigned int nr_inflight = 0;
> > > > > > -	int i;
> > > > > >  
> > > > > >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > > > > >  		if (!ubq->timeout) {
> > > > > > @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > > > >  		return BLK_EH_DONE;
> > > > > >  	}
> > > > > >  
> > > > > > -	if (!ubq_daemon_is_dying(ubq))
> > > > > > -		return BLK_EH_RESET_TIMER;
> > > > > > -
> > > > > > -	for (i = 0; i < ubq->q_depth; i++) {
> > > > > > -		struct ublk_io *io = &ubq->ios[i];
> > > > > > -
> > > > > > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > > > > > -			nr_inflight++;
> > > > > > -	}
> > > > > > -
> > > > > > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > > > > > -	if (nr_inflight == ubq->q_depth) {
> > > > > > -		struct ublk_device *ub = ubq->dev;
> > > > > > -
> > > > > > -		if (ublk_abort_requests(ub, ubq)) {
> > > > > > -			schedule_work(&ub->nosrv_work);
> > > > > > -		}
> > > > > > -		return BLK_EH_DONE;
> > > > > > -	}
> > > > > > -
> > > > > >  	return BLK_EH_RESET_TIMER;
> > > > > >  }
> > > > > >  
> > > > > > @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> > > > > >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > > > >  {
> > > > > >  	struct ublk_device *ub = filp->private_data;
> > > > > > +	bool need_schedule = false;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Error out any requests outstanding to the ublk server. This
> > > > > > +	 * may have happened already (via uring_cmd cancellation), in
> > > > > > +	 * which case it is not harmful to repeat. But uring_cmd
> > > > > > +	 * cancellation does not handle queues which are fully saturated
> > > > > > +	 * (all requests in ublk server), because from the kernel's POV,
> > > > > > +	 * there are no outstanding uring_cmds to cancel. This code
> > > > > > +	 * handles such queues.
> > > > > > +	 */
> > > > > > +
> > > > > > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > > > > > +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> > > > > > +
> > > > > > +	if (need_schedule)
> > > > > > +		schedule_work(&ub->nosrv_work);
> > > > > 
> > > > > ublk_abort_requests() should be called only in case of queue dying,
> > > > > since ublk server may open & close the char device multiple times.
> > > > 
> > > > Sure that is technically possible, however is any real ublk server doing
> > > > this? Seems like a strange thing to do, and seems reasonable for the
> > > > driver to transition the device to the nosrv state (dead or recovery,
> > > > depending on flags) when the char device is closed, since in this case,
> > > > no one can be handling I/O anymore.
> > > 
> > > ublk server should be free to open & close the char device multiple times,
> > > but you patch limits ublk server to open & close the char device just once.
> > > 
> > > The limit looks too strong...
> > 
> > Tying a userspace daemon lifetime to the file seems to also be done in
> > fuse, which is very similar to ublk_drv. See e.g. the description here:
> > 
> > https://lore.kernel.org/lkml/20240524064030.4944-1-jefflexu@linux.alibaba.com/T/
> > 
> > This seems required to support certain workflows, e.g. using an fdstore
> > with ublk devices. While we still keep task references in ublk_drv,
> > these workflows will be broken.
> > 
> > I am not familiar with fuse so I don't know for sure, but it sounds like
> > if the file is closed after some setup is performed, then the connection
> > is aborted. The analogy in ublk might be - if the file is closed while
> > the device is LIVE, then we transition to the nosrv state. Otherwise
> > nothing happens and the file can be reopened freely. This will allow
> > libublksrv to continue working as it opens/closes the fd early to
> > determine if it is accessible. Does that sound any better?
> 
> Yes, my point is that the close shouldn't delete disk, since it may
> be one normal close().
> 
> Actually I think your patch should work by the following change:
> 
> - remove 'schedule_work(&ub->nosrv_work);' done in ublk_ch_release()
> 
> - re-initialize each ublk_queue in open()
> 
> Then disk won't be deleted, but any IO is `aborted` by ubq->canceling
> if the char device isn't opened. After the char device is re-opened,
> everything will become fine.

Yes, thanks for the suggestion, but I ideally want to replace the two
places where we detect nosrv (uring_cmd cancellation and timeout) with
one new place, instead of adding a third one.

Please see the new patch at
https://lore.kernel.org/linux-block/20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com/T/#u

It allows multiple open/close as long as device is not LIVE. This is
similar to fuse and works with current libublksrv implementation, and is
resilient to accidental/random environmental open/close of the character
device, so it may be more acceptable.

Either way, let's continue discussion on that thread.

