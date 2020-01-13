Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8215EC33CA8
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 09:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516C42082E
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gMACNyW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMJ76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:59:58 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:8550 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJ76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 04:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578909597; x=1610445597;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=NLk0Q2nA10kWUDxhQp+mKV/5Lh/SEbObpJbRFWy+cF4=;
  b=gMACNyW5g21a/wSmZ3cQwlWkbqfn5wHAd2O1kWZCcuEDLRF4NdUuR24f
   eky5j1d5DdkJrwBLN9qdx89luO3lvXfwxcnTLGexjeporrspRiwGjfVNJ
   vrRckUyOQAUuUeu3Vn/qfR0Ddb26KVkoR6YUkG9yiUYPnvGy+emZXdwGw
   M=;
IronPort-SDR: 7UWxbXmeu6JLqhKd8TBlEtlwkYdPo3Dw/eqPtp8mbwamMLLQ+nGXJQbjrWOVHH98mInXf1z9Mv
 v1hiiYT81YKg==
X-IronPort-AV: E=Sophos;i="5.69,428,1571702400"; 
   d="scan'208";a="12078578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 13 Jan 2020 09:59:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id E0229A20D0;
        Mon, 13 Jan 2020 09:59:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 13 Jan 2020 09:59:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.92) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 13 Jan 2020 09:59:49 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <jgross@suse.com>,
        <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        <sj38.park@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: Re: [Xen-devel] [PATCH v13 0/5] xenbus/backend: Add memory pressure handler callback
Date:   Mon, 13 Jan 2020 10:59:32 +0100
Message-ID: <20200113095932.602-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200113095507.GE11756@Air-de-Roger> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.92]
X-ClientProxiedBy: EX13D32UWA001.ant.amazon.com (10.43.160.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Jan 2020 10:55:07 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Mon, Jan 13, 2020 at 10:49:52AM +0100, SeongJae Park wrote:
> > Every patch of this patchset got at least one 'Reviewed-by' or 'Acked-by' from
> > appropriate maintainers by last Wednesday, and after that, got no comment yet.
> > May I ask some more comments?
> 
> I'm not sure why more comments are needed, patches have all the
> relevant Acks and will be pushed in due time unless someone has
> objections.
> 
> Please be patient and wait at least until the next merge window, this
> patches are not bug fixes so pushing them now would be wrong.

Ok, I will.  Thank you for your quick and nice reply.


Thanks,
SeongJae Park

> 
> Roger.
> 
