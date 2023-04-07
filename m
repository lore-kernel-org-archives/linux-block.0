Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2DC76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 01:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjDGBOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDGBOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 21:14:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62D5B9A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 18:14:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-50fa02be315so69897a12.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680830072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFePiC80drSv997a5PrYVJZ8i/yBVUDW4g7ppp5ypnI=;
        b=dBWdh9mlTu0c6aYZ0y05BjeGVF+3roDIdeUjper8yYZnEjDqW4lbJ5Yf4Kz1zUa9TM
         wjxhKyFV+NBXzqUO53RWY/cUvRL/NIiBSFoHDXhtaMDH0mUfgSLAcpy77N315ktZ0XO/
         xpI/KxDfBlqAPoOm27mJflTvzghn/EY3Oj0eArvc8pTX3ioHeOfzMbwTA94mF0kGqWr8
         IKZVz73KJouOOQ8GLOP3PFrxp4R3VAlWUAG+6Y3ExoKA/cDpHYDBttfpcwj7452p2hr2
         dPlg9efv2pQ2Jj3PTRGs/RurXHwjlEs6c47Z7dLW6Zh0srUe21OVk05p+E+eULxM6odq
         e+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680830072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFePiC80drSv997a5PrYVJZ8i/yBVUDW4g7ppp5ypnI=;
        b=aNX5c5Xy+5lCVu7k5b1TqyXukYHWX6ntTUGcj3QcFk3DPB+ZE8SqfSXwA7JCkkws8c
         IkF7evniDAMF5uP/xe7NAgFXNTAbiGY1IzJxaHaJHs8K3idb9AgNaybe4HZrTGEGq8gW
         vMe8OooEKyu9nExvLiCleE1rT1jOElgGJ6zlob4INjTRMp8kSaOMXkdA1YjPwz8cKO2K
         M3iK4o3L451zXSgoS6OgMkBN+5U6yMHL13Q2BcHgFu8e8mv/yO5cUCHsTXQJ4VzNXDOt
         jhpJ7XTMqKxR4vLF75tiiykUyAGVz5mqMMRncZ+ZxCR5zQIHCDQnbwhdhEVFbmFp3/X7
         DdtA==
X-Gm-Message-State: AAQBX9e0mL2xubDdzoOnDtTIYS+yEP7xatIUrKg+V2BhdQcj29ErAcxp
        IAHFHFawqUpfcKUU2XumKpj4Ls5fXZM=
X-Google-Smtp-Source: AKy350b3vqunKUehhRorfzlvAQEyTRfwjvobRW0StJEeRMMgnewk224N8zCjN7a/RMVPegY5LuKCFQ==
X-Received: by 2002:aa7:9601:0:b0:625:e77b:93b2 with SMTP id q1-20020aa79601000000b00625e77b93b2mr841277pfg.5.1680830071641;
        Thu, 06 Apr 2023 18:14:31 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b0062d9ced3db3sm1921473pfi.23.2023.04.06.18.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 18:14:31 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 18:14:29 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <ZC9udSVxt9M4k9SO@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-2-hch@lst.de>
 <ZC81LyKt+QS18LzT@google.com>
 <20230407010419.GX12892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407010419.GX12892@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 10:04:19AM +0900, Sergey Senozhatsky wrote:
> On (23/04/06 14:10), Minchan Kim wrote:
> > >  static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
> > >  {
> > >  	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
> > > @@ -1190,10 +1166,9 @@ static ssize_t io_stat_show(struct device *dev,
> > >  
> > >  	down_read(&zram->init_lock);
> > >  	ret = scnprintf(buf, PAGE_SIZE,
> > > -			"%8llu %8llu %8llu %8llu\n",
> > > +			"%8llu %8llu 0 %8llu\n",
> > 
> > Since it's sysfs, I don't think we could remove it at this moment.
> > Instead, just return always 0?
> 
> I think this is what the patch does, it replaces %8llu placeholder with 0.

/me slaps self. 

Acked-by: Minchan Kim <minchan@kernel.org>
