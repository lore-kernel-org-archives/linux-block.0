Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077ADC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C470B20868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C470B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLAHH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:07:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLAHH6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 02:07:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2B758E670;
        Fri, 30 Nov 2018 19:57:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A308060A98;
        Fri, 30 Nov 2018 19:57:32 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:57:31 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] per-cpu in_flight counters for bio-based drivers
Message-ID: <20181130195731.GB3719@redhat.com>
References: <20181128004211.368810060@debian.vm>
 <20181130144343.GA13483@redhat.com>
 <20181130155054.GA13744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130155054.GA13744@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 30 Nov 2018 19:57:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30 2018 at 10:50am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Fri, Nov 30 2018 at  9:43am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Tue, Nov 27 2018 at  7:42pm -0500,
> > Mikulas Patocka <mpatocka@redhat.com> wrote:
> > 
> > > These are the patches for per-cpu in_flight counters.
> > 
> > Do you have updated before vs after performance results for these
> > changes?
> > 
> > I'd imagine they are comparable to your previous run (though that run
> > included some other DM changes that I already staged).
> 
> Would like to see before vs after with:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=for-4.21/block
> vs
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=block-dm-4.21-inflight
> 
> (block-dm-4.21-inflight is based on latest for-4.21/block -- and it
> contains DM changes in front of the block changes from this thread; I'd
> prefer Jens take the changes like this rather than leave DM in a bit of
> a mess for me/us to have to cleanup later)

I ran the same fio test you did (in the previous thread where you did
the switch to percpu local to DM, rather than in block) _except_ I used
a ramdisk-based pmem device rather than a pure ramdisk:

fio --ioengine=psync --iodepth=1 --rw=read --bs=512 --direct=1 --numjobs=12 --time_based --runtime=10 --group_reporting --name=/dev/pmem0

2 6-core processors (w/ HT, so 24 logical cpus):

/dev/pmem0                                        14.6M
/dev/pmem0 with percpu counters                   14.8M
/dev/mapper/linear                                4736k
/dev/mapper/linear with percpu counters           4595k

It is only after I apply this commit that I can realize a big
performance win:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=block-dm-4.21-inflight&id=335b41c7513110b1519d8a93d412c138bf671263

/dev/mapper/linear with percpu + pending removed  11.2M
