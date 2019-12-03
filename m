Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34439C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EFA20684
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCMWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:22:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLCMWz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 07:22:55 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 702D9616831BFA5CA328;
        Tue,  3 Dec 2019 20:22:50 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 20:22:45 +0800
Subject: Re: [PATCH] nbd: fix potential deadlock in nbd_config_put()
To:     Mike Christie <mchristi@redhat.com>, <josef@toxicpanda.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>
References: <1574937951-92828-1-git-send-email-sunke32@huawei.com>
 <5DE3F444.9080706@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <1702191a-99e1-1b56-c77a-0202b44885bf@huawei.com>
Date:   Tue, 3 Dec 2019 20:22:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5DE3F444.9080706@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Your solution ie better.

