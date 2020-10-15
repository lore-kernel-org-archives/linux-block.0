Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3466C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7972080A
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 15:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vsjkyc1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbgJOPJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 11:09:28 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6655 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388764AbgJOPJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602774568; x=1634310568;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=xI1wCRbxJCFX6yOdKgXcnKW1y6wTWNYIfl97uYZxpXE=;
  b=Vsjkyc1fSH69yCRzbm7KZgLcZ4D5al/jk3pmbnVEPrp0v40cWisL8N4v
   0uKrSD4N8yImivzTtD4aE07m/xbxepqapYq8lSiATPveM8XzwGKYLsGjQ
   EMraV5CcP6eIqI1fdu2FEyopPBxnHdwXbU571dpJJad4bEr6mHWxeULiI
   c=;
X-IronPort-AV: E=Sophos;i="5.77,379,1596499200"; 
   d="scan'208";a="59532495"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 15 Oct 2020 15:09:21 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 65806A20A0;
        Thu, 15 Oct 2020 15:09:18 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.125) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 15 Oct 2020 15:09:13 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Roger Pau Monne <roger.pau@citrix.com>
CC:     <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        "J . Roeleveld" <joost@antarean.org>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
Subject: Re: [PATCH 1/2] xen/blkback: turn the cache purge LRU interval into a parameter
Date:   Thu, 15 Oct 2020 17:08:49 +0200
Message-ID: <20201015150849.3844-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20201015142416.70294-2-roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D02UWC003.ant.amazon.com (10.43.162.199) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 15 Oct 2020 16:24:15 +0200 Roger Pau Monne <roger.pau@citrix.com> wrote:

> Assume that reads and writes to the variable will be atomic. The worse
> that could happen is that one of the LRU intervals is not calculated
> properly if a partially written value is read, but that would only be
> a transient issue.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-block@vger.kernel.org
> Cc: J. Roeleveld <joost@antarean.org>
> Cc: Jürgen Groß <jgross@suse.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-xen-blkback | 10 ++++++++++
>  drivers/block/xen-blkback/blkback.c                |  9 ++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index ecb7942ff146..776f25d335ca 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -35,3 +35,13 @@ Description:
>                  controls the duration in milliseconds that blkback will not
>                  cache any page not backed by a grant mapping.
>                  The default is 10ms.
> +
> +What:           /sys/module/xen_blkback/parameters/lru_internval
> +Date:           October 2020
> +KernelVersion:  5.10
> +Contact:        Roger Pau Monné <roger.pau@citrix.com>
> +Description:
> +                The LRU mechanism to clean the lists of persistent grants needs
> +                to be executed periodically. This parameter controls the time
> +                interval between consecutive executions of the purge mechanism
> +                is set in ms.

I think noticing the default value (100ms) here would be better.


Thanks,
SeongJae Park
