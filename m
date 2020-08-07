Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C899C433E1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523F421744
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSKIwXro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGQUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:20:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726013AbgHGQUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596817233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMPDP9XQsj5mXOlGNwxFwliNhcRlrtrFyC5zgNTgfvs=;
        b=iSKIwXrookUy5r+TQy6qiau40PKF6Dd25FgeaTUImcFE493NlVlKnYhk6wdPU426Ku+K2s
        uVvO71YKYJ4rWpxinfCGeTEiC/fN8ZSOAU0U+Abg4wL8+oN0IjRH5FhE2nK1sfrv3qt7EA
        tKzgsoBHzdijVjUg5SmwyK5RYOFI1Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-KJFjLhRkOauqD6sVbeStUg-1; Fri, 07 Aug 2020 12:20:32 -0400
X-MC-Unique: KJFjLhRkOauqD6sVbeStUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32B6801A03;
        Fri,  7 Aug 2020 16:20:30 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D321002382;
        Fri,  7 Aug 2020 16:20:21 +0000 (UTC)
Date:   Fri, 7 Aug 2020 12:20:21 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [git pull] device mapper changes for 5.9
Message-ID: <20200807162021.GA1065@redhat.com>
References: <20200807160327.GA977@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807160327.GA977@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 07 2020 at 12:03pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> Hi Linus,
> 
> The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:
> 
>   Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-changes
> 
> for you to fetch changes up to a9cb9f4148ef6bb8fabbdaa85c42b2171fbd5a0d:
> 
>   dm: don't call report zones for more than the user requested (2020-08-04 16:31:12 -0400)
> 
> Please pull, thanks!
> Mike
> 
> ----------------------------------------------------------------
> - DM multipath locking fixes around m->flags tests and improvements to
>   bio-based code so that it follows patterns established by
>   request-based code.
> 
> - Request-based DM core improvement to eliminate unnecessary call to
>   blk_mq_queue_stopped().
> 
> - Add "panic_on_corruption" error handling mode to DM verity target.
> 
> - DM bufio fix to to perform buffer cleanup from a workqueue rather
>   than wait for IO in reclaim context from shrinker.
> 
> - DM crypt improvement to optionally avoid async processing via
>   workqueues for reads and/or writes -- via "no_read_workqueue" and
>   "no_write_workqueue" features.  This more direct IO processing
>   improves latency and throughput with faster storage.  Avoiding
>   workqueue IO submission for writes (DM_CRYPT_NO_WRITE_WORKQUEUE) is
>   a requirement for adding zoned block device support to DM crypt.

I forgot to note that you'll get a trivial merge conflict in dm-crypt.c
due to commit ed00aabd5eb9f (" block: rename generic_make_request to
submit_bio_noacct").

Mike

