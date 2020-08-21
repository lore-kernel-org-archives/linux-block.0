Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA9C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2292076E
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ab/g5JSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHUXCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 19:01:59 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF744C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:01:58 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q14so2726249ilj.8
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ni9a4xGLzpMRi2DYHKOlD8dG65gEEXYsFw6fTagOdsg=;
        b=ab/g5JSUbIbWZP/L1QWVA0J7hMP7xsnMQDQfBHfAgEukske6xUkdalozJj/Yl2XW72
         qYCCStwgQULKuzVODZv93AKvDHaWz8EI6SGfGcvrVo0Xy9+K51Hf1YzjTXk5DEbMTWru
         UJt81ujRonnFLE4Q29ZY22EL4cmPXqv4spIssHlBTkIJ+PWPL4rszLmAn1wHfdbg+ujD
         oyE+Q7mFDtW51OGFBuDcHQaKid+IP/iqIVz9nijjWGucJVRjXA9jK7ZCAP49mPwfL7fU
         V8dz0VNcoWs6OOjQ6ovoLKhkYjpx6tIQybZRE7M/f4KsKgl+q4B6IWW5a4hfTpmdciSf
         2AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ni9a4xGLzpMRi2DYHKOlD8dG65gEEXYsFw6fTagOdsg=;
        b=gtgRKujdtUdEClHOVpvZQ7Da5bq+yIOMZdVVIipO2Q6cd18MG/ToLODGsBr90NhpEj
         tT8NbKqzXvjXG86tz61R52MCjQGwrpuxzZSjQO6GS41EU/mm1+e6EzxUakweLDWL4Rxt
         XnLuo/LOQa7Bfv3/i6dC0rj2gu0E2kAgrVGOfsrexGS6NZXznVjwjy6Vr6UpG8ohgNQa
         PkpQF76zKnHwQJRaGlFOTAqI7ivegEWKKPzwtRZKzl6gxKu/TqVU5gE+G10T9FD0Lvh7
         UNahWWmM76zN9mLa2QBBX2pcNcsi7pSSohrIcPzrsBlzkILMa8nGq2+aS8CWxYf6ITA9
         JeUw==
X-Gm-Message-State: AOAM532ItlvYo8y8F+0C3+YdF/R3ilJJNXIcjQz2xa4o5oBG0Fh2TDRE
        m5JhZzuxz/oLBYJpcc8yEzsVCDsZfcty7eNE
X-Google-Smtp-Source: ABdhPJwRzMQLuKh5XYPQwg4QHGOsLZmuDFwzsqrKY4UbR3J9jVUwcxe1V5jV3mz4Vl4Ms3v5RmlZGA==
X-Received: by 2002:a92:7991:: with SMTP id u139mr3811021ilc.62.1598050917806;
        Fri, 21 Aug 2020 16:01:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f128sm2046285ilh.71.2020.08.21.16.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 16:01:57 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
 <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
 <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk>
 <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a221d34-6651-ba92-f074-c785fab70460@kernel.dk>
Date:   Fri, 21 Aug 2020 17:01:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 4:45 PM, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 3:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I had to look for that, because it obviously didn't complain for me.
>> Looks like it's the one in drivers/block/rnbd/rnbd-srv.c which changes
>> from PTR_ERR() to using 'err' which is indeed an int.
> 
> You clearly didn't even build the patch you applied.
> 
> You can claim it's some odd uninteresting file, but then you damn well
> shouldn't have applied the patch if you can't even be bothered to
> compile-test it.
> 
> It really is that simple - this is not some odd configuration that has
> a build problem because it's esoteric.  That file *will* warn if you
> compile it. I don't think you can avoid it.
> 
> So it's literally a patch that cannot have been build-tested AT ALL.
> 
> I don't see why you even make excuses for it.

I'm not trying to make excuses. Should it have been compiled? Yes it
should. Did I miss it because it isn't part of my regular testing? Yes
obviously. Did I assume it was probably fine since multiple people
reviewed it, including the maintainer. Definitely. That doesn't excuse
the fact that it was missed, and it should not have been.

The tree is totally warning clean right now on build, but that's usually
not the case, and missing a single warning isn't that hard. It happens!
I think faulting someone severely for missing a mostly harmless warning
in a driver that can't be considered critical or tier 1 is a little out
there. That's all I'm trying to say.

And FWIW, this isn't some frivolous cleanup patch, it's fixing a real
error handling issue.

> Send me the fixes part of the pull, no new features, and no untested
> garbage.

There are no new features in here! The only patch I'd argue you could
object to is the raw deprecation, which should have gone in for -rc1.
I'm happy to drop that, was only trying to make the deprecation period a
bit longer for it. The majority is pure fixes, and there are a few
cleanups in there that just seem silly to defer when they show up.
You're making this sound like it's some pile of garbage, and frankly I
think that's way out of line.

> And no, I'm not your test build server that you send crap to and then
> when I notice it was broken you try to fix it up.
> 
> So it's your choice. If you want to let it simmer in linux-next for
> better testing and sending it to me for 5.10, I guess that's a choice
> too.
> 
> But I'm very very fed up with people sending me stuff that they didn't
> care enough to even check for warnings for. And no, I don't want to
> get some minimal fixup. I want a clean tree.

Right, and it totally shows since once the beaker flows over, then some
rando gets the wrath. Your delivery sucks, and you need to work on that.
This could have been handled so much better.

I'll rebase and re-test, but it'll be after -rc2.

-- 
Jens Axboe

