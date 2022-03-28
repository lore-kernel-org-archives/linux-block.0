Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6287C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 15:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbiC1PIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiC1PIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 11:08:00 -0400
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9642493;
        Mon, 28 Mar 2022 08:06:17 -0700 (PDT)
Received: from [10.42.99.207]
        by iris.vrvis.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <valentin@vrvis.at>)
        id 1nYqvu-0002xb-Pi; Mon, 28 Mar 2022 17:05:27 +0200
Message-ID: <f74aa70e-8222-12fc-b44a-880865c9badd@vrvis.at>
Date:   Mon, 28 Mar 2022 17:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
References: <07bafc71-a6d2-ad6d-4706-7c99047b3228@vrvis.at>
 <YioZaO21yingv0nD@infradead.org>
From:   Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <YioZaO21yingv0nD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] block: aoe: handle device timeouts atomic-safe
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/03/2022 16:29, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 04:17:37PM +0100, Valentin Kleibel wrote:
>> If an aoe device does not respond to any packet on the network layer within
>> aoe_deadsecs, the driver tries to mark the device as down, fail all I/O and
>> clean out the queue.
> 
> I think the problem is that aoe even tries to queue up request
> internally. It really needs to switch to use BLK_MQ_F_BLOCKING and
> stop queuing up the requests internall at all.

Unfortunately I'm not able to assess this.
It would be a more complicated change than I'd be able to provide and 
the proposed patch fixes the existing issue.

Cheers,
Valentin
