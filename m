Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F47C77B73
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 14:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjFEOcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjFEOcv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 10:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D31A7
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685975523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LOUE1+edZo8CLP02ssMHBKJqlKpC7hvUhEkUiHsJl4=;
        b=QLzo1eFFl+ObvLDbLS2FH2rufend9Sb9+GiNTwXcS/trPDny4d5pZcnv97Iq1Vnk+dKBOS
        FTZo3sHDNEb47DHk6qix0c3VNt6wRLL/aoXdFLlo1vJS2Uvk1po1v1954Ux0XuE/6Zatsc
        mPpmgyIfKOIGCp7Ta3y87CjXU8CwJDE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578--pANpk6ONoumG9-mI7wuCw-1; Mon, 05 Jun 2023 10:32:01 -0400
X-MC-Unique: -pANpk6ONoumG9-mI7wuCw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-25667878a53so1664607a91.3
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 07:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975521; x=1688567521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LOUE1+edZo8CLP02ssMHBKJqlKpC7hvUhEkUiHsJl4=;
        b=Z7sg8G2RA4LaSYrDDRBBs12hYlkIrN6I0qGGtG6kips8r4YbyzxPEsuDYX8C1w8ds0
         fMlBxSeBqtGe25jiG+YtTzQcuEj1UbaXGgg93RXLvqmV1oy7r8TF1RKgRGfDSXEZRKz7
         CFhNH2zvX2Sw6eYj1X9QN30/vrT+AF7MdRJRk3JcU3MaDqLkYXHOmzQhmgUN8qOqCM2b
         VGPzFBV4ynNw7SbeLtjreTLT5EGRb5HsXHXotk5ZZveXpRe7U3s6g/8VgXNEQ33BmT0I
         tjA1HSUlszks9jnTpO+T4IXW7HsxEnrfLdiNqAgCrQVpjzeEpJdZv+jCIA6UrI+M7r/8
         R0cQ==
X-Gm-Message-State: AC+VfDwESXcFSYS6XsNKSCAVXbJBnJI7PN5Q9HpSkiLF4pXIEpjaJzsI
        dLWTmi9lyfBYNTCsZtUdrxRHwIafAC9mcIyub8miv39QKKzEnwhZzQpEDIrG6LPBimrFV7cHlZx
        xAD3Bhi2PbmuxoSgiHUM8b+zKRjQRI1AxhFduXRw=
X-Received: by 2002:a17:90b:1241:b0:24c:5e6:7035 with SMTP id gx1-20020a17090b124100b0024c05e67035mr3740245pjb.30.1685975520835;
        Mon, 05 Jun 2023 07:32:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79eo6F/FYMQnL0znbN05LlFP4162WJ1RiEELM6PG6eNAfkSk/s/IY1CZksWJQ9xwWpnmdlbar2+RMMM6vMzlY=
X-Received: by 2002:a17:90b:1241:b0:24c:5e6:7035 with SMTP id
 gx1-20020a17090b124100b0024c05e67035mr3740228pjb.30.1685975520512; Mon, 05
 Jun 2023 07:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230530094322.258090-1-ming.lei@redhat.com> <20230530094322.258090-3-ming.lei@redhat.com>
In-Reply-To: <20230530094322.258090-3-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 5 Jun 2023 22:31:48 +0800
Message-ID: <CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: rdma/tcp: call nvme_delete_dead_ctrl for
 handling reconnect failure
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Ming, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, May 30, 2023 at 5:44=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Reconnect failure has been reached after trying enough times, and control=
ler
> is actually incapable of handling IO, so it should be marked as dead, so =
call
> nvme_delete_dead_ctrl() to handle the failure for avoiding the following =
IO
> deadlock:
>
> 1) writeback IO waits in __bio_queue_enter() because queue is frozen
> during error recovery
>
> 2) reconnect failure handler removes controller, and del_gendisk() waits
> for above writeback IO in fsync/invalidate bdev
>
> Fix the issue by calling nvme_delete_dead_ctrl() which call
> nvme_mark_namespaces_dead() before deleting disk, so the above writeback
> IO will be failed, and IO deadlock is avoided.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/rdma.c | 2 +-
>  drivers/nvme/host/tcp.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..cdf5855c3009 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1028,7 +1028,7 @@ static void nvme_rdma_reconnect_or_remove(struct nv=
me_rdma_ctrl *ctrl)
>                 queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
>                                 ctrl->ctrl.opts->reconnect_delay * HZ);
>         } else {
> -               nvme_delete_ctrl(&ctrl->ctrl);
> +               nvme_delete_dead_ctrl(&ctrl->ctrl);
>         }
>  }
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..2c119bff7010 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2047,7 +2047,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvm=
e_ctrl *ctrl)
>                                 ctrl->opts->reconnect_delay * HZ);
>         } else {
>                 dev_info(ctrl->device, "Removing controller...\n");
> -               nvme_delete_ctrl(ctrl);
> +               nvme_delete_dead_ctrl(ctrl);
>         }
>  }
>
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang

