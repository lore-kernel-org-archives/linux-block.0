Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC84C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB320855
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="JEJf9iuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfBJRqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:46:53 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:42732 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJRqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 12:46:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id DBB66A0FE8;
        Sun, 10 Feb 2019 18:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549820810; i=@fjfi.cvut.cz;
        bh=0nviwiTjbKqCgLvjB3i/IvE9KpLn1tfKfIa0mw0Dfgo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=JEJf9iuqlurIiqbyrB+Bl6bDCKFJFLN1Z5kcFJO41S1C1lXOeAKqKycUM1exSEGYO
         sZv2MkGr1+TzRnpabHDdQxhrUlyQFqyGfSMhVatMlDwZLy6dxwSQg0d4qANkgejSiJ
         rMDAyzNbUs7VLP/8CooSoRjVGtFqnBJbfmHHlmO0=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id sDMAb4WvOfG2; Sun, 10 Feb 2019 18:46:43 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id BD025A14F1;
        Sun, 10 Feb 2019 18:46:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz BD025A14F1
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 8CF526004E; Sun, 10 Feb 2019 18:46:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 79E886004D;
        Sun, 10 Feb 2019 18:46:18 +0100 (CET)
Date:   Sun, 10 Feb 2019 18:46:18 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
In-Reply-To: <1549666749.10972.62.camel@intel.com>
Message-ID: <alpine.LRH.2.21.1902101840020.28071@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>  <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz>  <20190204150132.GM31132@infradead.org>  <alpine.LRH.2.21.1902042336331.10661@linux.fjfi.cvut.cz>
 <1549666749.10972.62.camel@intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 8 Feb 2019, Derrick, Jonathan wrote:

> On Mon, 2019-02-04 at 23:44 +0100, David Kozub wrote:
>> On Mon, 4 Feb 2019, Christoph Hellwig wrote:
>>
>>>> +	/* first do a discovery0 */
>>>> +	error = opal_discovery0_step(dev);
>>>>
>>>> +	for (state = 0; !error && state < n_steps; state++)
>>>> +		error = execute_step(dev, &steps[state], state);
>>>> +
>>>> +	/*
>>>> +	 * For each OPAL command the first step in steps starts some sort of
>>>> +	 * session. If an error occurred in the initial discovery0 or if an
>>>> +	 * error occurred in the first step (and thus stopping the loop with
>>>> +	 * state == 1) then there was an error before or during the attempt to
>>>> +	 * start a session. Therefore we shouldn't attempt to terminate a
>>>> +	 * session, as one has not yet been created.
>>>> +	 */
>>>> +	if (error && state > 1)
>>>> +		end_opal_session_error(dev);
>>>>
>>>>  	return error;
>>>
>>> The flow here is a little too condensed for my taste.  Why not the
>>> plain obvoious, if a little longer:
>>>
>>> 	error = error = opal_discovery0_step(dev);
>>> 	if (error)
>>> 		return error;
>>>
>>> 	for (state = 0; state < n_steps; state++) {
>>> 		error = execute_step(dev, &steps[state], state);
>>> 		if (error)
>>> 			goto out_error;
>>> 	}
>>>
>>> 	return 0;
>>>
>>> out_error:
>>> 	if (state > 1)
>>> 		end_opal_session_error(dev);
>>> 	return error;
>>
>> No problem, I can use this version. But I think there is a minor issue -
>> the same one I hit in my original change, just from the other direction:
>>
>> If the loop succeds for the 0-th element of steps, and then fails for the
>> 1st element, then state equals 1 yet the session has been started, so we
>> should close it.
>>
>> I think the condition in out_error should be if (state > 0).
>>
>> Best regards,
>> David
> Looks good with Christoph's suggestion (for 14/16) and your state check fix
>
>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

Hi Jon,

What suggestion by Christoph you have in mind? I don't see any for 14/16. 
Currently, in my git repo, for this patch, I applied Christoph suggestion 
for this (15/16) patch + the "state > 0" fix. Is this what you mean?

Best regards,
David
