Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0062C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4620651
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfAQCbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:31:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfAQCby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 21:31:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so3948843plm.12
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 18:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O0uFvd2+f81KaU+7Y9if+mq4dlepuILnVwQ8ZWBfjR8=;
        b=B53IdARyEwvjuBtmJ97alsn7IyTZD3CbOS+eHJvync/Tj7RI8gPhCJFNCbjnoVHGA/
         JMzrbbsCcWKUnXbddcryN0apfwzHyTzjEUk8Hoo1f8R1IfqqkaS3sipNNvdxJxzbR+N+
         z2qIqWOD234yC9mH2NM5fvATD+2jvd+NyDD48fEnNLiTl/5o1SON6wCxLe5AA/9CSpMg
         QgwU/fIzNWlEWcciEPmOXGXqe1B63gq5DYmf/3tKLrliY0RcPFU1u0fd1/rteEulOFpK
         KfJKkqhGWEmw5ncTr1+Hwi3LCrDET+Lqsl0pXNFcz6y7aBgxC1KPnOpZz5dk2D/rBsKJ
         IAFQ==
X-Gm-Message-State: AJcUukctsSxgK+Wub2tz4UyVo4egUY8auoh7QeTDh2EQWy5aNskhL6sK
        CLF3LyvP5ZK6nAr2KpweoZY=
X-Google-Smtp-Source: ALg8bN5kg1mvkIBU9nbIJDCT1v3erp7uMJQRc/VMrDVTpp1l1BV913n3OS5EQJkEh8ha1aMoNjmFzw==
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr13014197pll.320.1547692313485;
        Wed, 16 Jan 2019 18:31:53 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id z62sm206685pfl.33.2019.01.16.18.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 18:31:52 -0800 (PST)
Subject: Re: [PATCH 1/3] blktests: add cgroup2 infrastructure
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
References: <20181204174733.7423-1-josef@toxicpanda.com>
 <20181204174733.7423-2-josef@toxicpanda.com>
 <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
 <1547570441.83374.112.camel@acm.org> <20190117014039.GA25494@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <781ed848-e7a1-47c7-12d1-4260f1e8924b@acm.org>
Date:   Wed, 16 Jan 2019 18:31:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190117014039.GA25494@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 5:40 PM, Omar Sandoval wrote:
> On Tue, Jan 15, 2019 at 08:40:41AM -0800, Bart Van Assche wrote:
>> On Tue, 2019-01-01 at 19:13 -0800, Bart Van Assche wrote:
>>> On 12/4/18 9:47 AM, Josef Bacik wrote:
>>>> In order to test io.latency and other cgroup related things we need some
>>>> supporting helpers to setup and tear down cgroup2.  This adds support
>>>> for checking that we can even configure cgroup2 things, set them up if
>>>> need be, and then add the cleanup stuff to the main cleanup function so
>>>> everything is always in a clean state.
>>>
>>> Is this the patch that went in as commit ae7daae7e35a ("blktests: add
>>> cgroup2 infrastructure")? I think that commit introduced a regression.
>>> With that patch applied the SRP tests fail as follows:
>>>
>>> # ./check -q srp/001
>>> srp/001 (Create and remove LUNs)
>>>       runtime  4.067s  ...
>>> common/cgroup: line 25: CGROUP2_DIR: unbound variable
>>>
>>> Is this a known issue?
>>
>> Hi Josef,
>>
>> Had you noticed this e-mail?
>>
>> Thanks,
>>
>> Bart.
> 
> Hey, Bart, I just pushed a fix for this:
> 
> commit 8a274578e2895b9f0b66c09f3a8f63b5ff1293b2
> Author: Omar Sandoval <osandov@fb.com>
> Date:   Wed Jan 16 17:34:19 2019 -0800
> 
>      cgroup: test if CGROUP2_DIR is set with -v instead of -n
>      
>      common/multipath-over-rdma does set -u, so -n "$CGROUP2_DIR" fails with
>      an unbound variable error. Instead, use -v to test if the variable was
>      set.
>      
>      Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> diff --git a/common/cgroup b/common/cgroup
> index 48e546f..554ebf7 100644
> --- a/common/cgroup
> +++ b/common/cgroup
> @@ -22,7 +22,7 @@ _init_cgroup2()
>   
>   _exit_cgroup2()
>   {
> -	if [[ -n $CGROUP2_DIR ]]; then
> +	if [[ -v CGROUP2_DIR ]]; then
>   		find "$CGROUP2_DIR" -type d -delete
>   		unset CGROUP2_DIR
>   	fi

That change looks good to me. Thanks!

Bart.


