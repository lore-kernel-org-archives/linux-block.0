Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE66C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77968207FD
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKYUty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:49:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42406 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYUty (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 15:49:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so7763221pgt.9
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2019 12:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFo6FpV3hvPtqHnef2DRfjIcDRiyQBx6qo4lEWdQ2fk=;
        b=WK5pLGTW61Zj7ou193M1WyPt0i0VLakMZXnJdXQxi2OnCl51NJm7p860SxmcGqlGe8
         kfMeGZtx/ufz9U1YwX1F0h5KntTI8Ec+iF2cBTknFVoFn6mn0Yk7ZL7AenA0XpitKW4A
         K95siTGfM15J5Gjr/bs787NIoUivgHik37KXPJpouGTp/5hKLsi8x/lIAboDrTiUyw9F
         NV30DlBFlcnUBjzj40yGKO/ku4BmF6Isrvv1ygmmCTaQrcZgLt/OoQ7mmx0TWRxXBOwV
         CIQworFeBjPBQ/zNQaVKxJHlyeT8+bkNP88wT1RCWBYLJM+ISHMamIZ62ZLFo+h0nTkG
         tFIw==
X-Gm-Message-State: APjAAAXIDQenmml3Soo4XsiwbVw/lVJoV2ZziKq9f/diOLH69K1nLCcG
        aiY8YxkOV+EXndzzGAZBJOlGyKqn
X-Google-Smtp-Source: APXvYqw27Em8pa1qkcvXPJh9+ljZJQn66h4zus1dqDMKeTWKI8wuH0tdpObVAftdZe264o1fEevIaQ==
X-Received: by 2002:a62:2942:: with SMTP id p63mr38057826pfp.110.1574714993350;
        Mon, 25 Nov 2019 12:49:53 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g7sm9261529pgr.52.2019.11.25.12.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:49:52 -0800 (PST)
Subject: Re: [PATCH blktests 4/4] tests/srp/015: Add a test that uses the
 SoftiWARP (siw) driver
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
References: <20191115170711.232741-1-bvanassche@acm.org>
 <20191115170711.232741-5-bvanassche@acm.org> <20191125201334.GA639675@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4dc03225-e495-6687-161b-e8b82a80f5c1@acm.org>
Date:   Mon, 25 Nov 2019 12:49:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125201334.GA639675@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/19 12:13 PM, Omar Sandoval wrote:
> On Fri, Nov 15, 2019 at 09:07:11AM -0800, Bart Van Assche wrote:
>> Recently support has been added in the SRP initiator and target drivers
>> for the SoftiWARP driver. Add a test for SRP over SoftiWARP.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   tests/srp/015     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/srp/015.out |  2 ++
>>   2 files changed, 44 insertions(+)
>>   create mode 100755 tests/srp/015
>>   create mode 100644 tests/srp/015.out
> 
> Hi, Bart,
> 
> I'm getting:
> 
> srp/015 (File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver) [failed]
>      runtime  1.076s  ...  1.026s
>      --- tests/srp/015.out       2019-11-25 12:07:06.749425714 -0800
>      +++ /home/vmuser/repos/blktests/results/nodev/srp/015.out.bad       2019-11-25 12:12:07.634062201 -0800
>      @@ -1,2 +1 @@
>      -Configured SRP target driver
>      -Passed
>      +mkdir: cannot create directory ‘0x52540012345600000000000000000000’: Invalid argument
> 
> This is on v5.4-rc8 with CONFIG_RDMA_SIW=m. Do you know what is wrong
> here?

Hi Omar,

I should have mentioned that the SRP iWARP support patches have been 
accepted in the RDMA tree but that these are not yet in Linus' tree. The 
SRP iWARP patches should be merged in Linus' tree during the current 
merge window. If you would like to test these patches before Linus 
merges the RDMA pull request, please have a look at 
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next&ofs=1000

Thanks,

Bart.


