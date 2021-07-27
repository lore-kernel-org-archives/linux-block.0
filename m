Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5EC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5060FA0
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhG0KnP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 06:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236212AbhG0KnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 06:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LK/Cw9dtZ2TMRxaIdRMYKSYbv2+yKBDFm/qg6Jb2IIs=;
        b=W4uYqbIMMQM5OzS5gKle1RFbHbujjuxladaMmdFqFUHEvKnJWaWdGbiqG1bwwj2luJa0mS
        4uTe1eLh2jtcaiWrM3gALD9bwS9IhcBRftlIlFu3uuTYPpdwbQD58MQWrIQwjW6n/58XsD
        3TPaoxFtMXsuy12PPQ1lv8/2FcBAsn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-juWnEyWsPUWdMamXg_wqJA-1; Tue, 27 Jul 2021 06:43:14 -0400
X-MC-Unique: juWnEyWsPUWdMamXg_wqJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921A0107ACF5;
        Tue, 27 Jul 2021 10:43:12 +0000 (UTC)
Received: from T590 (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0762C10023B0;
        Tue, 27 Jul 2021 10:43:05 +0000 (UTC)
Date:   Tue, 27 Jul 2021 18:43:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error
 handling
Message-ID: <YP/jOJZTFM2llXyC@T590>
References: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
 <YP/atlyuacbHF/sp@T590>
 <e0c47dfe-4774-358d-6e1d-22fa98865d57@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c47dfe-4774-358d-6e1d-22fa98865d57@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 11:30:00AM +0100, John Garry wrote:
> On 27/07/2021 11:06, Ming Lei wrote:
> > On Tue, Jul 27, 2021 at 05:32:53PM +0800, John Garry wrote:
> > > If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
> > > call blk_mq_sched_free_tags() -> blk_mq_free_rqs().
> > > 
> > > It is incorrect to do so, as any rqs would have already been freed in the
> > > blk_mq_alloc_rqs() call.
> > > 
> > > Fix by calling blk_mq_free_rq_map() only directly.
> > > 
> > > Fixes: 6917ff0b5bd41 ("blk-mq-sched: refactor scheduler initialization")
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > Not sure it is one fix, because blk_mq_free_rqs() does nothing when
> > ->static_rqs[] isn't filled, so 'Fixes' tag isn't needed, IMO.
> 
> I actually experimented by returning an error from blk_mq_sched_alloc_tags()
> -> blk_mq_alloc_rqs() at the function entry point, and it crashes:
> 
> [8.118419]
> ==================================================================
> [8.125677] BUG: KASAN: null-ptr-deref in blk_mq_free_rqs+0x170/0x380

OK, looks it is caused by un-initialized &tags->page_list, then it is fine
to mark it as fixes.

-- 
Ming

