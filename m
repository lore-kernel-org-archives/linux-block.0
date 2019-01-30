Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5AC282D0
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBC621473
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfA3BTp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:19:45 -0500
Received: from gfuc.org ([88.99.83.187]:48038 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfA3BTp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 20:19:45 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 20:19:41 EST
Received: from [192.168.178.39] (p57B54809.dip0.t-ipconnect.de [87.181.72.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id 58E341E00DE;
        Wed, 30 Jan 2019 01:13:31 +0000 (UTC)
Date:   Wed, 30 Jan 2019 02:13:28 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <c5f74f0b-5a03-0478-0a5e-2232ab28713c@oracle.com>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de> <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com> <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de> <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com> <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com> <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de> <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com> <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de> <3d921990-06c4-4662-2853-7667b4e9a462@oracle.com> <4fe48ebc-43db-7ada-087b-5ccbdb64cc66@oracle.com> <00501045-a87b-27d0-6373-72dcf243b32b@florianstecker.de> <a7a3e95e-5c66-31d6-c442-ad295f82d72c@oracle.com> <c5f74f0b-5a03-0478-0a5e-2232ab28713c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: fsync hangs after scsi rejected a request
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Florian Stecker <m19@florianstecker.de>,
        Ming Lei <tom.leiming@gmail.com>
CC:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
From:   Florian Stecker <mail@florianstecker.de>
Message-ID: <FFA98CC2-5083-4DD4-AC1E-ECA7A5BA52E4@florianstecker.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jianchao,

I just tried it out - it seems to work nicely.

Best,
Florian


On January 30, 2019 2:13:14 AM GMT+01:00, "jianchao.wang" <jianchao.w.wang@oracle.com> wrote:
>Hi Florian
>
>On 1/28/19 10:42 AM, jianchao.wang wrote:
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index a3fc7191..6e0f2d9 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -335,7 +335,7 @@ static void mq_flush_data_end_io(struct request
>*rq, blk_status_t error)
>>         blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
>>         spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>>  
>> -       blk_mq_run_hw_queue(hctx, true);
>> +       blk_mq_sched_restart(hctx);
>>  }
>
>Does this patch work ?
>
>Thanks
>Jianchao
