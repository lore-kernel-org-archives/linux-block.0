Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140CC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjDFFL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjDFFL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:11:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57293ED
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:11:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so39587028pjb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 22:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680757914; x=1683349914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTZf05gdzPPYXqJ5Ng0LvxdW3r30LRHZhVAxDkgDHPk=;
        b=GqHjGeT13huHbQnkWPRG235JzUXjrF4NfYLpI3FHPR4NU6D9/8TXcM97QDmSnFkKfn
         ZqpY+jU1e+CEjPjioIDfVhwi+mQ2Tm6PO7vabl2osKlUpmhdvHpk2Z0ICp1qbqo45gi2
         FRUr57WZQQNPbNY05mKHNurXRZuNpsSc6gL58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680757914; x=1683349914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTZf05gdzPPYXqJ5Ng0LvxdW3r30LRHZhVAxDkgDHPk=;
        b=MkwlvuNXSIzWPyQ6D3tmKWn1T9L+WbSsard1ZSaJ16g9CHPaDoGqn2eFLgXarutuHw
         jxtKrDc6d3PMrEVvmfpZvLtnabdkH1zGbKKFI9jloRPVl6l6ncwzbC1qNjSoB+fYMKnq
         O71ZU0+CsQrLO2elCyeoXdBRxwOVVPSd0UFQooK9GkcHtWWx4cKwFk2lgLgrK4SxQFcA
         CDPkgR3JFL3XedSwZ4jbf83YfKleDDlfy3maABUP5D/tFAg+/MqExNChUoDQnum4cjH5
         Eh07BRumciqfTMDgMXmtZWFC3kqDX3qqiPMGXutdCGnumJXGt4JHhbZGOx/OO9Dkd59X
         gnmg==
X-Gm-Message-State: AAQBX9cAAxiWiEaxaD2ux5DXKDuDNghJBKg02/4mEnODSntHJS3hGGdm
        d6Y0NRXKz7Rh/ZJ9Pg8o3o0HjQ==
X-Google-Smtp-Source: AKy350YwScSfaDXARkM56Ju/bkpmk1luuBIMn9Ri8evDNoPI2pIc4edAYMftz4XWCxbMI6FXhIDQ7Q==
X-Received: by 2002:a17:90b:4f8a:b0:244:952c:9701 with SMTP id qe10-20020a17090b4f8a00b00244952c9701mr1064261pjb.7.1680757914722;
        Wed, 05 Apr 2023 22:11:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090b050500b0023b3a9fa603sm2197161pjz.55.2023.04.05.22.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:11:54 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:11:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/16] zram: don't pass a bvec to __zram_bvec_write
Message-ID: <20230406051150.GA10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> __zram_bvec_write only extracts the page from __zram_bvec_write and
> always expects a full page of input.  Pass the page directly instead
> of the bvec and rename the function to zram_write_bvec.

					^^^ zram_write_page()

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
