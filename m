Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD954C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CD2146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ew9SX3Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLAFdh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:33:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54621 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeLAFdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 00:33:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so6777815wmc.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gyqSeFnxuL66/4Tb83vuNNeyna66MDa5D0/0KSnYmmA=;
        b=Ew9SX3RhnoO0FB2mWoiHH/G5G9uPbHdEEKfx28ZS1PmNH/iK+DNijjO38sGJjmcojV
         VTpXBHm1FHfP+HQEyVYsIQsMag6z4pGTPuHtx+kKI2peqoRPOkdUtVdfv0aFZ1MhIutc
         jXusQzvJpN5XrW4REVP3SAiqy/jxMo17A54Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gyqSeFnxuL66/4Tb83vuNNeyna66MDa5D0/0KSnYmmA=;
        b=e2uGFg8hAtbz4RNhF+0VLyjr23kaIkWobCXJ6PuJjjWoCDurQxAThvP9RHHTC0mg0P
         sz8biizu6YPuMEUBK3LHWm1ATdbNHAXtuwh47DbPoH4NZ+eMCQmFokZwQLC1/FVA78p3
         fVz4iIk/f3ASF7tX4gJm5QVmtZ8n4Q+N/oC/6sL3pHFrmIxtIiw9RxYjUzsi9CNhep82
         YPecZBHDOgogiIH6PAe4oQ6woiDKagLmSuqOt6Y5OhSMheb0aOgtpulvPMbAay7Q6Hl5
         Sr8hk4Et+JU4ALW+kECpfnFKoogY2Oa8Sr6xJHxEgcMHqbMdGs8HE3704X0e0CkzICtE
         smKg==
X-Gm-Message-State: AA+aEWYsoEIERkPfcr8ZItKq8JqzYJWxN0AVCB45jKCHaQI5sNQj/T7L
        EXHztjMR9B4ID0ltePyOSgpk1g==
X-Google-Smtp-Source: AFSGD/V2amZ1PLVb2nhEMbUahwTygyOFFUoTG/mBG2w41KefN6kABCf8oMVPRw0CUjuQ4ifzD6ySrA==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6541428wmi.61.1543602206993;
        Fri, 30 Nov 2018 10:23:26 -0800 (PST)
Received: from [192.168.0.101] (146-241-2-120.dyn.eolo.it. [146.241.2.120])
        by smtp.gmail.com with ESMTPSA id z17sm5453917wrv.2.2018.11.30.10.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:23:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
Date:   Fri, 30 Nov 2018 19:23:24 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
        broonie@kernel.org, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
To:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 20 nov 2018, alle ore 17:50, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 20 nov 2018, alle ore 17:28, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello, Paolo.
>>=20
>> On Mon, Nov 19, 2018 at 11:34:14AM +0100, Paolo Valente wrote:
>>> - if all entities produce the same output, the this common output is
>>> shown only once;
>>> - if the outputs differ, then every per-entity output is shown,
>>> followed by the name of the entity that produced that output.
>>=20
>> So, this doesn't make sense to me.  One set of numbers is meaningful,
>> the other not and the user doesn't have a way to tell which one is.
>> It makes no sense to present both numbers.
>>=20
>=20
> I do agree that these numbers may confuse.  Before discussing how to
> do this better, let me tell you why we are showing them.
>=20
> In the first place, the need for a diversified output showed up in the
> following case.  Given a group using the blkio/io controller, and two
> drives
> - one with legacy block and cfq
> - one with blk-mq and bfq
> there will be different statistics for each scheduler, for the same
> interface files.
>=20
> Then we understood that exactly the same happens with throttling, in
> case the latter is activated on different devices w.r.t. bfq.
>=20
> In addition, the same may happen, in the near future, with the
> bandwidth controller Josef is working on.  If the controller can be
> configured per device, as with throttling, then statistics may differ,
> for the same interface files, between bfq, throttling and that
> controller.
>=20
> More general examples could be made considering that this extension is
> for the generic cgroup interface.
>=20
> Of course, suggestions for a clearer way to show these numbers are
> more than welcome!  Maybe involved device identifiers can be somehow
> gathered by the entities providing these numbers, and then shown?  In
> this respect, consider that, even without this extension, one still
> has the fundamental problem of not knowing to which devices numbers
> apply (unless I'm missing something else).
>=20

Hi Tejun,
have you had time to look into this?  Any improvement to this
interface is ok for us. We are only interested in finally solving this
interface issue, as, for what concerns us directly, it has been
preventing legacy code to use bfq for years.

Thanks,
Paolo



> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

