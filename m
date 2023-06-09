Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12060C7EE29
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 13:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjFINW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFINW4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 09:22:56 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84330F7
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 06:22:21 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75efda08137so20274785a.2
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 06:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316940; x=1688908940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ItSZqiZR0dUIQmEkEzuGcGQcKdyOeKjnBx3LrxDDhQ=;
        b=IFppvXvchSQTgdCEsO/m53CFy57iZdN/Cs7nZcpx4lwI+RoExgLwgkoVW9DMSz4asM
         8+SViz9SwwnPs9I2h6plv7H7/bI5bh551tcxnpUyOYvAbaSfbsUJAaocy/T1aZx7rq/n
         H/iFfONsQjR2rJSANbC7TyjQgFn3uhn0Rp2dDmhtB6u9DsHYVwV9zlkJhV2le7xJ/bBJ
         nLZYYa/Nz6RYsmP4CnunLtfNifVFdPbKhj5it5t5pn4MXhTjs3Xz83dWf9mZ6/Vow32k
         3dMnI7X40rhJ0eXgMhsa0TZ8qpIX1Vuz7V6aGTkoXmvDfe5i+Y3IP0QeahguPOqQp5PC
         A5qQ==
X-Gm-Message-State: AC+VfDw/qK+gT2+0CgaKfP7oh8hGmDTCssjwq1sRfDW41IfuyKl82zxv
        bQUM9dasf0wAgpd8ZYb8WaTl
X-Google-Smtp-Source: ACHHUZ7EaXUkLQWa4KL7eGOdK/zJn4Oe2c+mBf8RG5CIwOab23xBx689Kz4XeWIsapxaCANxot2Leg==
X-Received: by 2002:a05:622a:288:b0:3f6:b32c:3766 with SMTP id z8-20020a05622a028800b003f6b32c3766mr1862912qtw.11.1686316940294;
        Fri, 09 Jun 2023 06:22:20 -0700 (PDT)
Received: from localhost ([37.19.196.165])
        by smtp.gmail.com with ESMTPSA id z4-20020ac87104000000b003f6be76a5c1sm1159305qto.6.2023.06.09.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:22:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:22:18 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: block: fix a crash when bio_for_each_folio_all iterates over an
 empty bio
Message-ID: <ZIMnivRz/3xfHKgV@redhat.com>
References: <alpine.LRH.2.21.2304171433370.17217@file01.intranet.prod.int.rdu2.redhat.com>
 <ZD61QWC6TW59anIM@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD61QWC6TW59anIM@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18 2023 at 11:20P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Mon, Apr 17 2023 at  3:11P -0400,
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > If we use bio_for_each_folio_all on an empty bio, it will access the first
> > bio vector unconditionally (it is uninitialized) and it may crash
> > depending on the uninitialized data.
> > 
> > This patch fixes it by checking the parameter "i" against "bio->bi_vcnt"
> > and returning NULL fi->folio if it is out of range.
> > 
> > The patch also drops the test "if (fi->_i + 1 < bio->bi_vcnt)" from
> > bio_next_folio because the same condition is already being checked in
> > bio_first_folio.
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> This fix is a prereq for this dm-crypt patch to use folios:
> https://patchwork.kernel.org/project/dm-devel/patch/alpine.LRH.2.21.2302161619430.5436@file01.intranet.prod.int.rdu2.redhat.com/
> Mikulas explained why an empty bio is possible here:
> https://listman.redhat.com/archives/dm-devel/2023-April/053916.html
> 
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Hey Jens (and Matthew),

Can you please pick this up?

Without it DM needs to do the checking (by open-coding a fixed variant
of bio_for_each_folio_all); while we _could_ do that: fixing
bio_first_folio seems best.

Thanks,
Mike
