Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 00/17] bcache for 4.19, 3rd wave
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180811052000.103680-1-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9fc1c391-bfde-ed26-925a-56e30d2fc07e@kernel.dk>
Date: Sat, 11 Aug 2018 15:42:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/10/18 11:19 PM, Coly Li wrote:
> Hi Jens,
> 
> This series contains several minor fixes and code cleanup reported by
> scripts/checkpatch.pl. After this series, there are still a few warning
> from checkpatch.pl, but I think they are necessary to be the way they
> are and don't change them. For example, error message exceeds 80 chars
> line limit.

It's a little late to apply these at this point, since 4.18 will be
released tomorrow. I can queue them up for later in the merge
window, for a post pull.

-- 
Jens Axboe
