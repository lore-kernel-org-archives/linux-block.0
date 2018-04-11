Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:30:59 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411173059.GO793541@devbig577.frc2.facebook.com>
References: <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
 <20180411170018.GL793541@devbig577.frc2.facebook.com>
 <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
 <20180411171538.GN793541@devbig577.frc2.facebook.com>
 <6cd1d285f726f81186dbab57c3308cc0b257ff99.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6cd1d285f726f81186dbab57c3308cc0b257ff99.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 05:26:12PM +0000, Bart Van Assche wrote:
> Please explain what you wrote further. It's not clear to me why you think
> that anything is broken nor what a "sever model" is.

So, sever (or revoke) model is where you actively disconnect an object
and ensuring that there'll be no further references from others.  In
contrast, what we usually do is refcnting, where we don't actively
sever the dying object from its users but let the users drain
themselves over time and destroy the object when we know all the users
are gone (recnt reaching zero).

> I think we really need the blkcg_exit_queue() call in blk_cleanup_queue()
> to avoid race conditions between request queue cleanup and the block cgroup
> controller. Additionally, since it is guaranteed that no new requests will
> be submitted to a queue after it has been marked dead I don't see why it
> would make sense to keep the association between a request queue and the
> blkcg controller until the last reference on a queue is dropped.

Sure, new requests aren't the only source tho.  e.g. there can be
derefs through sysfs / cgroupfs or writeback attempts on dead devices.
If you want to implement sever, you gotta hunt down all those and make
sure they can't make no further derefs.

Thanks.

-- 
tejun
