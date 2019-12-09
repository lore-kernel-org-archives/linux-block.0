Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A6C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F1E207FD
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LzYyV/QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLIKYc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:24:32 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:41315 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfLIKYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 05:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575887072; x=1607423072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=TFhrQ8TsGCVpfe7qixLlviznfKMBnnGyy14ZJutL01Q=;
  b=LzYyV/QZZc3sH1e7KGUGZXEsHI2keOD53LJXnCoKJSsJx8PT0TqLjlhs
   pR6kNwefBMlDDX8PTNfa6Ssld8ZRnMY4xbwdZ7waq4sVOyUrwgThSvVHG
   kI2X8R7dsUBCIyBCURi42nQt9ecL38zGlG7PzgtVYIn4jeN5lC7MBK6em
   c=;
IronPort-SDR: LhN+WuCUR0utaUbkSbqVuYjmhb2X6P9gEQoHKVbHuK6WeSYVaDGlSMQBcTUtdx6mHGX7twf2Sl
 tjgcW2EmOvsA==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="3990731"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Dec 2019 10:24:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id B074CA0766;
        Mon,  9 Dec 2019 10:24:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 10:24:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 10:24:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory pressure
Date:   Mon, 9 Dec 2019 11:23:47 +0100
Message-ID: <20191209102347.17337-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
References: <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
In-Reply-To: <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D22UWC003.ant.amazon.com (10.43.162.250) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On   Mon, 9 Dec 2019 10:39:02 +0100  Juergen <jgross@suse.com> wrote:

>On 09.12.19 09:58, SeongJae Park wrote:
>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>> the pool starts from zero and be increased on demand while processing
>> the I/O requests.  If current I/O requests handling is finished or 100
>> milliseconds has passed since last I/O requests handling, it checks and
>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>
>> Therefore, `blkfront` running guests can cause a memory pressure in the
>> `blkback` running guest by attaching a large number of block devices and
>> inducing I/O.
>
>I'm having problems to understand how a guest can attach a large number
>of block devices without those having been configured by the host admin
>before.
>
>If those devices have been configured, dom0 should be ready for that
>number of devices, e.g. by having enough spare memory area for ballooned
>pages.

As mentioned in the original message as below, administrators _can_ avoid this
problem, but finding the optimal configuration is hard, especially if the
number of the guests is large.

	System administrators can avoid such problematic situations by limiting
	the maximum number of devices each guest can attach.  However, finding
	the optimal limit is not so easy.  Improper set of the limit can
	results in the memory pressure or a resource underutilization.


Thanks,
SeongJae Park

>
>So either I'm missing something here or your reasoning for the need of
>the patch is wrong.
>
>
>Juergen
>
