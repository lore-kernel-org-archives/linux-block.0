Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5BC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD67E20659
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5+5VlvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgFHXkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbgFHXkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 19:40:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627FC08C5C2
        for <linux-block@vger.kernel.org>; Mon,  8 Jun 2020 16:40:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so15140956otr.12
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0ijiEm6+Snh9QxS1Zcj/PhcZrYdloldxYcA2M93sy4=;
        b=g5+5VlvVithVim19QYwMERO2dSXAMGCVxLTqjIM664YiJYYRIsYxgoJukDoxIzhnPU
         yewlklya1Wr2m2elEPcJKYMgBWjc2p7LP56robgtPmo3tKT/+VMdcyB1M25NhdYjclwB
         t0FFwRk22Nycp5lhHdVJpp74CMvU+wZDfpBETwGCpSgW8lEFQsRVgzvcNZHuvWbt67O5
         cuDUVFwn5kVZIGk9QlXESj5RxeqX6XThtmqok7JHbCTR5vj2MYPP+sbX795DFwFTKHo8
         DL1ZNJ4eUG2+6mmktOX35v/GNMG+WPX4NeyNGfm0guHOzVHhv/wDxpqOUiLdbOKbodpE
         6yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0ijiEm6+Snh9QxS1Zcj/PhcZrYdloldxYcA2M93sy4=;
        b=ijb4V+XXC2X/Nji/rjRkM76nE72ybfmHRexMUbzu1spiWDdDG17VFleiIla25pvNCr
         SCTOhFjrlqf57aeWU5QF5dy7tEKHHeDiAJW93U7WxjKmwPSW/rXD3vg6KDCdxV/b5+RF
         eVicp3bq7V2gshvTDWMF3Z7tQW8fj+rLulmhozGVvMpaQj3LS1UscMGyyhPkXCI05b7G
         rdyySS6VCcWOJ5MpLJ5w/P3TfzvC3gry+UKUzZv8RLLCoF1EWGevcdnC4z+eDyURpAHz
         eI3K9t8HLkV14SQA2n0+5btwRmhBuI2jzaln0JDGvA3iqGoBmwXtINtpP0RNtNU9ktDl
         9aQw==
X-Gm-Message-State: AOAM533pq17QvNWWveEKSA7xkFcNs2yxWaJo53z28ATQMkTGxICDqudz
        gEmszI4bfl2dEfoDjCDH4/vACcyH+r61BhFgHFY=
X-Google-Smtp-Source: ABdhPJyvntwFjs+TwofHyWpHB8ueuZAiC3t2p/M6gD08XjQNM14Wv9BCCuK/CY+tJ+ObD7G7vNytFFHJgIwKop2CJsE=
X-Received: by 2002:a9d:145:: with SMTP id 63mr16683895otu.141.1591659631860;
 Mon, 08 Jun 2020 16:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org> <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org> <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <35a5f5a7-770e-1cbe-10a3-118591b64f29@acm.org> <BYAPR04MB4965D2A36AE58C4519DBD77A86850@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965D2A36AE58C4519DBD77A86850@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 8 Jun 2020 16:40:21 -0700
Message-ID: <CAD+ocbygDJgeAPXodAOLcWJL6SmNxF-AhE=yMCYJU7QyQRgOww@mail.gmail.com>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given that this is a kernel bug and can be exploited by any user-space
application, the fix in the kernel is a must have. But we don't want
to break any existing user-space applications. So, we do need to go
make sure that this patch doesn't break any existing applications. I
originally sent this patch assuming that blktrace is the only user of
this IOCTL. So, if anyone knows any other callers that we need to
investigate, please let me know. I have verified that these limits
don't break blktrace.

On Mon, Jun 8, 2020 at 2:59 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Bart,
> On 6/8/20 7:20 AM, Bart Van Assche wrote:
> > On 2020-06-07 23:40, Chaitanya Kulkarni wrote:
> >> Bart,
> >> On 6/5/20 6:43 AM, Bart Van Assche wrote:
> >>> We typically do not implement arbitrary limits in the kernel. So I'd
> >>> prefer not to introduce any artificial limits.
> >> That is what I mentioned in [1] that we can add a check suggested in
> >> [1]. That way we will not enforce any limits in the kernel and keep
> >> the backward compatibility.
> >>
> >> Do you see any problem with the approach suggested in [1].
> >>
> >> [1]https://www.spinics.net/lists/linux-block/msg54754.html
> > Please take another look at Harshad's patch description. My
> > understanding is that Harshad wants to protect the kernel against
> > malicious user space software. Modifying the user space blktrace
> > software as proposed in [1] doesn't help at all towards the goal of
> > hardening the kernel.
> >
> > Thanks,
> >
> > Bart.
> >
>
> Hmmm, I agree that we need fix for that. What I did't understand that
> why we don't need userspace fix ?
>
> Also, what is a right way to impose these limits without having any
> bounds in kernel ?
From what I understand, there's no alternative to having a fix in the
kernel. That's because, if the kernel is not fixed and only the
commonly used user-space apps are fixed, I can always write a new
program to break the kernel. So, as mentioned above, maybe we can make
these limits configurable via sysfs but we'll need these bound checks
in the kernel.

Thanks,
Harshad
>
> Either I did not understand your comment(s) or I'm confuse.
>
> Can you please elaborate ?
