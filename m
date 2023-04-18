Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16399C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 15:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDRPVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRPVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 11:21:22 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCA10272
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 08:20:35 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id js7so9638292qvb.5
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 08:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831235; x=1684423235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CLdgn7FEJW50mDtv/lWeNBJ9hKg2Ov/8WlFbqJpJIs=;
        b=L6EwMgYzNtr3jExYhuXBZm8k3WtHbUHPjwDXD1CRDLmzT2JO54BEfFSHg0Gctn7hI4
         kuiPwtqxdGOJdHEEBNCN6qoAp8V1Y/3LCqo/kXtw2Qs2D6cmIihIVlqqF0tI5alpTHo9
         4MLN9gN0wFV6/qPaDDg9nUVP+ZoFS9GxZKtIkr9Ye5lB5Kef3RsLIhRhfTc36hd/F3oK
         PsgFtomzS3ujD9K2e+hF/CXWzyO6QHBgq0TVz/HudRLbZ2F4djRCVt9636UuYZVTkYnL
         f6XgaTObRGhbFZEa7XqMdRFXpi5I+fpW2lW3FPCvCH37RwyFeMFXFLok5OKlatxMkJei
         1VsQ==
X-Gm-Message-State: AAQBX9d8ar7sZief+Xr20DmVgro5kVdcd1QtOkwbLgHN9/N/gRQHNNlG
        i0QbhPvnWmbtLpoUS3FHIZ0m
X-Google-Smtp-Source: AKy350Y4cXxw9vWWlQiQfrff6ZcA7eR3+1dB65GdR9xdlfjhUTfjBpewtj4Qo98QVfFPqX6aFoZqOg==
X-Received: by 2002:ad4:5c43:0:b0:5be:cb17:90ab with SMTP id a3-20020ad45c43000000b005becb1790abmr27221625qva.40.1681831234997;
        Tue, 18 Apr 2023 08:20:34 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id y16-20020ad457d0000000b005ef40ffd97asm3799930qvx.0.2023.04.18.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:20:34 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:20:33 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: block: fix a crash when bio_for_each_folio_all iterates over an
 empty bio
Message-ID: <ZD61QWC6TW59anIM@redhat.com>
References: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 17 2023 at  3:11P -0400,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> If we use bio_for_each_folio_all on an empty bio, it will access the first
> bio vector unconditionally (it is uninitialized) and it may crash
> depending on the uninitialized data.
> 
> This patch fixes it by checking the parameter "i" against "bio->bi_vcnt"
> and returning NULL fi->folio if it is out of range.
> 
> The patch also drops the test "if (fi->_i + 1 < bio->bi_vcnt)" from
> bio_next_folio because the same condition is already being checked in
> bio_first_folio.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

This fix is a prereq for this dm-crypt patch to use folios:
https://patchwork.kernel.org/project/dm-devel/patch/alpine.LRH.2.21.2302161619430.5436@file01.intranet.prod.int.rdu2.redhat.com/
Mikulas explained why an empty bio is possible here:
https://listman.redhat.com/archives/dm-devel/2023-April/053916.html

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
