Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B06FC77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjERXjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjERXjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86890B3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E1E65141
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77A7C433D2;
        Thu, 18 May 2023 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684453189;
        bh=kkNU73U1fzhVWu9XoIA+BzNhOqs5ILS0qrpMilT9HtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lD1rvFoBF8hV/SnPrqIConC88CO+fu7KD3mZwMEtDK618oOOoFQV3dWIWKIMYxWmD
         967dxwxEyflKCUcS3FxT++P/HwL4meflpPG0r/WEBQFkDswQ+oSpW5FlelqBypJVAS
         WF3+75OcziClManvDrokINwIMtec1DCswqNPmBerzNWDEfl5pqV8PukjcHOsJhtjJt
         RNuwqRCWGlACL8k394jX2NjgdrGc32MucWAcXZtuUdA7ve8CaYENwDEvL4K8aEN5OO
         4aTmriIk4m75AEx6AkxqfmfesNgx6fi6UvhzC174QxBcJzHyRqHS8vOZTgx/Dtbd8e
         92Gpc6kYJ6gww==
Message-ID: <d38c2868-93c4-9111-aa14-bc986c60fff4@kernel.org>
Date:   Fri, 19 May 2023 08:39:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 01/11] block: mq-deadline: Add a word in a source code
 comment
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-2-bvanassche@acm.org>
 <f6086451-0811-7f25-035c-9c06fc40b5bd@kernel.org>
 <ee9bcf21-dafc-3d8d-d90a-b2bd54c5eb24@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ee9bcf21-dafc-3d8d-d90a-b2bd54c5eb24@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/23 08:20, Bart Van Assche wrote:
> On 5/18/23 16:11, Damien Le Moal wrote:
>> On 5/18/23 02:42, Bart Van Assche wrote:
>>> Add the missing word "and".
>>>
>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>>> Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline IO scheduler")
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>
>> Replying to this patch as there is no cover letter.
>>
>> I gave this series a spin yesterday using a 26TB SMR drive. No issues detected
>> and no performance regression that I can see. Tested on top of 6.4-rc2.
>>
>> So feel free to add:
>>
>> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Thanks Damien!
> 
> BTW, it seems like Lore received the cover letter. See also 
> https://lore.kernel.org/linux-block/20230517174230.897144-1-bvanassche@acm.org/T/#t.

Weird... I do not have it in my inbox..

> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

