Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB870C3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 07:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480921739
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 07:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enarFx7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgCDHOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:14:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36283 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCDHN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 02:13:59 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so1274971iog.3
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYQ/T5LGh6mDEqk2GDSOHdMSMQLCSwCgtcZjqBiXPaA=;
        b=enarFx7guPIjYL4/O9nUVrLD/dD4a2imxHUWiQNYtnRlSR6ot+3O5uKkUt5hYmyOjT
         IR56n4eGbk9JNb3ghZxZXFlkzDCTdtOnPPLZSPf+AQPxg7Hg0lEgsPyAXeO6BqmZyl5a
         Eodq39CkpTf8mZq/7uMH5TkuQ9aW+pMuPmFFmjokjPlU0TNyTd1a9cJreVIKgwkUe7Yx
         bo5YHJ7yoZiuXRTKtCoQ1HHLavCL/xB1UWTTv+R1Dm7twndXKA3VZuTXy/zwAyCgZ29e
         UnOuB7hRNJe5B/EPWAbwDJXmqaMzC8aJksYUx6IhefyYphtZB0D+2p7A7dSPy/WxOOEL
         3LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYQ/T5LGh6mDEqk2GDSOHdMSMQLCSwCgtcZjqBiXPaA=;
        b=FPpVJ7vt++s9I8w3Pzgrm7fQXCm32OQxTPidVhTTteZw/QLgVkLQTAO5nEoQK8pobk
         /aRoSv13k7qUhn/K7ioLI0QNf4Cye/1rBQUyoKn8xTfEKkspwb7iqkE5my8hyYwvC/kY
         fB2aghJn2Jvyf0la2GlvvLrYr+dRyDTwiCP+Su3QdWqopz5AWVLfPcFnK1aTmj/hlnBY
         oLaOGxqPB2W5yXZP3Djq5sRoLHMfmoE1gkvos29B+KBwRZlT97EUXsXABUvpMWIlxjeq
         AOTLuVh3Pl93bRKbFQZbHem+kyUd42soEspOdrEUTwUTJd/bFW1h9xzlPFPxzSVqIqwW
         aJ9Q==
X-Gm-Message-State: ANhLgQ1QWGzrzNXzYM/uBOIFHrcUSU/x0qF0B11v/BQz+EG0RQQ+CYmw
        iYXw+6M2yV8ixVTYhBbLtlvRxuwb+03P+TsCgSI=
X-Google-Smtp-Source: ADFU+vtbk6BExaveIxYZPxub+nRcosNMbOyMiuZ32caPDE9hpdGbBKA6sNZd5YMvC2pCwMEdR2mmqiW/ycFDXPK9Vhk=
X-Received: by 2002:a5d:9e0d:: with SMTP id h13mr1079955ioh.98.1583306038810;
 Tue, 03 Mar 2020 23:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20200228064030.16780-1-houpu@bytedance.com> <20200228064030.16780-3-houpu@bytedance.com>
 <34249aaa-7f0e-d0f4-7c1a-28aee9bddaa0@toxicpanda.com> <5E5ED4FF.8020209@redhat.com>
 <5E5ED861.6020209@redhat.com>
In-Reply-To: <5E5ED861.6020209@redhat.com>
From:   Hou Pu <houpu.main@gmail.com>
Date:   Wed, 4 Mar 2020 15:13:47 +0800
Message-ID: <CAKHcvQgQqqwg3rN_vrk5ZmuAzd1QVfJmh5b0xSu7ovrKJHmhAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nbd: requeue command if the soecket is changed
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 4, 2020 at 6:21 AM Mike Christie <mchristi@redhat.com> wrote:
>
> On 03/03/2020 04:06 PM, Mike Christie wrote:
> > On 03/03/2020 03:13 PM, Josef Bacik wrote:
> >> On 2/28/20 1:40 AM, Hou Pu wrote:
> >>> In commit 2da22da5734 (nbd: fix zero cmd timeout handling v2),
> >>> it is allowed to reset timer when it fires if tag_set.timeout
> >>> is set to zero. If the server is shutdown and a new socket
> >>> is reconfigured, the request should be requeued to be processed by
> >>> new server instead of waiting for response from the old one.
> >>>
> >>> Signed-off-by: Hou Pu <houpu@bytedance.com>
> >>
> >> I'm confused by this, if we get here we've already timed out and
> >> requeued once right?  Why do we need to requeue again?  Thanks,
> >>

Please see Mike's comments below. Thanks.

> >
> > We may not have timed out already. If the tag_set.timeout=0, then the
> > block timer will fire every 30 seconds. This could be the first time the
> > timer has fired. If it has fired multiple times already then it still
> > would not have been requeued because the num_connections=1 code just
> > does a BLK_EH_RESET_TIMER when timeout=0 and does not have support for
> > detecting reconnects.
> >
> > In this second patch if timeout=0 and num_connections=1 we restart the
> > command when the command timer fires and we detect a new connection
> > (nsock->cookie has incremented).
> >
> > I was saying in the last patch, maybe waiting for reconnect is wrong.
> > Does a cmd timeout=0 mean to wait for a reconnect or in this patch
> > should we do:
> >
> > 1. if timeout=0, num_connections=1, and the cmd timer fires and the
> > conneciton is marked dead then requeue the command.
> > 2. we then rely on the dead_conn_timeout code to decide how long to wait
> > for a reconnect.
> >

With the above 2 steps, we have same timeout action in following three case:
A. connections > 1
B. connections ==1 && tag_set.timeout > 0
C. connections ==1 && tag_set.timeout = 0
In all above case, socket is marked dead if needed. Request is requeued.
This also means that if timeout is set to 0 by user space, it will not
have any effect.

This looks good only except that the behavior of case C is not same as before.
(Before we wait until the request is completed. Now wait at most
dead_conn_timeout)
I am not sure if any user space tools relay on it.

I'd like to say that I prefer this way than reseting timer until the
request is completed.
But for now it might be better to keep the behavior same with before.
So I'd like to suggest that we fix reconnection in case B and C with
current patches if you agree.

Thanks.

>
> Oh yeah, I had thought Hou implemented timeout=0 to wait for a reconnect
> to handle existing apps. However, I am not sure if they exist. When we
> had timeout=0 support the first time then we did not have multi conn and
> reconnect support yet.

I was trying to keep the behavior of timeout=0 same as before, with
the difference
of only requeue the cmd if needed. I currently do not configure timeout to 0
in our environment.

>
> The current timeout=0 and reconnect support does not work since that is
> what Hou is implementing, so we can decide the behavior now.
>

Please see above.

Thanks and Regards
Hou.
