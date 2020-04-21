Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA0CC54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AF82078C
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDUNYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:24:50 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:28699 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1728786AbgDUNYu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 09:24:50 -0400
X-ASG-Debug-ID: 1587475487-0e4088442c28d4e0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.143]) by bsf01.didichuxing.com with ESMTP id 3tlo80HeEEHLg13Z; Tue, 21 Apr 2020 21:24:47 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Apr
 2020 21:24:46 +0800
Date:   Tue, 21 Apr 2020 21:24:45 +0800
From:   weiping zhang <zhangweiping@didichuxing.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH v3 6/7] block: refactor __blk_mq_alloc_rq_map_and_requests
Message-ID: <20200421132440.GB20391@192.168.3.9>
X-ASG-Orig-Subj: Re: [PATCH v3 6/7] block: refactor __blk_mq_alloc_rq_map_and_requests
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <eb995b7a9c5a942c596eb21856043c4a1b2135f1.1586199103.git.zhangweiping@didiglobal.com>
 <e289ea06-c799-8444-2b2a-720f5d75f2c2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e289ea06-c799-8444-2b2a-720f5d75f2c2@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.143]
X-Barracuda-Start-Time: 1587475487
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1158
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81316
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 02:07:13PM -0700, Bart Van Assche wrote:
> On 4/6/20 12:37 PM, Weiping Zhang wrote:
> >This patch add a new member nr_allocated_map_rqs to the
> >struct blk_mq_tag_set to record the number of maps and requests have
> >been allocated for this tagset.
> >
> >Now there is a problem when we increase hardware queue count, we do not
> >allocate maps and request for the new allocated hardware queue, it will
> >be fixed in the next patch.
> >
> >Since request needs lots of memory, it's not easy alloc so many memory
> >dynamically, espeicially when system is under memory pressure.
> >
> >This patch allow nr_hw_queues does not equal to the nr_allocated_map_rqs,
> >to avoid alloc/free memory when change hardware queue count.
> 
> It seems to me that patches 6 and 7 combined fix a single issue. How
> about combining these two patches into a single patch?
> 
It's ok for me, the reason why I split two patches is that make patch
review more easily, since patch-6 actually does not change original
logic. If you think combined them is more better, I can merge these
two patches.

Thanks
> Thanks,
> 
> Bart.
