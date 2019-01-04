Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B0DC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE456218D8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 20:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbfADUh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:37:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36941 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADUh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 15:37:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so33104924oth.4
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 12:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYl3IhxhZWjLf791qEkbqJAfeXAs2LCFnTqYe9F9CY8=;
        b=b28WsGZGNoAjy7sRvGFZHtIxGcehY2Pa2XVQyT4gs8s+6ztZ8DmDN8757DNR4n7Obo
         bKM5hnC6ku6l+EEQssThSN2sWy81Tz6d8x4SG3siBpZGo386kvJ172BmVaX9ncbwAYCU
         OMp1x/uxRsJLZiVOvLGWPcak8eD1e5dr/l3/lc/gxhDFbgOefOI2xd+3qD61yjluOeFw
         RhXSyFbYn9d+82pTF73SbyBsoGdvhF1W4yNQq9qyYIjYBbwrOqG2sqScfmPgwAcXTIOo
         dCKF6ySVdgaVF5to4ozaj99gPlfN2s30oFPnJrLNiVCk+zR38u3qlp129OtEzYYM+9+x
         AGTw==
X-Gm-Message-State: AJcUukfTcNH8JLPYwtiE16KoDZCSmAdmCtC4gCTCyp8J1tVUHzIVysGy
        ngwTmnRlY6c6diEn96XvY0Zl51FkkZZd3x28dbwbnA==
X-Google-Smtp-Source: ALg8bN5jnZT98gwjSBcROM0lboBZNntxnraKSq8zGR9PvW3h4h0cMJuvnLUf3UAlrJm14PxzjiD7/aNwz1BYT5icuY8=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr37062433otk.117.1546634247205;
 Fri, 04 Jan 2019 12:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20190104154243.3538-1-jpittman@redhat.com> <1546620417.163063.45.camel@acm.org>
In-Reply-To: <1546620417.163063.45.camel@acm.org>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 4 Jan 2019 15:37:16 -0500
Message-ID: <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com>
Subject: Re: [PATCH] null_blk: add zoned config support information
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Bart; I made the changes and sent them in as a v2, I'm sure you
already saw.  I have a quick, unrelated question if you have a moment.
In testing the null_blk driver, I found that trim commands sent by fio
were rejected due to lack of support.  Tracking down Shaohua's commit
306eb6b4a ("nullb: support discard"), he mentions that "discard makes
sense for memory backed disk".  Just to see what would happen, I
edited the source to make discard a configurable parameter at
modprobe, and after the edit & build, the trim commands submitted
fine.  Does this sort of change make sense?  I mean the ability to do
discard to null_blk without it being memory backed;  solely for
testing/benchmarking purposes.  I haven't found any good instructions
on creating a memory backed or discard enabled null_blk device from
the command line, so I assume a higher level driver would have to hook
in and enable these features manually.  Thanks for your time and any
information.
John

On Fri, Jan 4, 2019 at 11:47 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2019-01-04 at 10:42 -0500, John Pittman wrote:
> >  static inline int null_zone_init(struct nullb_device *dev)
> >  {
> > +     pr_info("CONFIG_BLK_DEV_ZONED not enabled\n");
> >       return -EINVAL;
> >  }
>
> Have you considered to use pr_err() instead of pr_info()?
>
> Thanks,
>
> Bart.
