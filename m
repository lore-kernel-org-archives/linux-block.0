Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E3EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 01:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjF1BQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF1BQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 21:16:58 -0400
X-Greylist: delayed 159058 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 18:16:55 PDT
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A12103
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 18:16:55 -0700 (PDT)
Message-ID: <61ccfd88-1d08-124b-02cc-213107e81438@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687915013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qh54UmxMUrYnf3XawZlR6M2UEV3kFrEfjxB/XEVSXo=;
        b=CBD8Ex1dSBrqVpzY5Kq0adyotRuj/OdOnUZqi7ddyhhKG3Aoj0GkoD3O9nOC2EUvQtXrQM
        IHqGyzcql5kqehzYm7Midalcd45bqJzldHoHMZh+R81ELfwwlRhG7A5/3kPIeHaH/Aafqp
        XwbL2iHfvPIuDOZYyBIqXYYveG4b7gY=
Date:   Wed, 28 Jun 2023 09:16:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
 <20230626050405.781253-4-chengming.zhou@linux.dev>
 <ZJn5F4xb6gln0653@slm.duckdns.org>
 <e1da325b-8f16-f4d2-d6bf-65976a4239b4@linux.dev>
 <ZJsuszuMcX72R7qD@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJsuszuMcX72R7qD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/6/28 02:47, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 27, 2023 at 07:32:42PM +0800, Chengming Zhou wrote:
>> Since all requests in batch allocation use the same alloc and start time, so this patch
>> just leave it as it is, and reset it at actual used time.
>>
>> I think both way is ok, do you think it's better to just set the popped one request, leave
>> other requests time to 0 ? If so, I can update to do it.
> 
> I think it'd be clearer if the rule is that the alloc time is set once when
> the request is actually dispensed for use in all cases, so yeah, let's just
> set it once when it actually starts getting used.
> 

Good, I will update the patchset today.

Thanks.

