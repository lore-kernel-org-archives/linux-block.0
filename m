Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CAC4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 22:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKUWev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUWeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 17:34:50 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616017E17
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 14:34:49 -0800 (PST)
Message-ID: <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669070087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mi5AOnkNDd5+Yw+FClfum/TPQGJ1wsJfNK1UjN5PLpY=;
        b=gEGNcd8+SurevPmIEcSmpmYBwWGnRLMXmOL8nUq3XOjVb0tJtb44Ajoy8xHkV5L8po5z64
        lSXbiOCb9t9HgOj/6TRHl3xuLs7D34tZrXupBZz8p2DsnRMe/htuTjJpjwc6BonJ33LUUH
        tXQsG5modsChaFE7JXeJRmbR1MGX1iE=
Date:   Mon, 21 Nov 2022 15:34:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <Y3vlsF7KcRrY7vCW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/21/2022 1:55 PM, Keith Busch wrote:
> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
>> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
>> reliably segfaults my QEMU instance (something else to look into) and I don't
>> have any 'real' hardware to test this on at the moment. It looks like several
>> passthru commands are able to enqueue prior/during/after resetting/connecting.
> 
> I'm not seeing any problem with the latest nvme-qemu after several dozen
> iterations of this test case. In that environment, the formats and
> resets complete practically synchronously with the call, so everything
> proceeds quickly. Is there anything special I need to change?
>  
I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
Does the tighter loop in the test comment header produce results?


>> The issue seems to be very heavily timing related, so the loop in the header is
>> a lot more forceful in this approach.
>>
>> As far as the loop goes, I've noticed it will typically repro immediately or
>> pass the whole test.
> 
> I can only get possible repro in scenarios that have multi-second long,
> serialized format times. Even then, it still appears that everything
> fixes itself after a waiting. Are you observing the same, or is it stuck
> forever in your observations?
In 5.19, it gets stuck forever with lots of formats outstanding and
controller stuck in resetting. I'll keep digging. Thanks Keith

> 
>> +remove_and_rescan() {
>> +	local pdev=$1
>> +	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
>> +	echo 1 > /sys/bus/pci/rescan
>> +}
> 
> This function isn't called anywhere.
