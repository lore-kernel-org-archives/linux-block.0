Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE64C678D6
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjAJAck (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjAJAch (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:32:37 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482EC43
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673310756; x=1704846756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DKdZKK3/sgBlphfMmvtyhfzt7eos3fPR7kuTFGJqVYk=;
  b=aE44dMtKRho4BIFePZUm4ybqsi9KkxkgOBRIxvbxyY3kyMj69Q8hsTRs
   AgpmBxnst4WgNfKZ6v5IitSmSEMKnPL5hb2XC/q66c9BGxCwS87xM91CV
   Mr7PPduJ+XPrkfY7bhVpEyh2leVntZC+kMZZ4sm6F6/elyYy7br7HNxeE
   NApHwSeRXHkxAjx7xKp7hqazYs4YJWIzCEF0/Agw/nyOT2Wf5qvfMwmKY
   kRXwqeHbiam/ot3/l2GRvB3pQnnoqxqkQIaeReLI5J4UmjG/Gj1N2SCa2
   dcB8AWsso+UncXkDtVnLdniSnwiLdLF+XKJ8o4Eb/DNyeSrcviDfwkYwR
   A==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="220508678"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 08:32:35 +0800
IronPort-SDR: x1+InM2o8ufxLKrTv/g/Eps+8BIRBjCYm1udovswAytAMpznpdSyYN5zY1u0DF6RJsDI0xJCb4
 MDStLpdowZGgrhc933o3NAFLdI3ltlXYaRAF8C6MoBpS6PLWnEAjgDE2SrSWMu0hYGGfDYzaUr
 7WYSNMgipnQlRHzzLonEs8c8PMLosO4/KAwqWFsiec5rDPz20tapgsFn1tDy8SUUdYFOmGWy46
 tLoH/hjquEMeQYT7V24R9kRBJ7aywOhr7o7cN18YJJjKhlFI5Xz+8j7kvcIkTpr35A0Gu+e/n4
 Owg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:44:41 -0800
IronPort-SDR: 3pK65/98U0wCpIQtHOgiUzBC4T4uVxA+b2DPrv3ZhO7Pl/x2vpygoriLmQSjGSkZLmV/k44sJT
 3vWq+bZCShXBwGMLHZIfWQ6c0q03R2/V4T/WKq96VZhndhevPalUZWC6psIacZ06RvY9N3UsaV
 06Cu9Sb7tcDGjV2rxXc0wOYCpt/wQwDURgIt70YZ+rAd5Qg1dBXRPXKOtCTBzGdivwUbX2sDWB
 DregFw+ZPLRsV0FvOpJMII2MAKR5x5MV4PO4dqC8jSZUQMtIizLDz203AzEKx6iCzauNUU9LOp
 K1Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 16:32:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrWwz37JMz1RvTr
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:32:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673310754; x=1675902755; bh=DKdZKK3/sgBlphfMmvtyhfzt7eos3fPR7ku
        TFGJqVYk=; b=g8WT3yJhpM6m/y+AjfXnsFsKnH+VDO/1CSuno+VIWoorp6wZJep
        kLheZlaI+ke7gNhmL5aAknqAUqYEQuzClTcRLeyEIsQ8M/yYApRV6V6PjYFBIcDm
        fmT94N7oI/LjbLAAhR0lnXMCgEY/fCrb+t5pWQCPOGfUHwfo3lbI1L/veP8KK457
        sETZ4n5xD9hd6T8yQvige1/dJYo8eMcOTIU3WWy4m155vNYRPJzZ4FFPWwmIzav7
        nun6S6a8YHp/D1xsjiFV1gl8MTeTk9J6XI1g+6Ysqd82Oc5rLWLDTdoyuM1SHqL2
        OZgCUj1C4RqoEBR6t2VGiK4PiWBmmTKAuoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1wRxLdUTd5on for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 16:32:34 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrWwx5yzxz1RvLy;
        Mon,  9 Jan 2023 16:32:33 -0800 (PST)
Message-ID: <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 09:32:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 09:19, Bart Van Assche wrote:
> On 1/9/23 15:56, Damien Le Moal wrote:
>> But my point is that if a request goes through the block layer requeue, it
>> will be out of order, and will be submitted out of order again, and will
>> fail again. Unless you stall dispatching, wait for all requeues to come
>> back in the scheduler, and then start trying again, I do not see how you
>> can guarantee that retrying the unaligned writes will ever succeed.
>>
>> I am talking in the context of host-managed devices here.
> 
> Hi Damien,
> 
> How about changing the NEEDS_RETRY in patch 7/8 into another value than 
> SUCCESS, NEEDS_RETRY or ADD_TO_MLQUEUE? That will make the SCSI core 
> wait until all pending commands have finished before it starts its error 
> handling strategy and before it requeues any pending commands.

Considering a sequence of sequential write requests, the request can be in:
1) The scheduler
2) The dispatch queue (out of the scheduler)
3) In the requeue list, waiting to be put back in the scheduler
4) in-flight being processed for dispatch by the scsi mid-layer & scsi
disk driver
5) being processed by the driver
6) dispatched to the device already

Requeue back to the scheduler can happen anywhere after (2) up to (5)
(would need to check again to be 100% sure though). So I do not see how
changes to the scsi layer only, adding a new state, can cover all possible
cases resulting at some point to come back to a clean ordering. But if you
have ideas to prove me wrong, I will be happy to review that :)

So far, the only thing that I think could work is: stall everything and
put back all write requests in the scheduler, and restart dispatching.
That will definitively have a performance impact. How does that compare to
the zone write locking performance impact, I am not sure...

It may be way simpler to rely on:
1) none scheduler
2) some light re-ordering of write requests in the driver itself to avoid
any requeue to higher level (essentially, handle requeueing in the driver
itself).

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

