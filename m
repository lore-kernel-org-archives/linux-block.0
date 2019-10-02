Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44AC4360C
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77DA21848
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 20:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJBU1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:27:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47025 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBU1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 16:27:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so202486pgm.13;
        Wed, 02 Oct 2019 13:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thPrT7yVrWLzrR73UMdFtFROCIaln63nE+Eo5yiQpnk=;
        b=XQ0qA9axYqr+cZUB07M7WSNATJN1SmrpFTyGzSN8jzB4GD+w2R3XTi3ew8RDCABb+0
         FXL2G7faqHi2MX2SAdi345qGoyUX8kIqcUKXxq9BBa2urZJuuGJ9Mwl7BraQZLFqgaHE
         dXnD4LTodzyH/39+foGZhDkAUiF6oIMS8ply+TumrpQwSHk0nf27fUX+KvX1deDjd+zJ
         J+nw6RdciZ7fO/s7n1siLTCC/D1dI5mtfNn5EL0bKw2denz44j+EIlm3pBr1Re3KPsaa
         agJ0ndGWuymMRTR1CiQXz5VwfLewK6rS8+oEofqeyjdepuJQy0Lz7RRF/gaXo+nFQeXE
         rjTA==
X-Gm-Message-State: APjAAAVt9VfKI9BSifou+qw4N27Vnto1MULaETEurgi6qLLk5MeZOsQP
        zuWotlCGUnPAMZ/S7+lHUExhZqA5
X-Google-Smtp-Source: APXvYqzo5rzZtC8vCCUsIHde3nji9og5JSYKZOamBYgBRL1NIjharGVaxXNnIix5U7bGlW7CLZ04AQ==
X-Received: by 2002:a63:e853:: with SMTP id a19mr5488996pgk.296.1570048038505;
        Wed, 02 Oct 2019 13:27:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l62sm311480pfl.167.2019.10.02.13.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 13:27:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20190930194846.23141-1-andrealmeid@collabora.com>
 <f1ca9de7-383b-4a84-31d0-92cfbb3759b2@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f46014fd-b29d-aee5-d49d-d2c5f2ddfb9f@acm.org>
Date:   Wed, 2 Oct 2019 13:27:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f1ca9de7-383b-4a84-31d0-92cfbb3759b2@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 8:33 PM, Jens Axboe wrote:
> On 9/30/19 1:48 PM, André Almeida wrote:
>> -
>> +/**
>> + * struct blk_mq_ops - list of callback functions for blk-mq drivers
>> + */
>>    struct blk_mq_ops {
>> -	/*
>> -	 * Queue request
>> +	/**
>> +	 * @queue_rq: Queue a new request from block IO.
>>    	 */
>>    	queue_rq_fn		*queue_rq;
>>    
>> -	/*
>> -	 * If a driver uses bd->last to judge when to submit requests to
>> -	 * hardware, it must define this function. In case of errors that
>> -	 * make us stop issuing further requests, this hook serves the
>> +	/**
>> +	 * @commit_rqs: If a driver uses bd->last to judge when to submit
>> +	 * requests to hardware, it must define this function. In case of errors
>> +	 * that make us stop issuing further requests, this hook serves the
>>    	 * purpose of kicking the hardware (which the last request otherwise
>>    	 * would have done).
>>    	 */
>>    	commit_rqs_fn		*commit_rqs;
> 
> Stuff like this is MUCH better. Why isn't all of it done like this?

Hi Jens,

If you prefer this style you may want to update
Documentation/doc-guide/kernel-doc.rst. I think that document recommends 
another style for documenting struct members, maybe because that style 
requires less vertical space:

------------------------------------------------------------------------
Structure, union, and enumeration documentation
-----------------------------------------------

The general format of a struct, union, and enum kernel-doc comment is::

   /**
    * struct struct_name - Brief description.
    * @member1: Description of member1.
    * @member2: Description of member2.
    *           One can provide multiple line descriptions
    *           for members.
    *
    * Description of the structure.
    */

You can replace the ``struct`` in the above example with ``union`` or
``enum``  to describe unions or enums. ``member`` is used to mean struct
and union member names as well as enumerations in an enum.

The brief description following the structure name may span multiple
lines, and ends with a member description, a blank comment line, or the
end of the comment block.
------------------------------------------------------------------------

Thanks,

Bart.
