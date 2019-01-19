Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9BC61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC382087E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 20:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfASUrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:47:01 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:39170 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbfASUrB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 15:47:01 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 5857319F4C8;
        Sat, 19 Jan 2019 21:45:58 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
Message-ID: <67344f49-5b56-86d3-eb2b-97441029ee82@free.fr>
Date:   Sat, 19 Jan 2019 21:45:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/01/2019 20:47, Marc Gonzalez wrote:

> On 19/01/2019 10:56, Christoph Hellwig wrote:
> 
>> On Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
>>
>>> It's UFS that totally buggy, if you look at its queuecommand, it does:
>>>
>>>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
>>>                 return SCSI_MLQUEUE_HOST_BUSY;
>>>
>>> UFS either needs to get fixed up, or we'll want a way to do something like
>>> the below.
>>
>> I think the right answer is to just revert the offending patch instead
>> of papering over it in the SCSI code.
> 
> [ Adjusting recipients list ]
> 
> Full thread, for new recipients:
> https://www.spinics.net/lists/linux-fsdevel/msg138601.html
> 
> Christoph, do you mean a3cd5ec55f6c7 ?

And by the way, can someone explain these two oddities:

1) the system only hangs if we try to read more than 3.8 GB
   (starting point is irrelevant)

2) the system does not hang if we use iflag=direct

Regards.
