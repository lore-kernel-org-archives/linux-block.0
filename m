Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35897C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF072173C
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHHVAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:00:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42650 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHVAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 17:00:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so44083822plb.9
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 14:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1N8lF3oHRIzR+bRugZI1tyGiLoVNk5fMIMSGh8hftKE=;
        b=d/c4GQ+E2kT5hhC3elN40Ic531HrMQzK0TIkxiZwd9V/IKH1kGialSuO6qHE9f4oF9
         +8jWaLJ4siRmw6Ij3ZPxlYu3F8HxkIqirUQ1ocHeEQpqD1Ea9xAShYi/drwQNYIyAfKD
         NyDD8bFkMpkpMF50XhIiqyKgmSw2uBLzPxrUVO6rvpPU7M4FSVeas0LfomMSb1NVy0HA
         NbnyM9NbFhmCicCF1M80IE9lt0Fz9V91D38a3bS5KH2pMqgxaG89Tg8wGzR5WeRdf11b
         QHm1DSEHMpUHW0ESpF71paXDN+MoHb7oVRByUFvHOtHaBiYYM26xo84XMsJX6Ll0I70B
         1KYw==
X-Gm-Message-State: APjAAAX/3KlMfPN+knkOoc16ZGBGwZkrSkwUGLxy6Pin97TX80J1lPzs
        iiFqgYc5QkG0A4+twISSedI=
X-Google-Smtp-Source: APXvYqycKDrdqxmWRP0VYSgs/rbnJLpFUY71HLb1khNqhx7LWcRgetujVFaXLqti+aOt/rg4emjB6w==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr15296874pls.294.1565298042998;
        Thu, 08 Aug 2019 14:00:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z20sm155447829pfk.72.2019.08.08.14.00.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 14:00:42 -0700 (PDT)
Subject: Re: [PATCH blktests 1/4] tests/nvme/rc: Modify the approach for
 disabling and re-enabling Ctrl-C
To:     Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190808200506.186137-1-bvanassche@acm.org>
 <20190808200506.186137-2-bvanassche@acm.org>
 <a90e327d-ea09-0286-f985-2d3775a38728@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a6b0bea2-3efb-fc04-f5a3-1dad562c72da@acm.org>
Date:   Thu, 8 Aug 2019 14:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a90e327d-ea09-0286-f985-2d3775a38728@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 1:08 PM, Logan Gunthorpe wrote:
> On 2019-08-08 2:05 p.m., Bart Van Assche wrote:
>> Avoid that the following error messages are reported when redirecting stdin:
>>
>> stty: 'standard input': Inappropriate ioctl for device
>> stty: 'standard input': Inappropriate ioctl for device
>>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>> Fixes: a987b10bc179 ("nvme: Ensure all ports and subsystems are removed on cleanup")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   tests/nvme/rc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index d4e18e635dea..40f0413d32d2 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -36,7 +36,7 @@ _cleanup_nvmet() {
>>   	fi
>>   
>>   	# Don't let successive Ctrl-Cs interrupt the cleanup processes
>> -	stty -isig
>> +	trap '' SIGINT
> 
> Did you test this? Pretty sure I tried using trap and it didn't work,
> probably because it's already running inside a trapped SIGINT.
> 
> Maybe it'd be better to just ignore any errors stty produces and pipe to
> /dev/null?

Hi Logan,

I don't think that redirecting the stty errors would be sufficient 
because Ctrl-C still works even if stdin, stdout and stderr are 
redirected. A command like sleep 60 </dev/null >&/dev/null can be 
interrupted with Ctrl-C but stty -isig >&/dev/null does not suppress 
Ctrl-C if stdin is redirected.

Are there other trap SIGINT statements in the blktests code? Does that 
mean that I overlooked something?

Thanks,

Bart.
