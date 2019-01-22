Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E71C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5927E20870
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 05:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas-edu.20150623.gappssmtp.com header.i=@utexas-edu.20150623.gappssmtp.com header.b="eAmT8Mn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfAVFNB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:13:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVFNB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 00:13:01 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so18208961ioi.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 21:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r2w9Pq7Vgiyw+qoG/dt3P4rdnCSK8s0Mx+pU37ZOgA=;
        b=eAmT8Mn7xbFNWXZVueFF3u1FzO4aukr2HhhWJHvbhnxNChvRX88/+67qcXT1CrWlI1
         sGdmFneEbQbwNNRE7SVxWSeuCWpt8fc14RiVJuhl4gjv67FfgpgwIICTbKwWaVu8t0Jc
         JbX46miHYGIDgK/w246tKn5IEjFrdyDo/fbAhZ0sJj29fLvhq/+IUM+thA2ZuKJsCTFW
         kueso6b3ANCVKaTknx6uR10+pvjd7rIeGoCNUbbTajRK+6gnMrkANs/XbZ6BI0EviV/0
         qhT8RhqNo74g+n9dcpGiqGL1iyYUsnAu5idtL5vfM6f7rozOSRk5Ii78vhrd52Iu7TT1
         bv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r2w9Pq7Vgiyw+qoG/dt3P4rdnCSK8s0Mx+pU37ZOgA=;
        b=QQ++n7zn801icW/tMx8YL4aNXkJDfMY7AlS5GBhI4K9r1WGumqrWcS7lb9Btcw23O2
         4qnYGA7EvFfwJn1gpKlDBTYeINQcCaSyM1uLKiwpoB9BSPPc0dWWSbelD9rLbEGOhae3
         9aiy/40yQb7TjRmLPSWbw1zYbQ0zm7bO2QwJodUKXMnA2gdAbjnHIa4oNzrr6fGzsyl2
         8elYn1iJHGnCBdMpYLf0jdixv6bQF9JXInv6R8EAj8MrfDj+H548YaJeWmkiAjyiLTs1
         RCGcltqtRI0UC459bTzLXf6JGXNzXM7yLYVHu0VleOv6+Rk2OtHKVrLjbv1BiKEjZRBt
         krjw==
X-Gm-Message-State: AJcUukf5PlaUeQI0JruQv7RTkuTxVHRGhiKsBRPM/gy+vzAk2jVSbrTY
        yo8kKaH9tlP2QnKeedCBUTiVTgu8YZupI5YtAJdeyg==
X-Google-Smtp-Source: ALg8bN6Hid+FQ5bLboQbz1LGp4as5O4EHYO7pnvUi3hsM3tMypjUNztU72ruzu+vQObLRWmvcR3wj5wtrCU4iaXPluc=
X-Received: by 2002:a5e:c914:: with SMTP id z20mr17628056iol.72.1548133980289;
 Mon, 21 Jan 2019 21:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFk8rvbdfzdChGf9jsTT7qPVf7bpW4VH0mys1He8_KjUD5mD2A@mail.gmail.com>
 <7064d8d4-675d-8c40-5f20-b865607d3495@acm.org>
In-Reply-To: <7064d8d4-675d-8c40-5f20-b865607d3495@acm.org>
From:   Ashlie Martinez <ashmrtn@utexas.edu>
Date:   Mon, 21 Jan 2019 21:12:49 -0800
Message-ID: <CAFk8rvaNjaDYddBGmgwAir4S-JkkR__9MhSv3Ep7hQA3-YFkCg@mail.gmail.com>
Subject: Re: RFC bio flags and ops in v4.10+
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 21, 2019 at 9:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/21/19 8:45 PM, Ashlie Martinez wrote:
> > I was working on porting parts of a file system crash consistency
> > checking tool called CrashMonkey [1] to linux kernels 4.9 and 4.14
> > when I noticed an inconsistency in how the bio->bi_opf field is
> > treated. According to the comments in /include/linux/blk_types.h, the
> > REQ_OP should be the upper bits in bi_opf, while the request flags
> > should be in the lower bits. In kernel 4.9, the accessor and setter
> > methods for this field appear to be correct. However, kernels 4.10+ do
> > not properly shift the REQ_OP argument up for either setting it or
> > getting it from bi_opf. Is this the intended behavior or is it a
> > mistake in how the code was written? Please note that I have not
> > checked all the releases between 4.9 and 5.0-rc3, but I know 4.10,
> > 4.14, 4.15, and 5.0-rc3 contain the same or similar code for setting
> > bio->bi_opf.
>
> Hi Ashlie,
>
> Are you perhaps referring to commit ef295ecf090d ("block: better op and
> flags encoding")? Have you noticed that that commit modified the
> encoding such that the operation ends up in the lower 8 bits and the
> flags in the upper 24 bits? That patch namely includes the following change:
>
> +enum req_flag_bits {
> +       __REQ_FAILFAST_DEV =    /* no driver retries of device errors */
> +               REQ_OP_BITS,
>

Ah, I missed that assignment hiding on the next line (possibly because
I've been staring at the code for various projects for too long :) ),
thanks for pointing it out for me! One (minor) nit about the current
code then: it appears that the comment on bio->bi_opf  still refers to
the old arrangement where the REQ_OP occupied the upper bits of the
field, making it hard to figure out what's happening at a glance

> Bart.
