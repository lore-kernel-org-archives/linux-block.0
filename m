Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48337 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041947AbdDUWJR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 18:09:17 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/8] blk-mq: Register <dev>/queue/mq after having
 registered <dev>/queue
Date: Fri, 21 Apr 2017 22:09:14 +0000
Message-ID: <1492812553.2499.11.camel@sandisk.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
         <20170418232949.5228-2-bart.vanassche@sandisk.com>
         <20170421220518.GA17177@vader.DHCP.thefacebook.com>
In-Reply-To: <20170421220518.GA17177@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-21 at 15:05 -0700, Omar Sandoval wrote:
> On Tue, Apr 18, 2017 at 04:29:42PM -0700, Bart Van Assche wrote:
> > +int blk_mq_register_dev(struct device *dev, struct request_queue *q)
> > +{
> > +	int ret;
> > +
> > +	ret =3D mutex_lock_interruptible(&q->sysfs_lock);
>=20
> Why did you make this interruptible? blk_mq_disable_hotplug() wasn't
> interruptible before, so now dm_mq_init_request_queue() can fail
> silently if it is interrupted.

Hello Omar,

Whether or not blk_mq_register_dev() should be interruptible is not that
important to me. I can change this function such that it again ignores
signals.

Bart.=
