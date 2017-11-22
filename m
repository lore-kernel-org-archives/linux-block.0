Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:42763 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdKVFSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 00:18:37 -0500
Received: by mail-qk0-f178.google.com with SMTP id a194so15224778qkc.9
        for <linux-block@vger.kernel.org>; Tue, 21 Nov 2017 21:18:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <32ba916e-a7d4-b4c0-ea75-844bb34a3d86@coly.li>
References: <1509437651-24052-1-git-send-email-tang.junhui@zte.com.cn> <32ba916e-a7d4-b4c0-ea75-844bb34a3d86@coly.li>
From: Michael Lyle <mlyle@lyle.org>
Date: Tue, 21 Nov 2017 21:18:36 -0800
Message-ID: <CAJ+L6qd3gVypK29V4xYs100zj0VmmTqNeGFs7BLzU8NDCJ=k0g@mail.gmail.com>
Subject: Re: [PATCH] bcache: stop writeback thread after detaching
To: Coly Li <i@coly.li>
Cc: Junhui Tang <tang.junhui@zte.com.cn>, Coly Li <colyli@suse.de>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang Junhui--

Thanks for noticing this issue.

On Wed, Nov 1, 2017 at 4:55 AM, Coly Li <i@coly.li> wrote:
> On 2017/10/31 =E4=B8=8B=E5=8D=884:14, tang.junhui@zte.com.cn wrote:
>> From: Tang Junhui <tang.junhui@zte.com.cn>
>>
>> Currently, when a cached device detaching from cache, writeback thread i=
s not stopped,
>> and writeback_rate_update work is not canceled. For example, after bello=
w command:
>> echo 1 >/sys/block/sdb/bcache/detach
>> you can still see the writeback thread. Then you attach the device to th=
e cache again,
>> bcache will create another writeback thread, for example, after bellow c=
ommand:
>> echo  ba0fb5cd-658a-4533-9806-6ce166d883b9 > /sys/block/sdb/bcache/attac=
h
>> then you will see 2 writeback threads.
>> This patch stops writeback thread and cancels writeback_rate_update work=
 when cached
>> device detaching from cache.
>>
>> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
>
> If the change can be inside bch_register_lock, it would (just) be more
> comfortable. The code is correct, because attach/detach sysfs is created
> after writeback_thread created and writeback_rate_update worker
> initialized, even these resources are initialized within
> bch_register_lock and released out of bch)register_lock in your patch,
> there won't be any race. It's OK to me.
>

I think I agree with Coly that I'd prefer it to be moved down into the
register lock, as I think that will be safer with any future changes.
Are you willing to adjust it this way?

Thanks,

Mike
