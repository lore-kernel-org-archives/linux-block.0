Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1797C7EE2F
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 02:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCCCwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 21:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCCwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 21:52:05 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F894ECDB;
        Thu,  2 Mar 2023 18:52:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VczFXIW_1677811920;
Received: from 30.97.56.172(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VczFXIW_1677811920)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 10:52:01 +0800
Message-ID: <7c787a9f-3cd9-cc76-8194-d861b5674334@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 10:52:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 00/12] io_uring: add IORING_OP_FUSED_CMD
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20230301140611.163055-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230301140611.163055-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I tried this patchset but there are some conflicts while applying.
Could please tell me the base branch? I have tried both io_uring
and block.

Regards,
Zhang

