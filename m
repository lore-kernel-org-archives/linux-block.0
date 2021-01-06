Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C766C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2507123125
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhAFRCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbhAFRCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 12:02:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2819C06135B
        for <linux-block@vger.kernel.org>; Wed,  6 Jan 2021 09:02:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y23so3222680wmi.1
        for <linux-block@vger.kernel.org>; Wed, 06 Jan 2021 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dTM16oNjf1fQfacfYh3azRUgkJmTA+T6DCqoFqB6YUA=;
        b=p6nFONWdSNXniDfEKw6pKY2xnIcJqy7lXmtl8gWoWYSCDSLkcOB54qmKiNwXBFa309
         xui5R7h7YupVD00BHXltqjRx5yGIlftkOX9f4el/kVPat01JpKiSN5b0coCBRR3xDj0S
         9T2iA993YF9hawwBUyWZYGZSQSFsQ9Ew3OPgiBMqnxiQfAtJa39mIFFdJYvMbSrrCyiM
         VZfgYwm/Zzri2Qg2fsaccuv2pDnaR6dRC/TfoP0bJTjF57XksTCSo/TveRR4NfnDTGig
         XRxZdXKdTNh3SPEx/QzPzezM/PlGziKEn2efUbMvPM/9vyr7iKWqQTSd3ds/73rAexwh
         ZGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dTM16oNjf1fQfacfYh3azRUgkJmTA+T6DCqoFqB6YUA=;
        b=pORsDkiKYVl/ooeitkWC5zfrRd9TmaurFsh1ImYCuSIqJrofk5mKhl5GrqYRlaTgZV
         xsMDKq21+FKIiLJje0SJunY0ZseQwdaxwuyf0rdRTiciHV8M1AME1XiljVj3nNlmAQTY
         wVz8ZIniuSW3gFLYQY16Y3w29dJqO3nlkBBAmIRgzKTEQPXmR8NEDIo6dTRuK3LuuABF
         KlSDON88I2Ac2G7f2Z6hbpppSLw8XjHP8U351cGyUqcHJD2STHdw31MHv487qcPAP711
         /ley6FaDCATXr4jDiowBnty78+khtbXP7KuSsGy4xkF/ETptYf4xkE8x5CdbotfKPgsf
         KC7g==
X-Gm-Message-State: AOAM531DVygg0f/CYrKLIUZUSm9erD0QjEvyWNaGuatM03KJHdDfNqIy
        JTetg75C3LQzOwM3eXsPEfFS+KlchwqA1qHU
X-Google-Smtp-Source: ABdhPJwOFE29pWovBjwRJAc3d+KmZVWpdo30imaC3mCxlFOyaQnL/y/j0L/sLUvs+nyP7fzMsL4YBQ==
X-Received: by 2002:a1c:151:: with SMTP id 78mr4598477wmb.24.1609952527546;
        Wed, 06 Jan 2021 09:02:07 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id f9sm4255927wrw.81.2021.01.06.09.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 09:02:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: Fix computation of shallow depth
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <238318dd-9103-e4e4-d591-ef7212b86a48@kernel.dk>
Date:   Wed, 6 Jan 2021 18:02:03 +0100
Cc:     Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78A91DC0-0DC9-41EE-909D-341082CE4DA5@linaro.org>
References: <20201210094433.25491-1-jack@suse.cz>
 <20210105162141.GA28898@quack2.suse.cz>
 <238318dd-9103-e4e4-d591-ef7212b86a48@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 5 gen 2021, alle ore 17:29, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/5/21 9:21 AM, Jan Kara wrote:
>> On Thu 10-12-20 10:44:33, Jan Kara wrote:
>>> BFQ computes number of tags it allows to be allocated for each =
request type
>>> based on tag bitmap. However it uses 1 << bitmap.shift as number of
>>> available tags which is wrong. 'shift' is just an internal bitmap =
value
>>> containing logarithm of how many bits bitmap uses in each bitmap =
word.
>>> Thus number of tags allowed for some request types can be far to =
low.
>>> Use proper bitmap.depth which has the number of tags instead.
>>>=20
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>=20
>> Ping Jens? I think it has fallen through the cracks?
>=20
> More like waiting for Paolo to take a look. Don't mind taking it, and
> I'll do that now, but I do expect him to review any BFQ patches being
> sent out.
>=20

Sorry for the delay Jan.  As you know, my priority is currently to
finalize the patches I have developed with your help; and
unfortunately I'm way behind.  This is delaying also my review
activity.

As for your proposal, I remember I found the right parameter rather
empirically.  In particular, I seem to remember that the bitmap.depth
parameter did not contain the value I needed, i.e, it did not
contain the total number of tags.  But maybe something has changed in
the meantime.  At any rate, if bitmap.depth does contain that value,
then your replacement is ok.

If your replacement is ok, then I guess you may want to also fix the
comments above the changes you propose.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

