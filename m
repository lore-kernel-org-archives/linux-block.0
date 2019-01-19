Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EAC61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2768B2084F
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfASRqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:46:42 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:38068 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfASRqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 12:46:42 -0500
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuhc-00069C-6e; Sat, 19 Jan 2019 10:46:40 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuhb-0005HM-Md; Sat, 19 Jan 2019 10:46:40 -0700
Received: from hacktheplanet (unknown [73.58.156.101])
        by plesk14.xmission.com (Postfix) with ESMTPSA id D2D072119B7;
        Sat, 19 Jan 2019 17:46:38 +0000 (UTC)
Date:   Sat, 19 Jan 2019 12:46:33 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, jonathan.derrick@intel.com
Message-ID: <20190119174633.GA15276@hacktheplanet>
References: <1547760716-7304-16-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547760716-7304-16-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gkuhb-0005HM-Md;;;mid=<20190119174633.GA15276@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 09:31:55PM +0000, David Kozub wrote:

> -	for (state = 0; !error && state < n_steps; state++) {
> -		step = &steps[state];
> -
> -		error = step->fn(dev, step->data);
> -		if (error) {
> -			pr_debug("Step %zu (%pS) failed with error %d: %s\n",
> -				 state, step->fn, error,
> -				 opal_error_to_human(error));
> -
> -			/* For each OPAL command we do a discovery0 then we
> -			 * start some sort of session.
> -			 * If we haven't passed state 1 then there was an error
> -			 * on discovery0 or during the attempt to start a
> -			 * session. Therefore we shouldn't attempt to terminate
> -			 * a session, as one has not yet been created.
> -			 */
> -			if (state > 1) {
> -				end_opal_session_error(dev);
> -				return error;
> -			}




> +	/* first do a discovery0 */
> +	error = opal_discovery0_step(dev);
>  
> -		}
> -	}
> +	for (state = 0; !error && state < n_steps; state++)
> +		error = execute_step(dev, &steps[state], state);
> +
> +	/* For each OPAL command the first step in steps starts some sort
> +	 * of session. If an error occurred in the initial discovery0 or if
> +	 * an error stopped the loop in state 0 then there was an error
> +	 * before or during the attempt to start a session. Therefore we
> +	 * shouldn't attempt to terminate a session, as one has not yet
> +	 * been created.
> +	 */
> +	if (error && state > 0)
> +		end_opal_session_error(dev);


This is subtly wrong. There was some state that was encoded by having the
loop the way we did.

the tl;dr is the check needs to be if (error && state > 1) still.

The why is that in the previous implementation we wanted to end_opal_session_error
only if a successful discovery0 AND a successful start_*_session. In the previous loop,
discovery0 would complete, we'd do state++, then we'd go and attempt to start our
session. If we failed on that session starting we'd still be in state 1, and wouldn't
attempt to close the session.

In the current form, discovery0 is gone, so start session is on state 0. If we fail
on the start session, we set error = true, state gets ++'d, then we look at !error
and we don't loop again.

We go down to the check and attempt to end a session that was never started.




> -- 
> 2.20.1
> 
> 
