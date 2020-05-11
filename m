Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A855C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1D9206F9
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c/fzhA4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgEKPCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKPCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 11:02:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A773C061A0C
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 08:02:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so7917402pjb.3
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FfcHG6dCtT1/Beq3duGCw1xmBaWsjgWcZxWLSDufIoo=;
        b=c/fzhA4ubiZwGdqAM/oYm8GPV6J++F0ESrTunD5wFUlCGqrTJmEEVXtNnP33+MulMK
         R5BL6TlhxRDhCvuqtTVsIkVVIntI1F4s7vi3lwSnOf0JR7B4oxZdyLs7mfG/HZyQvb/u
         VZNBPW/nbWYpNetPXn29ruWVt2YWT9q5t8N6EFxgxrUqTS/3f+Un86E9nzgU3Oyk2NXg
         CU2o6DRkrfyzf5YTK2jrjuMj35CjATcERL8CQGyS39laD2w6qzTPbW5+mHAMQPN5vshy
         4recjNaRcFrlmx1AsiJWA85xU9KuGrdHK5tF+1Ivb4683ZRCbMgbvEAw2RtOWBIGmlZE
         OL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FfcHG6dCtT1/Beq3duGCw1xmBaWsjgWcZxWLSDufIoo=;
        b=gh729y9ybuWLCUViFal2Y2+SX1kDROEUJrZxnyeXfsQixhVEL1rtj8IQ+inJroDNtS
         ssrKv4hZGssPShjrJQ0+5KfLrtQtq9q4qMlq/wJQjTjflqTwHvD457PFA4UF8c2W4V8O
         cU5DAzmbf1L+df+xm0t4p1X8K4QjDSrFQHVrjDYp+p1RUtmwwTiFVtZS9iq0OIsl2uUJ
         OWm/ND7ogr6tsIjuI5jxnTmtkjz4oAVi9hLGfpouRFji2kh0ALUd4LGbNRzERuXixKCW
         d/4Dl6MY9pU+IbV7gO+nG9d6OZdEafnRbYRxlc/BW1V0hJLhCAX5n74JtPrWlGWv3CVd
         A7Nw==
X-Gm-Message-State: AGi0PuY0jmwi5HMKSiHXOsUnHfKVfDG4zgrzIz2AVZaJm6OtSj4dj+M1
        zNpQOb/jsk8mSw0wpFzpvot8YrrbGnE=
X-Google-Smtp-Source: APiQypI0v45uQCD1lBJXNAM6fKHMgR7CPdAhrVIQti3ZxMe8Z4JzkZhpOCNCrNm0pl/4uEG+Fk2XSA==
X-Received: by 2002:a17:90a:fb89:: with SMTP id cp9mr22494808pjb.40.1589209342620;
        Mon, 11 May 2020 08:02:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2dd6:4c58:486d:263e? ([2605:e000:100e:8c61:2dd6:4c58:486d:263e])
        by smtp.gmail.com with ESMTPSA id v1sm5861227pgl.11.2020.05.11.08.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:02:21 -0700 (PDT)
Subject: Re: [GIT PULL v2] Block fixes for 5.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
 <CAHk-=wheALnWv1jaZM9yWhyrD_2nWppt96UYCQNE6V-DN_gGuA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbbbaa72-bee8-2af0-b05d-9ec31c8b1dca@kernel.dk>
Date:   Mon, 11 May 2020 09:02:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wheALnWv1jaZM9yWhyrD_2nWppt96UYCQNE6V-DN_gGuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/20 9:36 PM, Linus Torvalds wrote:
> On Sat, May 9, 2020 at 6:33 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Let's try this again... BFQ was missing a header, I fixed that up.
> 
> The fix looked trivial to me. That wasn't what worries me.
> 
> Why did you send me something that was clearly NOT TESTED AT ALL.
> 
> If it hadn't even gotten build-testing, what _did_ it get?
> 
> The fact that it now builds doesn't make me much happier.
> 
> Why should I believe that this clearly totally untested pull request
> is now any good?
> 
> Why should I believe that your _future_ pull requests are any good,
> when they clearly have absolutely _zero_ testing at all?
> 
> Jens, in case you didn't catch on, this is a BIG PROBLEM.
> 
> Sending me completely untested crap is a bigger deal than "let's just
> polish the crap until it at least compiles".
> 
> What have you done to make sure this doesn't happen again?

I was out all day yesterday, so didn't get a chance to follow up on this
one. I did notice that you pulled it, thanks for that.

My test box is currently out of commission. While that doesn't mean it
gets no testing, it does mean I'm using my laptop and qemu configs.
Neither one of those have BFQ set, which is why it was missed. While
that isn't ideal, it's not a core kernel file, or it would have never
been missed. If you look at the patches, it's also not like they weren't
reviewed, in fact they were quite heavily reviewed.

So, yes, I agree this was unfortunate, and I hate having sent something
that didn't compile for a pretty common option. That sucks.

-- 
Jens Axboe

