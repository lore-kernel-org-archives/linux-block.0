Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62535C43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 07:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiGAHDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiGAHDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 03:03:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA865C6
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 00:03:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v9so1489484ljk.10
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzGoxlloW/Tws0uB5qKakVTUVgLN1VSSjTDGzgBbeK4=;
        b=Y5TERYM1KO4GGyrxpePRMjK1I/B3OjmOWWVVJrwZbS5v/A+JRd3ymTog0e7f9KLa1M
         v1d0ILM6qPxanDRGGkF18ogf7iijflAkbtxgnAwvxKb0NCaEJJHPIPKgniZUxfn93vYZ
         puOQ9DChEJ8x9oXIkCSNx1XBvtCdgpE0dswfWslgvEUa+0UOhXIl59GqNb292YHlidzi
         tVLZdkEGdCpwxkIpFv7GR3OaL8zoxtlF0ljt6n2T8TOHiYu1+k5LECPuwiHGEtkDOR+s
         dUCWtlMdBrokhUUt7kroRI93iPEG5umNehcYF6qjjgJ0WoBJ9+hbwy/RXTcaMcnzvZnW
         gAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzGoxlloW/Tws0uB5qKakVTUVgLN1VSSjTDGzgBbeK4=;
        b=EB2u1EeeWqBD/AvdQRizHa5OjGdCjflmn9AhzYv6fuEIJJQt24gvYRHerM6vkSKp8u
         a8/36IGhcazKrjtlulGWPOiqnYDVpMgaTYr9+qbqFO5Zznxg31x4zGposd8NnzYR1BBU
         XWuccgqvcjcuFrGpo19ZfDQlCEGOdw7pJy9o7FYAoYdHwbPVNQRwv6CcpvQ3TzIiXsvf
         4WOXNKfCUar7/MZU2XswnvCdoefHRaBnsTesc9KLF0E7qO2cNnbbzP+Kj1JqmYKoknbX
         yr8Vf/i9SRi1Wj9R09EDuKzK2W/Ww/P8t6HneTZ7qUiG1RpftE0jXqo1hu/24+r6Vs+d
         CSYQ==
X-Gm-Message-State: AJIora+zxFnjA6YYn/JqdYs6e8b/tyxzzsEGTwJVjWA0FMRmeSKfOUX0
        jr1lO5zZPZsGUPTgwq7qDVubqbsKo5Cw0LU/m+s=
X-Google-Smtp-Source: AGRyM1uCZPHYSAuuTDM0k+PDr2scrPsQwfon3EPxQHMobJm2gWmkW3Rg6lxq7418ApG4tqXBLnoXiKt8NDXnMY1pNnk=
X-Received: by 2002:a05:651c:1543:b0:25a:94d9:7d3f with SMTP id
 y3-20020a05651c154300b0025a94d97d3fmr7230644ljp.330.1656659010952; Fri, 01
 Jul 2022 00:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-59-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-59-bvanassche@acm.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 1 Jul 2022 16:03:13 +0900
Message-ID: <CAKFNMomUbnbXNng-RL5JdNG8pYXc_y7r68hORnhxivd-tEs75A@mail.gmail.com>
Subject: Re: [PATCH v2 58/63] fs/nilfs2: Use the enum req_op and blk_opf_t types
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 8:33 AM Bart Van Assche wrote:
>
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags. Combine the 'mode' and
> 'mode_flags' arguments of nilfs_btnode_submit_block into a single
> argument 'opf'.
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/nilfs2/btnode.c            |  8 ++++----
>  fs/nilfs2/btnode.h            |  4 ++--
>  fs/nilfs2/btree.c             |  6 +++---
>  fs/nilfs2/gcinode.c           |  5 ++---
>  fs/nilfs2/mdt.c               | 19 ++++++++++---------
>  include/trace/events/nilfs2.h |  4 ++--
>  6 files changed, 23 insertions(+), 23 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good.  Thank you!

Ryusuke Konishi
