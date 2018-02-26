Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH][RESEND] block: copy ioprio in __bio_clone_fast()
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
 Hannes Reinecke <hare@suse.com>
References: <20180226132906.108227-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cb0a2196-2ec5-e66e-1fc9-e48d51b2ffb6@kernel.dk>
Date: Mon, 26 Feb 2018 09:06:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180226132906.108227-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/26/18 6:29 AM, Hannes Reinecke wrote:
> We need to copy the io priority, too; otherwise the clone will run
> with a different priority than the original one.

What about bio_clone_bioset()?

-- 
Jens Axboe
