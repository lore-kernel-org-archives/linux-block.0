Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7870DC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3502192D
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 19:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbfBPTOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:14:11 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:60931 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731200AbfBPTOL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 14:14:11 -0500
Subject: Re: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273
 pci_irq_get_affinity+0xf4/0x120
To:     Himanshu Madhani <hmadhani@marvell.com>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Giridhar Malavali <gmalavali@marvell.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        Himanshu Madhani <hmadhani@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
References: <c58b0ffc-434b-9db4-9ed5-07650368f336@linux.ee>
 <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
 <59ea474f-347e-185b-73c7-7fa7e6cfa7b4@linux.ee>
 <CACVXFVM04AW1vVcX4KCsi7eS1EWZcWkhUGYY5db=LJdmPGE4yw@mail.gmail.com>
 <BCC8BDF9-241A-4186-A73B-DEBEAFB1D3DB@marvell.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <3e8d4a8c-41e4-3617-d749-e96c69629b63@linux.ee>
Date:   Sat, 16 Feb 2019 21:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BCC8BDF9-241A-4186-A73B-DEBEAFB1D3DB@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hi Meelis,
>      
> Can you try patch just posted here.
> 
> https://patchwork.kernel.org/patch/10816115/

It works on both sparcs - no warnings, normal bootup as before.

There is no cable attached so I do not know if it really works but that's the same state as before.
-- 
Meelis Roos
