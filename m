Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB3C433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 01:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiCEBo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiCEBo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 20:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 940F6427DE
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646444613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZg5W4+QO1ldfqjf7DwPUgXUcbNTXwE2vv+mGlD6UBs=;
        b=NvytdDa0OFqW06EfWdP47CPeANKWbSUDSjmv5I7G1vSjnmqUE3K9B0UpdTUScnOWLQJiri
        CkrrYBSvvE2XfL0m4xoVgXeh/kQrYq6A1N5z385GD9l+bXuFJ62gNHyYI8C6r+G7Y4Y7YK
        Vcw/kAqqej2NhiO58csSzp/TNk9QeK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-A9j71LrsMGOAX69xWIGRVg-1; Fri, 04 Mar 2022 20:43:30 -0500
X-MC-Unique: A9j71LrsMGOAX69xWIGRVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 775031854E21;
        Sat,  5 Mar 2022 01:43:29 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88D524BC7A;
        Sat,  5 Mar 2022 01:43:05 +0000 (UTC)
Date:   Sat, 5 Mar 2022 09:43:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/2] block/dm: support bio polling
Message-ID: <YiLAJIOZz9UHbUKq@T590>
References: <20220304212623.34016-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304212623.34016-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 04, 2022 at 04:26:21PM -0500, Mike Snitzer wrote:
> Hi,
> 
> I've rebased Ming's latest [1] ontop of dm-5.18 [2] (which is based on
> for-5.18/block). End result available in dm-5.18-biopoll branch [3]
> 
> These changes add bio polling support to DM.  Tested with linear and
> striped DM targets.
> 
> IOPS improvement was ~5% on my baremetal system with a single Intel
> Optane NVMe device (555K hipri=1 vs 525K hipri=0).
> 
> Ming has seen better improvement while testing within a VM:
>  dm-linear: hipri=1 vs hipri=0 15~20% iops improvement
>  dm-stripe: hipri=1 vs hipri=0 ~30% iops improvement
> 
> I'd like to merge these changes via the DM tree when the 5.18 merge
> window opens.  The first block patch that adds ->poll_bio to
> block_device_operations will need review so that I can take it
> through the DM tree.  Reason for going through the DM tree is there
> have been some fairly extensive changes queued in dm-5.18 that build
> on for-5.18/block.  So I think it easiest to just add the block
> depenency via DM tree since DM is first consumer of ->poll_bio
> 
> FYI, Ming does have another DM patch [4] that looks to avoid using
> hlist but I only just saw it.  bio_split() _is_ involved (see
> dm_split_and_process_bio) so I'm not exactly sure where he is going
> with that change. 

io_uring(polling) workloads often cares latency, so big IO request
isn't involved usually, I guess. Then bio_split() is seldom called in
dm_split_and_process_bio(), such as if 4k random IO is run on dm-linear
or dm-stripe via io_uring, bio_split() won't be run into.

Single list is enough here, and efficient than hlist, just need
a little care to delete element from the list since linux kernel doesn't
have generic single list implementation.

> But that is DM-implementation detail that we'll
> sort out.

Yeah, that patch also needs more test.


Thanks, 
Ming

