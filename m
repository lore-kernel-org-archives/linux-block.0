Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E9C54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjA3Ovb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjA3Ovb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 09:51:31 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396E1E2A8
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 06:51:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 129so14346736ybb.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEvtFJQPulrkZV/QhUS2b7eZA6t1FKG+NUf243fMzo8=;
        b=k+9tMQaU6zoHpP+fpxi5OWD6hIzi6bR3xskQpIPNtLjur952NjxQjNQUo2DCbgfE1z
         1yFsgZF6mI42zmk9pdKJ3IiRai484ygIeMkBJxzPLfcpUfsf59qfZ2kd+vxVT6niETem
         sE3mDe8I2D7QX0s0LvEnskDwNi9gDKl82EI2B6r3w45yohUlSECDecqz4Zzip2CkB9Cl
         IOFOr+wJbvhRPXPnHsgdhILBuE09j4DWxxYAZp58yKA7PhHrsWg5CjfP6V4u0aUJWbTr
         bBWmTxhgmL3eghHghqdqW01R/OEdmCwAgq0UnLblj4w1TcksMlWP3nH2V+JPXZECJEe1
         eBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEvtFJQPulrkZV/QhUS2b7eZA6t1FKG+NUf243fMzo8=;
        b=vkYmdp1qNvEjSSbl/26coIoIfIFNcxA+x72SY9D3JdqefFIMrFy40RUmSd3lB+3Bui
         czIjbGI3WsEY9N98eApHKPH4TGQsc2qiV3NbaXJoIVn/sKbUV2OBfUXY3D+Jd8rXAtYz
         DysQAqe3NQ3adnqm+WvhOGpIGbIT2UoVsTEfK4/kljP43rBs50t6FQhMJBEmU4zKpGs7
         WXVd09Wyv+RZxBBBaJuVyMBltS1/9XeD/s9qrt8rloHbwZPDR9rlzmsyWgsRX4xDQuw/
         ZwhJz56eLTB+RvDaMphwvFVNnUrU0iwaOcmOq7PPHXcRC8sL+alcVhyq9fsupo/lh7tO
         P3WA==
X-Gm-Message-State: AO0yUKUGnBdWGIn2LjBVrKHR5dN16xLbiO5U3Uw6ogW6vFqTwdYFtGCj
        Za1rQYJQ5a7bi0FE80GC8H3ZnFwVjT+sZoklxBV0OPyCDuUJPQ==
X-Google-Smtp-Source: AK7set+DmIe7j3dOjIUAHsuKWG+Nf9Ts/6kB3gMISs2ovIESVYLF5OSnh2wEH25pcGyXaxyUNOY69zPTLYW8cD3J49o=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr1862087ybd.24.1675090289666; Mon, 30
 Jan 2023 06:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20230130121240.159456-1-ulf.hansson@linaro.org>
In-Reply-To: <20230130121240.159456-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 15:51:18 +0100
Message-ID: <CACRpkdbDxVcLV2JX3duKCQTNMS5-U8jJ4h7SmHYbwnUy1+TVug@mail.gmail.com>
Subject: Re: [PATCH] block: Default to use cgroup support for BFQ
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 30, 2023 at 1:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
> most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
> make it default y.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
