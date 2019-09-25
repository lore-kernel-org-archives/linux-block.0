Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC08C432C1
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 00:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE9B2146E
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 00:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfIYANr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:13:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfIYANq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 20:13:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C42B018C8914;
        Wed, 25 Sep 2019 00:13:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 291CA5C219;
        Wed, 25 Sep 2019 00:13:38 +0000 (UTC)
Date:   Wed, 25 Sep 2019 08:13:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't release queue's sysfs lock during switching
 elevator
Message-ID: <20190925001333.GA29621@ming.t460p>
References: <20190923151209.7466-1-ming.lei@redhat.com>
 <bc5864cd-a62b-d6d5-2d69-6ec03983508b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5864cd-a62b-d6d5-2d69-6ec03983508b@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 00:13:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 11:37:09AM -0700, Bart Van Assche wrote:
> On 9/23/19 8:12 AM, Ming Lei wrote:
> > @@ -523,11 +521,9 @@ void elv_unregister_queue(struct request_queue *q)
> >   		kobject_uevent(&e->kobj, KOBJ_REMOVE);
> >   		kobject_del(&e->kobj);
> > -		mutex_lock(&q->sysfs_lock);
> >   		e->registered = 0;
> >   		/* Re-enable throttling in case elevator disabled it */
> >   		wbt_enable_default(q);
> > -		mutex_unlock(&q->sysfs_lock);
> >   	}
> >   }
> 
> Does this patch cause sysfs_lock to be held around kobject_del(&e->kobj)?

Yes.

> Since sysfs_lock is locked from inside elv_attr_show() and elv_attr_store(),

The request queue's sysfs_lock isn't required in elv_attr_show() and
elv_attr_store(), and only elevator's sysfs_lock is needed in the two
functions.

> does this mean that this patch reintroduces the lock inversion problem that
> was fixed recently?

No.

The lock inversion issue only existed on kobjects of q->kobj & q->mq_obj,
which was fixed already given the queue's sysfs_lock is required in
.show/.store callback of these two kobjects' attributes.


thanks,
Ming
