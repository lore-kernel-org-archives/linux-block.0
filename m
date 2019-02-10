Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACCC282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5082213F2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="bB4C9sw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfBJU0C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:26:02 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47306 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJU0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 15:26:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C80E4A23A0;
        Sun, 10 Feb 2019 21:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549830359; i=@fjfi.cvut.cz;
        bh=8+vPETOh21HZkj7Q1AJIt7PeOhTv3OGHRvFPTDOcldE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=bB4C9sw+QsR57QG8EiKjszaVkiRn5PTkmNPI6Fw6JLVgyqzSII4dmgME/3Jzc8Kgg
         ETPjdsbdY3c5UnUVlGlLu/xOm28eOYM65qt8zm2cAQS2YNA1nN7JGUejToonIP+f87
         RHI4wqUk3NZznm628jmdt1UoSz7tX/fzx9m023pU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id wKqFhbHanzBN; Sun, 10 Feb 2019 21:25:57 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 619C4A040D;
        Sun, 10 Feb 2019 21:25:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 619C4A040D
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 329AC6004E; Sun, 10 Feb 2019 21:25:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 21C736004D;
        Sun, 10 Feb 2019 21:25:55 +0100 (CET)
Date:   Sun, 10 Feb 2019 21:25:55 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
In-Reply-To: <20190210182655.GA20491@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1902102117220.8545@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz> <20190204145244.GJ31132@infradead.org> <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz> <1549586652.11868.12.camel@intel.com>
 <20190210182655.GA20491@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 10 Feb 2019, Scott Bauer wrote:

> On Fri, Feb 08, 2019 at 12:44:14AM +0000, Derrick, Jonathan wrote:
>> On Thu, 2019-02-07 at 23:56 +0100, David Kozub wrote:
>>> On Mon, 4 Feb 2019, Christoph Hellwig wrote:
>>>>>  static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>>>>>  					  struct opal_mbr_data *opal_mbr)
>>>>>  {
>>>>> +	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
>>>>> +		? OPAL_TRUE : OPAL_FALSE;
>>>>>  	const struct opal_step mbr_steps[] = {
>>>>>  		{ opal_discovery0, },
>>>>>  		{ start_admin1LSP_opal_session, &opal_mbr->key },
>>>>> -		{ set_mbr_done, &opal_mbr->enable_disable },
>>>>> +		{ set_mbr_done, &token },
>
>>> Am I missing something here? This seems wrong to me. And I think this
>>> patch actually changes it by introducing:
>>>
>>> +    u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
>>> +            ? OPAL_TRUE : OPAL_FALSE;
>>>
>>> which is essentially a negation (map 0 to 1 and 1 to 0).
>
> Agreed the original code did the opposite of what the user wanted, looks like
> when I authored it I messed up that enum which set everything off.
>
>
>
>>> With regard to the new IOC_OPAL_MBR_STATUS: I find the usage of
>>> OPAL_MBR_ENABLE/DISABLE for this confusing: what should passing
>>> OPAL_MBR_ENABLE do? Should it enable the shadow MBR? Or should it
>>> enable the MBR-done flag? I think the implementation in this patch
>>> interprets OPAL_MBR_ENABLE as 'set the "done" flag to true', thus hiding
>>> the shadow MBR. But this is not obvious looking at the IOCTL name.
>
> For the new ioctl I think we should just add a new enum with the correct
> nomenclature.  So OPAL_MBR_DONE, OPAL_MBR_NOT_DONE.
>
>
>> In order to keep the userspace interface consistent, I'll ACK your
>> change in this patch, unless Scott can fill me in on why this looks
>> wrong but is actually right.
>
> I think it is just wrong.
>
>
>>
>> We have 7 bytes in the opal_mbr_data struct we could use for DONE/NOT
>> DONE. I'm not sure how to go about keeping it consistent with old uapi,
>> although arguably opal_enable_disable_shadow_mbr is already doing the
>> wrong thing with DONE and ENABLE so it's low impact.
>
> Can we keep the old mbr struct the same and just add a new struct with new enums
> for the new done ioctl? I think this will keep the new ioctl cleaner instead
> of trying to apply older, some what incorrectly named, enums.

I like this proposal, I'll try to implement it. Although currently I plan 
to first re-submit the cleanup parts, as suggested by Christoph[1]. So 
this will happen after that.

> Lastly someone will need to backport his
>
>>>>> +       u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
>>>>> +               ? OPAL_TRUE : OPAL_FALSE;
>
> to stable so we can fix up my broken coding in older kernels.
>
>
> I can do that or, if David wants to do that that's fine... just want to coordinate.

I'm quite busy juggling patches in this series. If you can find the time, 
please do it.

Best regards,
David

[1] https://lore.kernel.org/lkml/20190204150415.GO31132@infradead.org/

