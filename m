Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Jeff Moyer <jmoyer@redhat.com>, Damien.LeMoal@wdc.com,
 linux-block@vger.kernel.org
Cc: bgurney@redhat.com
References: <20180525211432.20359-1-jmoyer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
Date: Fri, 25 May 2018 16:04:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180525211432.20359-1-jmoyer@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/25/18 3:14 PM, Jeff Moyer wrote:
> Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
> SMR device.  It turns out he was using CFQ, which is the default.
> Unfortunately, as of v4.16, only the deadline schedulers work well with
> host-managed SMR devices.  This series aatempts to switch the elevator
> to deadline for those devices.
> 
> NOTE: I'm not super happy with setting up one iosched and then
> immediately tearing it down.  I'm open to suggestions on better ways
> to accomplish this goal.

Let's please not do this, a few years ago I finally managed to kill
drivers changing the scheduler manually. Why can't this go into a
udev (or similar) rule? That's where it belongs, imho.

-- 
Jens Axboe
