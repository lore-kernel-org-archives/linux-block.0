Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A0DC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEACD2078D
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czvFoZGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIORHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbgIORGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600189567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaAIY3trIyVJDCQ4cdD1VjusVArdzvlkB+UMbdJlbPw=;
        b=czvFoZGOdAqHd1GLoqfpHe9+UhmjFMe63Os05jtI2eLLy7gOqESjQsBHSoloT43twoAb2o
        Y5ci7QhJt5ecE4VU8MgdIlLqMeFNYteR7HVPcS7D89/QpGTsHsB3vx8Bnq6zdlFvz7F8M2
        YvoZnZTHtj1RhL2WiNzWu1xp/iQXYuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-dFrDnAaCMwGdMtYKDyf-1g-1; Tue, 15 Sep 2020 13:04:00 -0400
X-MC-Unique: dFrDnAaCMwGdMtYKDyf-1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 715B910074D8;
        Tue, 15 Sep 2020 17:03:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A4F275145;
        Tue, 15 Sep 2020 17:03:34 +0000 (UTC)
Date:   Tue, 15 Sep 2020 13:03:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Vijayendra Suman <vijayendra.suman@oracle.com>
Cc:     linux-block@vger.kernel.org,
        Somu Krishnasamy <somasundaram.krishnasamy@oracle.com>,
        dm-devel@redhat.com,
        RAMANAN_GOVINDARAJAN <ramanan.govindarajan@oracle.com>
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
Message-ID: <20200915170333.GA20998@redhat.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
 <20200910142438.GA21919@redhat.com>
 <5261af10-bf5c-f768-dbeb-2e784a5823f9@oracle.com>
 <20200915013308.GA14877@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915013308.GA14877@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14 2020 at  9:33pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Sep 10 2020 at  3:29pm -0400,
> Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
> 
> > Hello Mike,
> > 
> > I checked with upstream, performance measurement is similar and
> > shows performance improvement when
> > 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 is reverted.
> > 
> > On 9/10/2020 7:54 PM, Mike Snitzer wrote:
> > >[cc'ing dm-devel and linux-block because this is upstream concern too]
> > >
> > >On Wed, Sep 09 2020 at  1:00pm -0400,
> > >Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
> > >
> > >>    Hello Mike,
> > >>
> > >>    While Running pgbench tool with  5.4.17 kernel build
> > >>
> > >>    Following performance degrade is found out
> > >>
> > >>    buffer read/write metric : -17.2%
> > >>    cache read/write metric : -18.7%
> > >>    disk read/write metric : -19%
> > >>
> > >>    buffer
> > >>    number of transactions actually processed: 840972
> > >>    latency average = 24.013 ms
> > >>    tps = 4664.153934 (including connections establishing)
> > >>    tps = 4664.421492 (excluding connections establishing)
> > >>
> > >>    cache
> > >>    number of transactions actually processed: 551345
> > >>    latency average = 36.949 ms
> > >>    tps = 3031.223905 (including connections establishing)
> > >>    tps = 3031.402581 (excluding connections establishing)
> > >>
> > >>    After revert of Commit
> > >>    2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
> > >>    blk_queue_split() in dm_process_bio()")
> > >
> > >I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
> > >backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?
> >
> > Yes
> >
> > >>    Performance is Counter measurement
> > >>
> > >>    buffer ->
> > >>    number of transactions actually processed: 1135735
> > >>    latency average = 17.799 ms
> > >>    tps = 6292.586749 (including connections establishing)
> > >>    tps = 6292.875089 (excluding connections establishing)
> > >>
> > >>    cache ->
> > >>    number of transactions actually processed: 648177
> > >>    latency average = 31.217 ms
> > >>    tps = 3587.755975 (including connections establishing)
> > >>    tps = 3587.966359 (excluding connections establishing)
> > >>
> > >>    Following is your commit
> > >>
> > >>    diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > >>    index cf71a2277d60..1e6e0c970e19 100644
> > >>    --- a/drivers/md/dm.c
> > >>    +++ b/drivers/md/dm.c
> > >>    @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
> > >>    *md,
> > >>             * won't be imposed.
> > >>             */
> > >>            if (current->bio_list) {
> > >>    -               blk_queue_split(md->queue, &bio);
> > >>    -               if (!is_abnormal_io(bio))
> > >>    +               if (is_abnormal_io(bio))
> > >>    +                       blk_queue_split(md->queue, &bio);
> > >>    +               else
> > >>                            dm_queue_split(md, ti, &bio);
> > >>            }
> > >>
> > >>    Could you have a look if it is safe to revert this commit.
> > >No, it really isn't a good idea given what was documented in the commit
> > >header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
> > >excessive splitting is not conducive to performance either.
> > >
> > >So I think we need to identify _why_ reverting this commit is causing
> > >such a performance improvement.  Why is calling blk_queue_split() before
> > >dm_queue_split() benefiting your pgbench workload?
> >
> > Let me know if you want to check some patch.
> 
> Hi,
> 
> Could you please test this branch?:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.10
> (or apply at least the first 4 patches, commit 63f85d97be69^..b6a80963621fa)
> 
> So far I've done various DM regression testing.  But I haven't tested
> with pgbench or with the misaaligned IO scenario documented in the
> header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74.  But I'll
> test that scenario tomorrow.

Training DM core to set chunk_sectors and always use blk_queue_split
resolves the inefficient splitting documented in the header for
commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74.

xfs_io -d -c 'pread -b 2m 224s 4072s' /dev/mapper/stripe_dev

before, so with commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74:

253,2    5        1     0.000000000  4382  Q   R 224 + 2064 [xfs_io]
253,2    5        2     0.000003414  4382  X   R 224 / 256 [xfs_io]
253,2    5        3     0.000017838  4382  X   R 256 / 512 [xfs_io]
253,2    5        4     0.000019852  4382  X   R 512 / 768 [xfs_io]
253,2    5        5     0.000031316  4382  X   R 768 / 1024 [xfs_io]
253,2    5        6     0.000034333  4382  X   R 1024 / 1280 [xfs_io]
253,2    5        7     0.000037684  4382  X   R 1280 / 1536 [xfs_io]
253,2    5        8     0.000041011  4382  X   R 1536 / 1792 [xfs_io]
253,2    5        9     0.000043962  4382  X   R 1792 / 2048 [xfs_io]
253,2    5       10     0.000074765  4382  Q   R 2288 + 2008 [xfs_io]
253,2    5       11     0.000075020  4382  X   R 2288 / 2304 [xfs_io]
253,2    5       12     0.000077009  4382  X   R 2304 / 2560 [xfs_io]
253,2    5       13     0.000080509  4382  X   R 2560 / 2816 [xfs_io]
253,2    5       14     0.000084182  4382  X   R 2816 / 3072 [xfs_io]
253,2    5       15     0.000087274  4382  X   R 3072 / 3328 [xfs_io]
253,2    5       16     0.000090342  4382  X   R 3328 / 3584 [xfs_io]
253,2    5       17     0.000095348  4382  X   R 3584 / 3840 [xfs_io]
253,2    5       18     0.000097776  4382  X   R 3840 / 4096 [xfs_io]

after, so with 'dm-5.10' branch refernced above, meaning dm_process_bio
w/ unconditional blk_queue_split (w/ chunk_sectors):

253,2   17        1     0.000000000  2176  Q   R 224 + 2280 [xfs_io]
253,2   17        2     0.000001978  2176  X   R 224 / 256 [xfs_io]
253,2   17        3     0.000017882  2176  X   R 256 / 512 [xfs_io]
253,2   17        4     0.000020406  2176  X   R 512 / 768 [xfs_io]
253,2   17        5     0.000031298  2176  X   R 768 / 1024 [xfs_io]
253,2   17        6     0.000034654  2176  X   R 1024 / 1280 [xfs_io]
253,2   17        7     0.000038474  2176  X   R 1280 / 1536 [xfs_io]
253,2   17        8     0.000042299  2176  X   R 1536 / 1792 [xfs_io]
253,2   17        9     0.000054088  2176  X   R 1792 / 2048 [xfs_io]
253,2   17       10     0.000057884  2176  X   R 2048 / 2304 [xfs_io]
253,2   17       11     0.000081358  2176  Q   R 2504 + 1792 [xfs_io]
253,2   17       12     0.000081778  2176  X   R 2504 / 2560 [xfs_io]
253,2   17       13     0.000083496  2176  X   R 2560 / 2816 [xfs_io]
253,2   17       14     0.000085301  2176  X   R 2816 / 3072 [xfs_io]
253,2   17       15     0.000092374  2176  X   R 3072 / 3328 [xfs_io]
253,2   17       16     0.000094774  2176  X   R 3328 / 3584 [xfs_io]
253,2   17       17     0.000097977  2176  X   R 3584 / 3840 [xfs_io]
253,2   17       18     0.000100094  2176  X   R 3840 / 4096 [xfs_io]

> Any chance you could provide some hints on how you're running pgbench
> just so I can try to test/reproduce/verify locally?

I'm going to defer to you on pgbench testing.

What is your underlying storage?

Could it be that DM using unconditional blk_queue_split() is helping
your pgbench workload because it splits IO more (so smaller IO, lower
latency per IO)?

Do you have comparison blktrace data?

Mike

