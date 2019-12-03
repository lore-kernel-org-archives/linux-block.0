Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05110C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE7206EC
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wCY14kfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCOd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:33:59 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:23797 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575383639; x=1606919639;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RXSZcs/qVPDPyswC2jRGt//36h8Hc2BlXBaBEjUudjQ=;
  b=wCY14kfszZN+5M1gGz+TNBSn7W9LeJon/wiBTFc11q8Lq9THCvjcc7oW
   Sc6DPB/6KJN0EHhr5PhhoNvA21EpjSePDgM6A9RTOr6W0mELeser6QsvB
   1AnBz4aHiQZVkSQTM1CXlEaiyktC1obHotEMZ8c1lRmv9wW4PITwFhJoQ
   M=;
IronPort-SDR: coc3S0BFg7Yzigp7n7nUbxLeudhPKgshlx19TdBKmZeiBGKBdRS0F5W3etCiCBhBBo4Uwe2x2V
 JWuoaX8mHwvw==
X-IronPort-AV: E=Sophos;i="5.69,273,1571702400"; 
   d="scan'208";a="12661880"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Dec 2019 14:33:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id D515EA17D7;
        Tue,  3 Dec 2019 14:33:45 +0000 (UTC)
Received: from EX13D12UEA003.ant.amazon.com (10.43.61.184) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Dec 2019 14:33:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA003.ant.amazon.com (10.43.61.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Dec 2019 14:33:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.28.85.76) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Dec 2019 14:33:44 +0000
Subject: Re: [PATCH] xen/blkback: Avoid unmapping unmapped grant pages
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        <konrad.wilk@oracle.com>, <axboe@kernel.dk>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
References: <20191126153605.27564-1-sjpark@amazon.com>
 <20191127091314.GK980@Air-de-Roger>
From:   <sjpark@amazon.com>
Message-ID: <11ff29ea-ee0f-1dd1-a93e-84d1dd45418e@amazon.com>
Date:   Tue, 3 Dec 2019 15:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127091314.GK980@Air-de-Roger>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.11.19 10:13, Roger Pau Monné wrote:
> On Tue, Nov 26, 2019 at 04:36:05PM +0100, SeongJae Park wrote:
>> From: SeongJae Park <sjpark@amazon.de>
>>
>> For each I/O request, blkback first maps the foreign pages for the
>> request to its local pages.  If an allocation of a local page for the
>> mapping fails, it should unmap every mapping already made for the
>> request.
>>
>> However, blkback's handling mechanism for the allocation failure does
>> not mark the remaining foreign pages as unmapped.  Therefore, the unmap
>> function merely tries to unmap every valid grant page for the request,
>> including the pages not mapped due to the allocation failure.  On a
>> system that fails the allocation frequently, this problem leads to
>> following kernel crash.
>>
>>   [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
>>   [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
>>   [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
>>   [  372.012562] Oops: 0002 [#1] SMP
>>   [  372.012566] Modules linked in: act_police sch_ingress cls_u32
>>   ...
>>   [  372.012746] Call Trace:
>>   [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
>>   [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
>>   ...
>>   [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
>>   ...
>>   Decompressing Linux... Parsing ELF... done.
>>   Booting the kernel.
>>   [    0.000000] Initializing cgroup subsys cpuset
>>
>> This commit fixes this problem by marking the grant pages of the given
>> request that didn't mapped due to the allocation failure as invalid.
>>
>> Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")
>>
>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
>> Reviewed-by: David Woodhouse <dwmw@amazon.de>
>> Reviewed-by: Maximilian Heyne <mheyne@amazon.de>
>> Reviewed-by: Paul Durrant <pdurrant@amazon.co.uk>
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
>
> Thanks, Roger.


May I ask some more comments?



Thanks,

SeongJae Park


