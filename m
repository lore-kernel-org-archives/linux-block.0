Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABAC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 05:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJRFAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 01:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJRE7l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 00:59:41 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB164F68F;
        Mon, 17 Oct 2022 21:59:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VSTCT4L_1666069150;
Received: from 30.97.56.241(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VSTCT4L_1666069150)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 12:59:11 +0800
Message-ID: <bef81cd9-86a4-a671-2821-0d7021e4d49a@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 12:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 0/1] Documentation: document ublk user recovery
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221018045346.99706-1-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This doc patch is resent since user recovery feature of ublk has been merged. 
Please consider it.

Regards,
Zhang.
