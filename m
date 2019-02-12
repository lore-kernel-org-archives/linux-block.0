Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA907C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5BF218AD
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBLIV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:21:58 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:49027 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbfBLIV6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 03:21:58 -0500
Subject: Re: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273
 pci_irq_get_affinity+0xf4/0x120
To:     Giridhar Malavali <gmalavali@marvell.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>
References: <c58b0ffc-434b-9db4-9ed5-07650368f336@linux.ee>
 <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <f9334c87-644b-b584-d3cc-60cfc148790c@linux.ee>
Date:   Tue, 12 Feb 2019 10:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> We are working on this and we will have an update for this.
>      I tested todays 5.0.0-rc5-00358-gdf3865f on my sparcs and a couple of servers that have qla2xxx
>      FC adapter gave me this warning:
>      
>      [   19.746300] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.12-k.
>      [   19.746599] qla2xxx [0000:02:00.0]-001d: : Found an ISP2432 irq 18 iobase 0x(____ptrval____).
>      [   20.203186] ------------[ cut here ]------------
>      [   20.203306] WARNING: CPU: 8 PID: 268 at drivers/pci/msi.c:1273 pci_irq_get_affinity+0xf4/0x120
Today I tried another sparc with newer OS and gcc and older hardware platform (Sun V445)
and that did not exhibit the problem with QLA2422. PCI-MSI is still present there too but
does not seem to be used for qla2xxx (it has "sun4v -IVEC" irq type).

Relevant dmesg lines:

[   47.905692] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.12-k.
[   47.905801] qla2xxx [0000:06:01.0]-001d: : Found an ISP2422 irq 6 iobase 0x(____ptrval____).
[   48.744347] scsi host3: qla2xxx
[   48.864173] qla2xxx [0000:06:01.0]-00fb:3: QLogic QLA2460 - SG-(X)PCI1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-X Single Channel Host B.
[   48.938909] scsi: waiting for bus probes to complete ...
[   49.044973] qla2xxx [0000:06:01.0]-00fc:3: ISP2422: PCI-X Mode 1 (133 MHz) @ 0000:06:01.0 hdma- host#=3 fw=8.07.00 (9496).
[   49.045110] qla2xxx [0001:08:02.0]-001d: : Found an ISP2422 irq 17 iobase 0x(____ptrval____).
[   49.604393] scsi host4: qla2xxx
[   49.794640] qla2xxx [0001:08:02.0]-00fb:4: QLogic QLA2460 - SG-(X)PCI1FC-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-X Single Channel Host B.
[   50.160011] qla2xxx [0001:08:02.0]-00fc:4: ISP2422: PCI-X Mode 1 (100 MHz) @ 0001:08:02.0 hdma- host#=4 fw=8.07.00 (9496).
[   69.884173] qla2xxx [0000:06:01.0]-8038:3: Cable is unplugged...
[   71.068227] qla2xxx [0001:08:02.0]-8038:4: Cable is unplugged...

-- 
Meelis Roos <mroos@linux.ee>
