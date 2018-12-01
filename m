Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A55CC04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117FA20867
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4LZgxag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117FA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725732AbeLBFp3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:45:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 00:45:29 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so7254822ioj.5;
        Sat, 01 Dec 2018 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asChsHT+P653a2Z4qqA1mOWC3JexMOFWJqr5yPrVkMo=;
        b=N4LZgxag5ilSSzorVsQG8O7WVeB2Bu7bD6Do2UXCCk3kcS7IrRNGsvU7aqnwFbTFK5
         1lLeoUI6c2yl/gJdcV8LNNC/Td4zphnMJI9iJ3ePiIbdJY+/sxD0ZyaNScf+6PM0xWOP
         XJ40BitSDvAuNp1sIBx3Fl5kQVlkoB+abDDA6HagGnNleo5jDx+vPy4N8l5ZyggxnUnO
         FVAX3rLSCJMvUR3AXcPnmvu3Q8Is0IOKAbmLjwJ9fgG/IJQ+SVWRDUMCjKC8WE0z94UD
         BGWxm7CKurBpa/hRo4te3qI8dMRZtFM+AqKp7FHUWSgyn5jyM6ePPtHjMpdIEblTc7Tq
         90Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asChsHT+P653a2Z4qqA1mOWC3JexMOFWJqr5yPrVkMo=;
        b=MUhie5KjntJrTC2EgzcPOg5mfHsvJ/NCs7tqjkGP8BMM0uBUblTFZaj5TPKCy1da4b
         Tk606XgqQ1ylmBK2ZrUwFqbF3xzzPcEZE0brhfPxVGr7AvX67Bzd1GViVHX3muQUsLTv
         60sWePd6A+RVyefJCjp+zhsbP+AaK2QpEyN7RNp8KmpB8q4cvlFf6KvcnmXS0XQfMXvm
         WCbusZbMTOAbHT4EZoS61QaFh/tvbBbL/vEF9onSKrwo3qk9i3l3+MOpcinH9wXYk3uo
         wkQ33y/Zdej5Cfen3MnXARFHmlpGp35QCATfv2oZEYPF4SEoTcFe6PNm4D7MT8IbjI/S
         e0pg==
X-Gm-Message-State: AA+aEWYTm5hFyebcay7Bltv7cKkD+GcLmoKDYRyO1MpMm9YJBGDQ6Hcq
        sVYKWDo6rcHROfumsFS44MxHoycR7z7v1Sr+k5c=
X-Google-Smtp-Source: AFSGD/U/Uqe9lpVs0D59bSJBmvXaLGdQG8Qy99LlN5zXpaPjeHwlS2518dSShgjfzEp2HS+oU+FxWxf1UCxI2cVYoG8=
X-Received: by 2002:a5d:9818:: with SMTP id a24mr8262893iol.225.1543689141525;
 Sat, 01 Dec 2018 10:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20181201142414.7766-1-tiny.windzz@gmail.com> <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
In-Reply-To: <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 02:31:59 +0800
Message-ID: <CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com>
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

On Sun, Dec 2, 2018 at 2:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/1/18 7:24 AM, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > changes in v2:
> > -Modify some function names to avoid compilation errors
>
> The fact that your previous patch didn't even compile doesn't fill me
> with a lot of confidence in the amount of diligence and testing
> you apply to your patches.
>
> Why would you send something out that you didn't even compile?
>
> --
> Jens Axboe
>
These changes are the same and only require a small change.
Most of the changes are fine, so it's a bit negligent.

MBR,
Yangtao
