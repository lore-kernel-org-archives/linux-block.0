Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33309 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdGQPSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 11:18:11 -0400
Received: by mail-wr0-f170.google.com with SMTP id a10so13517232wrd.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2017 08:18:11 -0700 (PDT)
In-Reply-To: 
From: Evangelos Foutras <evangelos@foutrelis.com>
Subject: Re: linux-next scsi-mq hang in suspend-resume
Cc: linux-block@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <e2ce0f02-cf79-dc28-9380-3f2c558210c7@foutrelis.com>
Date: Mon, 17 Jul 2017 18:18:07 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

(Hopefully I got the In-Reply-To header right and won't mess up the thread.)

On 17/07/17 10:53, Christoph Hellwig wrote:
> I still haven't gotten hold of an i915 machine where I could
> run the actua ltest suite.

At the risk of posting an unproductive "me too" reply, I also got bit by
the dead disk on resume from S3 when Arch Linux enabled MQ by default in
the 4.12 kernel (CONFIG_SCSI_MQ_DEFAULT=y). The configuration change was
later reverted due to this issue.

For me the hang occurs pretty reliably (tested about 5-6 times) on an
Intel laptop and an AMD desktop, both with HDDs and ext4 on top of LUKS.
It feels as if the disk stops responding to commands. The machine itself
wakes up from sleep but even a simple `ls` will hang and do nothing.

> But I did some audit of the code, and it seems blk-mq is lacking
> support for the RQF_PM flag.  While I can't directly see how
> this would cause the hang your caused it's a least easy to test.
>
> Can you apply the patch below and test with the use_blk_mq=0 parameter?

I think the patch needs to be tested with scsi_mod.use_blk_mq=1 (which I
will try to do and report back).
