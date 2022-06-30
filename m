Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiF3Sne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiF3Sne (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316002CDDD
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B893A6226C
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266CFC385A2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656614610;
        bh=TpnUApIqSJfOS6SvivWLm1YHGUm/Vz8mXcpPPUEkPGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DGXZQX7dnNEINc20IzwTS5dvn5qDVweBLAOFBngc9y2mTeeGnLHRMNiRON/HBbAZw
         auUKvkPQNSbzVTFscp6SnFMe1ghytBLm4o8I8JZY3PweL5ncXhVrFOvjNt9qxDoal3
         a/UswA/stsKrZv3r+wL52EP93CAjwIyzldRYUoL/aRYhh1F2VBMLM01V6omc5htgOD
         h1ssW7JT1G8odQ3d/Liqy3UY1zcnIPSy7A/FW38SFtln46hqC+OPvC116jhzokt/kJ
         KTz4fvemeyWLDHu+IAvMvHShLXx85qn29LIZ1LMwkYskuJUd+ap6fwfyAzizqdtyz5
         xmCJK+qgq98XQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31772f8495fso2177737b3.4
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:43:30 -0700 (PDT)
X-Gm-Message-State: AJIora9CL3cLSnNpgEwbNYU2/2DvXdmehp+Bo73oxDIwZQt/c5L68wdr
        LgUUwbLfjAsKdjvEe14/dmuZnUKF74TQPzLDMnk=
X-Google-Smtp-Source: AGRyM1udv5/wnSJfpn8kZ771XB5WFr5MOfxpVhH4XCb4ClLoNkyNE8CFayHj543+ZQF2B6OTpPmBuZbS1pUohREYNi0=
X-Received: by 2002:a81:2f45:0:b0:317:71c7:fcdc with SMTP id
 v66-20020a812f45000000b0031771c7fcdcmr12503179ywv.73.1656614609225; Thu, 30
 Jun 2022 11:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-48-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-48-bvanassche@acm.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 30 Jun 2022 11:43:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YYXOeVrY9R642WRQsSRojDWdYP94ujLo6J5bXjtx4cA@mail.gmail.com>
Message-ID: <CAPhsuW7YYXOeVrY9R642WRQsSRojDWdYP94ujLo6J5bXjtx4cA@mail.gmail.com>
Subject: Re: [PATCH v2 47/63] fs/buffer: Combine two submit_bh() and
 ll_rw_block() arguments
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 4:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Both submit_bh() and ll_rw_block() accept a request operation type and
> request flags as their first two arguments. Micro-optimize these two
> functions by combining these first two arguments into a single argument.
> This patch does not change the behavior of any of the modified code.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/md/md-bitmap.c      |  4 +--

For the md bits:

Acked-by: Song Liu <song@kernel.org>
