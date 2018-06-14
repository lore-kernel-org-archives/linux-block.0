Return-Path: <lurodriguez@suse.de>
Date: Thu, 14 Jun 2018 19:46:12 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>, damien.lemoal@wdc.com, hare@suse.de,
	axboe@kernel.dk, jaegeuk@kernel.org, yuchao0@huawei.com,
	ghe@suse.com, mwilck@suse.com, tchvatal@suse.com, zren@suse.com,
	agk@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: dm-zoned-tools: add zoned disk udev rules for scheduler / dmsetup
Message-ID: <20180614174612.GK5527@wotan.suse.de>
References: <20180614001147.1545-1-mcgrof@kernel.org>
 <20180614123806.GA32162@redhat.com>
 <20180614173719.GI5527@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614173719.GI5527@wotan.suse.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 07:37:19PM +0200, Luis R. Rodriguez wrote:
> 
> Ie a file describing which
> disk serial gets deadline and which one gets mq-deadline.
> Anyway, let's assume this is done in the kernel, which one would use deadline,
> which one would use mq-deadline?

Nevermind this, deadline will work, Bart already stated why.

 Luis
