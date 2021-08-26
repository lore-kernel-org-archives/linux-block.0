Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB33C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7772600CC
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhHZJqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHZJqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 05:46:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B5C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 02:45:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i6so3765852edu.1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rZFactmh8+QxEY3gA+2s+3GnpVG/RFLpPoVnTconPAY=;
        b=EB/7d9h5KlVTHcRcU/zuje03iv6+DKgj6hPihRHXf9F0h/C75hE1OTVEeGLf3jbRCQ
         jevH6kcycVfp9YaAxZFcD5eOIBMDg0v2rECFuuZGrdFTsiNkkX2Br+kiNjtJ+q/bSGbr
         /lo6DMvlSvIwLuGP1t5/nP7UkJEa2DttHGFgbyvlPlK7dxxZePFguF408fUVAjRngj5o
         LaJkoJgIrrluRIO6CVQ+/1JTAN4E8m8dcsC13wCkQZaje1i4GMuB9ElI2UO+BBpUrfHg
         xKlSBID5jBRwXkk4/eAu7eu7+WgqziCloH7vXhMt5/bsfVT6XtUyjfCAlR1oXQqjqZDw
         m7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rZFactmh8+QxEY3gA+2s+3GnpVG/RFLpPoVnTconPAY=;
        b=gJVlZaPOIbWxepx4hWf8bPc/cPaKzppqdM+NUppBOVCKrbEv53Ndl2IIC5HaBtAITs
         oAJrWhoQo6aYscZsJ4+bA0e9gBlwRhJ5IFzYZottgXpwOwrMtQZqKPTHmRCj3ymcJVDd
         lbx6GiDlukLuJoJ2FnO+WcTBplMlqVtaWcSkwqgNiqcI2Cqzs6OZ0+sfYCDhdKsOrKm/
         QxrjIPP7S0FeqORnb/K63f7ka6tkz8g2HwFey51pFoIR11z7WsEkA23g1wC2eMt5xct2
         WDHR/0hpJAHPcQxz149v/9ROXMqPEqsDeQjuOJfPe4nK7+hlu7cvG+EiWv7UUF2xglwV
         mwsA==
X-Gm-Message-State: AOAM531+MKbGpjuiLuAPuo6pZ4Tebnt08Yvipe1A7A+7SMtVrVeRMdqM
        3ChS7Mjiw4YP3pBw0x2kJgWFtA==
X-Google-Smtp-Source: ABdhPJwpbsSt5unq+T3/PG9odNQXFq7tDpZSquDqPu+CtzbN9bb3aEdqQS5ET7/PYycZr9/QC42pNg==
X-Received: by 2002:a05:6402:2292:: with SMTP id cw18mr3183151edb.109.1629971119084;
        Thu, 26 Aug 2021 02:45:19 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id cr9sm1480646edb.17.2021.08.26.02.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 02:45:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: False waker detection in BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210825164301.GB14270@quack2.suse.cz>
Date:   Thu, 26 Aug 2021 11:45:17 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF2D1482-0CF4-4CDF-B31C-FA3354AC831C@linaro.org>
References: <20210505162050.GA9615@quack2.suse.cz>
 <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
 <20210813140111.GG11955@quack2.suse.cz>
 <A72B321A-3952-4C00-B7DB-67954B05B99A@linaro.org>
 <20210823160618.GI21467@quack2.suse.cz>
 <20210825164301.GB14270@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 25 ago 2021, alle ore 18:43, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Mon 23-08-21 18:06:18, Jan Kara wrote:
>> On Mon 23-08-21 15:58:25, Paolo Valente wrote:
>>>> Currently I'm running wider set of benchmarks for the patches to =
see
>>>> whether I didn't regress anything else. If not, I'll post the =
patches to
>>>> the list.
>>>=20
>>> Any news?
>>=20
>> It took a while for all those benchmarks to run. Overall results look =
sane,
>> I'm just verifying by hand now whether some of the localized =
regressions
>> (usually specific to a particular fs+machine config) are due to a =
measurement
>> noise or real regressions...
>=20
> OK, so after some manual analysis I've found out that dbench indeed =
becomes
> more noisy with my changes for high numbers of processes. I'm leaving =
for
> vacation soon so I will not be probably able to debug it before I =
leave but
> let me ask you one thing: The problematic change seems to be mostly a
> revert of 7cc4ffc55564 ("block, bfq: put reqs of waker and woken in
> dispatch list") and I'm currently puzzled why it has such an effect. =
What
> I've found out is that 7cc4ffc55564 results in IO of higher priority
> process being injected into the time slice of lower priority process =
and
> thus there's always only single busy queue (of the lower priority =
process)
> and thus higher priority process queue never gets scheduled. As a =
result
> higher priority IO always competes with lower priority IO and there's =
no
> service differentiation (we get 50/50 split of throughput between the
> processes despite different IO priorities).

I need a little help here.  Since high-priority I/O is immediately
injected, I wonder why it does not receive all the bandwidth it
demands.  Maybe, from your analysis, you have an answer.  Perhaps it
happens because:
1) high-priority I/O is FIFO-queued with lower-priority I/O in the
   dispatch list?
or
2) immediate injection prevents idling from being performed in favor
   of high-priority I/O?


>  And this scenario shows that
> always injecting IO of waker/wakee isn't desirable, especially in a =
way as
> done in 7cc4ffc55564 where injected IO isn't accounted within BFQ at =
all
> (which easily allows for service degradation unnoticed by BFQ).

Not sure that accounting would help high-priority I/O in your scenario.

>  That's why
> I've basically reverted that commit on the ground that on next =
dispatch we
> call bfq_select_queue() which will see waker/wakee has IO to do and =
can
> decide to inject the IO anyway. We do more CPU work but the IO pattern
> should be similar. But apparently I was wrong :)

For the pattern to be similar, I guess that, when new high-priority
I/O arrives, this I/O should preempt lower-priority I/O.
Unfortunately, this is not always the case, depending on other
parameters.  Waker/wakee I/O is guaranteed to be injected only when the
in-service queue has no I/O.

At any rate, probably we can solve this puzzle by just analyzing a
trace in which you detect a loss of throughput without 7cc4ffc55564.
The best case would be one with the minimum possible number of
threads, to get a simpler trace.

> I just wanted to bounce
> this off of you if you have any suggestion what to look for or any =
tips
> regarding why 7cc4ffc55564 apparently achieves much more reliable =
request
> injection for dbench.

I hope my considerations above help a little bit.

Thanks,
Paolo

> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

