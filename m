Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13166CCA482
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGOTxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGOTxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 15:53:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E06393E
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:53:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r2so7119344wrs.3
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoB4WlzK60FfsTcEbS+2/+Q3Hn7n6G9AnefRUurVRPY=;
        b=MmkNJgf4adqUSub9F1axftbHk9wZnHA4JaaalePnEyJ7EOgvM9CSTIp7CslsWNpNom
         plt6nc9oFiSxD00JMKi/5EOwlmXpWhKKLPmqkun4FYoVbVK895cQT7S7+Vd/LigWiVty
         pN/RxT5jtb8En4Y+5s4RcIHCKbo0881QzLzF3pfwo+o47ENo67rzFrmDTy9Zc3R8IWX5
         fj16Sg0PozOZ9dI7mu5B3vnG008Uj4/3EkRx7ioJUx3eFytLGngXn6gs/L95Z/J/9qMT
         3w0+JVJ/efmtAfMjwzJYofJ74Yu1uiMkuviDV8AUe2bH7M7ZedeZ8J4z5oYXYh1pzcOs
         zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoB4WlzK60FfsTcEbS+2/+Q3Hn7n6G9AnefRUurVRPY=;
        b=cQMuY4HMVp9U7N1e6azhhUfWq7hcPqAkb5tVbjr7AA5FyA4iJs/3rWMcdi7ixnEk+w
         ROyM6CqVL/Io9V7+IXSggmCDhA2f6PHJXoU9rp7QGtuDgzumrIYoVLOKytNyKprhV6Bf
         YKxncf4w9Sv/Fp4KYEBSShDZv4VuTsaQAKYmMQ1/8Se0FZOU+2Az4CZaqUo77yuxHIzs
         sGV2kk2CpowsriT4aLjESq+edc0Br0cBbKCX3Lvfo+l97/TQLuvEBJfueVaD1FuSfd0h
         62wS8kj74miOqN12d4gdCvePgKJjLcCQ52q51YWOS/NpTPkhvT7v2rOSBp89IgociQXM
         MvxQ==
X-Gm-Message-State: AJIora9tSt7Ee6VxdZ9PDFu/NyBhl/A/+TJVjAnX65ZoXKqjnloppOJJ
        2aqHlBLchBOnitIj9jLj0BWwFrHddA4rpNct/ICC
X-Google-Smtp-Source: AGRyM1t4EF/iYxd2UkC/st4fF7/g1qJCRBqTVLY6gX5RFKjWehP/FkVvPuh7my6+DKGsdqn3Q8a1Zc/g1cNB1UFzXX8=
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id
 e5-20020adff345000000b0021d6a266d8fmr14412309wrp.538.1657914783213; Fri, 15
 Jul 2022 12:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
In-Reply-To: <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Jul 2022 15:52:52 -0400
Message-ID: <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     casey@schaufler-ca.com, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 15, 2022 at 3:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd"), this extended the struct
> > file_operations to allow a new command which each subsystem can use
> > to enable command passthrough. Add an LSM specific for the command
> > passthrough which enables LSMs to inspect the command details.
> >
> > This was discussed long ago without no clear pointer for something
> > conclusive, so this enables LSMs to at least reject this new file
> > operation.
>
> From an io_uring perspective, this looks fine to me. It may be easier if
> I take this through my tree due to the moving of the files, or the
> security side can do it but it'd have to then wait for merge window (and
> post io_uring branch merge) to do so. Just let me know. If done outside
> of my tree, feel free to add:
>
> Acked-by: Jens Axboe <axboe@kernel.dk>

Thank you both.

-- 
paul-moore.com
