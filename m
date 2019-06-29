Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F87C5B577
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F64216FD
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfF2TqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:46:08 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:46469 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbfF2TqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 15:46:08 -0400
Received: from [192.168.32.100] (p5DCCE4B4.dip0.t-ipconnect.de [93.204.228.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 1289F1F453;
        Sat, 29 Jun 2019 21:46:04 +0200 (CEST)
Subject: Re: [PATCH v2] drivers/block/loop: Replace deprecated function in
 option parsing code
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
References: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190625175517.31133-1-florian.knauf@stud.uni-hannover.de>
 <BYAPR04MB574963E31CE0DB5581F5311F86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Florian Knauf <florian.knauf@stud.uni-hannover.de>
Message-ID: <eb0b0981-aba3-93dc-5ae5-d36f1f728024@stud.uni-hannover.de>
Date:   Sat, 29 Jun 2019 21:46:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB574963E31CE0DB5581F5311F86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------696AF862470C2DEF88101BCF"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------696AF862470C2DEF88101BCF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I have now, on the latest staging master (test log attached, everything 
green), and also learned a lesson about looking more thoroughly for 
automated test cases. That's a mea culpa, I suppose. :P

Before this I'd only found the Linux Test Project, which (if I'm not 
mistaken) contains tests that use loopback devices but no tests that 
specifically test the loopback driver itself. Given the small scope of 
the change, we then considered it sufficient to test manually that the 
loop device still worked and that the max_loop parameter was handled 
correctly. Of course, the blktests way is better.

Thanks for taking the time to answer and review.

Am 25.06.19 um 21:24 schrieb Chaitanya Kulkarni:
> I believe you have tested this patch with loop testcases present in the
> :- https://github.com/osandov/blktests/tree/master/tests/loop.
> 
> With that, looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.
> 
> On 06/25/2019 10:55 AM, Florian Knauf wrote:
>> This patch removes the deprecated simple_strtol function from the option
>> parsing logic in the loopback device driver. Instead kstrtoint is used to
>> parse int max_loop, to ensure that input values it cannot represent are
>> ignored.
>>
>> Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>
>> Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>
>> ---
>> Thank you for your feedback.
>>
>> There's no specific reason to use kstrtol, other than the fact that we
>> weren't yet aware that kstrtoint exists. (We're new at this, I'm afraid.)
>>
>> We've amended the patch to make use of kstrtoint, which is of course much
>> more straightforward.
>>
>> drivers/block/loop.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 102d79575895..adfaf4ad37d1 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -2289,7 +2289,7 @@ module_exit(loop_exit);
>>    #ifndef MODULE
>>    static int __init max_loop_setup(char *str)
>>    {
>> -	max_loop = simple_strtol(str, NULL, 0);
>> +	kstrtoint(str, 0, &max_loop);
>>    	return 1;
>>    }
>>
>>
> 

--------------696AF862470C2DEF88101BCF
Content-Type: text/x-log;
 name="check.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="check.log"

loop/001 (scan loop device partitions)                      
    runtime  0,401s  ...
loop/001 (scan loop device partitions)                       [passed]
    runtime  0,401s  ...  0,269s
loop/002 (try various loop device block sizes)              
    runtime  0,142s  ...
loop/002 (try various loop device block sizes)               [passed]
    runtime  0,142s  ...  0,148s
loop/003 (time opening and closing an unbound loop device)  
    runtime  0,047s  ...
loop/003 (time opening and closing an unbound loop device)   [passed]
    runtime  0,047s  ...  0,052s
loop/004 (combine loop direct I/O mode and a custom block size)
    runtime  0,382s  ...
loop/004 (combine loop direct I/O mode and a custom block size) [passed]
    runtime  0,382s  ...  0,383s
loop/005 (call LOOP_GET_STATUS{,64} with a NULL arg)        
    runtime  0,024s  ...
loop/005 (call LOOP_GET_STATUS{,64} with a NULL arg)         [passed]
    runtime  0,024s  ...  0,025s
loop/006 (change loop backing file while creating/removing another loop device)
    runtime  31,071s  ...
loop/006 (change loop backing file while creating/removing another loop device) [passed]
    runtime  31,071s  ...  31,050s
loop/007 (update loop device capacity with filesystem)      
    runtime  0,417s  ...
loop/007 (update loop device capacity with filesystem)       [passed]
    runtime  0,417s  ...  0,351s

--------------696AF862470C2DEF88101BCF--
