Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4EECAAD8
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 02:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiISCSD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISCSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 22:18:02 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA713D32;
        Sun, 18 Sep 2022 19:18:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQ4P4do_1663553878;
Received: from 30.97.56.99(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQ4P4do_1663553878)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 10:17:59 +0800
Message-ID: <4fb5d908-1cc9-02f5-53e5-96f8c243b427@linux.alibaba.com>
Date:   Mon, 19 Sep 2022 10:17:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 0/7] ublk_drv: add USER_RECOVERY support
Content-Language: en-US
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping...
