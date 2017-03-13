Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix tagset reinit in the presence of cpu
 hot-unplug
To: Sagi Grimberg <sagi@grimberg.me>
References: <1489414211-30437-1-git-send-email-sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05295231-7e4b-7043-34df-b3611af8c7a2@kernel.dk>
Date: Mon, 13 Mar 2017 08:23:14 -0600
MIME-Version: 1.0
In-Reply-To: <1489414211-30437-1-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/13/2017 08:10 AM, Sagi Grimberg wrote:
> In case cpu was unplugged, we need to make sure not to assume
> that the tags for that cpu are still allocated. so check
> for null tags when reinitializing a tagset.

Thanks Sagi, that seems reasonable. Applied for 4.11.

-- 
Jens Axboe
