Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBFC47404
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 01:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF9206C0
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 01:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfJHB3L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:29:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfJHB3L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 21:29:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADC01AE4F2E868DD868C;
        Tue,  8 Oct 2019 09:29:09 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 09:29:06 +0800
Subject: Re: [PATCH blktests v2] nbd/003:add mount and clear_sock test for nbd
To:     <osandov@fb.com>, <linux-block@vger.kernel.org>
References: <1568702991-69027-1-git-send-email-sunke32@huawei.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <f9506a86-ab53-20db-641f-ea52379dfefe@huawei.com>
Date:   Tue, 8 Oct 2019 09:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1568702991-69027-1-git-send-email-sunke32@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



ÔÚ 2019/9/17 14:49, Sun Ke Ð´µÀ:
ping

