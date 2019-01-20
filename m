Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54240C282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74A20823
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="w35K7R+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfAUII7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:08:59 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:55060 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfAUII6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:08:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C77DEA2A6B;
        Sun, 20 Jan 2019 21:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548015805; i=@fjfi.cvut.cz;
        bh=6sYmLwZ2FUMh4z5Tv34oBSifBfR1aAUqgGQRwnrGn08=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=w35K7R+Qm3N2wS7ssE0AEs5ve/ijVcrufpQheskfx6jCOm297pmBdRvMiHyq1wY0x
         teGbiTHFjvhXZFRdLPy5FK0iCAPn2hZ5CuBmxY9i6kNpVHY0pHj308Zhg+SNFkexrl
         Olm/03tTjGOQ5fnmsK+iqBKdgyUvSC/ilKOnHsaM=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id bDkgLG8Bx-fz; Sun, 20 Jan 2019 21:23:21 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 62617A2A5F;
        Sun, 20 Jan 2019 21:23:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 62617A2A5F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 266066004E; Sun, 20 Jan 2019 21:23:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 1AEF46002A;
        Sun, 20 Jan 2019 21:23:21 +0100 (CET)
Date:   Sun, 20 Jan 2019 21:23:21 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, jonathan.derrick@intel.com
Subject: Re: [PATCH v2 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
In-Reply-To: <20190119174633.GA15276@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1901201128260.4278@linux.fjfi.cvut.cz>
References: <1547760716-7304-16-git-send-email-zub@linux.fjfi.cvut.cz> <20190119174633.GA15276@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 19 Jan 2019, Scott Bauer wrote:

> On Thu, Jan 17, 2019 at 09:31:55PM +0000, David Kozub wrote:
>
>> -	for (state = 0; !error && state < n_steps; state++) {
>> -		step = &steps[state];
>> -
>> -		error = step->fn(dev, step->data);
>> -		if (error) {
>> -			pr_debug("Step %zu (%pS) failed with error %d: %s\n",
>> -				 state, step->fn, error,
>> -				 opal_error_to_human(error));
>> -
>> -			/* For each OPAL command we do a discovery0 then we
>> -			 * start some sort of session.
>> -			 * If we haven't passed state 1 then there was an error
>> -			 * on discovery0 or during the attempt to start a
>> -			 * session. Therefore we shouldn't attempt to terminate
>> -			 * a session, as one has not yet been created.
>> -			 */
>> -			if (state > 1) {
>> -				end_opal_session_error(dev);
>> -				return error;
>> -			}
>
>
>
>
>> +	/* first do a discovery0 */
>> +	error = opal_discovery0_step(dev);
>>
>> -		}
>> -	}
>> +	for (state = 0; !error && state < n_steps; state++)
>> +		error = execute_step(dev, &steps[state], state);
>> +
>> +	/* For each OPAL command the first step in steps starts some sort
>> +	 * of session. If an error occurred in the initial discovery0 or if
>> +	 * an error stopped the loop in state 0 then there was an error
>> +	 * before or during the attempt to start a session. Therefore we
>> +	 * shouldn't attempt to terminate a session, as one has not yet
>> +	 * been created.
>> +	 */
>> +	if (error && state > 0)
>> +		end_opal_session_error(dev);
>
>
> This is subtly wrong. There was some state that was encoded by having the
> loop the way we did.
>
> the tl;dr is the check needs to be if (error && state > 1) still.
>
> The why is that in the previous implementation we wanted to end_opal_session_error
> only if a successful discovery0 AND a successful start_*_session. In the previous loop,
> discovery0 would complete, we'd do state++, then we'd go and attempt to start our
> session. If we failed on that session starting we'd still be in state 1, and wouldn't
> attempt to close the session.
>
> In the current form, discovery0 is gone, so start session is on state 0. If we fail
> on the start session, we set error = true, state gets ++'d, then we look at !error
> and we don't loop again.
>
> We go down to the check and attempt to end a session that was never started.

Ouch! You're right. I'll fix this for v3 by comparing against 1.

There is one more issue that was bugging me. If next() fails at the 
discovery0 step, or at steps[0], in both cases the error message will say 
step 0 failed. But as it's just a pr_debug message, the function address 
is included and I don't see a short and nice solution (should I report the 
steps as starting from 1? but that might be confusing; or a different 
string? sounds like not worth it), I kept it that way.

But if someone thinks this is worth improving, please let me know.
