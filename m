Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make writeback throttling defaults consistent for
 SQ devices
To: Jan Kara <jack@suse.cz>
References: <20170419093327.14986-1-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <454d00f8-c89c-8b26-7ab6-d6b92eef7e20@kernel.dk>
Date: Wed, 19 Apr 2017 08:34:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170419093327.14986-1-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/19/2017 03:33 AM, Jan Kara wrote:
> When CFQ is used as an elevator, it disables writeback throttling
> because they don't play well together. Later when a different elevator
> is chosen for the device, writeback throttling doesn't get enabled
> again as it should. Make sure CFQ enables writeback throttling (if it
> should be enabled by default) when we switch from it to another IO
> scheduler.

Thanks Jan, added.

-- 
Jens Axboe
