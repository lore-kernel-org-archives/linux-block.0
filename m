Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D29C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0BF20717
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HmkYReAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLRRcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:32:47 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:6637 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 12:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576690367; x=1608226367;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FeQX76NID8dsLOSp0CkwolZX9DdPQj+OFtakt4kP7kA=;
  b=HmkYReAiKxCtO3m+0gxfHEtz9GndC6GGIi7/6lLXskf8sa+4LyjY+chC
   AbEAcxMlVKdXr+go0CNflSnDY6zPUOOghD01FqqhzKY+BMi7gEn6ws+De
   9PcsoEvzeH5UPkeT9gtNWI9yBlzx7Kly9eN1fTNORniYZ384MBavhn8BW
   s=;
IronPort-SDR: svtqNpTkuYb1WJ3MaCtzj/m7rTHlM88SUQfhUrvm4+MNQU/nZTWWMsutjb3KahLmjnakVAmTra
 /F+7pzDEND6g==
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="9070911"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Dec 2019 17:32:45 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id C914FC59C5;
        Wed, 18 Dec 2019 17:32:42 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Dec 2019 17:32:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.78) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 17:32:36 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <roger.pau@citrix.com>
Subject: Re: Re: [Xen-devel] [PATCH v12 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Wed, 18 Dec 2019 18:32:17 +0100
Message-ID: <20191218173217.7501-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <7edb266e-3185-5adc-1121-1b61feaf5a34@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.78]
X-ClientProxiedBy: EX13D33UWB002.ant.amazon.com (10.43.161.88) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 18 Dec 2019 16:11:51 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 18.12.19 15:40, SeongJae Park wrote:
> > On Wed, 18 Dec 2019 14:30:44 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> > 
> >> On 18.12.19 13:42, SeongJae Park wrote:
> >>> On Wed, 18 Dec 2019 13:27:37 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> >>>
> >>>> On 18.12.19 11:42, SeongJae Park wrote:
> >>>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>>
> >>>>> 'reclaim_memory' callback can race with a driver code as this callback
> >>>>> will be called from any memory pressure detected context.  To deal with
> >>>>> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> >>>>> 'reclaim_memory' callback is called, the lock of the device which passed
> >>>>> to the callback as its argument is locked.  Thus, drivers registering
> >>>>> their 'reclaim_memory' callback should protect the data that might race
> >>>>> with the callback with the lock by themselves.
> >>>>
> >>>> Any reason you don't take the lock around the .probe() and .remove()
> >>>> calls of the backend (xenbus_dev_probe() and xenbus_dev_remove())? This
> >>>> would eliminate the need to do that in each backend instead.
> >>>
> >>> First of all, I would like to keep the critical section as small as possible.
> >>> With my small test, I could see slightly increasing memory pressure as the
> >>> critical section becomes wider.  Also, some drivers might share the data their
> >>> 'reclaim_memory' callback touches with other functions.  I think only the
> >>> driver owners can know what data is shared and what is the minimum critical
> >>> section to protect it.
> >>
> >> But this kind of serialization can still be added on top.
> > 
> > I'm still worrying about the unnecessarily large critical section, but it might
> > be small enough to be ignored.  If no others have strong objection, I will take
> > the lock around the '->probe()' and '->remove()'.
> 
> The lock is per device, so contention is possible only for the
> reclaim case. In case probe or remove are running reclaim will have
> nothing to free (in probe case nothing is allocated yet, in remove
> case everything should be freed anyway). So the larger critical section
> is no problem at all IMO.

Agreed.  I think I was worried about nothing really existing now.

> 
> >> And with the trylock in the reclaim path I believe you can even avoid
> >> the irq variants of the spinlock. But I might be wrong, so you should
> >> try that with lockdep enabled. If it is working there is no harm done
> >> when making the critical section larger, as memory allocations will
> >> work as before.
> > 
> > Yes, you're right.  I will try test with lockdep.
> 
> Thanks,

Good news, lockdep says it's okay :)

Will post next version soon.


Thanks,
SeongJae Park

> 
> 
> Juergen
