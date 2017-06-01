Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdFOWxn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2017 18:53:43 -0400
Subject: Re: RFC: pwritev2 regression test for invalid flags
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <a5987ece-5351-346b-21fd-5a3e0092229e@linaro.org>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <43631a74-8934-6940-3eaa-e562e49c5cb2@intel.com>
Date: Thu, 1 Jun 2017 11:52:25 -0600
MIME-Version: 1.0
In-Reply-To: <a5987ece-5351-346b-21fd-5a3e0092229e@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Zanella,

On 06/15/2017 04:10 PM, Adhemerval Zanella wrote:
> After the issue with LO_HI_LONG definition on x86_64-linux-gnu, I planed to add 
> this patch to check the above patch for correct check for invalid flags (which
> would also have show this issue with LO_HI_LONG being used on p{read,write}v2).
> 
> However it seems to trigger what I think it is a kernel bug on version that
> provides p{read,write}v, where preadv2 does fails with EOPNOTSUPP but
> pwritev2 does not.  For instance, on x86_64-linux-gnu-x32 and i686-linux-gnu
> (4.10.0-21-generic/x86_64):

It looks like the issue is that you are going through the compat_writev
path, which for some reason discards the flags parameter.

Can you apply the patch below to your kernel?
diff --git a/fs/read_write.c b/fs/read_write.c
index c4f88af..f77eb22 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1210,7 +1210,7 @@ static size_t compat_writev(struct file *file,
        if (!(file->f_mode & FMODE_CAN_WRITE))
                goto out;

-       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, 0);
+       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, flags);

 out:
        if (ret > 0)
