Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D6C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BC3214C6
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfHHVLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:11:43 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60534 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHVLm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Aug 2019 17:11:42 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hvphF-0007mc-3o; Thu, 08 Aug 2019 15:11:42 -0600
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190808200506.186137-1-bvanassche@acm.org>
 <20190808200506.186137-2-bvanassche@acm.org>
 <a90e327d-ea09-0286-f985-2d3775a38728@deltatee.com>
 <a6b0bea2-3efb-fc04-f5a3-1dad562c72da@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5668ac69-a7e3-766b-852b-c7d1cb99dcec@deltatee.com>
Date:   Thu, 8 Aug 2019 15:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6b0bea2-3efb-fc04-f5a3-1dad562c72da@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: jthumshirn@suse.de, linux-block@vger.kernel.org, osandov@fb.com, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests 1/4] tests/nvme/rc: Modify the approach for
 disabling and re-enabling Ctrl-C
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-08-08 3:00 p.m., Bart Van Assche wrote:
> On 8/8/19 1:08 PM, Logan Gunthorpe wrote:
>> On 2019-08-08 2:05 p.m., Bart Van Assche wrote:
>>> Avoid that the following error messages are reported when redirecting
>>> stdin:
>>>
>>> stty: 'standard input': Inappropriate ioctl for device
>>> stty: 'standard input': Inappropriate ioctl for device
>>>
>>> Cc: Logan Gunthorpe <logang@deltatee.com>
>>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>>> Fixes: a987b10bc179 ("nvme: Ensure all ports and subsystems are
>>> removed on cleanup")
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   tests/nvme/rc | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>>> index d4e18e635dea..40f0413d32d2 100644
>>> --- a/tests/nvme/rc
>>> +++ b/tests/nvme/rc
>>> @@ -36,7 +36,7 @@ _cleanup_nvmet() {
>>>       fi
>>>         # Don't let successive Ctrl-Cs interrupt the cleanup processes
>>> -    stty -isig
>>> +    trap '' SIGINT
>>
>> Did you test this? Pretty sure I tried using trap and it didn't work,
>> probably because it's already running inside a trapped SIGINT.
>>
>> Maybe it'd be better to just ignore any errors stty produces and pipe to
>> /dev/null?
> 
> Hi Logan,
> 
> I don't think that redirecting the stty errors would be sufficient
> because Ctrl-C still works even if stdin, stdout and stderr are
> redirected. A command like sleep 60 </dev/null >&/dev/null can be
> interrupted with Ctrl-C but stty -isig >&/dev/null does not suppress
> Ctrl-C if stdin is redirected.

Ok, actually I just tested your change and it does work. I must have
done something slightly differently when I first tried it (I think I
added a handler which echoed messages which still let the SIGINTs
through to child processes but it works with the null string).

So:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> Are there other trap SIGINT statements in the blktests code? Does that
> mean that I overlooked something?

The main code traps EXIT which calls the cleanup handler that this trap
then overrides SIGINT with, so I'm not really sure how they interact.

Thanks,

Logan
