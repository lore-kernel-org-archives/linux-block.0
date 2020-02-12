Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F3C2BA83
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9920848
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgBLINH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:13:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbgBLINH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 03:13:07 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC8875B6E2FBB1FA99E8;
        Wed, 12 Feb 2020 16:13:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Feb 2020
 16:13:02 +0800
Subject: Re: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
To:     Omar Sandoval <osandov@osandov.com>
CC:     <linux-block@vger.kernel.org>, <osandov@fb.com>
References: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
 <8ece15f7-addf-44b2-0b54-4e1a450037f2@huawei.com>
 <20200211222345.GI100751@vader>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <c374674b-f884-3d2e-14ca-bae2982e3fbd@huawei.com>
Date:   Wed, 12 Feb 2020 16:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200211222345.GI100751@vader>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



ÔÚ 2020/2/12 6:23, Omar Sandoval Ð´µÀ:
> On Mon, Dec 23, 2019 at 11:15:35AM +0800, sunke (E) wrote:
>> Hi Omar,
>>
>> The nbd/003 you simplified does the same I want to do and I made some small
>> changes. I ran the simplified nbd/003 with linux kernel at the commit
>> 7e0165b2f1a, it could pass.Then, I rollbacked the linux kernel to commit
>> 090bb803708, it indeed triggered the BUGON.
>>
>> However, there is one difference. NBD has ioctl and netlink interfaces. I
>> use the netlink interface and the simplified nbd/003 use the ioctl
>> interface. The nbd/003 with the netlink interface indeed seem to trigger
>> some other issue. So, can it be nbd/004?
> 
> Sure, how about we add a flag to mount_clear_sock that specifies to use
> the netlink interface instead of the ioctl interface, and make nbd/004
> which is the same as nbd/003 expect it runs it with the netlink flag?
> 
Hi Omar

I can not understand adding a flag to mount_clear_sock. How about add 
_start_nbd_server_netlink and _stop_nbd_server_netlink in tests/nbd/rc, 
others can also reuse the code?

Thanks
Sun Ke

