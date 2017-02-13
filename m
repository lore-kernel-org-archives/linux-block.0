Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Scott Bauer <scott.bauer@intel.com>
Subject: RE: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Date: Mon, 13 Feb 2017 17:07:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02851D7@AcuExch.aculab.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
 <20170213162941.GB18913@sbauer-Z170X-UD5>
 <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
In-Reply-To: <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

From: Arnd Bergmann
> Sent: 13 February 2017 17:02
...
> >> > +   ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
> >> > +   if (IS_ERR_OR_NULL(ioctl_ptr)) {
> >> > +           ret = PTR_ERR(ioctl_ptr);
> >> > +           goto out;
> >> ...
> >> > + out:
> >> > +   kfree(ioctl_ptr);
> >> > +   return ret;
...
> >> That error path doesn't look quite right to me.
...
> > good god, this is a mess this morning. Thanks for the catch, I'll review these
> > more aggressively before sending out.
> 
> memdup_user() never returns NULL, and generally speaking any use of
> IS_ERR_OR_NULL() indicates that there is something wrong with the
> interface, so aside from passing the right pointer (or NULL) into kfree()
> I think using IS_ERR() is the correct solution.

You missed the problem entirely.
Code needs to be:
	if (IS_ERR(ioctl_ptr))
		return PTR_ERR(ioctl_ptr);

	David

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
