Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576FEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2H37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 03:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjF2H36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 03:29:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B2E58
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:29:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992ace062f3so45190866b.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688023795; x=1690615795;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=s5nGGw5gvPHiYhCADwmQXV7PL7CPhqenUtZ/ZGNPhyk=;
        b=FecDdIDCDGjKQnAkDLrNfxBzQgNPyKHtyCp/sXn/Io9r4tUWa8G/pVqxGdKU1Zhhiv
         4UEDRHX/xSBASiG73ttGLR+OvaxQ/JuzBbH5aT+RTImnKkHKoqEzMSDdueUdcKDWLlcZ
         lPtbx9DIIik0XUeq+MSwXohACSIqUqCgpWgKh3fuI2szFBaJDs9vrnD/hWaiy+JWYp5u
         QCdY2FSKiXuTbevAaUOA/Z/ljh90+/XtPnis2HFE1jhZ1SuLUOJJ4Fu+AoQsuOIernV3
         1qeDFNAb61HHocFkfmOPwe1amncovMFPQKd0clrVtpxlPqhU8W0sZoxkCsU3K/PJaFGW
         2ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688023795; x=1690615795;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5nGGw5gvPHiYhCADwmQXV7PL7CPhqenUtZ/ZGNPhyk=;
        b=d/CuqFm2iwDYIhq3AU63GrsQfvF1SFfnPxYw/TXgR81Absqp5fTpeHW2A1ARwVL5Nh
         5jMEvKm6sEsZ0ylykVPAwhRT++JSnemzJIY112sTtYrEF8U8kPeht9FPCwgrt6TJQe4V
         a3a1cP9rk0fqRD0XmSLeZ0ACQfBBwOBGTommqiQFxAXyocZRvbr181e3cV3L7IKnocMU
         CKRhlywztp2KZHOzP1wQ/zkY3Qfw23AJTsdeqzhuYh/N6/GU8PBZ9Rsm1hygq277GIbl
         4IzYg53J3IFYhiwl5uKwXAEjH9DRqssxx+WaO9jpu44XUVjT7/jSr3oAXnPnmHQgx1fx
         vG8w==
X-Gm-Message-State: AC+VfDwhA0T5CbAiD/sNVg7OnG0c/5nUPuKPJ+aBdFnDgw8dAsF/R0Mc
        haHlh73BeQ2ZKvwtx+Y9ICTekQ==
X-Google-Smtp-Source: ACHHUZ5kzvNl4uQvDPstO0o4laP2SbJB9IDXUab/0LqsWirbwRZ7JyJlxeuThpTm6cG6qhYj9Ts10A==
X-Received: by 2002:a17:906:9b86:b0:982:21a1:c4e0 with SMTP id dd6-20020a1709069b8600b0098221a1c4e0mr35643468ejc.56.1688023795459;
        Thu, 29 Jun 2023 00:29:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b009893b06e9e3sm6552996ejb.225.2023.06.29.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:29:55 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk> <ZJ0ZAmpNpid8Ff08@infradead.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Thu, 29 Jun 2023 09:25:32 +0200
In-reply-to: <ZJ0ZAmpNpid8Ff08@infradead.org>
Message-ID: <871qhuzpxr.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> What's the point in having a separate file for about 100 lines of
> actual code?  Especially as that needs a header, intefaces, etc?

This was suggested by Niklas [1] to make the conditionally compiled code
more readable. The alternative would be masking out the code with a big
`#ifdef`.

If you prefer the latter, I can change it back, no problem. But I must
say I think it comes off cleaner when we move as much as possible of the
zoned code to a separate translation unit.

[1] https://lore.kernel.org/all/Y%2Fy+UFEHn1F1sg4i@x1-carbon/
