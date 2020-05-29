Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67917C433E1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463C920721
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTNbrma4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbgE2DnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 23:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbgE2DnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 23:43:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB3C08C5C6
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 20:43:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so1559711wmd.5
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVd4Mrs1U/5A2IfnCC8X5EEtHjPOE7HxiGZ1sl3wvYI=;
        b=NTNbrma41jWb9ZxdhkCC2cNhYh29W7WYsx5CnIfy0X82s6PEJc8ev12p2Ui0F74tM+
         QSrhatHaEmpCZJ8uosoqWhazybAtGUSJeecjXouuf3HMo51gyCz4R0EmHGOxTkw6mJLu
         InFoAWgn+5/tj+jtgBOLJFSC6coaxNgy9FpcoHHf3LIUYPj0mxwUx54V4MoBk68p08bb
         U+PIMfIJZ9Z2xA7OUzD+wVcGXWKaPjb0p9hle6wZ9CtK7VNi3eGbw3iBgPOoyS/tYRZ7
         iXtlRaZMYiw0TK4aOcWSC1alWil8zbK/CjgBrQO9cwl6CRCFop/w4+YgO6Zv9hJ+w4Hr
         /41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVd4Mrs1U/5A2IfnCC8X5EEtHjPOE7HxiGZ1sl3wvYI=;
        b=IRnmHlDk8urEv54kkvbd94MgBP5eOtJC0nRqJW7KQCcETl0m7k9aGZAP443H4vUN2M
         bTQWKGdAhtfWy1adSleOnr5ety5HnhEdmNKnd2PY4Az3sQmNwSZ/YqnPpK369ACTlifD
         9VERd/nzh4VU4FBA2N0SllV26jI70kQuQjmwCxvPuAkwmQM346RnPbSYW0f/VJD5TMJ/
         Td/1rScPf8eH9ThlQoeud1zxAJmNReg4474RQQ/wjwyurjXQLIM5aTI3DnzekVwQ69vz
         f+ysHz5yaIu3UI5O1F6GodnIVFp/5/nz3LmsGgqzGkJJrzeCbKpJVIHjtt9hEpwrvZ42
         Ut5Q==
X-Gm-Message-State: AOAM533zDQik4O3REtNTdFXf7BXBekIg7S33h3xxoBjWbAi2thKTBR5p
        YDQStvS4axicTebPYhL1eTZy8l2iqCzqAj8LsZI=
X-Google-Smtp-Source: ABdhPJxHB+sKYUh9DfAl0ytD3Fg6TyhqqVHefR8XB+OU7FR6SA4N5F73MJUDnCyS4z2o6nxZSW/e3697tJHqe40OWrg=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr6251862wmb.162.1590723792990;
 Thu, 28 May 2020 20:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org> <20200528153441.3501777-2-kbusch@kernel.org>
In-Reply-To: <20200528153441.3501777-2-kbusch@kernel.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 29 May 2020 11:43:02 +0800
Message-ID: <CACVXFVNTMeyM7RrBuirSUXPZvDT3QvdoxDJBc4RYBuUdX2kJYQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 11:35 PM Keith Busch <kbusch@kernel.org> wrote:
>
> Once the driver decides to cancel requests, the concept of those
> requests timing out ceases to exist. Use __blk_mq_complete_request() to
> bypass fake timeout error injection so that request reclaim may
> proceed.
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..f65a0b6cd988 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>                 return true;
>
>         nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -       blk_mq_complete_request(req);
> +       __blk_mq_complete_request(req);
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(nvme_cancel_request);

Looks reaonable,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
