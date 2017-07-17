Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32885 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdGQRRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 13:17:14 -0400
Received: by mail-oi0-f41.google.com with SMTP id p188so123504915oia.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2017 10:17:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2ce0f02-cf79-dc28-9380-3f2c558210c7@foutrelis.com>
References: <e2ce0f02-cf79-dc28-9380-3f2c558210c7@foutrelis.com>
From: Evangelos Foutras <evangelos@foutrelis.com>
Date: Mon, 17 Jul 2017 20:17:13 +0300
Message-ID: <CAA407mxf83uagxsbd-ZvTSSH8hmrct=TT7SwJn40Sgmp99QPAA@mail.gmail.com>
Subject: Re: linux-next scsi-mq hang in suspend-resume
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 17 July 2017 at 18:18, Evangelos Foutras <evangelos@foutrelis.com> wrote:
> On 17/07/17 10:53, Christoph Hellwig wrote:
>> But I did some audit of the code, and it seems blk-mq is lacking
>> support for the RQF_PM flag.  While I can't directly see how
>> this would cause the hang your caused it's a least easy to test.
>>
>> Can you apply the patch below and test with the use_blk_mq=0 parameter?
>
> I think the patch needs to be tested with scsi_mod.use_blk_mq=1 (which I
> will try to do and report back).

I briefly tested the patch (on top of Linux 4.12.2) and it appears to
successfully work around the issue; my laptop happily resumes from S3
and can access the HDD.
