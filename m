Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751917AbdBBX5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 18:57:03 -0500
Subject: Re: block for-next: zram build error
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1486078839.2816.24.camel@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
From: Jens Axboe <axboe@fb.com>
Message-ID: <57303c09-8bf3-3660-ca01-80d13fcca98c@fb.com>
Date: Thu, 2 Feb 2017 16:56:50 -0700
MIME-Version: 1.0
In-Reply-To: <1486078839.2816.24.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/02/2017 04:40 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> I noticed accidentally that with the for-next branch of the block
> git repository that the zram driver doesn't build anymore:
> 
> 
> $ make M=drivers/block/zram
>   LD      drivers/block/zram/built-in.o
>   CC [M]  drivers/block/zram/zcomp.o
>   CC [M]  drivers/block/zram/zram_drv.o
> drivers/block/zram/zram_drv.c: In function ‘zram_revalidate_disk’:
> drivers/block/zram/zram_drv.c:120:37: error: ‘zram->disk->queue->backing_dev_info’ is a pointer; did you mean to use ‘->’?
>   zram->disk->queue->backing_dev_info.capabilities |=
>                                      ^
>                                      ->
> make[1]: *** [scripts/Makefile.build:294: drivers/block/zram/zram_drv.o] Error 1
> make: *** [Makefile:1490: _module_drivers/block/zram] Error 2
> 
> Compilation exited abnormally with code 2 at Thu Feb  2 15:37:19
> 
> 
> I have not yet tried to figure out which commit broke the build.

Thanks for catching that, Bart. I fixed it here after your report:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.11/next&id=e17354961bb50931ec7b33f59c0713dcf98ac7d2

It's caused by commit:

commit dc3b17cc8bf21307c7e076e7c778d5db756f7871
Author: Jan Kara <jack@suse.cz>
Date:   Thu Feb 2 15:56:50 2017 +0100

    block: Use pointer to backing_dev_info from request_queue

-- 
Jens Axboe

