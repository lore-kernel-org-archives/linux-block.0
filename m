Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC6CC43381
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A49D20882
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfCaPk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:40:28 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:22057 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1731162AbfCaPk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 11:40:28 -0400
X-Greylist: delayed 687 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Mar 2019 11:40:17 EDT
X-ASG-Debug-ID: 1554046126-0e41083ba3135a60001-Cu09wu
Received: from BJEXMBX012.didichuxing.com (bjexmbx012.didichuxing.com [172.20.2.191]) by bsf02.didichuxing.com with ESMTP id ciWaJdIvxiB4XEXX; Sun, 31 Mar 2019 23:28:46 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sun, 31 Mar
 2019 23:28:46 +0800
Date:   Sun, 31 Mar 2019 23:28:40 +0800
From:   weiping zhang <zhangweiping@didichuxing.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Weiping Zhang <zhangweiping@didiglobal.com>, <axboe@kernel.dk>,
        <hch@infradead.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
Message-ID: <20190331152824.GA29577@192.168.3.9>
X-ASG-Orig-Subj: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org
References: <20190107125215.GA5039@192.168.3.9>
 <1546995460.83374.37.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1546995460.83374.37.camel@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS004.didichuxing.com (172.20.1.44) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexmbx012.didichuxing.com[172.20.2.191]
X-Barracuda-Start-Time: 1554046126
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2708
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.69237
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 04:57:40PM -0800, Bart Van Assche wrote:
Hi Bart,
Sorry to reply so late.
> On Mon, 2019-01-07 at 20:52 +0800, Weiping Zhang wrote:
> > If the low level driver has no timerout handler, the
>                                  ^^^^^^^^
>                                  timeout?
> 
OK, I'll fix this spelling mistake.
> > +static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
> > +				int n)
> > +{
> > +	struct request_queue *q =
> > +		container_of(kobj, struct request_queue, kobj);
> > +
> > +	if (attr == &queue_io_timeout_entry.attr) {
> > +		if (!q->mq_ops || !q->mq_ops->timeout)
> > +			return 0;
> > +	}
> 
> Are there any legacy block drivers left? Do we really need the mq_ops test?
As request_fn removed, now we can use mq_ops->timeout directly.
> 
> Additionally, please combine the two nested if-statements into a single
> if-statement.
OK, it's more clear.
> 
> > @@ -942,6 +961,14 @@ int blk_register_queue(struct gendisk *disk)
> >  		goto unlock;
> >  	}
> >  
> > +	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
> > +	if (ret) {
> > +		kobject_del(&q->kobj);
> > +		blk_trace_remove_sysfs(dev);
> > +		kobject_put(&dev->kobj);
> > +		goto unlock;
> > +	}
> 
> Are you sure the "goto unlock" is OK here? Shouldn't kobject_del() be called
> to undo the kobject_add() call if sysfs_create_group() fails?
Sorry, can you tell me why it's may be not safe, if goto unlock here,
if failed to call sysfs_create_group, I think we should call
kobject_del.
> 
> >  	if (queue_is_mq(q)) {
> >  		__blk_mq_register_dev(dev, q);
> >  		blk_mq_debugfs_register(q);
> > @@ -958,6 +985,7 @@ int blk_register_queue(struct gendisk *disk)
> >  		if (ret) {
> >  			mutex_unlock(&q->sysfs_lock);
> >  			kobject_uevent(&q->kobj, KOBJ_REMOVE);
> > +			sysfs_remove_group(&q->kobj, &queue_attr_group);
> >  			kobject_del(&q->kobj);
> >  			blk_trace_remove_sysfs(dev);
> >  			kobject_put(&dev->kobj);
> > @@ -1006,6 +1034,7 @@ void blk_unregister_queue(struct gendisk *disk)
> >  		blk_mq_unregister_dev(disk_to_dev(disk), q);
> >  	mutex_unlock(&q->sysfs_lock);
> >  
> > +	sysfs_remove_group(&q->kobj, &queue_attr_group);
> >  	kobject_uevent(&q->kobj, KOBJ_REMOVE);
> >  	kobject_del(&q->kobj);
> >  	blk_trace_remove_sysfs(disk_to_dev(disk));
> 
> Is it necessary to call sysfs_remove_group() explicitly? Isn't this something
> kobject_del() does automatically?
I check kobject_del, it's same as you said,
kobject_del->sysfs_remove_dir->kernfs_remove, it will remove all files
and subdirectories belong this kobject directory.
> 
> Thanks,
> 
Thanks

Weiping
> Bart.
> 
