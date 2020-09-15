Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143FC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB6920829
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 01:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDHZLi6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIOBdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:33:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgIOBdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 21:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600133599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=05KugUf1ZLMiv3KVgeD3PrmciWvgAl/Dm1NjOmE5L64=;
        b=VDHZLi6PhNcJ9b96KnN1dERlgJVGzVicKLL3Z599yXiYafc8L578Yyk26DNgCDSIX5zF/G
        Ud2n+GdXDQZtECjB5UCb9n5+V6EsjQjl54yqtnnrQQYRvdvIKepNnv1EuDHjErdGPD0rjM
        uMq20VYUKxY8G3jF9cj3kApFxRAnsDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-P19Sq5k6PgaSlBLuUc298Q-1; Mon, 14 Sep 2020 21:33:17 -0400
X-MC-Unique: P19Sq5k6PgaSlBLuUc298Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A3638018A7;
        Tue, 15 Sep 2020 01:33:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59CD278482;
        Tue, 15 Sep 2020 01:33:09 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:33:08 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Vijayendra Suman <vijayendra.suman@oracle.com>
Cc:     linux-block@vger.kernel.org,
        Somu Krishnasamy <somasundaram.krishnasamy@oracle.com>,
        dm-devel@redhat.com,
        RAMANAN_GOVINDARAJAN <ramanan.govindarajan@oracle.com>
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
Message-ID: <20200915013308.GA14877@redhat.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
 <20200910142438.GA21919@redhat.com>
 <5261af10-bf5c-f768-dbeb-2e784a5823f9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5261af10-bf5c-f768-dbeb-2e784a5823f9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 10 2020 at  3:29pm -0400,
Vijayendra Suman <vijayendra.suman@oracle.com> wrote:

> Hello Mike,
> 
> I checked with upstream, performance measurement is similar and
> shows performance improvement when
> 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 is reverted.
> 
> On 9/10/2020 7:54 PM, Mike Snitzer wrote:
> >[cc'ing dm-devel and linux-block because this is upstream concern too]
> >
> >On Wed, Sep 09 2020 at  1:00pm -0400,
> >Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
> >
> >>    Hello Mike,
> >>
> >>    While Running pgbench tool with  5.4.17 kernel build
> >>
> >>    Following performance degrade is found out
> >>
> >>    buffer read/write metric : -17.2%
> >>    cache read/write metric : -18.7%
> >>    disk read/write metric : -19%
> >>
> >>    buffer
> >>    number of transactions actually processed: 840972
> >>    latency average = 24.013 ms
> >>    tps = 4664.153934 (including connections establishing)
> >>    tps = 4664.421492 (excluding connections establishing)
> >>
> >>    cache
> >>    number of transactions actually processed: 551345
> >>    latency average = 36.949 ms
> >>    tps = 3031.223905 (including connections establishing)
> >>    tps = 3031.402581 (excluding connections establishing)
> >>
> >>    After revert of Commit
> >>    2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
> >>    blk_queue_split() in dm_process_bio()")
> >
> >I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
> >backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?
>
> Yes
>
> >>    Performance is Counter measurement
> >>
> >>    buffer ->
> >>    number of transactions actually processed: 1135735
> >>    latency average = 17.799 ms
> >>    tps = 6292.586749 (including connections establishing)
> >>    tps = 6292.875089 (excluding connections establishing)
> >>
> >>    cache ->
> >>    number of transactions actually processed: 648177
> >>    latency average = 31.217 ms
> >>    tps = 3587.755975 (including connections establishing)
> >>    tps = 3587.966359 (excluding connections establishing)
> >>
> >>    Following is your commit
> >>
> >>    diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> >>    index cf71a2277d60..1e6e0c970e19 100644
> >>    --- a/drivers/md/dm.c
> >>    +++ b/drivers/md/dm.c
> >>    @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
> >>    *md,
> >>             * won't be imposed.
> >>             */
> >>            if (current->bio_list) {
> >>    -               blk_queue_split(md->queue, &bio);
> >>    -               if (!is_abnormal_io(bio))
> >>    +               if (is_abnormal_io(bio))
> >>    +                       blk_queue_split(md->queue, &bio);
> >>    +               else
> >>                            dm_queue_split(md, ti, &bio);
> >>            }
> >>
> >>    Could you have a look if it is safe to revert this commit.
> >No, it really isn't a good idea given what was documented in the commit
> >header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
> >excessive splitting is not conducive to performance either.
> >
> >So I think we need to identify _why_ reverting this commit is causing
> >such a performance improvement.  Why is calling blk_queue_split() before
> >dm_queue_split() benefiting your pgbench workload?
>
> Let me know if you want to check some patch.

Hi,

Could you please test this branch?:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.10
(or apply at least the first 4 patches, commit 63f85d97be69^..b6a80963621fa)

So far I've done various DM regression testing.  But I haven't tested
with pgbench or with the misaaligned IO scenario documented in the
header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74.  But I'll
test that scenario tomorrow.

Any chance you could provide some hints on how you're running pgbench
just so I can try to test/reproduce/verify locally?

Thanks,
Mike

