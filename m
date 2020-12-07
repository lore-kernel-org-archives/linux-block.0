Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8F0C4361B
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F7522ADF
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 07:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLGHUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:20:42 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34089 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgLGHUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Dec 2020 02:20:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UHn7rkj_1607325588;
Received: from 30.21.164.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UHn7rkj_1607325588)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Dec 2020 15:19:48 +0800
Subject: Re: [PATCH v2 0/5] Some cleanups and improvements for blk-iocost
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <ef1ebb96-3e2b-44e9-f7dd-463124921747@linux.alibaba.com>
Date:   Mon, 7 Dec 2020 15:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

> Hi,
> 
> This patch set did some cleanups and improvements for blk-iocost, and
> no big functional changes. Please help to review. Thanks.
> 
> Changes from v1:
>   - Add acked-by tag from Tejun.
>   - Drop 2 unnecessary patches.
>   - Move the related variable declarations inside the block together
>   with the code in patch 3.
>   - Move the commit_weights() into ioc_check_iocgs().
>   - Move more related logics of adjusting base vrate into the
>   ioc_adjust_base_vrate().
>   - Rename the new functions.

Could you take this patch set if no objection from your side? Thanks.

> 
> Baolin Wang (5):
>    blk-iocost: Fix some typos in comments
>    blk-iocost: Remove unnecessary advance declaration
>    blk-iocost: Move the usage ratio calculation to the correct place
>    blk-iocost: Factor out the active iocgs' state check into a separate
>      function
>    blk-iocost: Factor out the base vrate change into a separate function
> 
>   block/blk-iocost.c | 251 +++++++++++++++++++++++++++++------------------------
>   1 file changed, 137 insertions(+), 114 deletions(-)
> 
