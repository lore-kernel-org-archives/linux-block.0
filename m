Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55B1C433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D47A61076
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhJYBqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhJYBqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 21:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635126252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+DIrvZXbcAkXJ/OchXf+lha18HEJRfjUfzTN2XxsYY=;
        b=aEB1gwJIihCnQ/9Y+zGYCOmQboMqavaKxrMlWnfTX1LG5wgsJH6RmIw67lAQizQMOhIfwb
        XkKk9ylbb5jxp1AWX0D8whXpkspBoS2o6NNjcppJFDxMH/yqBIu+4joUUTqcHBcp24No7K
        fkn92uz24rX0ul3oT5y40EM9J2itq2o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-exnlklDeM92MhePHMNf5OQ-1; Sun, 24 Oct 2021 21:44:09 -0400
X-MC-Unique: exnlklDeM92MhePHMNf5OQ-1
Received: by mail-yb1-f200.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so15131276ybe.20
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 18:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+DIrvZXbcAkXJ/OchXf+lha18HEJRfjUfzTN2XxsYY=;
        b=iAawixqujqQsQdcHxg0UK6Wws2OZYUqXT3dGssDtrV8wO68eamn/MFQi7CJ8ScZlD0
         N6iMhNjSzD2HFO2l0dWjf+qvHxI2C4z8qbbKZjcsqqnoWevmcI3CmLdAXtxaieRqmT81
         eEo6KDqROoTrOuiJZ4em3GtsJgT9b+AjZrZXHQT7sTxG6j7Ivt2Z0IQ84WLl34iitGgg
         lCzgPlS+u2PXuge4HzuT6RdUN015Aa6z9xafN3i2GxYz45pojcPoqPQYkON/31LEPCQ2
         bezuyJsf05pOJRtUyzyCqoLMZ7MAumV9RHKc7Me2nAPtQaVZQ2rFK6I5fNeaJQeujtkQ
         qBUA==
X-Gm-Message-State: AOAM530LW/tO5/3ZjbXZJRjl+vCtQxjmveSpn54elyud7UEH5DkA+UBy
        xwDo2Vs7PrhYyyp6rJgQBqqzrleS/JTVj6fG8t26I7qHbauu2Mz7gztuatpgIPfQofnbpLTMPuz
        24bHbBX10/E0aZaS8kQaiUldVJ+IkXOL/WiEwOS8=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr14527346ybl.308.1635126248675;
        Sun, 24 Oct 2021 18:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXgAebb5EiOX8n3xGCGi7pF2GMyeviasxkrMIBZ4FLVtuGqvIhRrxVJyTEMj3M5GvFesVhioiqCJC2jL6JZ2s=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr14527331ybl.308.1635126248542;
 Sun, 24 Oct 2021 18:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211021145918.2691762-1-ming.lei@redhat.com>
In-Reply-To: <20211021145918.2691762-1-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 25 Oct 2021 09:43:57 +0800
Message-ID: <CAHj4cs8QB7QCc7t+bweesdZPOLmAXrwrj8yEnAtJPk80L_v1kQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] block: keep quiesce & unquiesce balanced for scsi/dm
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Verified with the blktests srp/, thanks Ming.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Thu, Oct 21, 2021 at 11:00 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hello Jens,
>
> Recently we merge the patch of e70feb8b3e68 ("blk-mq: support concurrent queue
> quiesce/unquiesce") for fixing race between driver and block layer wrt.
> queue quiesce.
>
> Yi reported that srp/002 is broken with this patch, turns out scsi and
> dm don't keep the two balanced actually.
>
> So fix dm and scsi and make srp/002 pass again.
>
>
> Ming Lei (3):
>   scsi: avoid to quiesce sdev->request_queue two times
>   scsi: make sure that request queue queiesce and unquiesce balanced
>   dm: don't stop request queue after the dm device is suspended
>
>  drivers/md/dm.c            | 10 ------
>  drivers/scsi/scsi_lib.c    | 70 ++++++++++++++++++++++++++------------
>  include/scsi/scsi_device.h |  1 +
>  3 files changed, 49 insertions(+), 32 deletions(-)
>
> --
> 2.31.1
>


-- 
Best Regards,
  Yi Zhang

