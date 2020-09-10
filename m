Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB6C43461
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EDB221E5
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtFaCt5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIJVVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731126AbgIJOZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 10:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599747885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2uRnQnP1ed2gvxzbsFcdmIP/DbyExQBxh8KjxEaNic=;
        b=CtFaCt5WXmS0QgE3CzBgcje4dUC3509oM7+1QAr5q0hKlAq/JwVyECUXRKKD+TrOsoobgV
        sSRs4AQCyT6pvbhWiKhPkJOgKvIYARYxWRSOpkXh/cydSNHQF14ny9s7KC8I7/pjGhRC8q
        dx5fYZwnIWSJSrocKa/QGuEN2Optzko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-YRVyuaNbMAaD2OIllsioxA-1; Thu, 10 Sep 2020 10:24:44 -0400
X-MC-Unique: YRVyuaNbMAaD2OIllsioxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106CF80EF8C;
        Thu, 10 Sep 2020 14:24:43 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD6D27BDD;
        Thu, 10 Sep 2020 14:24:39 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:24:39 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Vijayendra Suman <vijayendra.suman@oracle.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
Message-ID: <20200910142438.GA21919@redhat.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[cc'ing dm-devel and linux-block because this is upstream concern too]

On Wed, Sep 09 2020 at  1:00pm -0400,
Vijayendra Suman <vijayendra.suman@oracle.com> wrote:

>    Hello Mike,
> 
>    While Running pgbench tool with  5.4.17 kernel build
> 
>    Following performance degrade is found out
> 
>    buffer read/write metric : -17.2%
>    cache read/write metric : -18.7%
>    disk read/write metric : -19%
> 
>    buffer
>    number of transactions actually processed: 840972
>    latency average = 24.013 ms
>    tps = 4664.153934 (including connections establishing)
>    tps = 4664.421492 (excluding connections establishing)
> 
>    cache
>    number of transactions actually processed: 551345
>    latency average = 36.949 ms
>    tps = 3031.223905 (including connections establishing)
>    tps = 3031.402581 (excluding connections establishing)
> 
>    After revert of Commit
>    2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
>    blk_queue_split() in dm_process_bio()")

I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?

>    Performance is Counter measurement
> 
>    buffer ->
>    number of transactions actually processed: 1135735
>    latency average = 17.799 ms
>    tps = 6292.586749 (including connections establishing)
>    tps = 6292.875089 (excluding connections establishing)
> 
>    cache ->
>    number of transactions actually processed: 648177
>    latency average = 31.217 ms
>    tps = 3587.755975 (including connections establishing)
>    tps = 3587.966359 (excluding connections establishing)
> 
>    Following is your commit
> 
>    diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>    index cf71a2277d60..1e6e0c970e19 100644
>    --- a/drivers/md/dm.c
>    +++ b/drivers/md/dm.c
>    @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
>    *md,
>             * won't be imposed.
>             */
>            if (current->bio_list) {
>    -               blk_queue_split(md->queue, &bio);
>    -               if (!is_abnormal_io(bio))
>    +               if (is_abnormal_io(bio))
>    +                       blk_queue_split(md->queue, &bio);
>    +               else
>                            dm_queue_split(md, ti, &bio);
>            }
> 
>    Could you have a look if it is safe to revert this commit.

No, it really isn't a good idea given what was documented in the commit
header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
excessive splitting is not conducive to performance either.

So I think we need to identify _why_ reverting this commit is causing
such a performance improvement.  Why is calling blk_queue_split() before
dm_queue_split() benefiting your pgbench workload?

Thanks,
Mike

