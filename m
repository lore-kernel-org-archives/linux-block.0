Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Johannes Thumshirn' <jthumshirn@suse.de>, Scott Bauer
 <scott.bauer@intel.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Date: Fri, 10 Feb 2017 10:28:17 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02833C4@AcuExch.aculab.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
 <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>
In-Reply-To: <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@infradead.org" <hch@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

From: Johannes Thumshirn
> Sent: 10 February 2017 07:46
> On 02/09/2017 06:20 PM, Scott Bauer wrote:
> > When CONFIG_KASAN is enabled, compilation fails:

Does CONFIG_KASAN allocate guard stack space around everything that
is passed by address?
That sounds completely brain-dead.
There are a lot of functions that have an 'int *' argument to return
a single value - and are never going to do anything else.

...
> > Moved all the ioctl structures off the stack and dynamically activate
> > using _IOC_SIZE()
...
> 
> > -		if (copy_from_user(&session, arg, sizeof(session)))
> > -			return -EFAULT;
> > -		return opal_erase_locking_range(dev, &session);
> > +	ioctl_ptr = kzalloc(cmd_size, GFP_KERNEL);
> > +	if (!ioctl_ptr)
> > +		return -ENOMEM;
> > +	if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
> > +		ret = -EFAULT;
> > +		goto out;
> >  	}
> 
> Can't we use memdup_user() instead of kzalloc() + copy_from_user()?

You either want the copy_from_user() or the memzero() not both.

ISTM there could be two 'library' functions, maybe:
void *get_ioctl_buf(unsigned int cmd, long arg)
to malloc the buffer, memzero/copy_from_user, returns -EFAULT if copy fails.
int put_ioctl_buf(int rval, unsigned int cmd, const void *buf)
does copy_to_user() if rval >= 0 and IOR_READ, then frees buf.
return value is rval unless the copyout fails.

	David


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
