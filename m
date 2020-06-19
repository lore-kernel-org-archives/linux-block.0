Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C95BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D6B20890
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYqfLLGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbgFSVJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389580AbgFSVJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 17:09:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458B0C06174E;
        Fri, 19 Jun 2020 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=SKXBg9QCixG/IchKHg9Q2/lXiIJ73XcZduzMIVVEuUQ=; b=dYqfLLGFB8fvVBDYf1TIgO0wYh
        FP7werI4Q/FAE7u7P6X1AU6HfAOG/7ZHvwxQJPaxy6esNCCCsOy1C1V4TtnhFNIDBeMbyv9h+DdY3
        IgHp8Y2NVmydmTD+aGKHWHUFz7deZOGTT3voPMo6eng9tD05KSXEe0vo4ON1EmxCpT8Dvu5CHBaNb
        2jjxUbtd640+5DIUNY94jO+pXWc+/q3jb682oVQWx2jS/X2fQTxhin6yyDs1nuVl7agNac4CCJz5q
        3U1waI7KAFxgfakjYr3kMR6yAAWWJK6Vsusz7MBTSwLXAzgar6NOJdTUDsFkmBSDoOB+yB6tfWGyZ
        YS1qFaZA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmOGW-0004Vu-6E; Fri, 19 Jun 2020 21:09:36 +0000
Subject: Re: [PATCH v3] docs: block: Create blk-mq documentation
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, dongli.zhang@oracle.com
References: <20200619200114.6896-1-andrealmeid@collabora.com>
 <c2f83c87-f473-4d30-2430-442e957de14f@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ff82592-c5cb-bb2a-d298-10a91fb9e69d@infradead.org>
Date:   Fri, 19 Jun 2020 14:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c2f83c87-f473-4d30-2430-442e957de14f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 1:56 PM, Jens Axboe wrote:
> On 6/19/20 2:01 PM, André Almeida wrote:
>> Create a documentation providing a background and explanation around the
>> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
>>
>> The reference for writing this documentation was the source code and
>> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
>> Systems", by Axboe et al.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> Changes from v2:
>> - More fixed typos
>> - Once again, reworked the definition of `blk_mq_hw_ctx` in "Hardware
>>   dispatch queues" section
>>
>> Changes from v1:
>> - Fixed typos
>> - Reworked blk_mq_hw_ctx
>>
>> Hello,
>>
>> This commit was tested using "make htmldocs" and the HTML output has
>> been verified.
>>
>> Thanks,
>> 	André
>> ---
>>  Documentation/block/blk-mq.rst | 155 +++++++++++++++++++++++++++++++++
>>  Documentation/block/index.rst  |   1 +
>>  2 files changed, 156 insertions(+)
>>  create mode 100644 Documentation/block/blk-mq.rst

LGTM.
Acked-by: Randy Dunlap <rdunlap@infradead.org>


thanks.
-- 
~Randy

