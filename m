Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B37C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 13:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiFCNWK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbiFCNWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 09:22:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539F101D7
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 06:22:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so10382102wrg.12
        for <linux-block@vger.kernel.org>; Fri, 03 Jun 2022 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGU+Xu8QDUfq/qo2/JU9T5aRAydFmE44aLPRPpmDV8U=;
        b=UTDloxPKOiYzDyUa4exszRUCqVRxzJPdzR7cknbEoHq7XBiOIj0oHC6t73uaYPSP/T
         6VEe1fRJj9ccZUTrmblRlhaCP3y0+BWGj4rcZZQ4Wn2+/zqxSIv4XTC973xIXU5zWlbZ
         SjZ4J0CuHQNh2EzL0HT1I8ATLbmAwpYth6amCF0yooDSCXeXW7Q++5KtNIczOn+zBqVP
         lSEHKjCo2ryOcSXz9sBOXPz359ki+Z8zoNZPU4Wepk0ftTAayPLH/Kt9WIVhFj2Sg60J
         sc0q/PPymEReagx60muboLoUooBz4yUS92MBPeYxU22tMZqzHuElkK9PwJAn4ffikQ4x
         Xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGU+Xu8QDUfq/qo2/JU9T5aRAydFmE44aLPRPpmDV8U=;
        b=CEnhY/HhIGnZPQs87f//Lro1dHslNebGILDRr9S8Saq53JWabFAxU4DJw1mWVN1dvs
         wYaUuUtkXAnF2J0cZj7SwHm6lPn8t6w9Sn5SfP/67AShgWrUmw6PHLHzQzwX9Z6aXgaz
         zz7hqauhF22JPvOUlIxYwnpKQVLhRpkVNNTq/YpAavBwWeF6exEnitM5wfP7IUaeZ0ib
         bvvbHFleRxJj+40Wh7BTFfgRJfu50iQgAsnxo7R4MHucnCJq5yWLXNpwdVPj9X0ZUu5N
         lu54rMmGXR1hQdAxm+549v2QvUUDyThngNpJgx3dmXq6gnOaBR7Pa0Pipi40VIvU4hqb
         rKMg==
X-Gm-Message-State: AOAM5305yXKPVJbZUuiIMQI+NHTb9Bd/03MQ1gsxqMeg7IdbeG2rSiqG
        1oWwCKVoXK2DV+Wziy415fpW/gUatrF8cipyDGic+5u5T/K12g==
X-Google-Smtp-Source: ABdhPJz2bpzIiIssUgyGi+Sj5UOIu8e4KPDKeIwrTx/ae2bYxb3tVplj+QXqlERXujmxxeO3ewzMP8IHP2lRQGiEiY4=
X-Received: by 2002:a5d:54cb:0:b0:213:55ab:cecd with SMTP id
 x11-20020a5d54cb000000b0021355abcecdmr6411216wrv.374.1654262524691; Fri, 03
 Jun 2022 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de>
In-Reply-To: <20220603124956.GA18365@lst.de>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 3 Jun 2022 15:21:28 +0200
Message-ID: <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you, Christoph! <3

Patch https://lore.kernel.org/all/20220527055806.1972352-1-hch@lst.de/
does indeed fix the issue.

Could this patch also be backported to 5.17 and 5.18?
