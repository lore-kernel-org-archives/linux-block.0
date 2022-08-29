Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3595ECAAD4
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiH2Mdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2Mdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 08:33:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63A19C08
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 05:17:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bx38so7819498ljb.10
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yuHdVt0/eo9ZST6J7H4oWl3nRFDUlOktmfCexGEC3Vk=;
        b=SVn0jn695/IQMfX2BtfxLOVQ8Y7pakyvV+4srnNkCKBYoAyH5T0HsIImchR8s+IzLT
         MlkI3FekLG4p66s9SKKbJM8hsbFs0buGOFovO3To8OYc8HB1AIVedPZINIWqBvQkO2jr
         MeLi1YChRNQMgKLZzWJBz87c/wPks1WR/SIazNTei8vq676tqO2VSoiSwbrp9Y1LViAY
         vqcneFJUoKNyLs/1Atn6RqzLdhZSJ341j+trxCPlTLX8bBesTHUEvTXxEVgfDm748TF2
         mVjudU6KRF7JeGtKMEXGfOqW3ZOqY+iwlIV7j+uqaZvqrLKNpN0UVyH2UtwaRRKqmNcb
         x2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yuHdVt0/eo9ZST6J7H4oWl3nRFDUlOktmfCexGEC3Vk=;
        b=go7wVWDz//FOofIDtWBHA5GRdGQdzl9KhkZf+1i9ZVxI8n91Fg/dmTmtngjToElCRc
         YbruQHMTrKaPNyHNecZjoVy+4ou3RlkAfG+NlSIM8psJWxk7lWke3qA4NIQKDs+Nwzo9
         RLMVf0XydvYvvzFCXUMxvp1+/+MHucMkFYF8V+xXI+XMwE4uZYOU63JpJHE316KKC2UM
         zvO6XUYXC1IMJo5PtkzBA/wt7HPpzexORLyPy6D6TPBU9d/T1LGOB7pSI0eWBowFaMFn
         URea1JgbLkX9N+EYMya+U6Q1TSYu0OuZ/BCko35Fll6r/Nlvf/u6hE0ea5TAe+KgkG4F
         UZ5A==
X-Gm-Message-State: ACgBeo1O2B4tJ9nWVUNgeAY+RFNo+tN08p7GvshR5TpJvQdcg7FagRwc
        YdpMF9pKe0GyoPD7oCI0IjMqY600UWfWSF8xRlY1wQIYa+Y=
X-Google-Smtp-Source: AA6agR4rFvN/HFYBxKgvh5InjZkk/uG8RWVmM8EPYr7XL1XqXc3hzMaYwMooJflvjwGn4sqk6i0xL9VnhWwE+Mfero0=
X-Received: by 2002:a17:907:75ec:b0:741:484b:3ca4 with SMTP id
 jz12-20020a17090775ec00b00741484b3ca4mr6916830ejc.316.1661771588049; Mon, 29
 Aug 2022 04:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
 <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev> <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
 <c4fb6007-91f9-6d2c-4888-d49a08dd297e@linux.dev> <CAMGffEkAYOJPAPaHDspk-JfJNNF96pHWnrCwYzROFZxPBBO+Fw@mail.gmail.com>
 <09317a03-4e29-0f8b-4d7e-a2024c9364f6@linux.dev>
In-Reply-To: <09317a03-4e29-0f8b-4d7e-a2024c9364f6@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 13:12:57 +0200
Message-ID: <CAMGffE=kUGmntpJSmtd_hTSTXPQxRfKquBsggBRn6TyrCKyiGA@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 26, 2022 at 4:02 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 8/26/22 7:58 PM, Jinpu Wang wrote:
> >> And I guess we can just pass parameters with register after remove an
> >> argument,
> >> otherwise need to push/pop stack with more than six parameters for x64.
> > I doubt it makes any notable performance change.
>
> I think it is called in the IO path (process_read and process_write) ...
>
> BTW, do you agree if the 'usr' can be dropped from rdma_ev given it is
> always
> same as 'data + data_len'?
in the current form, yes, usr  can be dropped. we can add later if
there is a need.
>
> Thanks,
> Guoqing
Thx!
