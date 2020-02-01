Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62417C33C9E
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36638206D3
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 09:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgBAJJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 04:09:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBAJJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Feb 2020 04:09:01 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixold-0003oU-V5; Sat, 01 Feb 2020 10:08:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7F0CE103088; Sat,  1 Feb 2020 10:08:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        keith.busch@intel.com, minwoo.im.dev@gmail.com,
        edmund.nadolski@intel.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous affinity set
In-Reply-To: <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
References: <cover.1580211965.git.zhangweiping@didiglobal.com> <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
Date:   Sat, 01 Feb 2020 10:08:36 +0100
Message-ID: <871rrevfmz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Weiping Zhang <zhangweiping@didiglobal.com> writes:

> nvme driver will add 4 sets for supporting NVMe weighted round robin,
> and some of these sets may be empty(depends on user configuration),
> so each particular set is assigned one static index for avoiding the
> management trouble, then the empty set will be been by
> irq_create_affinity_masks().

What's the point of an empty interrupt set in the first place? This does
not make sense and smells like a really bad hack.

Can you please explain in detail why this is required and why it
actually makes sense?

Thanks,

        tglx
