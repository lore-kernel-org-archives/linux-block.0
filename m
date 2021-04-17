Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D033C433ED
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 02:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2576115B
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 02:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhDQCFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 22:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQCFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 22:05:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA8C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 19:04:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14so10101069pjl.5
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IjyBsGbrhD0e8ChSUJj1DeWndggSBU7E89gn0IpFmq0=;
        b=j2I2r4+mslqU2OE9WzJ9CzDAO6bqm8kWu3ZWUVlUsVDbooPrJ7iFX1N1XuEWbyGvbm
         57BJEjxw+uQRn/MdPmDs86Pila/or1WwCI6HtkxT4Ue9oHczJu91w3hzYFOQ2dOBflvI
         ea0jvqO8pTBr7jKqW1tV1Q70MlNtSqgB8aOPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IjyBsGbrhD0e8ChSUJj1DeWndggSBU7E89gn0IpFmq0=;
        b=An2IHbzsHQa4dQAd8xqu7rSlHaod6tjLYV4WVrbnFIY/GDbaHIH/hWLF/Xcl4wxJSk
         8aFF58PNlxjPthMK6wnYLus33/4ZVMlD6fQl4tvjlAanMcrb7Vikup0JrD4V6zWIfLrQ
         aEBPJNPBdSDpxdzxlGbjywI8d2/BaC0uMVC0i7hzw7xTKMS7FxtJH6ixEjLJ6P8DUivT
         AwpTN/VPh48nsbJQXU4XZN8rs4jiG3q39dWe1dUCec9aGy2THZHtS5BzvF89kCt1+w7s
         IZ2ZpAvIVcKPtFRc/czGZ7AxO+gGrnAse4Shqx+w0RP3D8M9ZG3GjmOCDil4I6uHo60k
         Xu2w==
X-Gm-Message-State: AOAM530ikyMGDmbfRnvihl1oCHLOJ5XjRULdh5oTvWoYIYQURe/6+LX8
        CX9EDsLJgRUaqSRdowbjgtCnW6Q2X2VRWfQNMeTuHw==
X-Google-Smtp-Source: ABdhPJxXhhQnoqZymujAJYq5ljJSCbqsZCna52/jrjw8cw2dapSGSWqudVT9J1LPKzRiaqI7lmjeLkYZcolY58PQ+a0=
X-Received: by 2002:a17:90b:d92:: with SMTP id bg18mr12908519pjb.155.1618625082647;
 Fri, 16 Apr 2021 19:04:42 -0700 (PDT)
MIME-Version: 1.0
From:   Casey Chen <cachen@purestorage.com>
Date:   Fri, 16 Apr 2021 19:04:34 -0700
Message-ID: <CALCePG0y1REA8xXX1ymTwAZhrbSyUh41zfpOmFQViuyPGf5ePg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To:     kbusch@kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > >         if (poll)
> > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > You may need to audit other completion handlers for blk_execute_rq_nowait().
>
> Why? Those callers already provide their own callback that directly get
> the error.

We should make sure all callbacks provided to blk_execute_rq_nowait()
carry error back. i.e. by reusing rq->end_io_data.

>
> > How to get error ret from polled rq?
>
> Please see nvme_end_sync_rq() for that driver's polled handler callback.
> It already has the error.

nvme_end_sync_rq() currently doesn't store error in rq->end_io_data as
you proposed in patch 1.

- Casey
