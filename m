Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
Date: Thu, 15 Jun 2017 08:21:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170615081914.GD10599@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/15/2017 02:19 AM, Christoph Hellwig wrote:
> I think Darrick has a very valid concern here - using RWF_* flags
> to affect inode or fd-wide state is extremely counter productive.
> 
> Combined with the fact that the streams need a special setup in NVMe
> I'm tempted to say that the interface really should be fadvise or
> similar, which would keep the setup out of the I/O path and make clear
> it's a sticky interface.  For direct I/O RWF_* would make some sense,
> but we'd still have to deal with the setup issue.

OK, which is exactly how I had implemented the interface 2 years ago.
I can resurrect that part and dump the RWF_* flags. I agree the RWF_*
flags are confusing for buffered IO, since they are persistent. For
O_DIRECT, they make more sense. So the question is if we want to
retain the RWF_WRITE_LIFE_* hints at all, or simply go back to the
fadvise with something ala:

POSIX_FADV_WRITE_HINT_SET	Set write life time hint
POSIX_FADV_WRITE_HINT_GET	Get write life time hint

I'd still very much like to stick to the same four hints, and not
require any special setup. I think the lazy setup for nvme is fine. Some
devices can do it at probe time, others will want to do it lazily to not
waste resources. Do we really want to have the HINT_SET bubble down to
the device and allocate streams?

I want to keep this simple to use. The RWF_WRITE_LIFE_* are easy to use
and adopt. But I do agree that being able to query the setting is
useful, and then we may as well introduce a get/set fadvise interface
for doing so.

Do people like the S_WRITE_LIFE_* part, or should we keep the
i_write_hint and just shrink it to 8 bytes?

-- 
Jens Axboe
