Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33392 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbdFPNCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 09:02:11 -0400
Received: by mail-yw0-f179.google.com with SMTP id 63so18134541ywr.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2017 06:02:11 -0700 (PDT)
Subject: Re: RFC: pwritev2 regression test for invalid flags
To: Christoph Hellwig <hch@infradead.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Cc: GNU C Library <libc-alpha@sourceware.org>,
        Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        viro@zeniv.linux.org.uk
References: <a5987ece-5351-346b-21fd-5a3e0092229e@linaro.org>
 <43631a74-8934-6940-3eaa-e562e49c5cb2@intel.com>
 <20170616060459.GA5472@infradead.org>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <83b773ee-8fec-a164-fd73-c707e21447e2@linaro.org>
Date: Fri, 16 Jun 2017 10:01:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170616060459.GA5472@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 16/06/2017 03:04, Christoph Hellwig wrote:
> On Thu, Jun 01, 2017 at 11:52:25AM -0600, Jon Derrick wrote:
>> Can you apply the patch below to your kernel?
> 
> I've already sent this patch to Al twice (including a stable tag),
> but it didn't seem to make it anywhere.

Right, thanks for the reply.  So it is a kernel issue and I think it
should not prevent us to use it a regression test.

> 
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index c4f88af..f77eb22 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1210,7 +1210,7 @@ static size_t compat_writev(struct file *file,
>>         if (!(file->f_mode & FMODE_CAN_WRITE))
>>                 goto out;
>>
>> -       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, 0);
>> +       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, flags);
>>
>>  out:
>>         if (ret > 0)
> ---end quoted text---
> 
