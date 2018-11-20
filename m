Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CFFC04EBC
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7920851
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+VPNrW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeKTX5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeKTX5I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 18:57:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29F12087E;
        Tue, 20 Nov 2018 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542720479;
        bh=U+DiQLCfNM4Vrl8ko0SQDX19J99cdnJXg7BenCLDLgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+VPNrW4ZcwICXbFeTuPvTaWZsEiOJwgKmo14xquOggCd7+UlU8GgLbIHDTltXtQ/
         LofpMLa/viB2j3VT2mqYjx9flp61FeDT+aRt+aRezCBdfNgsVwSEFIYP/d7jY/I0XL
         Odeo3JIYpottoFSJRS4FD02si7lkI4MlS0cKAj0o=
Date:   Tue, 20 Nov 2018 14:27:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20181120132757.GB19173@kroah.com>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> >> > > >> > So this code is broken without me evening having to look at it, please
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

Subject: [PATCH 4.21 V3] blk-mq: not embed .mq_kobj and ctx->kobj into queue instance

Hope this helps,

greg k-h
