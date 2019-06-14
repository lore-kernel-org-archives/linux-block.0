Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD78C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 21:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E65F217F9
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQcH302x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNVFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:05:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNVFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 17:05:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so3887365wre.7
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2UPQSB8xh9r9rESlBaTGMSBsYdva2mQUu0m2IxrADE4=;
        b=VQcH302xgJQ/FwixtX0rbbdYophC66AUd6XoeQ/AYCtfCxuO9gq9Xutl1eNXjFOqdK
         BnvEoKGaiZnkaEAsKWgVFrQTDloyMSkt//9eWCmFZquhJ3Zi0ymmrxwwdZBapoPVqzXb
         lr4kf3nklZkbfNg6azolcdauWoY/xUJYoD/2EP2AA86Bg8kRxIrT+gmlMZlLbDiPkCgF
         kUkKkaG97v3n7jFB+eha4QebXwizo+FxT43BXcY5poZ7G55j2UKJ7ctXrv4vJImt3C1G
         uIBAlv0r3cyeJ9EYU/pfkz8vQyblojY8GtkxS75waPNPU+0lF5KPNtunGunt2jVbBe7w
         nEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2UPQSB8xh9r9rESlBaTGMSBsYdva2mQUu0m2IxrADE4=;
        b=Yxjgc0p5V7uSQc+HzsnXE9rJ5teb+LZIr1gARTqn5h7uM+gS7+sTZAkbDpjRBfQ25D
         LnQ9H7cdSt5+Vty0Hrq88sJydk1XCs0/5zszDZ/j94qupVCK7uZbjctsaIfX2/rN2Eqj
         4LUIeI7LA/kMpmqw1y5kM8MYdV6/hOyB5Cq3+n66I4TD8vjq8gJ+KyufuQC2sVBpJNCB
         cYPfhZ5cPnzE/nR6duSl0Wco1vzsqzXzO2nIovrmWXUxc+LCXcqEgoEOhL5ACRcj1kMT
         8iHDrGSKt1dPBg5zTToezktVztCkoF3hOEjhMtzABBCLhgkAkBSM7k3BtTWhYeunfgsX
         qEOA==
X-Gm-Message-State: APjAAAXgJK+gCGW4p3boCW0kHMwMMeq0P61VmLOcxm2qNW5JwbulrRln
        oSwRjJ7XGGieKnRHDPzhi7l0Dw==
X-Google-Smtp-Source: APXvYqylq6ZBuhPUqOBSVsBANBcGCvlURPsUNTIhF0qgnLjOUXfNyODmI5EphJLG4dtzQji4tPm1mw==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr10023738wrg.175.1560546338492;
        Fri, 14 Jun 2019 14:05:38 -0700 (PDT)
Received: from [192.168.0.101] (146-241-103-106.dyn.eolo.it. [146.241.103.106])
        by smtp.gmail.com with ESMTPSA id z77sm270813wmc.25.2019.06.14.14.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 14:05:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190614202222.GC657710@devbig004.ftw2.facebook.com>
Date:   Fri, 14 Jun 2019 23:05:36 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78B23D07-0EF6-4FBA-8B21-5C028699C450@linaro.org>
References: <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
 <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
 <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
 <530F0FC2-EBE5-4417-8732-010837C18357@linaro.org>
 <20190614202222.GC657710@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 giu 2019, alle ore 22:22, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Thu, Jun 13, 2019 at 08:10:38AM +0200, Paolo Valente wrote:
>> BFQ does not implement weight_device, but we are not talking about
>> weight_device here.  More precisely, *nothing* implements =
weight_device
>> any longer in cgroups-v1, so the documentation is wrong altogether.
>=20
> I can't see how renaming an interface file which has different
> behaviors on the same input to the same name is something acceptable.
> Imagine how confusing that'd be to userspace.  If you want to rename
> the control knob to io.weight, please implement full semantics for
> both cgroup1 and cgroup2.
>=20

I want to, and I've tried to make it easier for you to point me to
what is missing exactly.  Once again, the only missing piece I see are
per-device weights.

> I just posted a separate io.weight implementation for cgroup2 but it's
> easy to provide a way to override the interface files when bfq gets
> selected, so let me know when you have a working implementation of the
> interface.
>=20

Ok, thanks.  I'll ping you when also per-device weights are available
in BFQ's interface.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

