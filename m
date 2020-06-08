Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF3C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CD420801
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 01:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFHB2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:28:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbgFHB2w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 7 Jun 2020 21:28:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CC09978E1AF52A4C9A6;
        Mon,  8 Jun 2020 09:28:50 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 09:28:40 +0800
Subject: Re: [PATCH v3] block: Fix use-after-free in blkdev_get()
To:     Jan Kara <jack@suse.cz>
CC:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hulk Robot <hulkci@huawei.com>
References: <20200605104558.16686-1-yanaijie@huawei.com>
 <20200605143710.GA13248@quack2.suse.cz>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3c9298bd-6406-6815-09d2-ca4fdd732b79@huawei.com>
Date:   Mon, 8 Jun 2020 09:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200605143710.GA13248@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



ÔÚ 2020/6/5 22:37, Jan Kara Ð´µÀ:
> No need for braces here after you remove bdput(). With this fixed, feel
> free to add:
> 
> Reviewed-by: Jan Kara<jack@suse.cz>

Thanks, I will fix it in v4.

Jason

