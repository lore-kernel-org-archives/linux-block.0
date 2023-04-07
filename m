Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34010C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 01:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDGBE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 21:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjDGBEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 21:04:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42F83FA
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 18:04:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5140926a867so71664a12.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680829464; x=1683421464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ2/2/alrOrOJ5NOzVGNABqYDTMJskB7TwTd50pEcz0=;
        b=BfCSUEy+HeB2hDmdbALRZfAZ9q9UC1xpmnPORfn5Ms1lxP6Py0ZuTqPVzjh30b2cAt
         7DlQaYRy5ouqNy9IGbDKFYlG//7Hsi65ToB+nb5CIPQCdKgGdw+dalKUi3dRULJ2hD5+
         XpRA+oqW0/bcb+GM2WUvGLIY+szudPtgZSgx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680829464; x=1683421464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ2/2/alrOrOJ5NOzVGNABqYDTMJskB7TwTd50pEcz0=;
        b=IDiQtUzU60ndZgQtLqi2zFccWeakN2ApcDC7FrZbqvN3aXVnVGrVs7mx+c4ASR7TOz
         5MAk69cQNpRFAQCSszS9655pC9KcTHvMCDH4ORJqHOrRPmzRihKUAEWVH4t6Kyudi4GT
         F+Zp2zoYi890/+llzS22qHLQmJ8qVzOZRSpdPeKbY7qQ6/ufbZun6Ruz2DJKXBfOEHfz
         oXGohUAKRP2hvcm7JSe4ff4+JMhavCeOYFfNfmQ6cZtbmLlUFABhw5hKmaZJM/7pwqIK
         9M6OE9XDTwpaSQYctwi8iEQfLq4xltkEPo3UWvF4zBVwI8YDwXSK5uk6QgwOJz/U1gDP
         yzug==
X-Gm-Message-State: AAQBX9e8ojA3xNAm3ckTHwNQxxQ+ieOf6cvkaY82atmxz3Nd+XDh04K1
        KNGBxN51OafCz+EU/Edx5rfVow==
X-Google-Smtp-Source: AKy350bwM5NdXQQWn+TgCbamuFti8Svkf7VhrB870slr8vlvZzQ449k9kX8/IKbdWLaonOHcPN7J5w==
X-Received: by 2002:a62:19c2:0:b0:624:7c9a:c832 with SMTP id 185-20020a6219c2000000b006247c9ac832mr694560pfz.8.1680829464066;
        Thu, 06 Apr 2023 18:04:24 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0062ddcad2cbesm1969815pfa.145.2023.04.06.18.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 18:04:23 -0700 (PDT)
Date:   Fri, 7 Apr 2023 10:04:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <20230407010419.GX12892@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-2-hch@lst.de>
 <ZC81LyKt+QS18LzT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC81LyKt+QS18LzT@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/06 14:10), Minchan Kim wrote:
> >  static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
> >  {
> >  	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
> > @@ -1190,10 +1166,9 @@ static ssize_t io_stat_show(struct device *dev,
> >  
> >  	down_read(&zram->init_lock);
> >  	ret = scnprintf(buf, PAGE_SIZE,
> > -			"%8llu %8llu %8llu %8llu\n",
> > +			"%8llu %8llu 0 %8llu\n",
> 
> Since it's sysfs, I don't think we could remove it at this moment.
> Instead, just return always 0?

I think this is what the patch does, it replaces %8llu placeholder with 0.
