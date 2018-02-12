Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65265 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964924AbeBLQbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Feb 2018 11:31:19 -0500
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
To: Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
Date: Mon, 12 Feb 2018 08:31:18 -0800
MIME-Version: 1.0
In-Reply-To: <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/11/18 23:35, Paolo Valente wrote:
> Also this smells a little bit like some spurious elevator call.
> Unfortunately I have no clue on the cause.  To go on, I need at least
> to reproduce it.  In this respect: Bart, could you please tell me how
> to setup the offending configuration, and to cause the failure?
> Possibly with just one, or at most two PCs.  I don't have fancier hw
> at the moment.

Hello Paolo,

Although I expect that it is possible to reproduce this with an 
unmodified v4.16-rc1 kernel, this is how I ran into this issue:
* Clone the for-next branch of https://github.com/bvanassche/linux.
* Build and install that kernel in a virtual machine.
* Clone https://github.com/bvanassche/srp-test.
* Run the following command:
   srp-test/run_tests -c -d -r 10 -t 02-mq -e bfq

Thanks,

Bart.
