Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: add FUA op support
To: Shaun McDowell <shaunjmcdowell@gmail.com>, linux-block@vger.kernel.org
Cc: jbacik@fb.com, nbd-general@lists.sourceforge.net, bsdkurt@gmail.com
References: <20170526035554.GA31566@auir>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7f285935-f1f1-30f3-6a23-befd1f39c790@kernel.dk>
Date: Tue, 30 May 2017 08:20:59 -0600
MIME-Version: 1.0
In-Reply-To: <20170526035554.GA31566@auir>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/25/2017 09:55 PM, Shaun McDowell wrote:
> NBD userland client and server have FUA (forced unit access) support
> and flags defined. Make NBD kernel module recognize NBD_FLAG_SEND_FUA,
> enable FUA on the queue, and forward FUA requests to the server.

Queued up for 4.13, thanks.

-- 
Jens Axboe
