Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A7C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 02:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjB0C6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Feb 2023 21:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjB0C6G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Feb 2023 21:58:06 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6FA5FC
        for <linux-block@vger.kernel.org>; Sun, 26 Feb 2023 18:58:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcVvbWo_1677466680;
Received: from 30.97.56.173(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VcVvbWo_1677466680)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 10:58:00 +0800
Message-ID: <f20ad4c4-fc74-0bea-a07d-8f6c8a028754@linux.alibaba.com>
Date:   Mon, 27 Feb 2023 10:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
 <Y/h1LQbf+brRw1mo@T590> <20230224114156.yxul4qb323pswteq@shindev>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230224114156.yxul4qb323pswteq@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/24 19:41, Shinichiro Kawasaki wrote:
> On Feb 24, 2023 / 16:28, Ming Lei wrote:
>> On Fri, Feb 24, 2023 at 03:52:28PM +0800, Ziyang Zhang wrote:
>>> On 2023/2/20 11:46, Ming Lei wrote:
>>>
>>> [...]
>>>
>>>>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> ---
>>>>  src/.gitignore |    1 +
>>>>  src/Makefile   |   18 +
>>>>  src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 1395 insertions(+)
>>>>  create mode 100644 src/miniublk.c
>>>>
>>>> diff --git a/src/.gitignore b/src/.gitignore
>>>> index 355bed3..df7aff5 100644
>>>> --- a/src/.gitignore
>>>> +++ b/src/.gitignore
>>>> @@ -8,3 +8,4 @@
>>>>  /sg/dxfer-from-dev
>>>>  /sg/syzkaller1
>>>>  /zbdioctl
>>>> +/miniublk
>>>> diff --git a/src/Makefile b/src/Makefile
>>>> index 3b587f6..81c6541 100644
>>>> --- a/src/Makefile
>>>> +++ b/src/Makefile
>>>> @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
>>>>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>>>>  		else echo "$(3)"; fi)
>>>>  
>>>> +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
>>> Hi Ming,
>>>
>>> It should be "\#include", not "#include". You miss a "\".
>>
>> "\#include" won't work for checking the macro of IORING_OP_URING_CMD.
>>
>> [root@ktest-36 linux]# echo "\#include <liburing.h>" | gcc -E -
>> # 0 "<stdin>"
>> # 0 "<built-in>"
>> # 0 "<command-line>"
>> # 1 "/usr/include/stdc-predef.h" 1 3 4
>> # 0 "<command-line>" 2
>> # 1 "<stdin>"
>> \#include <liburing.h>
> 
> I also tried and observed the same symptom. HAVE_C_MACRO works well without the
> backslash. Adding the backslash, it fails.
> 
> I think Ziyang made the comment because HAVE_C_HEADER has the backslash. (Thanks
> for catching the difference between HAVA_C_HEADER and HAVE_C_MACRO.) I think
> another fix is needed to remove that backslash from HAVE_C_HEADER.  I've create
> a one liner fix patch quickly [1]. It looks ok for blktests CI. I will revisit
> it after Ming's patches get settled.
> 
> [1] https://github.com/osandov/blktests/pull/112/commits/dd5852e69abc3247d7b0ec4faf916a395378362d
> 

Hello,

Sorry, I am not familiar with shell script. But **without** the backslash,
I get this error:

$ make
make -C src all
make[1]: Entering directory '/home/alinux/workspace/blktests/src'
Makefile:5: *** unterminated call to function 'shell': missing ')'.  Stop.
make[1]: Leaving directory '/home/alinux/workspace/blktests/src'
make: *** [Makefile:5: all] Error 2

Regards,
Zhang
