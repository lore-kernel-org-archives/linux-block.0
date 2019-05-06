Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D6C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 23:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9A4206BF
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 23:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exs8fXD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEFXYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 19:24:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45703 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFXYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 19:24:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id n22so2844287lfe.12
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxOxaQdaJ/OqsDlgu3Co/ZHHyfNtTpij4NOpIoNjyRo=;
        b=Exs8fXD4Jqa/FITqHIxIUYPuAtzNVtgBVyTdjoEYK/C8LQnLfUHNjL3Od+0J+L6P0c
         N+/6dW1+q48z7LtvGFaxnpe91QwUY8nthDfjWBNfLFQSKjF889lnd06ghTMSPLhOr+VC
         m8DPHaZQQSeEj6ylMVYnE7sh7dJfeISdUsbmndUQ2Nl07PWNfgg5/5WixNjodesS3BLY
         4j+ER9uozNTwOyG3WM27MCbgu3sZcpV1SCYAkTf4JoA/f8zsIrmhRveYpxFLZO/RpmCC
         Q6Do37JCOXHX4a/EmveQpgOr4ivz+oehjBZqB5znjr0ke6GWiMpSVnFn+oOV9V+23jYR
         G2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxOxaQdaJ/OqsDlgu3Co/ZHHyfNtTpij4NOpIoNjyRo=;
        b=Q7MZ6UqmC7U4Urh00NA65PklO29VZLQVGEsrzJvHGk5RllFBtNtzweDfuYyqtOZbAv
         jGsOyacmtoKFfDLbm3CVC0ZX01oJGWF1SmFzqVMeaJ2sqIdEWcSyntZOSdoRmSFAMQma
         EogFJcihhUzE6exbACCTTP2t+yE4Jo8KPlkrdESdwpEaJnQjYUGbv2PkQbcpS4gOyJhH
         jgyrKVzmS/o6aChoI1L1SHwUm32ZKQVzj/Hg+c4xfyYg3BXjCjCSOQF3NLEVCSMu1iz0
         KSFkovn79G74D+2QlLlOy2DrApN3DT71w/03PqwaRVrypPt4OxkWXBH0q9MtA9BFe3p4
         fnVg==
X-Gm-Message-State: APjAAAWzaXZC52ngGKZHGk4hbelCsq+o1nCtbl34h3L2vdT2NZ4mFz9Y
        XvmzkEaSJIJpH/laoP5mv0IhezHGwgLZWW0qHUw=
X-Google-Smtp-Source: APXvYqy3+wc9LwHke83ghsu/ky296EBG64QMHx0omQCuy5+hPsx48g3IEd8bVfQqFsUbGJGxcMfGi49/fMmUesxJn0o=
X-Received: by 2002:a19:750e:: with SMTP id y14mr3757298lfe.110.1557185037775;
 Mon, 06 May 2019 16:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com> <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com> <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com> <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Date:   Tue, 7 May 2019 08:23:45 +0900
Message-ID: <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >> I wasn't clear enough.
> >>
> >> It doesn't check for the return value for now. What needs to happen is :-
> >>
> >> 1. Get rid of the variable strings which are not part of the discovery
> >>       log page entries such as Generation counter.
> >> 2. Validate each log page entry content.
> >
> > Question again here.
> > Do you mean that log page entry contents validation should be in bash
> > level instead of *.out comparison?
>
> It has *out level comparison.

I'm not sure I have got what you really meant.  Please correct me if I'm wrong
here ;)

First of all, removal of variable values in the result of the
discovery get log page
looks great to me also.  Maybe those variable values are able to be replaced
a fixed value like port does (replace port value via sed command to X).

But, it also depends on the outout of the nvme-cli, not return value.
Anyway, let's discuss about it with Keith also because he discussed it with me
few weeks ago,I think.

> >
> >> 3. Check the return value.
> >
> > nvme-cli is currently returning value like:
> >     > 0 :   failed with nvme status code (but the actual value may not be
> > the same with status)
> >     == 0 : done successfully
> >     < 0 :   failed with -errno
> >
> > But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss.
> > Anyway, if nvme-cli is going to return 0 for both cases: success, error
> > with nvme status, then test case is going to be hard to check the error
> > status by a return value.
>
> This should not happen as it will break existing scripts which are
> written on the top the nvme-cli in past few years.

Agreed.  But, please refer the following comment below ;)

>
>    It should be with output string parsing which
> > would be great if it's going to be commonized.
> >
> No, we cannot rely on the output string as this problem is a good example.
>
> I'm not sure returning == 0 for error case is a good idea. Checking
> return value prevents us from writing unstable testcases which are bases
> on the text output and allow us to modify tools as specification moves
> forward.

Please refer a discussion on https://github.com/linux-nvme/nvme-cli/pull/489
Keith and I had a discussion about the return value of the program itself.
The nvme status value is composed of 16 bits value, by the way, the actual
return value of the program is in 8bits(signed) which means it's not
able to carry
the actual nvme status value out of the program.

If you have any idea about it, Please let me know.  By the way, I really do
agree with what you mentioned about the return value.  If it's possible,
I would like to too :)

>
> > [1] https://github.com/linux-nvme/nvme-cli/pull/492
> >
>
