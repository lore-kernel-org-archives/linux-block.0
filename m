Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com, hch@lst.de,
 bart.vanassche@wdc.com, hare@suse.de, ming.lei@redhat.com
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
Date: Tue, 28 Aug 2018 09:48:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180828154727.3589-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> Kernel oops when booting on Bay and Cherry Trail devices
> such as Intel Compute Stick. Bisected as:
> 
> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> 
> This patch reverts the above commit.

Did I miss the posting of that oops? Just curious where this is
going wrong. Not adverse to reverting, but I'd like to try to
understand the issue first.

-- 
Jens Axboe
