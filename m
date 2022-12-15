Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AEC4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLOAfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLOAfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 19:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A031ED4
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 16:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671064458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqeMywu3iT4ftxLMJbD0nCtsC2LYnymRthrhqGzevww=;
        b=JDGxtEBM5JwE8bvC851JSy6yg9u5skcTYX6KY9/VghUWGIh2CRskeTVRYifbdDklB9VcJ3
        OlHRRW1ctcOrzRRsCubt5f9X2uAdF+4ZXrnw9VytUrHzbt5/baoQwjVcs1mnueSuqgu1te
        zETj8zxvi4uI2fZ4DWTWrbFStAPXRYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-HCZZRf8fOYm2A6yCDzp3UQ-1; Wed, 14 Dec 2022 19:34:14 -0500
X-MC-Unique: HCZZRf8fOYm2A6yCDzp3UQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D294858F0E;
        Thu, 15 Dec 2022 00:34:14 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 199E4492C14;
        Thu, 15 Dec 2022 00:34:09 +0000 (UTC)
Date:   Thu, 15 Dec 2022 08:34:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH 3/3] lib/percpu-refcount: drain ->release() in
 perpcu_ref_exit()
Message-ID: <Y5prfOjyyjQKUrtH@T590>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
 <20221214081651.954-1-hdanton@sina.com>
 <Y5nP4JC00zTepHue@T590>
 <Y5n0wBarpw7IEQX4@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5n0wBarpw7IEQX4@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 14, 2022 at 08:07:28AM -0800, Dennis Zhou wrote:
> Hello,
> 
> On Wed, Dec 14, 2022 at 09:30:08PM +0800, Ming Lei wrote:
> > On Wed, Dec 14, 2022 at 04:16:51PM +0800, Hillf Danton wrote:
> > > On 14 Dec 2022 10:51:01 +0800 Ming Lei <ming.lei@redhat.com>
> > > > The pattern of wait_event(percpu_ref_is_zero()) has been used in several
> > > 
> > > For example?
> > 
> > blk_mq_freeze_queue_wait() and target_wait_for_sess_cmds().
> > 
> > > 
> > > > kernel components, and this way actually has the following risk:
> > > > 
> > > > - percpu_ref_is_zero() can be returned just between
> > > >   atomic_long_sub_and_test() and ref->data->release(ref)
> > > > 
> > > > - given the refcount is found as zero, percpu_ref_exit() could
> > > >   be called, and the host data structure is freed
> > > > 
> > > > - then use-after-free is triggered in ->release() when the user host
> > > >   data structure is freed after percpu_ref_exit() returns
> > > 
> > > The race between exit and the release callback should be considered at the
> > > corresponding callsite, given the comment below, and closed for instance
> > > by synchronizing rcu.
> > > 
> > > /**
> > >  * percpu_ref_put_many - decrement a percpu refcount
> > >  * @ref: percpu_ref to put
> > >  * @nr: number of references to put
> > >  *
> > >  * Decrement the refcount, and if 0, call the release function (which was passed
> > >  * to percpu_ref_init())
> > >  *
> > >  * This function is safe to call as long as @ref is between init and exit.
> > >  */
> > 
> > Not sure if the above comment implies that the callsite should cover the
> > race.
> > 
> > But blk-mq can really avoid the trouble by using the existed call_rcu():
> > 
> 
> I struggle with the dependency on release(). release() itself should not
> block, but a common pattern would be to through a call_rcu() in and

Yes, release() is called with rcu read lock, and I guess the trouble may
be originated from the fact release() may do nothing related with
actual data releasing.

> schedule additional work - see block/blk-cgroup.c, blkg_release().

I believe the pattern is user specific, and the motivation of using call_rcu
can't be just for avoiding such potential race between release() and
percpu_ref_exit().

> 
> I think the dependency really is the completion of release() and the
> work scheduled on it's behalf rather than strictly starting the
> release() callback. This series doesn't preclude that from happening.

Yeah.

For any additional work or sort of thing scheduled in release(), only
the caller can guarantee they are drained before percpu_exit_ref(), so
I agree now it is better for caller to avoid the race.

> 
> /**
>  * percpu_ref_exit - undo percpu_ref_init()
>  * @ref: percpu_ref to exit
>  *
>  * This function exits @ref.  The caller is responsible for ensuring that
>  * @ref is no longer in active use.  The usual places to invoke this
>  * function from are the @ref->release() callback or in init failure path
>  * where percpu_ref_init() succeeded but other parts of the initialization
>  * of the embedding object failed.
>  */
> 
> I think the percpu_ref_exit() comment explains the more common use case
> approach to percpu refcounts. release() triggering percpu_ref_exit() is
> the ideal case.

But most of callers don't use in this way actually.


Thanks, 
Ming

