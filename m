Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90FC2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBBE2073A
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHM+BReN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgAUMZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:25:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgAUMZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 07:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579609512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksHPSbakxXNR8cEUw6z99EW4vRwmmJQjKBoAiN1aeVg=;
        b=UHM+BReNr1/53eHcdfiXlOkxU7imFlI9Rt/2/RWHWtgF9d25PW+rCcmIpXv2Zjb0r/m/rH
        Boy6eFA0w0u97JRghX4gb6E18jwJNw+LIue031WwLo9LAVswXOp+RtkgnrOJ5ve5XrFTvX
        7Q1bYKnuglImwSVaSAIuzGmdmEpYA7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-cTu5te75Nq2wWKiYoY0C_g-1; Tue, 21 Jan 2020 07:25:09 -0500
X-MC-Unique: cTu5te75Nq2wWKiYoY0C_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1CF3800D4C;
        Tue, 21 Jan 2020 12:25:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B78508BE17;
        Tue, 21 Jan 2020 12:24:59 +0000 (UTC)
Date:   Tue, 21 Jan 2020 07:24:59 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, dm-devel@redhat.com, song@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH v4 6/7] dm: Directly disable max_allocate_sectors for now
Message-ID: <20200121122458.GA9365@redhat.com>
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
 <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 21 2020 at  5:42am -0500,
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Since dm inherits limits from underlining block devices,
> this patch directly disables max_allocate_sectors for dm
> till full allocation support is implemented.
> 
> This prevents high-level primitives (generic_make_request_checks(),
> __blkdev_issue_write_zeroes(), ...) from sending REQ_ALLOCATE
> requests.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  drivers/md/dm-table.c |    2 ++
>  drivers/md/md.h       |    1 +
>  2 files changed, 3 insertions(+)

You're mixing DM and MD changes in the same patch.

But I'm wondering if it might be best to set this default for stacking
devices in blk_set_stacking_limits()?

And then it is up to each stacking driver to override as needed.

Mike

