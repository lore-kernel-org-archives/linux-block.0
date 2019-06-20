Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B8C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 01:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4D2147A
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 01:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFTByY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:54:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfFTByY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 21:54:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9805F7830375BB799FBF;
        Thu, 20 Jun 2019 09:54:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Jun
 2019 09:54:17 +0800
Subject: Re: [PATCH V4 5/5] f2fs: use block layer helper for show_bio_op macro
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-block@vger.kernel.org>
CC:     <jaegeuk@kernel.org>, <bvanassche@acm.org>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <20190619171302.10146-6-chaitanya.kulkarni@wdc.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e2a68b89-404f-3f75-d235-88c9e4e15d33@huawei.com>
Date:   Thu, 20 Jun 2019 09:54:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190619171302.10146-6-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/6/20 1:13, Chaitanya Kulkarni wrote:
> Adjust the f2fs tracing code to use newly introduced block layer
> function blk_op_str() which converts the REQ_OP_XXX into the string
> XXX.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
