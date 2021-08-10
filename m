Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A7C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 00:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E0860F38
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 00:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhHJARr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 20:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhHJARn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 20:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628554642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pJ9mtGT8YizJJRqVC041LrTmK6DM9Sov7/CV20wokc=;
        b=hBgsdi+lXj0SKZaQDOmqvZfnLEVSgu7eZ/vgirTBCoY4i9m4s5eQt0guaWlkd61VGLKdEZ
        Xecr6m1mHT87aNbxUAlXh9g9IychNS/oldAS/fUKdnQpbB/GxD/SQKxvaDZc1YsdB/pDdb
        lQcMyMNTWdO6/BnYmD0/VBES8xPX3E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-SGbWsb1NPz-xDhzMXnwxcg-1; Mon, 09 Aug 2021 20:17:20 -0400
X-MC-Unique: SGbWsb1NPz-xDhzMXnwxcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C51187504B;
        Tue, 10 Aug 2021 00:17:19 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C307366FFF;
        Tue, 10 Aug 2021 00:17:08 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id C86B642C4190; Tue, 10 Aug 2021 01:17:09 +0100 (BST)
Date:   Tue, 10 Aug 2021 01:17:09 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        prajnoha@redhat.com
Subject: Re: [dm-devel] [PATCH 7/8] dm: delay registering the gendisk
Message-ID: <20210810001709.GA101579@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        prajnoha@redhat.com
References: <20210804094147.459763-8-hch@lst.de>
 <20210809233143.GA101480@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809233143.GA101480@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 12:31:43AM +0100, Alasdair G Kergon wrote:
> When loading tables, our tools also always refer to devices using
> the 'major:minor' format, which isn't affected, rather than using
                            ^^^^^^^^^^^^^^^^^^^^
Wrong - that is also affected.

So there is a new general constraint that a table must be loaded into a
device before another device's table can reference that device.  (The
stacked device handling in lvm2 as supported by libdevmapper should
always be doing this.)

(The original implementation had to be a bit loose to accommodate
multipath device paths that were essentially placeholders at the point
they got set up.)

Alasdair

