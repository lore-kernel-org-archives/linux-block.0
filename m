Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F433C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiAZN5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbiAZN5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:57:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7004C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:57:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n8so22789201lfq.4
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlwWjyfotkmfk8dQ6xD9rHPkaDtrnYCd/riWpoI/3oQ=;
        b=MNtDjoG7nls0UBHQ8euyPAgmdWtplH6jibNg/7Eu53LzdL/mQHCK9iRa9+AR721NJd
         uipCn6/bOqxOiR6LghKEeMav3GNdY557WN8jLv82dqEyVdCNU6/nrByVrPvjR6/sy82a
         3aq0INNQNTEz9zCtK/MWmNnXpyfvS9YB0vzCKG7rG9vlXr7//c4/P2odsADi2tFzsF+D
         2Ht8FNeWR6k1u+tPnamzbUM8Erxyt6uHasJ6LfL2/l7dofVJrUru69yd2LV7KGvTHZiG
         loAKczaCmMA05WfWVU0ond0ddtc+8naKDfH0olSDOouuZDGVeX+0Cv+GARrI/INyiqr0
         sYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlwWjyfotkmfk8dQ6xD9rHPkaDtrnYCd/riWpoI/3oQ=;
        b=ZMjXKVRDbsFKX0k3HVyBAvxE2X1OsauK3GEkOMC27gp8pYgYz4Xr0CD5EzbfSmPGp8
         YOc4PliZe2TEITExjNBGAPUFsHTc+QKPc7WF+IFG0qGqXHmHfvSbeFqkoC/iO4NgDgBL
         aa7g1ZC2I5514e8zR4+8ehUW0JFmQ51YBXMqCMzFsy6xn42fofJdgWpaZej0R6m9ijIy
         k8f0D2S3O7Om/UNHLwcQeEF10/2AgWMJjG4Vo694SeAENj1YmvwCt5bnDWUePiNY7+ZO
         grpOZyM3ioMQznDL9rtz0UCw2gNjBVtzXTCH80I8bwJzuJDFYWuCFS9MzCnhY7tplY8t
         jaTA==
X-Gm-Message-State: AOAM5305zxIOasfo4x0a5dU+pgAYKdWiP1dgCEl/B34+In21pt+V0uZE
        ElajwwxRqpqabZaQKse4hMCi030iFBjbpzu5tw1rwYFLZFY=
X-Google-Smtp-Source: ABdhPJyTB77TAnQeFwy/VkOhL1t/PW3+N6Hhdhsa9dDPe2kqXHCUoCslul2tKPM+dlGRog9K5/sxPHoWNbYP6UBxPnQ=
X-Received: by 2002:ac2:4193:: with SMTP id z19mr19903433lfh.358.1643205432029;
 Wed, 26 Jan 2022 05:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20220114155855.984144-1-haris.iqbal@ionos.com>
In-Reply-To: <20220114155855.984144-1-haris.iqbal@ionos.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 26 Jan 2022 14:57:01 +0100
Message-ID: <CAJpMwyiF_BpE9=fagomhdWAs7DsWOSMZE0GjaB-RbP4=wc0sKA@mail.gmail.com>
Subject: Re: [PATCH for-next 0/2] Misc RNBD update
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 14, 2022 at 4:58 PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> Hi Jens,
>
> Please consider to include following change for next merge window.
>  - fixes warning generated from checkpatch
>  - removes rotational param from RNBD device

Ping.

>
> Gioh Kim (2):
>   block/rnbd-clt: fix CHECK:BRACES warning
>   block/rnbd: client device does not care queue/rotational
>
>  drivers/block/rnbd/rnbd-clt.c   | 15 ++++++++-------
>  drivers/block/rnbd/rnbd-clt.h   |  1 -
>  drivers/block/rnbd/rnbd-proto.h |  4 ++--
>  drivers/block/rnbd/rnbd-srv.c   |  1 -
>  4 files changed, 10 insertions(+), 11 deletions(-)
>
> --
> 2.25.1
>
