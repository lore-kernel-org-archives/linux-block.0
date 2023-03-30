Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBFC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 07:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjC3HnV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjC3HnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 03:43:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646016199
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:43:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so72975032edd.5
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qxb+z0M56kXGKsGqUzmde7aSXJSNER5bkDSqRNFsW8=;
        b=UJBukVFEt5dB7HsMZhm8rpG6GkSrR6oamn4AyWhd8ZQPOX1GhBV/ZV16dR83JU1y/X
         N30JaFrz+2vGq5ca63TxcCERgT6qek7mqtmN81N5//AscM6N8cflImnSD/ZahG+4q0Xn
         9qp/XyM4ZMQRj7L0H7/4AehjvjsguULR7WeiMPvo+WNkpMojlq5AXSO5o21krpYdZ7B3
         PB9AZFZMuLkAAEJQVYvz3QY9bGxfNFE34InRWkd4v45XrEk3Mww05p5yDkBJhramLr+a
         T7lX9urUThW1psrr/JFE2xLVVKoi0OfuM7xGQ2KkdeGHTHhVMnrIjKr3CZ5s/MVVlIAH
         QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qxb+z0M56kXGKsGqUzmde7aSXJSNER5bkDSqRNFsW8=;
        b=qAwlkT9DJapb5VPpxAN7m40aWd362tdoUXzl5E3o2R8I04Rbxhp8OED8oFyXNurAkD
         yYKw0orgTLBP5HW93HJ19rP08xnGz5Y1BR+cvv11mg5n1W+6ZdVV9T2ovxWL8s2h2BWy
         cOGPRkHuchArDgfuVb8HSaHmg+l84HuF+IpS1N7ImQuKDnyfzwcYUIY993OzbqVXpbVK
         dYRXtEuJgAUO/ujV8qlkwIrQuNDAMFMyMP90LkwrPXpXrCfn5zrM2AlCTQHbELGo3z5j
         r2S9R535dJsoYYpfSopDZC7jth6FBXGDMZFSXTUuZZYtCC6CfBjOHvYE3FtA/eri2tcv
         wn9A==
X-Gm-Message-State: AAQBX9f1qL55eSr6zITE5SufuJUu6hgr8E7Q/Tqp1V2RyuAPNdPCt/mT
        utuOoAu9ZTQPdyzH8Fd9+kgWddxVyJWW7o4cWrge3Q==
X-Google-Smtp-Source: AKy350adp4S5XsudZey37elUZ5q0L0p7Iwz+j7h/yciRdtLAgVA0EL7LYgLVZr1SbfHf+UbmlaKLQyfCX54NppPfH9M=
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr11518130ejc.15.1680162192486; Thu, 30
 Mar 2023 00:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com> <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
In-Reply-To: <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:42:36 -0700
Message-ID: <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 30, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > In workingset_refault(), we call
> > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within an
> > RCU read section and with sleeping disallowed. Move the call above
> > the RCU read section and allow sleeping to avoid unnecessarily
> > performing a lot of work without sleeping.
>
> Could you say few words why the flushing is done before counters are
> updated rather than after (the RCU section)?

It's not about the counters that are updated, it's about the counters
that we read. Stats readers do a flush first to read accurate stats.
We flush before a read, not after an update.

> --
> Michal Hocko
> SUSE Labs
