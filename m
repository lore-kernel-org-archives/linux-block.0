Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6BFC001DB
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 17:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHGRzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHGRzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 13:55:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BE51701
        for <linux-block@vger.kernel.org>; Mon,  7 Aug 2023 10:55:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583a8596e2aso44709957b3.1
        for <linux-block@vger.kernel.org>; Mon, 07 Aug 2023 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691430912; x=1692035712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RlCzFKNj2PLZtrDRconO+Ncogzp7Fz5t1sVouGvRFAY=;
        b=hQ1WnTzUldedGB8lRCPKEoaeLuFvbD/k9u0mNXh3ly3gMJu7N8NVV21hA6n0junL6q
         oxiSmBRroH02OdBGgner9gFn990pIHTanAtRdWN80/lHbo8T9EfdCzwx4J1eqJCQ+O7a
         LH5yE5ftlwI7BywP/sXLvUeSBeQk/7PH3IoQ2q+ObmzBTd7JCl09N4qyvSfvIH/nBPVG
         +N4fVsEcaJ0YXx9I0CC3nal7/6T01FWzAZRFPV9og04b5OcHuZaZXJ7c6BtdRFmpJaUB
         PGfK0H/QKN9mD1KXLtfW9HNcodhKKra3lS75KalFMtOAXlMk7iB2HPRCdSvT6b9QZe1I
         Sicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430912; x=1692035712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlCzFKNj2PLZtrDRconO+Ncogzp7Fz5t1sVouGvRFAY=;
        b=gvyAol0ILisKcKEwrfMFFVrgaaW61Y0JKqv/zu+jbv/6fcEVDum9OrFvmiOyleaHJR
         c5w84BHd+1wxjiKQVyDucNw5Zvcod9C8I3T9nLgqlHT/s3ONHP4hLWh6lbNnam7DUfs6
         vEG9Dlg/cEm6rvhNZYioWEa1ENj9PsyMQtlKH+gI4/AlfVJMuEYh2sF/MOH3yWDUA2Z+
         ijfqN6mY4TpoJpYfxt7QcN2zleGUb/RETqnmlqvIY+H8xzIw01mA49WROA2DVUAzfprc
         tOkKD3iJqrds1Ypv8cWgl+eUyc9ZRhnkzTK57d9hy8WLrmWd72+sFMidn4twJ6A6vSot
         eS8A==
X-Gm-Message-State: AOJu0Yzutdji6nnCjCejfNw2da+ITITxqLlrKXGRWOrXnF99mD3VHkbq
        h34D1UA+h0AHH2dXN02FTEgGiZjslrfn1XXMWD8=
X-Google-Smtp-Source: AGHT+IF5Ce1yonD0nOwgvcdw9qjEnYMDbsCE0lJy3vYjGlNkX/3UOoq1uZ81RGlcEoSrEM0dk8SYv08ML3WTpFRyDrg=
X-Received: by 2002:a81:a045:0:b0:56d:2c60:2f84 with SMTP id
 x66-20020a81a045000000b0056d2c602f84mr8419886ywg.46.1691430912283; Mon, 07
 Aug 2023 10:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
 <20230713135413.2946622-1-houtao@huaweicloud.com> <CAM9Jb+jjg_By+A2F+HVBsHCMsVz1AEVWbBPtLTRTfOmtFao5hA@mail.gmail.com>
 <47f9753353d07e3beb60b6254632d740682376f9.camel@intel.com> <bcd1a935-b6ce-3941-5315-197f6876379e@intel.com>
In-Reply-To: <bcd1a935-b6ce-3941-5315-197f6876379e@intel.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 7 Aug 2023 19:55:00 +0200
Message-ID: <CAM9Jb+jmjDOsJz=D7GEtah4xFamVHUFsruh4eW7VtO6A8yCZTw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "houtao@huaweicloud.com" <houtao@huaweicloud.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
        "kch@nvidia.com" <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >> Gentle ping!
> >>
> >> Dan, Vishal for suggestion/review on this patch and request for merging.
> >> +Cc Michael for awareness, as virtio-pmem device is currently broken.
> >
> > Looks good to me,
> >
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> >
> > Dave, will you queue this for 6.6.
>
> Looks like it's already queued:
> https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-for-next&id=c1dbd8a849183b9c12d257ad3043ecec50db50b3

Thank you, Dave!

Best regards,
Pankaj
