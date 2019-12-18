Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773FAC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD7F21582
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RV3rXPZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfLROk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:40:57 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:20484 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLROk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 09:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576680057; x=1608216057;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9TSSJzMeZCiqUiC9We6oHtvYEYmkGKrZqf9wv74O1kk=;
  b=RV3rXPZoZdth0OXc24vpUutgAe9DSrjAAAj2UQKYF0xjz14uJ/SkcuJ7
   GzSF6vl8YIgJH7Y4cYi0+KyyXF6Tm/rWhiFpEbPm0WM4kBrrAIEL3clv1
   UxgqSEUtq284ylHxa7h3acgjcCba1qeLvKO/NSaCClmLdIC31lh8yOH5Y
   I=;
IronPort-SDR: jSc+E8xRrCSZQoSlNwzzxZ2Qt5foevig6NsIXRRGZopSepGBVga7+89uIb9r6bG12xVsPzG1Vv
 vCzkdB274h9w==
X-IronPort-AV: E=Sophos;i="5.69,329,1571702400"; 
   d="scan'208";a="9045548"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Dec 2019 14:40:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 65BBC1A94AC;
        Wed, 18 Dec 2019 14:40:53 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Dec 2019 14:40:52 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 14:40:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <axboe@kernel.dk>,
        <sj38.park@gmail.com>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <roger.pau@citrix.com>
Subject: Re: Re: [Xen-devel] [PATCH v12 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Wed, 18 Dec 2019 15:40:25 +0100
Message-ID: <20191218144025.24277-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <ee6c4bae-0571-a18e-d408-0b69f8018329@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D27UWA004.ant.amazon.com (10.43.160.43) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 18 Dec 2019 14:30:44 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 18.12.19 13:42, SeongJae Park wrote:
> > On Wed, 18 Dec 2019 13:27:37 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> > 
> >> On 18.12.19 11:42, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> 'reclaim_memory' callback can race with a driver code as this callback
> >>> will be called from any memory pressure detected context.  To deal with
> >>> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> >>> 'reclaim_memory' callback is called, the lock of the device which passed
> >>> to the callback as its argument is locked.  Thus, drivers registering
> >>> their 'reclaim_memory' callback should protect the data that might race
> >>> with the callback with the lock by themselves.
> >>
> >> Any reason you don't take the lock around the .probe() and .remove()
> >> calls of the backend (xenbus_dev_probe() and xenbus_dev_remove())? This
> >> would eliminate the need to do that in each backend instead.
> > 
> > First of all, I would like to keep the critical section as small as possible.
> > With my small test, I could see slightly increasing memory pressure as the
> > critical section becomes wider.  Also, some drivers might share the data their
> > 'reclaim_memory' callback touches with other functions.  I think only the
> > driver owners can know what data is shared and what is the minimum critical
> > section to protect it.
> 
> But this kind of serialization can still be added on top.

I'm still worrying about the unnecessarily large critical section, but it might
be small enough to be ignored.  If no others have strong objection, I will take
the lock around the '->probe()' and '->remove()'.

> 
> And with the trylock in the reclaim path I believe you can even avoid
> the irq variants of the spinlock. But I might be wrong, so you should
> try that with lockdep enabled. If it is working there is no harm done
> when making the critical section larger, as memory allocations will
> work as before.

Yes, you're right.  I will try test with lockdep.


Thanks,
SeongJae Park

> 
> 
> Juergen
