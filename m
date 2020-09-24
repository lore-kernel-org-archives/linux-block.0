Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E58C4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 06:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0221D7F
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 06:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KrqgABaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgIXG1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:27:18 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:13396 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIXG1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 02:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600928837; x=1632464837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=zknW5jJHzdymA6wvIjLBr4rV/FXE51ARi7wGFxmt7nQ=;
  b=KrqgABaE2Ncw17dXyNT3rI/zOqgCoUgcqVrJdb0tYbXiWX4nZK/pGBl4
   eIrxvdZrmTCLG/J5NwWMU7ofUkrXyWTVMRrt3hETNHoIE8R81LHIPwD6s
   xKxTY/XjpHZD//eI/n97XR4fu9l86XOkj6GuEr9TLwfhRc4Rggf/zk/Fn
   s=;
X-IronPort-AV: E=Sophos;i="5.77,296,1596499200"; 
   d="scan'208";a="56021443"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Sep 2020 06:27:15 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id EB1FB1A03DC;
        Thu, 24 Sep 2020 06:27:14 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Sep 2020 06:27:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     SeongJae Park <sjpark@amazon.com>, <roger.pau@citrix.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent grants
Date:   Thu, 24 Sep 2020 08:26:53 +0200
Message-ID: <20200924062653.9449-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923200930.GB11767@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D17UWB004.ant.amazon.com (10.43.161.132) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Sep 2020 16:09:30 -0400 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overhead[1] and thus it is
> > required to be disabled.  But, there is no option to disable it.  For
> > the reason, this commit adds a module parameter for disabling of the
> > feature.
> 
> Would it be better suited to have it per guest?

The latest version of this patchset[1] supports blkfront side disablement.
Could that partially solves your concern?

[1] https://lore.kernel.org/xen-devel/20200923061841.20531-1-sjpark@amazon.com/


Thanks,
SeongJae Park
