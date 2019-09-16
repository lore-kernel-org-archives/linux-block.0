Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B427DC49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92707216C8
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 13:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfIPNkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:40:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732992AbfIPNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 09:40:01 -0400
Received: from [IPv6:2804:431:c7f4:d32a:d711:794d:1c68:5ed3] (unknown [IPv6:2804:431:c7f4:d32a:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1688828D3B4;
        Mon, 16 Sep 2019 14:39:57 +0100 (BST)
Subject: Re: [PATCH v2 4/4] coding-style: add explanation about pr_fmt macro
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        kernel@collabora.com, krisman@collabora.com
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-5-andrealmeid@collabora.com>
 <20190914015018.4fa90f28@lwn.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <e8e82c8b-7a2f-e238-a687-8505195ecb39@collabora.com>
Date:   Mon, 16 Sep 2019 10:38:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190914015018.4fa90f28@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/19 4:50 AM, Jonathan Corbet wrote:
> On Fri, 13 Sep 2019 19:03:00 -0300
> André Almeida <andrealmeid@collabora.com> wrote:
> 
>> The pr_fmt macro is useful to format log messages printed by pr_XXXX()
>> functions. Add text to explain the purpose of it, how to use and an
>> example.
> 
> So I've finally had a chance to take a real look at this...
> 
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index f4a2198187f9..1a33a933fbd3 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -819,7 +819,15 @@ which you should use to make sure messages are matched to the right device
>>  and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>>  dev_info(), and so forth.  For messages that aren't associated with a
>>  particular device, <linux/printk.h> defines pr_notice(), pr_info(),
>> -pr_warn(), pr_err(), etc.
>> +pr_warn(), pr_err(), etc. It's possible to format pr_XXX() messages using the
>> +macro pr_fmt() to prevent rewriting the style of messages. It should be
>> +defined before ``#include <linux/kernel.h>``, to avoid compiler warning about
>> +redefinitions, or just use ``#undef pr_fmt``. This is particularly useful for
>> +adding the name of the module at the beginning of the message, for instance:
>> +
>> +.. code-block:: c
>> +
>> +        #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> Honestly, I think that this is out of scope for a document on coding
> style.  That document is already far too long for most people to read, I
> don't think we should load it down with more stuff that isn't directly
> style related.
> 
> That said, the information can be useful.  I wanted to say that it should
> go with the documentation of the pr_* macros but ... well ... um ... we
> don't seem to have a whole lot of that.  Figures.
> 
> I suspect this is more than you wanted to sign up for, but...IMO, the right
> thing to do is to fill printk.h with a nice set of kerneldoc comments
> describing how this stuff should be used, then to pull that information
> into the core-api manual, somewhere near our extensive discussion of printk
> formats.  It's amazing that we lack docs for something so basic.
> 

Thanks for the feedback jon. For now, I'll drop this patch for this
series. In a future patch I'll move this text for
Documentation/core-api/printk-formats.rst and will also add kernel-doc
comments to pr_XXXX() functions.

> Thanks,
> 
> jon
> 

