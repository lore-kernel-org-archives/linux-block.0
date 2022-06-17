Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B97C43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 00:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiFQAFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQAFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 20:05:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9562CC0
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655424314; x=1686960314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CX8AQn/wCnFFCp/kMmaN9sSTqk+AgMO0u3RXrxXuCnE=;
  b=l73m3PWPYNyq5rELN3YLjYeniEPv26B2U7hpWIy+sBei1kRKUKNXkogf
   xXyPVnHrCauMP2iYIF9/7A2UCqdcgC5w9wk3/5TN+HxJVkYo8WEHLV5AK
   qY4ZuSFmXrzqXGIzgGdwKRXZe9sZqYsg8Aypzc3RsWqk+rZCQEOWUMtXs
   OuLGMTnJFOo/Y2pbB/U4hVjeK/l+eVJW1KavUXjd1k8f5E1Wp4TzhOheY
   oVykDCZJ9waR7eaqc8wuRe4xiL/QRR5e7snZyEls+T+VTiKrjiWg9XMqc
   XH1Z2LuPG0GKuL5pUQQvTiA5U+viwO07Nf1VWCi6bD4ZcvZlZSAVjaMgx
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307682562"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 08:05:14 +0800
IronPort-SDR: TUeH/POsE5NS3Yz6LjTfa1PBQhEcDxCnkm8Oh9FAVMD9b7lHKeXXnTSYdfz6HQ/8z0/doQ8PNn
 SEDXTMWXyWOSCAJEPbjCQnlinh/lMqETxmguEzcWW9nxvVcgUn7DUxQrLhfnPUiF+inTjr8dar
 Il+p0TNjwk/Vt08s1YWTbpWtQFv1/ORQBnAVtyRBXKeWk3s+26yMfGoePgFv8WM6+dYpwV7Tc2
 EhCQ65pu9eI7bKW9zgmZZu+9D89ofhAGiVl3CMjdOJlocRgFBRqZthNLCmuPrscbVX3OiFhomK
 w+k1xEe1sIIoNmFksyVvtNyZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:27:50 -0700
IronPort-SDR: 95vQQdsWxQa0Nnl2Z4Q8S+SvsAvlP438KwfA9Op0clsc/Sb4Tailq8Kw4HTiHvJ26iolS8GRjj
 vhC9Larct7jFSgNvYUhvgTFeRH6QLDG7lLjRkY//9TW+cQj3iszBe+pqbff50ZYhqqmGyE/wQw
 x8HbmVx5ZHZq8nJA3etQ0uu14ePUWN1+69jGT3XgWydHIHcxqlWo+IUUMDc9N2aOPICMMYwpk6
 o/hkTpAAPbiChMzaMkYQuYOw8Lo1kHvNfTjrgewXC2WxTWrm9BNLHBWn8WY4t04kD4ltZQ5Pji
 024=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 17:05:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPK6y1j5yz1Rwrw
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 17:05:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655424313; x=1658016314; bh=CX8AQn/wCnFFCp/kMmaN9sSTqk+AgMO0u3R
        XrxXuCnE=; b=M7bEfLhjnXzfaG45XvdcQIogjmg7j3Epk/VoZY4kXOz6VuCDQkK
        GYv6VcKuMMfKSA+QzknL84DOPy/T/C+042wPyywVey6FGnYlXWCX58gsfF1/3J0R
        0aqMWIL1Y4XpPWfPuCqLl6pCuBimajtemn3a4OVjuFMsRKJj8m6m2f1DsMS7hK9o
        Gb/GUWonBZvssi+/PDy25YZsCTZYpJ5O8f7buY8PsvXYTdaCfaOnie4ttLCOqq/C
        xNaw/e78N6c/kkS7xt6T/WYBJDkkLyJZ+y8OVx7ekBeH0ZNZ3dmMTfTZ9wzOnnRN
        gkY6mRN5Vta9l9gGQj7oLQQAiTh7KAi/HIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NITMo3MSzsbq for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 17:05:13 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPK6x0Q0Rz1Rvlc;
        Thu, 16 Jun 2022 17:05:12 -0700 (PDT)
Message-ID: <ae8fbc74-64b7-2d2e-ba46-cc72851e30b5@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 09:05:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616112303.wywyhkvyr74ipdls@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 20:23, Jan Kara wrote:
> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
>> On 6/16/22 01:16, Jan Kara wrote:
>>> Currently, IO priority set in task's IO context is not reflected in the
>>> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
>>> results in odd results where process is submitting some bios with one
>>> priority and other bios with a different (unset) priority and due to
>>> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
>>> always set on bio submission.
>>>
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>   block/blk-mq.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index e17d822e6051..e976f696babc 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>>>   static void bio_set_ioprio(struct bio *bio)
>>>   {
>>> +	unsigned short ioprio_class;
>>> +
>>>   	blkcg_set_ioprio(bio);
>>
>> Shouldn't this function set the default using the below "if" code ?
>>
>>> +	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
>>> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
>>
>> I do not think that the ioprio_class variable is useful.
>> This can be:
>>
>> 	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
>> 		bio->bi_ioprio = get_current_ioprio();
> 
> You are right. Fixed.

What about moving this inside blkcg_set_ioprio() ? bio_set_ioprio() would
then not be needed at all and blkcg_set_ioprio() called directly ?

> 
>>> +	if (ioprio_class == IOPRIO_CLASS_NONE)
>>> +		bio->bi_ioprio = get_current_ioprio();
>>>   }
>>>   /**
>>
>> Beside this comment, I am still scratching my head regarding what the user
>> gets with ioprio_get(). If I understood your patches correctly, the user may
>> still see IOPRIO_CLASS_NONE ?
>> For that case, to be in sync with the man page, I thought the returned
>> ioprio should be the effective one based on the task io nice value, that is,
>> the value returned by get_current_ioprio(). Am I missing something... ?
> 
> The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
> or IOPRIO_WHO_USER the effective IO priority may be different for different
> processes considered and it can be also further influenced by blk-ioprio
> settings. But thinking about it now after things have settled I agree that
> what you suggests makes more sense. I'll fix that. Thanks for suggestion!
> 
> 								Honza


-- 
Damien Le Moal
Western Digital Research
