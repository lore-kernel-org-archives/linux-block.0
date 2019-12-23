Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA5C2D0D2
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 03:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1216C20733
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 03:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLWDPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:15:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfLWDPk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Dec 2019 22:15:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F6DE8F43E9875C0B0A4;
        Mon, 23 Dec 2019 11:15:38 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 11:15:35 +0800
Subject: Re: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
References: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <8ece15f7-addf-44b2-0b54-4e1a450037f2@huawei.com>
Date:   Mon, 23 Dec 2019 11:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

The nbd/003 you simplified does the same I want to do and I made some 
small changes. I ran the simplified nbd/003 with linux kernel at the 
commit 7e0165b2f1a, it could pass.Then, I rollbacked the linux kernel to 
commit 090bb803708, it indeed triggered the BUGON.

However, there is one difference. NBD has ioctl and netlink interfaces. 
I use the netlink interface and the simplified nbd/003 use the ioctl 
interface. The nbd/003 with the netlink interface indeed seem to trigger 
some other issue. So, can it be nbd/004?

thanks,

Sun Ke.


