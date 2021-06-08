Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F37C4743D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE6061377
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFHRex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:34:53 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37695 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhFHRex (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 13:34:53 -0400
Received: by mail-pf1-f181.google.com with SMTP id y15so16240222pfl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=biLwqIL1ECQDpYXkKAkiuZYqmbzWdb0jGyciw3wmlN1bVkaAqUDBkQKGemUGGKPL9U
         Tuk/hQkeIOll0FNN/hDB8AaeP1VGf7Qh6LzsEwg0eZ8SWEGsKMvfxztXJlKPzFBPfqAq
         9CB7AN3O47sSHxkKxthkxvZ0/1sBjuSWXLyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=IjKFZg3AfUCLwDPiccx3wbwjAkyNPnRVudv7JZwu7FtHAp3OAO79GFXZB2W9Aoq/Ku
         YJNy+lkc2L0zy/ZFgL01H+A47Cu7B2ptUsTAk0dztbdtRVZv4+DqeIYD9Gb8trYJVudT
         zih5Oc2Q5fXob35tNuwWYTYzx8Vpd/Zm1KYdB3GHtFSirSplX+lOrnZmvZr7z76I/Kbh
         GU6YV615imiVFZmbSW/2jhovYwe9vPdKduLlL2op6/GpHJawdZvIux8AIl70nQfO0T10
         tAO101J1KPzrC4X/h//0kn5hC3/daF67oIinVg5nhVXXZme6+/Ni53Y+Axynd7RADOT6
         zyVg==
X-Gm-Message-State: AOAM533Yydrsx1ZfQCx6SSuSGg3ZJ8gniKgqKHCecL3IWTElR5jkJOCT
        z1H/jreyM2IflmhpwwfySaelkw==
X-Google-Smtp-Source: ABdhPJzIuNZXhKV1ztPY/+fg/0E6Sqq1LW/i6wIG6EXJPGFBpvO72K9KL365GXBSM6yBmu+VJToBZA==
X-Received: by 2002:a62:1481:0:b029:2c1:1e90:c54 with SMTP id 123-20020a6214810000b02902c11e900c54mr982446pfu.55.1623173520075;
        Tue, 08 Jun 2021 10:32:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm12557362pgs.45.2021.06.08.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:31:59 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:31:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202106081024.09E42DA400@keescook>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
 <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com>
 <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
 <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 07, 2021 at 12:37:07PM +0000, Bhaskara Budiredla wrote:
> [...]
> >What patches are you referring to?
> 
> I was referring to this patch.
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pstore

I applied the first three:
https://lore.kernel.org/lkml/160685706687.2724892.9289969466453217944.b4-ty@chromium.org/

and explained my aversion to the others. Christoph never replied to my
notes on patch 8/9:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-Kees

-- 
Kees Cook
