Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E3EC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D261611AF
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 17:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhDPRMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDPRMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 13:12:49 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40AC061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 10:12:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e66so13245204oif.11
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYO+h9/pPElF5xRtH81qVcZRLIBEZanluS9s1mxpRmA=;
        b=MPOnwmZRVUdCIy3ydzrwJe8L4KiU4rnYvgplGLm7iZbFw188qql9Mw/jeq5k5v/xjK
         q4l1rL1lzOm2cz/CnbAeK06YG3xdEkBsidoaGxf3c9kZQB8P+LtDPHPusDNxYNv3koPX
         PrCvB7dtQypDYLnS4jq6Ue/pVJfHLMimQv22w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYO+h9/pPElF5xRtH81qVcZRLIBEZanluS9s1mxpRmA=;
        b=a/rpuBQMf4ylMnruzEtUg91Z3H8cTC0hTYz4m2B/sFighKJb2LK8Zw1i+C4QP9tUog
         ByjNUbQxHFVqSa85QdvDMXs6bfEIdyn8mDFxgTt+OHPYE/D9ZUMZyf3WOstd6FYREeoc
         H2mat663wqFCw9D/kLgMOdHavr4nKSAu3EgGcQZRcxp5MmhXxeTJXteVyfk/Fud4z3OO
         XijCvsqISibPrSJZT1TNy34PNi0CwnFxxsbqUtKXV5V5hI0zklj7sxsw8H6LCn/M9GSg
         Gt9h3uTtuL3KR3AG9XOxkvAqyGKRdEUKb5Z1aQ0ke/xjetYlsDx34oTEnAL3w9EooTym
         3nmA==
X-Gm-Message-State: AOAM531knBbRkGjdvXEGdUMy5uI0ENMqpVnIOXdCPtb7Wy7v7O2liQZU
        MBp4imeK1fSFSgReNZKjpppmRf+753Bbp1C3Y5bYyb/wiKPafA==
X-Google-Smtp-Source: ABdhPJwEmW6zsugZig1r7cYr2Qubb8k8Jjjo7KdKDJp/MA8zpRjkVORVHfwp3lqpw4KysSbWmmRLdCLAcRvcBDNZBzY=
X-Received: by 2002:aca:d556:: with SMTP id m83mr7394899oig.71.1618593142437;
 Fri, 16 Apr 2021 10:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org> <20210416165353.3088547-2-kbusch@kernel.org>
In-Reply-To: <20210416165353.3088547-2-kbusch@kernel.org>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Fri, 16 Apr 2021 10:12:11 -0700
Message-ID: <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>         if (poll)
>                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
You may need to audit other completion handlers for blk_execute_rq_nowait().
How to get error ret from polled rq?
>         else
> -               blk_execute_rq(NULL, req, at_head);
> +               ret = blk_execute_rq(NULL, req, at_head);
>         if (result)
>                 *result = nvme_req(req)->result;
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
> -       else
> +       else if (nvme_req(req)->status)
>                 ret = nvme_req(req)->status;


-- 
Regards,
Yuanyuan Zhong
