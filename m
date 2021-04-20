Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB26C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2477D613C4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhDTOjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 10:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhDTOjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 10:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618929542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+yEmtDQxZnRobM2yTHXpbpllEHKIzCjW0+95zQCocs=;
        b=hOa1IrSZI/kgG1K26nxhAWj6wDC9IYsRhOTmDqXGmrq1bnsFfBOP1/sK/OzzN/eNd3ec8E
        ARIN34w4r5nmm2+ujO6Ptl5Wx9wKLgyHKy1eaELPR/7jSX/aKvdxssRF7kun1hTgLsQpjR
        8v/CeezPRPHB0xbzeSHoqXKRAJ7Ex/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-U5yStXyBOxa8G8siGMqhHw-1; Tue, 20 Apr 2021 10:38:59 -0400
X-MC-Unique: U5yStXyBOxa8G8siGMqhHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FF08189C6;
        Tue, 20 Apr 2021 14:38:56 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD2C60916;
        Tue, 20 Apr 2021 14:38:53 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:38:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210420143852.GB14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420093720.GA28874@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20 2021 at  5:37am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> > RHEL9 is coming, would really prefer that these changes land upstream
> > rather than carry them within RHEL.
> 
> We've told from the very beginning that dm-multipth on nvme is not
> a support configuration.

You have some high quality revisionist history there. But other than
pointing that out I'm not going to dwell on our past discussions on how
NVMe multipathing would be.

> Red Hat decided to ignore that and live with the pain.

Red Hat supports both native nvme-multipath _and_ DM-multipath on NVMe.

The only "pain" I've been living with is trying to get you to be
impartial and allow others to provide Linux multipathing as they see
fit.

> Your major version change is a chance to fix this up on the Red Hat
> side, not to resubmit bogus patches upstream.

Please spare me the vapid and baseless assertion about patches you
refuse to review technically without political motivation.

> In other words: please get your house in order NOW.

My simple 3 patch submission was an attempt to do so. Reality is the
Linux NVMe maintainers need to get their collective house in order.

Until sanity prevails these NVMe changes will be carried in RHEL. And if
you go out of your way to cause trivial, or elaborate, conflicts now
that you _know_ that changes that are being carried it will be handled
without issue.

Sad this is where we are but it is what it is.

Linux is about choice that is founded upon need. Hostile action that
unilaterally limits choice is antithetical to Linux and Open Source.

Mike

