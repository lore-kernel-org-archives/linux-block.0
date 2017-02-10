Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Fri, 10 Feb 2017 08:57:56 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Message-ID: <20170210155755.GA2734@sbauer-Z170X-UD5>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
 <4455227.qpXP0b5apU@wuerfel>
MIME-Version: 1.0
In-Reply-To: <4455227.qpXP0b5apU@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, David.Laight@aculab.com,
 linux-block@vger.kernel.org, jonathan.derrick@intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 10, 2017 at 09:01:23AM +0100, Arnd Bergmann wrote:
> On Thursday, February 9, 2017 10:20:01 AM CET Scott Bauer wrote:
> > When CONFIG_KASAN is enabled, compilation fails:
> > 
> > block/sed-opal.c: In function 'sed_ioctl':
> > block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > 
> > Moved all the ioctl structures off the stack and dynamically activate
> > using _IOC_SIZE()
> > 
> > Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> > 
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> > ---
> >  block/sed-opal.c | 134 +++++++++++++++++++++----------------------------------
> >  1 file changed, 50 insertions(+), 84 deletions(-)
> > 
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index bf1406e..4985d95 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -2346,7 +2346,10 @@ EXPORT_SYMBOL(opal_unlock_from_suspend);
> >  
> >  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
> >  {
> > +	void *ioctl_ptr;
> > +	int ret = -ENOTTY;
> >  	void __user *arg = (void __user *)ptr;
> > +	unsigned int cmd_size = _IOC_SIZE(cmd);
> >  
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		return -EACCES;
> 
> We usually have a size check in there to avoid allocating large amounts
> of memory. _IOC_SIZEBITS is 14, so you can have up to 16kb here, which
> is probably ok, but I'd recommend either adding a comment to say that
> it is, or just checking against the largest realistic size.

Right now it's up to the storage driver to call into the sed-opal ioctl.
We have a function is_sed_ioctl() which is called before jumping into sed_ioctl.
So we will be weeding out any non opal ioctls before getting in there so I don't
see any overly large 16kb allocations happening.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
