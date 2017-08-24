Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:19643 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbdHXShY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 14:37:24 -0400
Date: Thu, 24 Aug 2017 21:36:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] skd: Avoid that module unloading triggers a
 use-after-free
Message-ID: <20170824183654.o4glfufhi243io4c@mwanda>
References: <20170824110412.uh27qkhutnrid7ji@mwanda>
 <1503587051.2702.1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503587051.2702.1.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 24, 2017 at 03:04:12PM +0000, Bart Van Assche wrote:
> On Thu, 2017-08-24 at 14:04 +0300, Dan Carpenter wrote:
> > Hello Bart Van Assche,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 7277cc67b391: "skd: Avoid that module unloading triggers a 
> > use-after-free" from Aug 17, 2017, leads to the following Smatch 
> > complaint:
> > 
> > drivers/block/skd_main.c:3080 skd_free_disk()
> > 	 error: we previously assumed 'disk' could be null (see line 3074)
> > 
> > drivers/block/skd_main.c
> >   3073	
> >   3074		if (disk && (disk->flags & GENHD_FL_UP))
> >                     ^^^^
> > Existing code checked for NULL.  The new code shuffles things around.
> > 
> >   3075			del_gendisk(disk);
> >   3076	
> >   3077		if (skdev->queue) {
> >   3078			blk_cleanup_queue(skdev->queue);
> >   3079			skdev->queue = NULL;
> >   3080			disk->queue = NULL;
> >                         ^^^^^^^^^^^
> > Now we don't check here.
> > 
> >   3081		}
> >   3082	
> > 
> > regards,
> > dan carpenter
> 
> Hello Dan,
> 
> If you have a look at skd_cons_disk() you will see that skdev->queue != NULL
> implies that skdev->disk != NULL. So I think the above report is a false
> positive.
> 

Oh, yeah.  You're right.  Thanks for taking a look at this.

regards,
dan carpenter
