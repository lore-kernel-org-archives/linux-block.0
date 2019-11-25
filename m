Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C3C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 21:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020752071A
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 21:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYVl0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:41:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39480 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVl0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 16:41:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so8029901pfo.6
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2019 13:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOv3h/jPA3Vr7PGn6c/L03ypALRD0X4bYBurs6pqNuM=;
        b=nTc/gZEJJ4OC7a+jK5PKpG8oTvFqZwKHTkdmXPCS0O9LDarpBUpBT5ULjAOxpnVw6n
         03DdXgfJx575k2CoCwb6K9v1TtpUifAYR7JLTxVVQDrKpdtXN1lQRQ7kPxImBZNwkikQ
         TbfQFJ3GRkFls1JgcqZunaVKKbvnjkxuzxmvQi/dedTeVOW2j0gtzjZtjnXnqGXGlIox
         1GXSWHT/5k+yaMjUoVsvd1hnkUV03KyAQHsOqNV1JS1NuXrDALeseJhruVcB8/Yl7dvK
         q8ttxLf0+WuCGsSNItS2WuCTaezgMU/G4xNz/lJpSKWdL8JCDqSzxAu2/yB7TQ+NdrU1
         BfmQ==
X-Gm-Message-State: APjAAAUz+hH7QZh6w42jU9qUJy4xVdzuitaImy4AiFa2d4xa91/2Jq2k
        M+B02Ymd0Tzh9CraHar4ce8ffurP
X-Google-Smtp-Source: APXvYqwxDI/YRGC85ymATiCZRSQEni3MLeIH8o1wgG7N2+ZXXf/tSokSbnRBSiuUrXsyTae9XULmcw==
X-Received: by 2002:a62:e716:: with SMTP id s22mr37012108pfh.258.1574718084940;
        Mon, 25 Nov 2019 13:41:24 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o125sm9448056pfg.118.2019.11.25.13.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:41:24 -0800 (PST)
Subject: Re: [PATCH blktests 4/4] tests/srp/015: Add a test that uses the
 SoftiWARP (siw) driver
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
References: <20191115170711.232741-1-bvanassche@acm.org>
 <20191115170711.232741-5-bvanassche@acm.org> <20191125201334.GA639675@vader>
 <4dc03225-e495-6687-161b-e8b82a80f5c1@acm.org>
 <20191125211050.GB639675@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <57e49fb3-bbc7-5230-e7e4-67b873bb9d75@acm.org>
Date:   Mon, 25 Nov 2019 13:41:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125211050.GB639675@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/19 1:10 PM, Omar Sandoval wrote:
> On Mon, Nov 25, 2019 at 12:49:51PM -0800, Bart Van Assche wrote:
>> On 11/25/19 12:13 PM, Omar Sandoval wrote:
>>> On Fri, Nov 15, 2019 at 09:07:11AM -0800, Bart Van Assche wrote:
>>>> Recently support has been added in the SRP initiator and target drivers
>>>> for the SoftiWARP driver. Add a test for SRP over SoftiWARP.
>>>>
>>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>>> ---
>>>>    tests/srp/015     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/srp/015.out |  2 ++
>>>>    2 files changed, 44 insertions(+)
>>>>    create mode 100755 tests/srp/015
>>>>    create mode 100644 tests/srp/015.out
>>>
>>> Hi, Bart,
>>>
>>> I'm getting:
>>>
>>> srp/015 (File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver) [failed]
>>>       runtime  1.076s  ...  1.026s
>>>       --- tests/srp/015.out       2019-11-25 12:07:06.749425714 -0800
>>>       +++ /home/vmuser/repos/blktests/results/nodev/srp/015.out.bad       2019-11-25 12:12:07.634062201 -0800
>>>       @@ -1,2 +1 @@
>>>       -Configured SRP target driver
>>>       -Passed
>>>       +mkdir: cannot create directory ‘0x52540012345600000000000000000000’: Invalid argument
>>>
>>> This is on v5.4-rc8 with CONFIG_RDMA_SIW=m. Do you know what is wrong
>>> here?
>>
>> Hi Omar,
>>
>> I should have mentioned that the SRP iWARP support patches have been
>> accepted in the RDMA tree but that these are not yet in Linus' tree. The SRP
>> iWARP patches should be merged in Linus' tree during the current merge
>> window. If you would like to test these patches before Linus merges the RDMA
>> pull request, please have a look at https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next&ofs=1000
> 
> Okay, I figured I was missing something. Can we detect this in
> requires() so that it doesn't fail on old kernels?

Sure, I will make that change.

Bart.


