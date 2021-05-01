Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB75C433ED
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 15:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB18E61613
	for <linux-block@archiver.kernel.org>; Sat,  1 May 2021 15:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhEAPU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 May 2021 11:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhEAPU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 May 2021 11:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619882376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rFHOewkqpfaAfcRGyC3A1F6e6B81+Bw3V/AJ/vMzXM=;
        b=isqELWg7z8LUcT0lHmdKz/2f1HbGEyaUZc06oIvdhQjPrAKGp0/aEl2VJI/ycd4Bzn8Gao
        dTx5cfPScVke0YSXzyMcwr9qh9+A1SzvP+xPLNYAtJbN87NApycHvx6ikH1sF9PQFqu+X6
        ic7vyMuUPHxNCiOzUucaKbQsTqMHRvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-GYOaYCb-NWC70J2HhBvwiw-1; Sat, 01 May 2021 11:19:34 -0400
X-MC-Unique: GYOaYCb-NWC70J2HhBvwiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A2D5801107;
        Sat,  1 May 2021 15:19:33 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7202B1D0;
        Sat,  1 May 2021 15:19:29 +0000 (UTC)
Date:   Sat, 1 May 2021 11:19:28 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210501151928.GA12518@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de>
 <20210420143852.GB14523@redhat.com>
 <6a22337b0d15830d9117640bd227711ba8c8aef8.camel@redhat.com>
 <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2df22ef-583e-1d80-6ea7-2edfe61b9b53@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 01 2021 at  7:58am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 4/20/21 5:46 PM, Laurence Oberman wrote:
> [ .. ]
> >
> >Let me add some reasons why as primarily a support person that this is
> >important and try avoid another combative situation.
> >
> >Customers depend on managing device-mapper-multipath the way it is now
> >even with the advent of nvme-over-F/C. Years of administration and
> >management for multiple Enterprise O/S vendor customers (Suse/Red Hat,
> >Oracle) all depend on managing multipath access in a transparent way.
> >
> >I respect everybody's point of view here but native does change log
> >alerting and recovery and that is what will take time for customers to
> >adopt.
> >
> >It is going to take time for Enterprise customers to transition so all
> >we want is an option for them. At some point they will move to native
> >but we always like to keep in step with upstream as much as possible.
> >
> >Of course we could live with RHEL-only for while but that defeats our
> >intention to be as close to upstream as possible.
> >
> >If we could have this accepted upstream for now perhaps when customers
> >are ready to move to native only we could phase this out.
> >
> >Any technical reason why this would not fly is of course important to
> >consider but perhaps for now we have a parallel option until we dont.
> >
> Curiously, we (as in we as SLES developers) have found just the opposite.
> NVMe is a new technology, and out of necessity there will not be any
> existing installations where we have to be compatible with.
> We have switched to native NVMe multipathing with SLE15, and decided
> to educate customers that NVMe is a different concept than SCSI, and
> one shouldn't try treat both the same way.

As you well know: dm-multipath was first engineered to handle SCSI, and
it was too tightly coupled at the start, but the scsi_dh interface
provided sorely missing abstraction. With NVMe, dm-multipath was
further enhanced to not do work only needed for SCSI.

Seems SUSE has forgotten that dm-multipath has taken strides to properly
abstract away SCSI specific details, at least this patchset forgot it
(because proper layering/abstraction is too hard? that mantra is what
gave native NVMe multipath life BTW):
https://patchwork.kernel.org/project/dm-devel/list/?series=475271

Long story short, there is utility in dm-multipath being transport
agnostic with specialized protocol specific bits properly abstracted.

If you or others don't care about any of that anymore, that's fine! But
it doesn't mean others don't. Thankfully both can exist perfectly fine,
sadly that clearly isn't possible without absurd tribal fighting (at
least in the context of NVMe).

And to be clear Hannes: your quick review of this patchset couldn't have
been less helpful or informed. Yet it enabled NVMe maintainers to ignore
technical review (you gave them cover).

The lack of proper technical review of this patchset was astonishing but
hch's dysfunctional attack that took its place really _should_ concern
others. Seems it doesn't, must be nice to not have a dog in the fight
other than philosophical ideals that enable turning a blind eye.

> This was helped by the
> fact the SLE15 is a new release, so customers were accustomed to
> having to change bits and pieces in their infrastructure to support
> new releases.

Sounds like you either have very few customers and/or they don't use
layers that were engineered with dm-multipath being an integral layer
in the IO stack. That's fine, but that doesn't prove anything other
than your limited experience.

> Overall it worked reasonably well; we sure found plenty of bugs, but
> that was kind of expected, and for bad or worse nearly all of them
> turned out to be upstream issues. Which was good for us (nothing
> beats being able to blame things on upstream, if one is careful to
> not linger too much on the fact that one is part of upstream); and
> upstream these things will need to be fixed anyway.
> So we had a bit of a mixed experience, but customers seemed to be
> happy enough with this step.
> 
> Sorry about that :-)

Nothing to be sorry about, good on you and the others at SUSE
engineering for improving native NVMe multipathing. Red Hat supports it
too, so your and others' efforts are appreciated there.

Mike

