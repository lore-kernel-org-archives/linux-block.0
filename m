Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA9CDB465
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 02:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjJLC1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjJLC1D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 22:27:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4527A4
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:27:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so865267a12.0
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1697077620; x=1697682420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uAVbdAI/t4kp4F0w7o3XfjGK/x3xwElaYSG4Wap1s0=;
        b=SGZe1AfUk0omF01bhlOoqzan1SZglYgEK5f0qkT2MBckNIayIYVb1mqNJfgJx1ZeKN
         0z9nM6GW998cDVX2c3uGqd82ToPSR22Q054CC1Fk0fkTF5KQqBbypONRlT+pWGQCV4kd
         ZdchkeLjM0DqoD4uxDHpkW3O3+XJy0pS8Lv6dxbSRZfEt3nI5EibJYpYXGukIxt8xRAe
         SdVOjI44RBSfSeT/Gb8gfhkcg3AsmIi+rd6XgN0L0vvA55ulCJT9PFs5XZdaLMELNK6F
         uDgIABmIQ63JtXkeXvVNfWOyqqJw+NzwrEcvl1E6gLpDBkNK8ycUfGjRmEiPCXcPRwh+
         sSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697077620; x=1697682420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uAVbdAI/t4kp4F0w7o3XfjGK/x3xwElaYSG4Wap1s0=;
        b=bF6CZRpnCCAI8/N9efRWoiaITXm22wQp2jBSQStD5HjBqfzUWBHZpY7xSJ+Fj8ulkI
         fUKkQLeOuxWUaYWoEiQHvu12w+lsytV8iwDcd5lDSVJWLFnOfnS01L9AWOoaSP4pn6Xm
         Cz+ZjkIixqWEpAm3b3p8eRobJS1TZMfuYuNxlstrk2iKQJuVkzBOXGcErMfz6GNAgn3b
         73QgEQSSIvINX/bnk/Sv4V0UxQe5bkh//CQeJP1wyJM9FYgoyRqnaaiQwuovzrZMteFZ
         UogmeTunCoXASg4jKVw3ZsPqIkDy4EhxTywIv+r/Vi5V+r5L0pac2CYPX70fCb4y/uKf
         0D6A==
X-Gm-Message-State: AOJu0Yxy5ii7mhzOIKwHwDGRN5iE53Ojb/nJVCpVk3XVUWu5dHIT1FZK
        bgA1qq9BEurnsxNHYt3j2W99mymp9629Vn4O8EuYfw==
X-Google-Smtp-Source: AGHT+IEBboUS4cwn4e3Ys9mXQ4ZCkgfLdr7atTruR6S+lBb7qdwzHO/3JSrHZfVGLZdiOBdEoTiN3ePEBse1tsA5adw=
X-Received: by 2002:a05:6402:5194:b0:53e:395:59d with SMTP id
 q20-20020a056402519400b0053e0395059dmr726299edd.8.1697077620310; Wed, 11 Oct
 2023 19:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231009100349.52884-1-yizhou.tang@shopee.com> <cf850508-498b-4748-955c-382906eff676@acm.org>
In-Reply-To: <cf850508-498b-4748-955c-382906eff676@acm.org>
From:   Tang Yizhou <yizhou.tang@shopee.com>
Date:   Thu, 12 Oct 2023 10:26:49 +0800
Message-ID: <CACuPKxm+YtdierSLCTiqn3qEcgexM6O7AwVQrgSGq5mz8bJDog@mail.gmail.com>
Subject: Re: [PATCH] doc: blk-ioprio: Standardize a few names
To:     Bart Van Assche <bvanassche@acm.org>, houtao1@huawei.com,
        jack@suse.cz, kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        chunguang.xu@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your suggestion, I will fix it in the next version.

Thanks,
Tang


On Wed, Oct 11, 2023 at 8:05=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/9/23 03:03, yizhou.tang@shopee.com wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
>
> The title of this patch is misleading. The title suggests that the
> user interface is changed, which is not the case. What this patch does
> is to bring the documentation in sync with the implementation.
>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
