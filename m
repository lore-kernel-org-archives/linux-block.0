Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE24C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222C62081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222C62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeK1OLk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:11:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeK1OLk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:11:40 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4EA54A65DF845;
        Wed, 28 Nov 2018 11:11:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 11:11:27 +0800
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
To:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <0fbf532cf75e23ad70367d66c53f2de7819aa71a.camel@redhat.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <8804c192-e15a-2636-1060-a8ae3e3df70f@hisilicon.com>
Date:   Wed, 28 Nov 2018 11:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0fbf532cf75e23ad70367d66c53f2de7819aa71a.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2018/11/28 4:22, Ewan D. Milne 写道:
> On Tue, 2018-11-27 at 17:55 +0800, chenxiang (M) wrote:
>> [  629.210506] Unable to handle kernel paging request at virtual address
>> 0000ffff8027e048
>> [  629.210506] Unable to handle kernel paging request at virtual address
>> 0000ffff8027e048
>> ...
>> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
>> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
>> [  629.389799] lr : dd_dispatch_request+0x184/0x1e0
>> [  629.389799] lr : dd_dispatch_request+0x184/0x1e0
>> [  629.399031] sp : ffff0000275a3aa0
>> [  629.399031] sp : ffff0000275a3aa0
>> [  629.405651] x29: ffff0000275a3aa0 x28: ffff8027dc230d40
>> [  629.405651] x29: ffff0000275a3aa0 x28: ffff8027dc230d40
>> [  629.416278] x27: 0000000000000001 x26: ffff8027dc230d40
>> [  629.416278] x27: 0000000000000001 x26: ffff8027dc230d40
>> [  629.426903] x25: 0000000000000000 x24: ffff0000094f1000
>> [  629.426903] x25: 0000000000000000 x24: ffff0000094f1000
>> [  629.437529] x23: ffff8027a1e1d140 x22: 0000000000000006
>> [  629.437529] x23: ffff8027a1e1d140 x22: 0000000000000006
>> [  629.448155] x21: ffff7e009ec69842 x20: ffff8027a1e1d100
>> [  629.448155] x21: ffff7e009ec69842 x20: ffff8027a1e1d100
>> [  629.458781] x19: ffff8027a1e1d100 x18: 0000000000000000
>> [  629.458781] x19: ffff8027a1e1d100 x18: 0000000000000000
>> [  629.469406] x17: 000000009e8c9c80 x16: 00000027a3272000
>> [  629.469406] x17: 000000009e8c9c80 x16: 00000027a3272000
>> [  629.480032] x15: ffff7e009fff9534 x14: ffff7e009ec698c0
>> [  629.480032] x15: ffff7e009fff9534 x14: ffff7e009ec698c0
>> [  629.490658] x13: ffff7e009ec69880 x12: 0000000000000009
>> [  629.490658] x13: ffff7e009ec69880 x12: 0000000000000009
>> [  629.501284] x11: 0000000000000000 x10: ffff8027a7c03560
>> [  629.501284] x11: 0000000000000000 x10: ffff8027a7c03560
>> [  629.511910] x9 : ffff8027a7c007b8 x8 : 0000000000000007
>> [  629.511910] x9 : ffff8027a7c007b8 x8 : 0000000000000007
>> [  629.522535] x7 : ffff8027a7c011c8 x6 : 0000000000000000
>> [  629.522535] x7 : ffff8027a7c011c8 x6 : 0000000000000000
>> [  629.533161] x5 : 0000000000000000 x4 : 0000ffff8027e040
>> [  629.533161] x5 : 0000000000000000 x4 : 0000ffff8027e040
>> [  629.543787] x3 : ffff8027a1e20040 x2 : ffff8027da87f6a0
>> [  629.543787] x3 : ffff8027a1e20040 x2 : ffff8027da87f6a0
>> [  629.554413] x1 : ffff8027a1e1d140 x0 : ffff8027a1e1d160
>> [  629.554413] x1 : ffff8027a1e1d140 x0 : ffff8027a1e1d160
> I don't have an ARM architecture machine, but the faulting
> address looks like it may have been loaded from a corrupted
> pointer value (0000ffff8027e048 instead of ffff8027e048----)
>
> The code in question uses some list primitives, were there any
> warning messages about list corruption prior to the crash?

There is no warning message abort list corruption or other corruption 
prior to the crash.

>
> -Ewan
>
>
> .
>


