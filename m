Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1775BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 20:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiKJUdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKJUdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 15:33:05 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED14E432
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 12:33:04 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id s18so3684793ybe.10
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+ymxk/qsnbKhW8YJf+YIPXdWnFarr1o3UXzpt7/nQA=;
        b=jjCrpStI1FfNQhuzyniPwdY8XP1ZjB30bS2Bmt9EP5+LSPlXpFfXYsAPYbQYWAwF/v
         AzO20P58nylcSRe8RV3SwXV0KcZntyUyZtLRaYTah43QJC7LkBS0yPEYsrXr6SPglp5y
         3vY3Ehb6xcnGNhk5cPPpiBp7NRKjxlTBJvUaRqxJcL2MWTgPRZhICOQ5t0BOjSUYSpX1
         fEjskwTolJnfKYTDoZ0gfjKvRd8FHcUn16U6uESH2SfidI1d5MNHc7lXCbZmtVHwW9Pj
         qLRa3WQkVZTn3b5qNjX6kYeEQATMoKUIGXk79qHEhQuG6iSW32v7g4k87e7xi6u7w4yE
         3TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+ymxk/qsnbKhW8YJf+YIPXdWnFarr1o3UXzpt7/nQA=;
        b=rhz0RDAcT9Nw6k/vrDeDqDpjYFCyOYIpAiM0mPNnb0hXi6ig1LKlKKh9gjjKFEoaHs
         ciB6WPGGPGOIIkPxpOMsNyVzsGD8VsrBlZw1lMiWWjcQIa7/CaO5jxXi1GU9E1YYEtpJ
         qVU6rOLS7cW+vaKijgl7nYpGaw8GT6JdjivqIi1ytr2i6aoiG6+E/qiw4h0BWw9nQHoQ
         DreaIVg6gasSqJ3Fe0HdO7YeV75RYQyAyiStvT7yE7LlpucZZW1+14tZkmqBvHmd9+8V
         AY91AwlVetMebtz5O1bq9cey+KK2E2RYaE/UhGnUfWoQocFY6UjIVTWaMrhh48JkaXOA
         MahQ==
X-Gm-Message-State: ACrzQf10ZRg8Bk4yhJtAdpkac7EW+6vtldiR0F/utf3u2eFeBDsaeZBb
        Z/kfIXp2bIwYWo+tmAaWY6ceF8pj3XIPfwt0UBA=
X-Google-Smtp-Source: AMsMyM72OrWM16ASWQ0L39PC0FS2D2nEWuNTBlyxdv8KGIt0VihJF04Eb4kB4GXJpKzdfA0fV80i9pMU0lLAjXc0CUM=
X-Received: by 2002:a05:6902:191:b0:6cd:3a43:cda3 with SMTP id
 t17-20020a056902019100b006cd3a43cda3mr52919168ybh.207.1668112384084; Thu, 10
 Nov 2022 12:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20221110053952.3378990-1-dmitry.fomichev@wdc.com>
In-Reply-To: <20221110053952.3378990-1-dmitry.fomichev@wdc.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Thu, 10 Nov 2022 15:32:52 -0500
Message-ID: <CAJSP0QUa9R7S76SGB+d8cx0J4_0wRAQjQdxZnW4=y+GEkLPzPQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] virtio-blk: support zoned block devices
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 10 Nov 2022 at 00:39, Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> In its current form, the virtio protocol for block devices (virtio-blk)
> is not aware of zoned block devices (ZBDs) but it allows the driver to
> successfully scan a host-managed drive provided by the virtio block
> device. As the result, the host-managed drive is recognized by the
> virtio driver as a regular, non-zoned drive that will operate
> erroneously under the most common write workloads. Host-aware ZBDs are
> currently usable, but their performance may not be optimal because the
> driver can only see them as non-zoned block devices.
>
> To fix this, the virtio-blk protocol needs to be extended to add the
> capabilities to convey the zone characteristics of ZBDs at the device
> side to the driver and to provide support for ZBD-specific commands -
> Report Zones, four zone operations (Open, Close, Finish and Reset) and
> (optionally) Zone Append.
>
> The required virtio-blk protocol extensions are currently under review
> at OASIS Technical Committee and the specification patch is linked at
>
> https://github.com/oasis-tcs/virtio-spec/issues/143 .

This patch series can be merged as soon as the VIRTIO spec change is accepted.

Stefan
