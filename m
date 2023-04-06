Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB3C7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjDFCts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjDFCtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:49:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F0AD31
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:46:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso5066154pjc.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680749195; x=1683341195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeAeGiIMMPkODtVQnbL7Neaq6+tCKwj1oqRUt7WARBQ=;
        b=ZpptC+2EEi7MG2AkKP5qFP3nlEtzd/GkcDovUV1jz+U++PjCS9bZ/dAEqhfirpgyiH
         Ssc8uqPWpNecYFhbJ43lJwvg5r2csCYhKAfmoqv7bBQORpx9wysC4MYsIQrn/PHHtZTT
         LpC6tKKilltW/gBt8C2POQvYPnMUBxb9Und6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749195; x=1683341195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeAeGiIMMPkODtVQnbL7Neaq6+tCKwj1oqRUt7WARBQ=;
        b=CWZl+Vsb2GOEK+q4dAHSyzBk+Cn/iccR8h4xvGXXFbj2n0kwB1iccDKc3OCcr2NKfI
         fnmekeStE6dInXhNRCKZSKqxetE5HxsVklw6kNL4kEwTAtZHKYXBu5sKt1Qi6or46Sw6
         FEBEbR0fkkX0ku9g8CZBdlk/exKjHGTJL8weriDIntUBoNwKY9R9eKsXkb8kY9zxUNm6
         De8+Yz1GYM3ZVkwvHmUFU5qLEIVsLdH4+MQPjHyMBzQwQ3rqKKsWe7OKnqa+u74OvzQr
         laj7G8NuOR7WiczSf3xyAf6HgW9SBQAEmSmp6UH8iHj8w3hCaQZoBef3vEDlyJ5Vdl4+
         vemw==
X-Gm-Message-State: AAQBX9eR/9GmcPq3hntgd6SQ2sj+CUWDBNPk/s/E8xwCIxldSrEeswfO
        IubCMwyYoFzdHX/JHWAuP8iVp1rauctSgusgR20=
X-Google-Smtp-Source: AKy350bkFSrsFP4qvN+pRQmHaOhEDzTZxkU3GF7XlRnR4htmantEEXFpkcdxBsDjzZbebosceWrmwQ==
X-Received: by 2002:a17:902:d4d1:b0:19b:dbf7:f9ca with SMTP id o17-20020a170902d4d100b0019bdbf7f9camr11586689plg.0.1680749194955;
        Wed, 05 Apr 2023 19:46:34 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c08500b001a076b5a193sm217247pld.145.2023.04.05.19.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:46:34 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:46:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/16] zram: don't use highmem for the bounce buffer in
 zram_bvec_{read,write}
Message-ID: <20230406024631.GS12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> There is no point in allocation a highmem page when we instantly need
> to copy from it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense to me

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
