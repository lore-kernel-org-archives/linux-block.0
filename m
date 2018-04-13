Return-Path: <m.tretter@pengutronix.de>
Date: Fri, 13 Apr 2018 16:25:18 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
 kernel@pengutronix.de
Subject: Re: [PATCH] nbd: do not update block size if file system is mounted
Message-ID: <20180413162518.47840e6f@litschi.hi.pengutronix.de>
In-Reply-To: <6c862ddf-b352-6ef4-06f8-516680e9f19f@kernel.dk>
References: <20180228095456.31472-1-m.tretter@pengutronix.de>
	<20180315110057.13eecda6@litschi.hi.pengutronix.de>
	<6c862ddf-b352-6ef4-06f8-516680e9f19f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 16 Mar 2018 09:36:45 -0700, Jens Axboe wrote:
> On 3/15/18 3:00 AM, Michael Tretter wrote:
> > On Wed, 28 Feb 2018 10:54:56 +0100, Michael Tretter wrote:  
> >> If a file system is mounted on the nbd during a disconnect, resetting
> >> the size to 0, might change the block size and destroy the buffer_head
> >> mappings. This will cause a infinite loop when the file system looks for
> >> the buffer_heads for flushing.
> >>
> >> Only set the file size to 0, if we are the only opener of the nbd.
> >>
> >> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> >> ---
> >>  drivers/block/nbd.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> >> index 5f2a4240a204..0d1dbb60430b 100644
> >> --- a/drivers/block/nbd.c
> >> +++ b/drivers/block/nbd.c
> >> @@ -1118,7 +1118,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
> >>  	if (ret)
> >>  		sock_shutdown(nbd);
> >>  	mutex_lock(&nbd->config_lock);
> >> -	bd_set_size(bdev, 0);
> >> +	if (bdev->bd_openers <= 1)
> >> +		bd_set_size(bdev, 0);
> >>  	/* user requested, ignore socket errors */
> >>  	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
> >>  		ret = 0;  
> > 
> > Are there any comments on this patch?  
> 
> Josef?
> 

Maybe some history helps for reviewing the patch:

Commit abbbdf12497d ("nbd: replace kill_bdev() with
__invalidate_device()") already fixed this issue once by changing
nbd_size_clear() to only set the size to 0 if the device is only opened
once. The line was moved several times during the rework for the
netlink interface and the check for the number of openers was dropped,
reintroducing the issue.

Michael
