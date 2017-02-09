Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Bauer' <scott.bauer@intel.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sed-opal fixups 
Date: Thu, 9 Feb 2017 17:43:20 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0281B85@AcuExch.aculab.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
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

From: Scott Bauer
> Sent: 09 February 2017 17:20
> It may be too late to change anyhting in the uapi header. When we
> switched over to using IOC_SIZE I found a bug where I had switched
> up a structure in one of the series from v4 to v5 but never changed
> the structure in the IOW. The structure that was in there was to small
> so when we kzalloc on it we don't request enough space. It worked before
> because we were using the cmd strictly as a command #, not using the IOC
> and friends.
> 
> If it's too late to modify that IOW, I can work around it by reallocing
> on the correct size for that command only. I verified the rest of the
> commands and the structures are the same.
> 
> Let me know what you think, please.

Maybe define IOC_OPAL_ACTIVATE_LSP_OLD to the incorrect value and
IOC_OPAL_ACTIVATE_LSP to the correct one.
But that relies on any users specifying the correct structure.
I wouldn't guarantee that.

At the top of the driver's ioctl path add:
	if (cmd == IOC_OPAL_ACTIVATE_LSP_OLD) cmd = IOC_OPAL_ACTIVATE_LSP;

For some code I added a userspace wrapper on ioctl() to check the
size of the supplied arg matched that required by the 'cmd'.
I've also done the same in the kernel.
(all as compile time checks).

	David



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
