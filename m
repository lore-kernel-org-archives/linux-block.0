Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7314C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 06:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjB0GKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 01:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0GKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 01:10:05 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF24E05A
        for <linux-block@vger.kernel.org>; Sun, 26 Feb 2023 22:10:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcX.IGf_1677478201;
Received: from 30.97.56.173(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VcX.IGf_1677478201)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 14:10:01 +0800
Message-ID: <cfccc895-5a9b-f45b-5851-74c94219d743@linux.alibaba.com>
Date:   Mon, 27 Feb 2023 14:10:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
 <Y/h1LQbf+brRw1mo@T590> <20230224114156.yxul4qb323pswteq@shindev>
 <f20ad4c4-fc74-0bea-a07d-8f6c8a028754@linux.alibaba.com>
 <20230227054130.eygpm5e22yejug6t@shindev>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230227054130.eygpm5e22yejug6t@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/27 13:41, Shinichiro Kawasaki wrote:
> On Feb 27, 2023 / 10:57, Ziyang Zhang wrote:
>> On 2023/2/24 19:41, Shinichiro Kawasaki wrote:
>>> On Feb 24, 2023 / 16:28, Ming Lei wrote:
>>>> On Fri, Feb 24, 2023 at 03:52:28PM +0800, Ziyang Zhang wrote:
>>>>> On 2023/2/20 11:46, Ming Lei wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>> ---
>>>>>>  src/.gitignore |    1 +
>>>>>>  src/Makefile   |   18 +
>>>>>>  src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  3 files changed, 1395 insertions(+)
>>>>>>  create mode 100644 src/miniublk.c
>>>>>>
>>>>>> diff --git a/src/.gitignore b/src/.gitignore
>>>>>> index 355bed3..df7aff5 100644
>>>>>> --- a/src/.gitignore
>>>>>> +++ b/src/.gitignore
>>>>>> @@ -8,3 +8,4 @@
>>>>>>  /sg/dxfer-from-dev
>>>>>>  /sg/syzkaller1
>>>>>>  /zbdioctl
>>>>>> +/miniublk
>>>>>> diff --git a/src/Makefile b/src/Makefile
>>>>>> index 3b587f6..81c6541 100644
>>>>>> --- a/src/Makefile
>>>>>> +++ b/src/Makefile
>>>>>> @@ -2,6 +2,10 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
>>>>>>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>>>>>>  		else echo "$(3)"; fi)
>>>>>>  
>>>>>> +HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
>>>>> Hi Ming,
>>>>>
>>>>> It should be "\#include", not "#include". You miss a "\".
>>>>
>>>> "\#include" won't work for checking the macro of IORING_OP_URING_CMD.
>>>>
>>>> [root@ktest-36 linux]# echo "\#include <liburing.h>" | gcc -E -
>>>> # 0 "<stdin>"
>>>> # 0 "<built-in>"
>>>> # 0 "<command-line>"
>>>> # 1 "/usr/include/stdc-predef.h" 1 3 4
>>>> # 0 "<command-line>" 2
>>>> # 1 "<stdin>"
>>>> \#include <liburing.h>
>>>
>>> I also tried and observed the same symptom. HAVE_C_MACRO works well without the
>>> backslash. Adding the backslash, it fails.
>>>
>>> I think Ziyang made the comment because HAVE_C_HEADER has the backslash. (Thanks
>>> for catching the difference between HAVA_C_HEADER and HAVE_C_MACRO.) I think
>>> another fix is needed to remove that backslash from HAVE_C_HEADER.  I've create
>>> a one liner fix patch quickly [1]. It looks ok for blktests CI. I will revisit
>>> it after Ming's patches get settled.
>>>
>>> [1] https://github.com/osandov/blktests/pull/112/commits/dd5852e69abc3247d7b0ec4faf916a395378362d
>>>
>>
>> Hello,
>>
>> Sorry, I am not familiar with shell script. But **without** the backslash,
>> I get this error:
>>
>> $ make
>> make -C src all
>> make[1]: Entering directory '/home/alinux/workspace/blktests/src'
>> Makefile:5: *** unterminated call to function 'shell': missing ')'.  Stop.
>> make[1]: Leaving directory '/home/alinux/workspace/blktests/src'
>> make: *** [Makefile:5: all] Error 2
> 
> I see... I googled and learned that make version 4.3 introduced this '# inside
> macro' handling difference [2]. I guess your make has version older than 4.3,
> isn't it?
> 
> [2] https://lwn.net/Articles/810071/
> 
> Per the the LWN article [2], the fix should be as follows. It works as expected
> on my system with make version 4.3. Could you try it on your system?
> 
> diff --git a/src/Makefile b/src/Makefile
> index 81c6541..322eb1c 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -1,8 +1,10 @@
> -HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
> +H := \#
> +
> +HAVE_C_HEADER = $(shell if echo "$(H)include <$(1)>" |		\
>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>  		else echo "$(3)"; fi)
>  
> -HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
> +HAVE_C_MACRO = $(shell if echo -e "$(H)include <$(1)>" |	\
>  		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
>  		then echo 1;else echo 0; fi)

My make version is 4.2.1, and your fix works! Thanks, Shinichiro.

Regards,
Zhang
