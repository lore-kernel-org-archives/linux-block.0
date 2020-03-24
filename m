Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA1BC10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DBA20714
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLx97bsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCXDxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:53:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41872 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbgCXDxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 23:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585022002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Foa5EtPSVO2fQmVu7TAxz60TcHedluqsObJcm8gkuiE=;
        b=OLx97bsgd5qTRspIih42uBYes96sYZxq9NbLDT6m727sJWlgfNwu+c7GfF6C4jNGuFsA8h
        nxtqOeTeHbiOpPVo8az+LXs6BeHLHaVW+5GpYzeYTZqt0+QCU+dnjYlxN/2lMEmt+rq1ze
        dhjoWpbW0P03kDwgaKKscvjnXv8Ffx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-SJCKVWLsNgCFcyy8T7aAUw-1; Mon, 23 Mar 2020 23:53:19 -0400
X-MC-Unique: SJCKVWLsNgCFcyy8T7aAUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DF8A107ACC4;
        Tue, 24 Mar 2020 03:53:18 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C97A19C6A;
        Tue, 24 Mar 2020 03:53:15 +0000 (UTC)
Date:   Mon, 23 Mar 2020 23:53:14 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        mpatocka@redhat.com,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: very inaccurate %util of iostat
Message-ID: <20200324035313.GE30700@redhat.com>
References: <20200324031942.GA3060@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324031942.GA3060@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23 2020 at 11:19pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Hi Guys,
> 
> Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> changes calculation of 'io_ticks' a lot.
> 
> In theory, io_ticks counts the time when there is any IO in-flight or in-queue,
> so it has to rely on in-flight counting of IO.
> 
> However, commit 5b18b5a73760 changes io_ticks's accounting into the
> following way:
> 
> 	stamp = READ_ONCE(part->stamp);
> 	if (unlikely(stamp != now)) {
> 		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> 			__part_stat_add(part, io_ticks, 1);
> 	}
> 
> So this way doesn't use any in-flight IO's info, simply adding 1 if stamp
> changes compared with previous stamp, no matter if there is any in-flight
> IO or not.
> 
> Now when there is very heavy IO on disks, %util is still much less than
> 100%, especially on HDD, the reason could be that IO latency can be much more
> than 1ms in case of 1000HZ, so the above calculation is very inaccurate.
> 
> Another extreme example is that if IOs take long time to complete, such
> as IO stall, %util may show 0% utilization, instead of 100%.

Hi Ming,

Your email triggered a memory of someone else (Konstantin Khlebnikov)
having reported and fixed this relatively recently, please see this
patchset: https://lkml.org/lkml/2020/3/2/336

Obviously this needs fixing.  If you have time to review/polish the
proposed patches that'd be great.

Mike

