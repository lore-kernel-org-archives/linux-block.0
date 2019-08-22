Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4528FC3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDBC22DD3
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfHVBQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbfHVBQh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 21:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27440106BB25;
        Thu, 22 Aug 2019 01:16:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEB903DB3;
        Thu, 22 Aug 2019 01:16:28 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:16:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
Message-ID: <20190822011622.GA28635@ming.t460p>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <09092247-1623-57ff-6297-1abd9a8cc8a2@acm.org>
 <20190821030052.GD24167@ming.t460p>
 <d27b430e-ed9b-7de7-5947-c93f1753c529@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27b430e-ed9b-7de7-5947-c93f1753c529@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 01:16:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 21, 2019 at 08:41:32AM -0700, Bart Van Assche wrote:
> On 8/20/19 8:00 PM, Ming Lei wrote:
> > On Tue, Aug 20, 2019 at 02:21:10PM -0700, Bart Van Assche wrote:
> > > -	/*
> > > -	 * Remove the sysfs attributes before unregistering the queue data
> > > -	 * structures that can be modified through sysfs.
> > > -	 */
> > >   	if (queue_is_mq(q))
> > > -		blk_mq_unregister_dev(disk_to_dev(disk), q);
> > > -	mutex_unlock(&q->sysfs_lock);
> > > -
> > > +		kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
> > 
> > Could you explain why you move the above line here?
> 
> I'm not sure whether kobject_del() deletes any objects attached to the
> deleted kobj. This change ensures that kobject_uevent() is called before the
> parent object of q->mq_kobj is deleted.

From comment of kernfs_remove(), all subdirectories and files will be
removed.

kobject_del
	sysfs_remove_dir
		kernfs_remove

	/**
	 * kernfs_remove - remove a kernfs_node recursively
	 * @kn: the kernfs_node to remove
	 *
	 * Remove @kn along with all its subdirectories and files.
	 */
	void kernfs_remove(struct kernfs_node *kn)


Thanks,
Ming
