Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B89C32789
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170D20831
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 16:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bR53PuEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1170D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeKUDUZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:20:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38913 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeKUDUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:20:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so2980164wmc.4
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+Wf6CDJUPs+eWjtmr8Hr9KG3FFVm+nlkqZS2f8RgM/w=;
        b=bR53PuEkjfKVO5TfuQ57wxNpCGss5PElS42NlnIjUGGw8biMobE8VfD8A7yOhyg7TC
         evXEdHcDLEQS1PR8hyjN3k1q1TpLWTTPVIMHma0fR4A9eq/FXWqA9rrXZQ6+52BApAWS
         dXn5fVB13ahQLsouU+4AlZzMipjOTQmhOgXT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+Wf6CDJUPs+eWjtmr8Hr9KG3FFVm+nlkqZS2f8RgM/w=;
        b=ctH0ditsMBb8y24nkegwrRyMRMCrY+FqSXWwRgn0V4iIcm+ggw8mQkTsp7JZXBvGJE
         +qkJ0M+4VVDPUgrtX/8UBRNFB7jR6m/lJOrgGaKKy4cNFVX+cp4JtwgMzOjvpopsgPli
         EzlyqB73cM/bf0LMlWilR6WgFCc7B/sdbfQqf8SDQoqF0aGi1R71MAyka2xij9UEElgy
         xpbCXb8TkLd6wmKF9w3+MbK1MJHUHWDEPHIFBUZ5QC4JJaNSHtz+dQdYlYE84PyjcpOG
         2SJ1hX6op+xXe2S8fVZ2MwuTlhZiWntRqxrM1U93l9q3HQLj5qlhx6ZEg2yHZ9AVo8pP
         5tXA==
X-Gm-Message-State: AGRZ1gIqLyDXGADUO8BGVlgcfk7ATnHRo853dwQ5Hfb/14X9b2pG8jMD
        +pPO0gF6jBnBFUp9C+3JR/HY2g==
X-Google-Smtp-Source: AJdET5dkziSdP8kN9ecWfAoJJIrNuDvoLya7OiySpONwRyyCGhF1GloXfIzKPQNpK90RAvs1zJhLRA==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr2719620wmf.47.1542732619004;
        Tue, 20 Nov 2018 08:50:19 -0800 (PST)
Received: from [192.168.43.112] ([37.162.66.240])
        by smtp.gmail.com with ESMTPSA id x6-v6sm13626648wrs.50.2018.11.20.08.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:50:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
Date:   Tue, 20 Nov 2018 17:50:14 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 20 nov 2018, alle ore 17:28, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Mon, Nov 19, 2018 at 11:34:14AM +0100, Paolo Valente wrote:
>> - if all entities produce the same output, the this common output is
>> shown only once;
>> - if the outputs differ, then every per-entity output is shown,
>> followed by the name of the entity that produced that output.
>=20
> So, this doesn't make sense to me.  One set of numbers is meaningful,
> the other not and the user doesn't have a way to tell which one is.
> It makes no sense to present both numbers.
>=20

I do agree that these numbers may confuse.  Before discussing how to
do this better, let me tell you why we are showing them.

In the first place, the need for a diversified output showed up in the
following case.  Given a group using the blkio/io controller, and two
drives
- one with legacy block and cfq
- one with blk-mq and bfq
there will be different statistics for each scheduler, for the same
interface files.

Then we understood that exactly the same happens with throttling, in
case the latter is activated on different devices w.r.t. bfq.

In addition, the same may happen, in the near future, with the
bandwidth controller Josef is working on.  If the controller can be
configured per device, as with throttling, then statistics may differ,
for the same interface files, between bfq, throttling and that
controller.

More general examples could be made considering that this extension is
for the generic cgroup interface.

Of course, suggestions for a clearer way to show these numbers are
more than welcome!  Maybe involved device identifiers can be somehow
gathered by the entities providing these numbers, and then shown?  In
this respect, consider that, even without this extension, one still
has the fundamental problem of not knowing to which devices numbers
apply (unless I'm missing something else).

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

