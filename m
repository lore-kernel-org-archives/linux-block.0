Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45294C2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CB924653
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXtV+cC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUNs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:48:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43499 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgAUNs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 08:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579614534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sry8glaf+2eDUM7x4dnclmuXsj6ELrKrtRIG9vYSZo=;
        b=VXtV+cC/l0X4NcShyX55iJu8dipc39kgu5OYrIFZZ1vNysCMXtumh+WVEl/TfVJ/NMQzts
        8LQeRzwWZolBykFvvdpYl9lChyIo3vtuc+1l4yfN3nsEdQpSsBKOARZMH7G4ft7pGI+PY5
        1DYsY9mg5r4fIkKX//rCAfqtRN3GghY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-X16t49KjNWKuSIvbi2LOzg-1; Tue, 21 Jan 2020 08:48:50 -0500
X-MC-Unique: X16t49KjNWKuSIvbi2LOzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20246107ACC4;
        Tue, 21 Jan 2020 13:48:47 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77D6C7DB5D;
        Tue, 21 Jan 2020 13:48:41 +0000 (UTC)
Date:   Tue, 21 Jan 2020 08:48:40 -0500
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
Message-ID: <20200121134840.GA9944@redhat.com>
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
 <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
 <20200121122458.GA9365@redhat.com>
 <f7e0fb38-a894-da33-c46b-e192ed907ee0@virtuozzo.com>
 <619a7a14-44e6-eca7-c1ea-3f04abeee53d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619a7a14-44e6-eca7-c1ea-3f04abeee53d@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 21 2020 at  8:33am -0500,
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> On 21.01.2020 15:36, Kirill Tkhai wrote:
> > On 21.01.2020 15:24, Mike Snitzer wrote:
> >> On Tue, Jan 21 2020 at  5:42am -0500,
> >> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >>> Since dm inherits limits from underlining block devices,
> >>> this patch directly disables max_allocate_sectors for dm
> >>> till full allocation support is implemented.
> >>>
> >>> This prevents high-level primitives (generic_make_request_checks(),
> >>> __blkdev_issue_write_zeroes(), ...) from sending REQ_ALLOCATE
> >>> requests.
> >>>
> >>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >>> ---
> >>>  drivers/md/dm-table.c |    2 ++
> >>>  drivers/md/md.h       |    1 +
> >>>  2 files changed, 3 insertions(+)
> >>
> >> You're mixing DM and MD changes in the same patch.
> >>
> >> But I'm wondering if it might be best to set this default for stacking
> >> devices in blk_set_stacking_limits()?
> >>
> >> And then it is up to each stacking driver to override as needed.
> > 
> > Hm. Sound like a good idea. This "lim->max_allocate_sectors = 0" in blk_set_stacking_limits()
> > should work for dm's dm_calculate_queue_limits(), since it calls blk_stack_limits(), which is:
> > 
> > 	t->max_allocate_sectors = min(t->max_allocate_sectors,
> > 				      b->max_allocate_sectors);
> > 
> > Could you please tell is this fix is also enough for md?
> 
> It looks like it's enough since queue defaults are set in md_alloc()->blk_set_stacking_limits().
> In case of we set "max_allocate_sectors = 0", in further it can be changed only manually,
> but nobody does this.

Yes, it will work to disable this capability for MD and DM.

But if/when a stacked device _dooes_ want to support this then it'll be
awkward to override this stacking default to allow blk_stack_limits()
to properly stack up this limit.  blk_limits are extremely fiddley so
this isn't necessarily new.  But by explicitly defaulting to 0 and then
having blk_stack_limits use min() for this limit: it results in stacking
drivers needing to clumsily unwind the default.  E.g. DM will need to
tweak its blk_stack_limits() related code to allow override that
actually _does_  stack up the underlying devices' capability (and not
just impose its own limit that ignores the underlying devices).

So I'm not convinced this is the right way to go (be it the v4 approach
you took or the cleaner use of blk_set_stacking_limits I suggested).

And to be clear, I'm interested in having DM thinp support this
capability to preallocate blocks.

Mike

