Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B14C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF33224F8
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dmnked13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfLEPQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:16:25 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41101 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 10:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575558984; x=1607094984;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3b67Jvba8gIZpJXfm/xkjZkiUlmiLZrVurEcjDQr9gM=;
  b=Dmnked13jT0UiEApZAy281HL9UYhEcsYtHuv6ZiYOyHZh5atLetBNSYa
   mbKGdr5bjoGuPll/2sdqRh35TQOVB1a7i6GLhFQwC+tu6ABb8TwNyWw/X
   OzLlLNq33hiIJQYKwAQSnYcTdBnaFVdiihSeS0bobnP5MxFPolRRU/Edj
   4=;
IronPort-SDR: P0031kteqDJXom+suS0YoL3vZtyZhvtmuu8SxhbS0cp8MRcu2sQ04TvZ7dRBYg+AB6KE8ujlDo
 HL4sA5jG+dLQ==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="6355523"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 05 Dec 2019 15:16:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id C0567A18DE;
        Thu,  5 Dec 2019 15:16:21 +0000 (UTC)
Received: from EX13D04UEA001.ant.amazon.com (10.43.61.40) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:16:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D04UEA001.ant.amazon.com (10.43.61.40) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:16:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.28.85.76) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 15:16:20 +0000
Subject: Re: [PATCH v2 0/1] xen/blkback: Aggressively shrink page pools if a
 memory pressure is detected
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20191205150932.3793-1-sjpark@amazon.com>
From:   <sjpark@amazon.com>
Message-ID: <af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com>
Date:   Thu, 5 Dec 2019 16:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205150932.3793-1-sjpark@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.12.19 16:09, SeongJae Park wrote:
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>
> Therefore, `blkfront` running guests can cause a memory pressure in the
> `blkback` running guest by attaching a large number of block devices and
> inducing I/O.  System administrators can avoid such problematic
> situations by limiting the maximum number of devices each guest can
> attach.  However, finding the optimal limit is not so easy.  Improper
> set of the limit can result in the memory pressure or a resource
> underutilization.  This commit avoids such problematic situations by
> shrinking the pools aggressively (further the limit) for a while (users
> can set this duration via a module parameter) if a memory pressure is
> detected.
>
>
> Base Version
> ------------
>
> This patch is based on v5.4.  A complete tree is also available at my
> public git repo:
> https://github.com/sjp38/linux/tree/blkback_aggressive_shrinking_v2
>
>
> Patch History
> -------------
>
> Changes from v1 (https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
>  - Adjust the description to not use the term, `arbitrarily` (suggested
>    by Paul Durrant)
>  - Specify time unit of the duration in the parameter description,
>    (suggested by Maximilian Heyne)
>  - Change default aggressive shrinking duration from 1ms to 10ms
>  - Merged two patches into one single patch
>
>
> SeongJae Park (1):
>   xen/blkback: Aggressively shrink page pools if a memory pressure is
>     detected
>
>  drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)


CC-ing xen-devel@lists.xenproject.org


Thanks,
SeongJae Park

>

