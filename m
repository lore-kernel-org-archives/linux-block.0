Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D8C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4A9613AB
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhFHRgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:36:41 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37852 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhFHRgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 13:36:40 -0400
Received: by mail-pf1-f169.google.com with SMTP id y15so16244716pfl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWNeSL+Bq72a437AxKxQVe0Uaeu2Nm8OpDkaGtEuRXM=;
        b=Kqic/OcsvMBiFMhntb0VgSYT7yhKK3qXwWc/y1DWmiUoAxhJFfIVM4HXXkezRAnIcb
         eWPMHke0GAc2x5PjLRdgAIGfiDbqRT8Y90u67zBEdCXpYSTc6/lobNpcy1YkOlWjr3JU
         n1zlDpvI6Idcz7GAiZQUyi48DdeMK9DuoM/A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWNeSL+Bq72a437AxKxQVe0Uaeu2Nm8OpDkaGtEuRXM=;
        b=YYdNrsgTfRD0J0U/cnPR2/FTA/LfGSUJymxykGM17xyHbBnSZOu2iovTaUjoR8gP97
         jH2MHyRfZBVmcv64p4CLx1PuRjGHGJu128VIEMCTlSkHVSHZdXZpLbYS5w3G1NXb48ei
         jCOOoNy4q+9Z6dTdEXrjwo66OhQPOP07iWfiI2cHfFCn0hv/6EAoPhrHWPBBK57eTu/4
         5x0dZc515fGPa434/tF9Sw1RWgJzIdJB7LKG4VJuNgQ16BbwB8roZDp38VuKRTF8rp8F
         CesfNV+NJ1PlDUPZ6AagMaEqH0SrdhXL2nc7s7OD2sHLYZqNxAczE/7qbmnakT+tAXzh
         DOpw==
X-Gm-Message-State: AOAM5320ff8vPPkvwFMETiIh/gh4df8d8w4BH7FbFLmfDsVujV6xPwcD
        2zoOIzaebMIk6PZ32Q0/yajMMw==
X-Google-Smtp-Source: ABdhPJyW5o12lK2i8NyhtfF01aYhPcle5/0y9+/NtAzVkK25FOXHqk5pODvPkjT2lvLlw/rGv3M0nw==
X-Received: by 2002:a63:5756:: with SMTP id h22mr23206898pgm.377.1623173627855;
        Tue, 08 Jun 2021 10:33:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ig1sm15535215pjb.27.2021.06.08.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:33:47 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:33:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202106081032.58FEA082CF@keescook>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
 <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com>
 <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
 <20210608161422.GA10298@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608161422.GA10298@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 06:14:22PM +0200, Christoph Hellwig wrote:
> Given that Kees was unwilling to take the series to unbreak the pstore
> block support I've sent a patch to Jens to mark it broken and thus
> effectively disable it.  We can't really let this spread any further.

Hmm? You never replied to my concerns:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-- 
Kees Cook
