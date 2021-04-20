Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA3C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2179F613B8
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhDTOSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 10:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbhDTOSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 10:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618928258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMvyKj25gjB0oXytYH0t3C8VbQ+294kybBDKJCOZKyo=;
        b=X1k4GhugVE21ETSKNZe9tOv9eBLgWSfusScvJIJOA78Zz9AiC0azg6Bx1sGPK3P1E6SGqS
        7IB2hRXwnFtFUZLUlAmM4y2uXNY5qq0s0nJinkUGOMvkXZJa25hoisOJqWE3le0eRWr4H6
        jGkdgbrpAVKghkRPt4xRValulwPUf2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-SB2yQHMNNICkIdFP3lYE2w-1; Tue, 20 Apr 2021 10:17:36 -0400
X-MC-Unique: SB2yQHMNNICkIdFP3lYE2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58C6E10CE782;
        Tue, 20 Apr 2021 14:17:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 268A26061F;
        Tue, 20 Apr 2021 14:17:35 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:17:34 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read support
 from native multipathing
Message-ID: <20210420141734.GA14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210416235329.49234-4-snitzer@redhat.com>
 <20210420093453.GB28625@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420093453.GB28625@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20 2021 at  5:34am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Apr 16, 2021 at 07:53:29PM -0400, Mike Snitzer wrote:
> > Whether or not ANA is present is a choice of the target implementation;
> > the host (and whether it supports multipathing) has _zero_ influence on
> > this. If the target declares a path as 'inaccessible' the path _is_
> > inaccessible to the host. As such, ANA support should be functional
> > even if native multipathing is not.

As you well know, ANA is decoupled from multipathing in the NVMe spec.
This fix illustrates that the existing Linux NVMe ANA handling is too
tightly coupled with native NVMe multipathing. Unfortunately, you've
forced this as a means to impose your political position:

> NAK.  nvme-multipathing is the only supported option for subsystems with
> multiple controllers.

And while this is largely irrelevant to the technical review of my fix:
native nvme-multipath may be the only supported option in your world. In
mine that isn't true and never has been.

Your political posturing doesn't replace technical justification. You
don't have a compelling technical case to take the stance you do, yet
you guard it like you do. Just a really stark inconsistency in your
technical leadership that is repeatedly left unchecked by others.

Alas.

