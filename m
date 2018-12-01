Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A43C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83372081C
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdc4RqdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83372081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725731AbeLBGMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:12:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36723 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBGMb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 01:12:31 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so7291407ioh.3;
        Sat, 01 Dec 2018 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7YcdIqzv1sYAlkJ/sjGQIzHUTNivoehXbNlBnCrIt8=;
        b=pdc4RqdNO3u5c/PcskeDcB5WpU82VaJaUmUsqP3aNVUSVNFzOTjGHUb1lkRRDAEmAH
         f3naAS/YQBwAyl5s0ACsuxOEsmvF1lFRAZu+CYZIfRgMY5OIxU7Zx+PUs1BeNp/xuBS0
         7ypY/hv8gMO6wuQRqi1I5qdBy163kWOcYzEzCMTFAZK8wqi9r0qnI6/iVTFVmszG0WIO
         Kqz5LfagK/QpYpWt6tqwzzkGUquWCAJN20iqBH+t+z0i2jpHGmApDi+BuxwVO1H3JLnD
         2GcgKgMbfCrRA8iYmKcQbgj75bmGgielCv5CGEBz5YxJEcwWdJjQUMKQdXnfZptFhG7h
         8Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7YcdIqzv1sYAlkJ/sjGQIzHUTNivoehXbNlBnCrIt8=;
        b=HZl8aMYuFTfRfJfEEj9bbToGdujkOitM1IGctDuXqM8cJNsBZSmNStIItQ0+wgDtSY
         e76JRq+NPNlu4IFJm3lb4LUVgJoMBILl72ImQentXmhXb12zd0hs8DpNn+djd4rdYt1j
         omMJ7yYZkeETMIAY1mhpLMaVIqPfrM9WBEyFcDi+ES61z8zReTcKuDUZsncUsUJ9hML5
         avBj8o5yqDWih/Vh+bTyi5Q91/6HWpiwDljxri1IGuNhdNsK/5w9/r87tCCqRrOiErev
         SI/Ws3Q1MctEGZkm3c7tNDMrIU1LAiEe42CtBMz6uF7/u9iHK/UPD6ygmPL9Oq2IxNZ0
         6log==
X-Gm-Message-State: AA+aEWZvxm0mOr0/3NPSiirnKN7zssJYM2K/EntW3ZTh4h6W5H/oji6K
        IuQ2NYACDXR/GmHssWuoHYxiwLp1+CbAW6BPecg=
X-Google-Smtp-Source: AFSGD/Vj9Yo1PoPRmGG0D6PVfTNgBOiFG3wsTfImebfG8F6uLWrrI3lRyIaOa8sSxCrv5GE8imIZNZ9l1jCryi8sM54=
X-Received: by 2002:a5d:9818:: with SMTP id a24mr8302004iol.225.1543690759690;
 Sat, 01 Dec 2018 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20181201142414.7766-1-tiny.windzz@gmail.com> <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
 <CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com> <92334639-9d34-5e6a-2c43-945a20077394@kernel.dk>
In-Reply-To: <92334639-9d34-5e6a-2c43-945a20077394@kernel.dk>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 02:58:57 +0800
Message-ID: <CAEExFWtx=+Ee2FgxvOJPFOK=cisjMZiUM18OqQ8hb1FET6N=7Q@mail.gmail.com>
Subject: Re: [PATCH v2] block: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     axboe@kernel.dk
Cc:     ed.cashin@acm.org, philipp.reisner@linbit.com,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, josh.h.morris@us.ibm.com,
        pjk1939@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 2, 2018 at 2:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/1/18 11:31 AM, Frank Lee wrote:
> > On Sun, Dec 2, 2018 at 2:11 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 12/1/18 7:24 AM, Yangtao Li wrote:
> >>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >>>
> >>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>> ---
> >>> changes in v2:
> >>> -Modify some function names to avoid compilation errors
> >>
> >> The fact that your previous patch didn't even compile doesn't fill me
> >> with a lot of confidence in the amount of diligence and testing
> >> you apply to your patches.
> >>
> >> Why would you send something out that you didn't even compile?
> >>
> >> --
> >> Jens Axboe
> >>
> > These changes are the same and only require a small change.
> > Most of the changes are fine, so it's a bit negligent.
>
> When someone is sending a patch for inclusion, at the very minimum
> I expect it to have been compiled, and preferably tested too. Doesn't
> matter how small the change is, even a one-liner should go through that.
>
> That said, I'm not a huge fan of changes like this. It completely
> hides what is going on for someone reading the code, and it's not
> like there's a win on code size for example. The only win seems to
> be that driver writes can't mess it up, which is a nice benefit.
>
> --
> Jens Axboe
>
Yeah,you are right.Can you review it?

Yours,
Yangtao
