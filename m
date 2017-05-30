Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] nbd: nbd_reset() call in nbd_dev_add() is
 redundant
To: Ilya Dryomov <idryomov@gmail.com>, Josef Bacik <jbacik@fb.com>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org
References: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2094f61-b383-09e4-5795-d01c6dc0ee8d@kernel.dk>
Date: Tue, 30 May 2017 08:15:47 -0600
MIME-Version: 1.0
In-Reply-To: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/23/2017 09:49 AM, Ilya Dryomov wrote:
> There is nothing to clear -- nbd_device has just been allocated.
> Fold nbd_reset() into its other caller, nbd_config_put().

Added 1+2 for 4.12.

-- 
Jens Axboe
