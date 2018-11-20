Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF227C04EBC
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D895206BB
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D895206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKTX6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:58:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeKTX6G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 18:58:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D354308428C;
        Tue, 20 Nov 2018 13:28:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B980C6012B;
        Tue, 20 Nov 2018 13:28:41 +0000 (UTC)
Date:   Tue, 20 Nov 2018 21:28:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: kobject lifetime issues in blk-mq
Message-ID: <20181120132836.GA22666@ming.t460p>
References: <20181112200236.GA4415@kroah.com>
 <20181113002226.GA4455@ming.t460p>
 <20181113004124.GC4455@ming.t460p>
 <20181114110827.GA31430@ming.t460p>
 <20181114151410.GB26378@kroah.com>
 <20181115003616.GA32603@ming.t460p>
 <20181115005658.GA24847@kroah.com>
 <CACT4Y+bSzPM022bGMmj4GQ_YHVsVqd6r+NTC4+fRrRT+yjAjEw@mail.gmail.com>
 <20181120120540.GA14861@kroah.com>
 <CACT4Y+abDYfK0bD+5E_2T_hR=-0CbJzWnEVVJTTLYAi1-QCx1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+abDYfK0bD+5E_2T_hR=-0CbJzWnEVVJTTLYAi1-QCx1w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 20 Nov 2018 13:28:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 01:53:47PM +0100, Dmitry Vyukov wrote:
> On Tue, Nov 20, 2018 at 1:05 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Nov 20, 2018 at 12:34:40PM +0100, Dmitry Vyukov wrote:
> >> On Thu, Nov 15, 2018 at 1:56 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Thu, Nov 15, 2018 at 08:36:17AM +0800, Ming Lei wrote:
> >> >> > So even if you think the kernel is not going to do this, remember, you
> >> >> > have no control over it.  Reference counted objects are done this way
> >> >> > for a reason, you really do not know who has a reference and you really
> >> >> > do not care.
> >> >> >
> >> >> > You are just papering over the real issue here, see my previous email
> >> >> > for how to start working on resolving it.
> >> >>
> >> >> IMO, there isn't real issue, and the issue is actually in 'delay release'.
> >> >
> >> > Nope, sorry, that is not true.
> >> >
> >> >> Please look at the code in block/blk-mq-sysfs.c, both q->mq_kobj and all
> >> >> ctx->kobj share same lifetime with q->kobj, we even don't call get/put
> >> >> on q->mq_kobj & all ctx->kobj, and all are simply released in q->kobj's
> >> >> release handler.
> >> >
> >> > How do you "know" you are keeping those lifetimes in sync?  The joy of a
> >> > kobject is that _ANYTHING_ can grab a reference to your object without
> >> > you knowing about it.  That includes userspace programs.  Yes, sysfs is
> >> > now much better and it trys to release that reference "quickly" when it
> >> > determines you are trying to delete a kobject, but it's not perfict,
> >> > there are still races there.
> >> >
> >> > And that is what the delay release code is showing you.  It is showing
> >> > you that you "think" your reference counting is wrong, but it is not.
> >> > It is showing you that if someone else grabs a reference, you are not
> >> > correctly cleaning up for yourself.
> >> >
> >> > Never think that you really know the lifetime of a kobject, once you
> >> > realize that your code gets simpler and you can then just "trust" that
> >> > the kernel will do the right thing no matter what.
> >> >
> >> > Because really, you are using a kobject because you want that correct
> >> > reference counting logic.  By ignoring that logic, you are ignoring the
> >> > reason to be using that object at all.  If you don't need reference
> >> > counting, then don't use it at all.
> >> >
> >> > And if you need sysfs files, then you need to use the kobject and then
> >> > you need to handle it properly, because again, you do NOT have full
> >> > control over the lifetime of your object.  That's the basis for
> >> > reference counting in the firstplace.
> >> >
> >> > So this code is broken without me evening having to look at it, please
> >> > fix it to handle release properly.  Again, the kernel tried to tell you
> >> > this, but you hacked around the kernel core to remove that warning
> >> > incorrectly.  Please go read the kobject documentation again for even
> >> > more details about this than what I said here.
> >> >
> >> > thanks,
> >> >
> >> > greg k-h
> >>
> >> Whoever is the right person to fix this, please prioritize this to the
> >> degree possible.
> >> This issue does not allow to use DEBUG_KOBJECT_RELEASE in any
> >> automated testing (in particular syzbot) on both upstream and stable
> >> trees. We have to disable it for now, so other bugs won't be noticed
> >> and will pile up.
> >
> > Patches for this have already been posted :)
> 
> 
> This is great.
> What is the patch name? I can't find anything that looks relevant on
> LKML searching by kobject.

https://marc.info/?l=linux-block&m=154270006101625&w=2

Thanks,
Ming
