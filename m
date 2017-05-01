Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:39700 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdEAPuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2017 11:50:07 -0400
Date: Mon, 1 May 2017 17:49:58 +0200
From: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH cosmetic] Remove trailing newline in elevator switch
 error message
Message-ID: <20170501154958.GA291@x4>
References: <20170429053808.GA293@x4>
 <1493651927.2665.3.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493651927.2665.3.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017.05.01 at 15:18 +0000, Bart Van Assche wrote:
> On Sat, 2017-04-29 at 07:38 +0200, Markus Trippelsdorf wrote:
> > Trying to switch to a non-existing elevator currently results in garbled
> > dmesg output, e.g.:
> > 
> >  # echo "foo" > /sys/block/sda/queue/scheduler 
> > 
> > elevator: type foo not found
> > elevator: switch to foo
> >  failed
> > 
> > (note the unintended line break.)
> > 
> > Fix by stripping the trailing newline.
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index bf11e70f008b..4f13fcd3c626 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -1112,6 +1112,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
> >  ssize_t elv_iosched_store(struct request_queue *q, const char *name,
> >  			  size_t count)
> >  {
> > +	char elevator_name[ELV_NAME_MAX];
> >  	int ret;
> >  
> >  	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
> > @@ -1121,7 +1122,9 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
> >  	if (!ret)
> >  		return count;
> >  
> > -	printk(KERN_ERR "elevator: switch to %s failed\n", name);
> > +	strlcpy(elevator_name, name, sizeof(elevator_name));
> > +	strstrip(elevator_name);
> > +	printk(KERN_ERR "elevator: switch to %s failed\n", elevator_name);
> >  	return ret;
> >  }
> 
> Hello Markus,
> 
> Your patch duplicates the code to remove trailing whitespace which is not
> very elegant. Please move the code that removes trailing whitespace from
> __elevator_change() into  elv_iosched_store() instead of duplicating it.

Yes, I thought about it, but the problem is that elevator_change() calls 
__elevator_change(), too.

-- 
Markus
