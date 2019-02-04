Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092CC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB552083B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 22:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="KMpDbuDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfBDWoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:44:23 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:50730 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBDWoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 17:44:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 520A2AAC03;
        Mon,  4 Feb 2019 23:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549320261; i=@fjfi.cvut.cz;
        bh=XMJ6BiXNSnDlZAGeoVO4B3QPvI+zIZtIb54q/F4HDjg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=KMpDbuDgB2vaN2HB60ksTcsLlIwj721kF4kDmPsu3yrwuUI/T3+TEF6o/3JjJoooz
         IBWp/8mAqN0iWKmBgaofi41WKU3duOmeUww3YZj8j/pC4JKn5Cj7BnwNYu1HMYqNFU
         vwYdCL8yDZlM1amn6MYKZus4O+FIhsma7a3zTvB0=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id FiRM-O8CFEgJ; Mon,  4 Feb 2019 23:44:18 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 92FD3AA8BC;
        Mon,  4 Feb 2019 23:44:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 92FD3AA8BC
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id E13926004E; Mon,  4 Feb 2019 23:44:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id D6AE26004D;
        Mon,  4 Feb 2019 23:44:16 +0100 (CET)
Date:   Mon, 4 Feb 2019 23:44:16 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
In-Reply-To: <20190204150132.GM31132@infradead.org>
Message-ID: <alpine.LRH.2.21.1902042336331.10661@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz> <20190204150132.GM31132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

>> +	/* first do a discovery0 */
>> +	error = opal_discovery0_step(dev);
>>
>> +	for (state = 0; !error && state < n_steps; state++)
>> +		error = execute_step(dev, &steps[state], state);
>> +
>> +	/*
>> +	 * For each OPAL command the first step in steps starts some sort of
>> +	 * session. If an error occurred in the initial discovery0 or if an
>> +	 * error occurred in the first step (and thus stopping the loop with
>> +	 * state == 1) then there was an error before or during the attempt to
>> +	 * start a session. Therefore we shouldn't attempt to terminate a
>> +	 * session, as one has not yet been created.
>> +	 */
>> +	if (error && state > 1)
>> +		end_opal_session_error(dev);
>>
>>  	return error;
>
> The flow here is a little too condensed for my taste.  Why not the
> plain obvoious, if a little longer:
>
> 	error = error = opal_discovery0_step(dev);
> 	if (error)
> 		return error;
>
> 	for (state = 0; state < n_steps; state++) {
> 		error = execute_step(dev, &steps[state], state);
> 		if (error)
> 			goto out_error;
> 	}
>
> 	return 0;
>
> out_error:
> 	if (state > 1)
> 		end_opal_session_error(dev);
> 	return error;

No problem, I can use this version. But I think there is a minor issue - 
the same one I hit in my original change, just from the other direction:

If the loop succeds for the 0-th element of steps, and then fails for the 
1st element, then state equals 1 yet the session has been started, so we 
should close it.

I think the condition in out_error should be if (state > 0).

Best regards,
David
