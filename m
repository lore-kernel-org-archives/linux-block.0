Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] bcache patches for 4.19, 2nd wave
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180809074851.11027-1-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ffb6468d-2f00-f9e7-665a-b82d0dcf1e1f@kernel.dk>
Date: Thu, 9 Aug 2018 08:21:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 1:48 AM, Coly Li wrote:
> Hi Jens, 
> 
> Here are 2nd wave bcache patches for 4.19.
> 
> The patches from me were either verified by other people or posted
> for quite long time. Except for the debugfs_create_dir() fix and
> "set max writeback rate" fix, rested patches are simple or trivial
> IMHO.
> 
> Our new bcache developer Shenghui Wang contributes two patches in
> this run. The first one fixes a misleading error message, and the
> second one is a code style clean up.
> 
> Thanks in advance for picking them.

Applied, fixed up a typo in your patch #4.

-- 
Jens Axboe
