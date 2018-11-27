Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749E2C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAFA20645
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAFA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeK1HVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:21:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbeK1HVX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 02:21:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFA2A2D2BF2;
        Tue, 27 Nov 2018 20:22:19 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EEBA5DEDE;
        Tue, 27 Nov 2018 20:22:15 +0000 (UTC)
Message-ID: <0fbf532cf75e23ad70367d66c53f2de7819aa71a.camel@redhat.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Date:   Tue, 27 Nov 2018 15:22:15 -0500
In-Reply-To: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 27 Nov 2018 20:22:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-11-27 at 17:55 +0800, chenxiang (M) wrote:
> [  629.210506] Unable to handle kernel paging request at virtual address 
> 0000ffff8027e048
> [  629.210506] Unable to handle kernel paging request at virtual address 
> 0000ffff8027e048
> ...
> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
> [  629.389799] lr : dd_dispatch_request+0x184/0x1e0
> [  629.389799] lr : dd_dispatch_request+0x184/0x1e0
> [  629.399031] sp : ffff0000275a3aa0
> [  629.399031] sp : ffff0000275a3aa0
> [  629.405651] x29: ffff0000275a3aa0 x28: ffff8027dc230d40
> [  629.405651] x29: ffff0000275a3aa0 x28: ffff8027dc230d40
> [  629.416278] x27: 0000000000000001 x26: ffff8027dc230d40
> [  629.416278] x27: 0000000000000001 x26: ffff8027dc230d40
> [  629.426903] x25: 0000000000000000 x24: ffff0000094f1000
> [  629.426903] x25: 0000000000000000 x24: ffff0000094f1000
> [  629.437529] x23: ffff8027a1e1d140 x22: 0000000000000006
> [  629.437529] x23: ffff8027a1e1d140 x22: 0000000000000006
> [  629.448155] x21: ffff7e009ec69842 x20: ffff8027a1e1d100
> [  629.448155] x21: ffff7e009ec69842 x20: ffff8027a1e1d100
> [  629.458781] x19: ffff8027a1e1d100 x18: 0000000000000000
> [  629.458781] x19: ffff8027a1e1d100 x18: 0000000000000000
> [  629.469406] x17: 000000009e8c9c80 x16: 00000027a3272000
> [  629.469406] x17: 000000009e8c9c80 x16: 00000027a3272000
> [  629.480032] x15: ffff7e009fff9534 x14: ffff7e009ec698c0
> [  629.480032] x15: ffff7e009fff9534 x14: ffff7e009ec698c0
> [  629.490658] x13: ffff7e009ec69880 x12: 0000000000000009
> [  629.490658] x13: ffff7e009ec69880 x12: 0000000000000009
> [  629.501284] x11: 0000000000000000 x10: ffff8027a7c03560
> [  629.501284] x11: 0000000000000000 x10: ffff8027a7c03560
> [  629.511910] x9 : ffff8027a7c007b8 x8 : 0000000000000007
> [  629.511910] x9 : ffff8027a7c007b8 x8 : 0000000000000007
> [  629.522535] x7 : ffff8027a7c011c8 x6 : 0000000000000000
> [  629.522535] x7 : ffff8027a7c011c8 x6 : 0000000000000000
> [  629.533161] x5 : 0000000000000000 x4 : 0000ffff8027e040
> [  629.533161] x5 : 0000000000000000 x4 : 0000ffff8027e040
> [  629.543787] x3 : ffff8027a1e20040 x2 : ffff8027da87f6a0
> [  629.543787] x3 : ffff8027a1e20040 x2 : ffff8027da87f6a0
> [  629.554413] x1 : ffff8027a1e1d140 x0 : ffff8027a1e1d160
> [  629.554413] x1 : ffff8027a1e1d140 x0 : ffff8027a1e1d160

I don't have an ARM architecture machine, but the faulting
address looks like it may have been loaded from a corrupted
pointer value (0000ffff8027e048 instead of ffff8027e048----)

The code in question uses some list primitives, were there any
warning messages about list corruption prior to the crash?

-Ewan

