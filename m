Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBBC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E3C2146E
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ghmpKaSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLRMn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:43:29 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63581 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRMn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 07:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576673008; x=1608209008;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=xHFo6mvkYQfQbv/gkkkxzHborqm3JkMeR8OIVG6UBXk=;
  b=ghmpKaSbziZQuKiQDMq+MtWv3r0GxFuk8Hb10CyPlgJbHq3191pt9myG
   188zmtDyp2TiwxfamAIP59Y6XftR/f5zCYsNtO9k0w7FOr1Gu7NQM+iTn
   uxPrlZpWk/SOenc+MIZ9wx5whmzCohMfkq4kzGHCCOrRIdQOWo9pDP6YU
   A=;
IronPort-SDR: nHmGLueb0tT74FASDEbqGU0v4H6T3ZMOFwQejVqZ7VBgH8XZxt8zIkWugLKdBymWO4lkWAwvUt
 cLAUIMuq3n2A==
X-IronPort-AV: E=Sophos;i="5.69,329,1571702400"; 
   d="scan'208";a="15616175"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Dec 2019 12:43:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id B218EA1D18;
        Wed, 18 Dec 2019 12:43:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 12:43:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 12:43:10 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <roger.pau@citrix.com>,
        <linux-block@vger.kernel.org>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: Re: [Xen-devel] [PATCH v12 2/5] xenbus/backend: Protect xenbus callback with lock
Date:   Wed, 18 Dec 2019 13:42:44 +0100
Message-ID: <20191218124244.8840-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <af02058a-fa76-5eb5-5c2b-60555273bac2@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D01UWA003.ant.amazon.com (10.43.160.107) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 18 Dec 2019 13:27:37 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 18.12.19 11:42, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > 'reclaim_memory' callback can race with a driver code as this callback
> > will be called from any memory pressure detected context.  To deal with
> > the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> > 'reclaim_memory' callback is called, the lock of the device which passed
> > to the callback as its argument is locked.  Thus, drivers registering
> > their 'reclaim_memory' callback should protect the data that might race
> > with the callback with the lock by themselves.
> 
> Any reason you don't take the lock around the .probe() and .remove()
> calls of the backend (xenbus_dev_probe() and xenbus_dev_remove())? This
> would eliminate the need to do that in each backend instead.

First of all, I would like to keep the critical section as small as possible.
With my small test, I could see slightly increasing memory pressure as the
critical section becomes wider.  Also, some drivers might share the data their
'reclaim_memory' callback touches with other functions.  I think only the
driver owners can know what data is shared and what is the minimum critical
section to protect it.

If you think differently or I am missing something, please let me know.


Thanks,
SeongJae Park

> 
> 
> Juergen
