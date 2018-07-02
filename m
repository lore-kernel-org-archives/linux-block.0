Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44211 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeGBNQK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jul 2018 09:16:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180702130310.GA19610@infradead.org>
References: <20180702050642.26265-1-ming.lei@redhat.com> <20180702125422.GA600@infradead.org>
 <20180702125652.jxjcig63xvljfqow@linux-x5ow.site> <20180702130310.GA19610@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 2 Jul 2018 21:16:08 +0800
Message-ID: <CACVXFVORKqQzANtkxvBY5dzBsDTNw9kO-ySCdvkPGtUeRghZRA@mail.gmail.com>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of 'use_blk_mq'
To: Christoph Hellwig <hch@infradead.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 2, 2018 at 9:03 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 02, 2018 at 02:56:52PM +0200, Johannes Thumshirn wrote:
>> On Mon, Jul 02, 2018 at 05:54:22AM -0700, Christoph Hellwig wrote:
>> > On Mon, Jul 02, 2018 at 01:06:42PM +0800, Ming Lei wrote:
>> > > With the introduced module parameter of 'use_blk_mq', it is easy
>> > > to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
>> > > module, so that we can test scsi_mq/blk_mq related regressions easily.
>> >
>> > No.  We should not make a per driver choice.
>>
>> Btw, wouldn't it be time for:
>>
>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>> index 35c909bbf8ba..bd115bab162e 100644
>> --- a/drivers/scsi/Kconfig
>> +++ b/drivers/scsi/Kconfig
>> @@ -49,6 +49,7 @@ config SCSI_NETLINK
>>
>>  config SCSI_MQ_DEFAULT
>>       bool "SCSI: use blk-mq I/O path by default"
>> +     default y
>>       depends on SCSI
>>       ---help---
>>         This option enables the new blk-mq based I/O path for SCSI
>>
>> again and see how we've improved in the last year and a half?
>
> Yes, totally.  We'll just need to sort out the error handling with
> scsi and mq first (for 4.18 in fact).

IMO, this two aren't contradictory, or not related, because this patch's
motivation is for doing scsi_mq/blk_mq regression test.

thanks,
Ming Lei
