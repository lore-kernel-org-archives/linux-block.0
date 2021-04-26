Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5799FC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D84D61263
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhDZGdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231816AbhDZGdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 02:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619418759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ZMGb2xqKw5kC3fxalGJHU2xVz4gwBTJicM9Dy18l+E=;
        b=J7hzG+4YVN9PcWfvMGzjQCYCIixGwm5XfZFmcoWfaIK6BUOc22bP8tOWdVX/YzoiL5homS
        y3SnOp2JZ0KBCMTOMmJH3qViSJ1jkiHWFNDmPUrxdYbLZQrfoa1za/K/1uyje+lPQIL/Qk
        JeiEg4LH/vAyjO7dQ3x9ID0gLcyPR4g=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-G3y_ybkTPC-AEcA-N0TtMw-1; Mon, 26 Apr 2021 02:32:37 -0400
X-MC-Unique: G3y_ybkTPC-AEcA-N0TtMw-1
Received: by mail-yb1-f200.google.com with SMTP id c8-20020a25a2c80000b02904eda0a22b5dso5691777ybn.17
        for <linux-block@vger.kernel.org>; Sun, 25 Apr 2021 23:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZMGb2xqKw5kC3fxalGJHU2xVz4gwBTJicM9Dy18l+E=;
        b=X4LfPPMpk77eIIwRGfEGSvpivrTO6txkYU9dsu1ZIhYV7E1bck8DOSv80b1tbG05pb
         rnOHxZ9Y/6eOLwlq0kCsGU3cnWfJjfjB0uSKzmDo3y7iZiiEfNk2PvSHkplJ0afd9rtn
         C0iJTtQyWzPGTFDdIBj1qhkmK/B193U9IF5Dw+tdSpMu8fN8Arfv/AkI2++O0o1nyKWs
         MWL/VWVByX3Lg+CloSe7407mMRCMTQgJHeoPyFtFkJ5TSSAwXJoqboncJvOuA7sivcxL
         lTywQjDt5uNKi2orwvQMbkGJTnB2UDqjbemLyHtGx5fX4Pkwklk/TO+OdFLN2gdUsxvr
         VxSQ==
X-Gm-Message-State: AOAM53166v9pkzSCCLg9L1uJyZ/nZ/j/h5+slUhNB+AARWr3PciwH103
        OMpMVTLLaiZwvBt3aMSdlK/v7ALr2X0LqjtFdlhYWsYYG29SlBLWdSpp13C5k5QYLaVXdj9F8tt
        oNJPGu6Gj+YeaBeMehs/REAWaDNLCylRlIYyhAzo=
X-Received: by 2002:a25:24f:: with SMTP id 76mr23038916ybc.124.1619418757231;
        Sun, 25 Apr 2021 23:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTBuQDbrgExEF/QLECRrb98F0nnwbw0+SgdKl89YhgEjwxct1jsWjgPfvCDND2ON2yusFI4CLnja3KtGH6dDI=
X-Received: by 2002:a25:24f:: with SMTP id 76mr23038895ybc.124.1619418756959;
 Sun, 25 Apr 2021 23:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210425043020.30065-1-bvanassche@acm.org> <a6d1b5a0-01ca-5f17-d7f1-31257457c13f@kernel.dk>
In-Reply-To: <a6d1b5a0-01ca-5f17-d7f1-31257457c13f@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 26 Apr 2021 14:32:26 +0800
Message-ID: <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens/Bart
CKI reproduced the boot panic issue again with the latest
linux-block/for-next[1] today, then I checked the patch 'bio: limit
bio max size'[2] found Bart's fix patch does not fold in that commit,
could you help recheck it, thanks.

[1]
Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
            Commit: ffa77af5731d - Merge branch 'for-5.13/io_uring'
into for-next
[2] bio: limit bio max size
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=42fb54fbc7072da505c1c59cbe9f8417feb37c27

Thanks
Yi
>
> Since I had to shuffle patches anyway, I folded in this fix. Thanks
> Bart.
>
> --
> Jens Axboe
>

