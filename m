Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E037EC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A22184D
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 15:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa+rL/KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1PcF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:32:05 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53897 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1PcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 11:32:05 -0400
Received: by mail-wm1-f48.google.com with SMTP id q16so4042769wmj.3;
        Thu, 28 Mar 2019 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IS/RSOm3zlVImWcezcR+ocyFLYvoZdo9zgmFGvoorg=;
        b=fa+rL/KM7nVByaCTlGgeZK+CN2Ivr2e/LLoCrXGyLVS5F1SC8hQu8tww0dpK6mbRXW
         3/Ydh1ubn38tW3YplHfuSFa65XuEQDXd+m3iRx1T2qjlRUegSrvuNk3n6SmOdlu9JsoP
         0AvaaTlxtNhSHc+jWCzjxTiN8+pQ2CmoibXKv2XvnKbDnqVJZzqdh08qlmrHwBcq3Yzl
         G5KgXfV/Zzb50eybGx3Uz/YtRbVZH1RgOV8gM/sBRraChDxir22HmLyJRkeYwNbLkupA
         w77gIMUgFQrS91DrUSS+gPe7Qw3zC39y8xLdNmIxQXbzQyesXgxAy/W3d1V5m7jzUk9s
         aSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IS/RSOm3zlVImWcezcR+ocyFLYvoZdo9zgmFGvoorg=;
        b=kffIJpwUb0vx8B4iAdSueIZGDgO/iPWwN/JfjPaA8Joumx9UrT3NeR4q8GecjVKUBg
         MQuXaLk12B815iLS6owKw2y/B5eXTKaILRd4y7/fXwx0QgeHaSBZF5YkHQn8wWaxpGiy
         5hMovqQ2Q/6+5IjyYIJ9hQXQMMxzYU+w1wdkwKvxSmW6HqT7PHznVPdM7A3F4AWc/OkO
         rDAHIAVgsjRxioFkm/yE/RB4iBvi6Fc9y2lao9vsVvl4jXGaV4X0KvPKqN60Bf7TxISQ
         Nxf2pHVwB3SEwp5v7b1r9zLPttmBo3VdfF9ZSF/UzZupybGSM5GtjehwEH1WU5LqFPx4
         BUAw==
X-Gm-Message-State: APjAAAVyfwGm8D78OvB6UueViWgybJnY2nkpNTsnZGqzieXQPKv6kCnk
        PEelGFLVJtUXKdix+3LzjSeGNKkXkrwhqTHZ7vU=
X-Google-Smtp-Source: APXvYqy2lY3hBQJ0TjxxRM7edmep6uxTgIY1PCh6AMUBewrypFD63hWkVKuDq92h6joGFIwAdpqhDwcd3LsRSAxXc6M=
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr368411wmf.77.1553787123695;
 Thu, 28 Mar 2019 08:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190328035001.26276-1-ming.lei@redhat.com> <5258cad3-b324-660f-589f-73eb7fb8fa04@kernel.dk>
 <20190328150320.GB9265@infradead.org>
In-Reply-To: <20190328150320.GB9265@infradead.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 28 Mar 2019 23:31:52 +0800
Message-ID: <CACVXFVOOBerm38vmZjhvDi8OKdyX_sW0jU1tTr5Fp=qahY+Vhw@mail.gmail.com>
Subject: Re: [PATCH] block: clarify that bio_add_page() and related helpers
 can add multi pages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 28, 2019 at 11:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 28, 2019 at 08:21:55AM -0600, Jens Axboe wrote:
> > This is going to create a needless conflict between 5.1 and the 5.2
> > block tree. I haven't pushed the 5.2 tree out yet, plan to do so
> > this week after I've pushed the current 5.1 patches. Can you respin
> > this one on top of for-5.2/block when it comes out?
>
> Can we also drop the parameter name rename and just add the comments?

OK, I will drop the name rename change and send it out after for-5.2 comes out.

Thanks,
Ming Lei
