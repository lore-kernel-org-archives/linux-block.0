Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F90C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9320772
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="N/GLW1oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCaLZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:25:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46142 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaLZz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 07:25:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so13884867ljg.13
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgIzEqM2LnXzzHvamHw2Hc0doSxZZqIged014OPYZ0c=;
        b=N/GLW1oFEDCQ7URS2WLGzLmJwWLDAHhMdnP/DjtzUiv/pmSayZhM604q+eXRSuKSox
         fVIur3LF2iFCCwdN9TPJmP2ZJBMiRnUUon4gjk8p4INkbpG3/wbZ4d8HaR8WjOgaR0XP
         VX7ae0ZYBui7NTCWEUNvg9Cm4feg1FDJi+4pmphpaOBMZlVjACtYYkAdS5kPPiWJU9sa
         vTFCuVaPHaKBshlk3/mEPamPWmBOjLqK2DzRJyP33+cHCTCBjwayCZu7YvmGkKGyVI3C
         cdNLr7VZu3I3e1CkVMYuWphdHkkNUsRc4GvY07AMDIjH7fmxKEAQX59A7pEMYxl6Osit
         Jkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgIzEqM2LnXzzHvamHw2Hc0doSxZZqIged014OPYZ0c=;
        b=KXz/P8e+hppEyu0gS0NIjiaXx+7fKurcTpdfwdXHcZfyp+G/ot8P4DOJJNCiRK/Gpf
         OgDYckQIAgH9O0SCYHd+YuR3gsvin42oDwPX1vFrwMpDhdz589I+EEc4jN9xgmsv8VxB
         Y0rpZtsFkM3vaShknI1+jKIRcVbB2iKiv7UhxKDigsoKSfhICEHv9dD94w2NLamuvX1Z
         pc5u7TwetwaBhhRYLNu1A9pb2irzNDMj80n7zoIFw5o9MzFjhONbnC1yrTluOW9vjN4M
         C220pfWBBNbJKlMCffmDqKfYQvN657G4MyucwnfXnob953szk5PM0VJpH4woBX18bfIr
         j2jw==
X-Gm-Message-State: AGi0PuZnJUzGBbHPAF+EU/eaEK537Q6Ke9vP3YE/3/EXaQX2+9WYkrge
        t314HfNKx5CBOkuOTvscPRURpwkkNu1xMxfPyD6EhA4H
X-Google-Smtp-Source: APiQypJTsUNMZl+N2BPqArgyZP2C2flmTEyblIXo71oiZxzoozA+8v6tymPhb52VSmB4cJtT70qkRRWfTUvd6eB5w4U=
X-Received: by 2002:a2e:9681:: with SMTP id q1mr10418971lji.179.1585653953043;
 Tue, 31 Mar 2020 04:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200329140459.18155-1-maco@android.com> <20200330010024.GA23640@ming.t460p>
 <CAB0TPYG4N-2Gg95VwQuQBQ8rvjC=4NQJP4syJWS3Q6CO28HzTQ@mail.gmail.com> <20200331074828.GA24372@lst.de>
In-Reply-To: <20200331074828.GA24372@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Mar 2020 13:25:41 +0200
Message-ID: <CAB0TPYEwOd-jYJTkq1DYp=c7uXMKvpSpgpcpZGMwW2QsYkOtSw@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 31, 2020 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> I think the full blown set fd an status would seem a lot more useful,
> or even better a LOOP_CTL_ADD variant that sets up everything important
> on the character device so that we avoid the half set up block devices
> entirely.

Thanks for the feedback, I will work on that then. I think I could do
both - LOOP_SET_FD_AND_STATUS and a new variant of LOOP_CTL_ADD that
calls it - the former could still be useful if the kernel pre-created
a large amount of loop devices.

Martijn
