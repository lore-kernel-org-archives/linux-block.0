Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85CC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB0421783
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAr3PctE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKLTJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:09:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33237 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKLTJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 14:09:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so19098636ljk.0
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FPgM7SKFCN9msWXuyWzvDA0G+gWYRF9TEdVYJj4UX4=;
        b=LAr3PctEvf0Qp97K3E1zPlt4STnZtx88R2lMOGizjf8Qv9n3YYDLOdCeA6Psx+7cKw
         5JREarMdzn92YHkL67Rqpw4BU4RaeAAWEl6NKOMIGvya/yqlPa33AxGrCE9r/JOsXvcf
         2XZUsajCtPg7eoVXew31WlRhJKOw7o705SzR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FPgM7SKFCN9msWXuyWzvDA0G+gWYRF9TEdVYJj4UX4=;
        b=YBSxy8CYOAODNWWqaYlmZPzpYQ22vsawpa8Vrl3wXmxqIpZV3I8quo9jq6P3HEci2E
         YJGMfabN9fu5RRpk1t6L+nmHRxnKggUF6cluhXdBtvZ+wXzriof1sD11XGGaHvrJnQka
         8566YYOQ1Z+oyV74My/65TrWufX/zWjAOORp1ghUqjUdfbejCA+IFxBUV2L1NIBlBlfF
         1dHiI0iYRnvz8u9LD8WkZkyNyZddFrXgyxNvF74pQVJpC/5IOdcDgMGlFHw8CutDOhNE
         NUsLvLQVZJWkQgKMLasBkuQC4d1nzmdMp5n5O2Hc9Zq6k/eP8xu0L/+yz/efjSrsRnqH
         x8Hw==
X-Gm-Message-State: APjAAAVz3wbKb8Amhyi7JjSiM6u+wHalQX45ez3Iz2ruGu+1RMkQQVNI
        vvApLBCVRxeqFjs5/QYk0A9RUBXPgjY=
X-Google-Smtp-Source: APXvYqzjYgKZ20CPrkuAQn0589PoA+0TWzh6KHLpkNgqF3ob/n5LIUSnfoGrqnhfmH5ZhGt8Bl398w==
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr7241540ljs.26.1573585785947;
        Tue, 12 Nov 2019 11:09:45 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w18sm8679955lji.38.2019.11.12.11.09.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:09:44 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id j26so6682489lfh.7
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 11:09:44 -0800 (PST)
X-Received: by 2002:a19:40cf:: with SMTP id n198mr20776284lfa.189.1573585784155;
 Tue, 12 Nov 2019 11:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-2-evgreen@chromium.org>
 <20191112083208.GA1848@infradead.org>
In-Reply-To: <20191112083208.GA1848@infradead.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Nov 2019 11:09:07 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
Message-ID: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 12, 2019 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Nov 11, 2019 at 10:50:29AM -0800, Evan Green wrote:
> > -             if (cmd->ret < 0)
> > +             if (cmd->ret == -EOPNOTSUPP)
> > +                     ret = BLK_STS_NOTSUPP;
> > +             else if (cmd->ret < 0)
> >                       ret = BLK_STS_IOERR;
>
> This really should use errno_to_blk_status.  Same for the other hunk.

Seems reasonable, I can switch to that.
