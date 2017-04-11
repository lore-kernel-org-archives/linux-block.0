Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: WBT for SQ devices interface
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20170411093827.GC2471@quack2.suse.cz>
Date: Tue, 11 Apr 2017 10:22:37 -0600
Cc: linux-block@vger.kernel.org
Message-Id: <F875D86A-57DF-42EA-B397-22BE15D1B210@kernel.dk>
References: <20170411093827.GC2471@quack2.suse.cz>
To: Jan Kara <jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Apr 11, 2017, at 3:38 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Hi,
>=20
> when testing my fix for 0-day reports with writeback throttling I came
> across somewhat unexpected behavior with user interface of writeback
> throttling. So currently if CFQ is used as an IO scheduler, we disable
> writeback throttling because they don't go well together. However when use=
r
> has CONFIG_BLK_WBT_SQ=3Dy and switches IO scheduler to NOOP or DEADLINE
> writeback throttling still stays disabled. This is somewhat unexpected
> especially because the switching of IO scheduler from CFQ to something els=
e
> can have happened behind user's back by some udev rule or so. So basically=

> CONFIG_DEFAULT_CFQ=3Dy and CONFIG_BLK_WBT_SQ=3Dy don't make sense together=
.
>=20
> So do people thing we should enable WBT if CONFIG_BLK_WBT_SQ=3Dy and IO
> scheduler is switched from CFQ to something else?

Yes, I think so. We should have consistent behavior in that area, regardless=
 of the starting point.

--=20
Jens Axboe
