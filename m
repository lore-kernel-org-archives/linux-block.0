Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89752C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjDFGqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjDFGqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:46:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E696581
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:46:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z19so36689272plo.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680763565; x=1683355565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DN2pGSG9OTIk3BhUlHrk419MrAxlcCtNH+bbZxLORLE=;
        b=dJhlZI4r+4V0tS7DrZeVw48Mz72GDwupAH/ot8RmIelhvDjP/QR5/YGkaruTer+Oul
         fTesQn8nopMg2cba06oR63tJA8A4BBfIcSeoO6NN5CUTo6U/hUcClLU63OQUoehnwokq
         GoNvWlsD2V5IWCeroGTrlRkun1/XGvBC2vbIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763565; x=1683355565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DN2pGSG9OTIk3BhUlHrk419MrAxlcCtNH+bbZxLORLE=;
        b=7czoEJhpI6W7YMeL+RgJNmDjoo43V8UOZdewiZ0xAhvugTj9nUKxMgPSb/S8/8j1KX
         xavWZMrDku8ahdVWZLtkvay7tTz0LH39PBMXTHzD2wBVk2KnfSPRGK/hua0D7eMl58XB
         FA0hZGFcLlfvRuloSvg1RUBH7W7xrB5BDCxR3k4nIXE96CPCPsxlnUSFhQFKpoyD6brt
         uhDqU/3/CTWZe/L61QXuuzpxlN3k4Ofw9kKVB39PMXZtYxqB7jUGj6gxQXuExM0mzLxL
         kGy8Nw1OXn4QRadW5PXGZXxGw0Gb1kvqkdGIUVZORYtfKCA1EI+W4skLB8gPL4i0JymL
         KVEQ==
X-Gm-Message-State: AAQBX9e7TlgnuFNKSRw551Npj6BOTpXwn4WmEpO83RD+q+Pfa7fZJw97
        qyrgEg+EljbFw9QLCknPmVB8OA==
X-Google-Smtp-Source: AKy350bGNsbQw1jf3hLHwvIlW7PaghtBsKIddx6NwkV6PEibNErvbrMY99bdkXny64HiASBL2u4VIQ==
X-Received: by 2002:a17:90a:e7c1:b0:23a:340d:fa49 with SMTP id kb1-20020a17090ae7c100b0023a340dfa49mr10031108pjb.32.1680763565612;
        Wed, 05 Apr 2023 23:46:05 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id k16-20020a170902761000b0019aa8149cc9sm635875pll.35.2023.04.05.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:46:05 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:46:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: zram I/O path cleanups and fixups
Message-ID: <20230406064601.GJ10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230406064325.GI10419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406064325.GI10419@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/06 15:43), Sergey Senozhatsky wrote:
> On (23/04/04 17:05), Christoph Hellwig wrote:
> > 
> > I don't actually have a large PAGE_SIZE system to test that path on.
> 
> Likewise. Don't have a large PAGE_SIZE system, so tested on a 4k x86_64.

Hold on... Something isn't right with the writeback test. It doesn't
look like reads of ZRAM_WB pages work.
