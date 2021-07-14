Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D618EC12002
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7313610CB
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhGNUg6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGNUg6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 16:36:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF3C06175F;
        Wed, 14 Jul 2021 13:34:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g4-20020a17090ace84b029017554809f35so4557854pju.5;
        Wed, 14 Jul 2021 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=6u4Kc/MlFhTHYE4kKbxeOSm+0tW4tXnf9YsPfOpp7rA=;
        b=JY39Xc8ma461Ms/wxEuC7yQisfQuS1mohIjI5VlQu84SiW3Y+JJjBhVa88yHuq7MFm
         RIieJejVpKfs7cBGJRr8yKwLA+aEayvE2Mtr3E32t9N9XefKU7Eryz9MxNfOPd+USkga
         Hwy5g38l32tygr7RtmTFxWDnbAuwMxnlkoJavWWBZAByFcwhhBesckhrgjIe9yPNmFpo
         8VbtHjqvcGlA30aQeQMioCf7Wirq70n3SI6h0B+1O/73xIS24GTA6J7zXY0fjdt/szu4
         Z2G4UopdcjVLdKyj5IcecBFksdlEPMwquL/HsRcLFeva1Vz6kzRTvJsatXnMjzRZ2Vpy
         qm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=6u4Kc/MlFhTHYE4kKbxeOSm+0tW4tXnf9YsPfOpp7rA=;
        b=sfeTsRvPwWsvpPwet387u90Hxzlk/oX/uWhSF62JIXucMdYdcn6kMH9LAv/bCDChFQ
         KP2fSmhnUR6zAj4pUTT4ef+K1Y/1aUqn/jzmqjtWxQiP2pU93dcI5rVo29iUdt7Ra5+v
         Z2X8TDQr6CZyJB6m5Zubv/D+rF10cDtguknFATCfhVnvM8MTCcpxjdnocs86eHQmmFwY
         3BemzfOIXr5Ag9rNBgiLgysKgHZ6YuY9iwv2/Ck6TwAAhBiQhomKXkpDBtNFRcBCPfTG
         EEFSb4VIGmsTegM5zRxTjDRskkJLxLy68qQw99bHd8EtUhmBW3HjECADqqwXpWwmtUWk
         98gA==
X-Gm-Message-State: AOAM533Yx65fdH7RlCz2W+6+GL2g008hYDZy63swUORuvqP43ZPOBsvL
        bd/5wh+UNb3rDS2CBY6vhcc69AfmylaPfA==
X-Google-Smtp-Source: ABdhPJzZJ0STVr0DLDGtvm14e9Go01kafX9HrOGjaC6KZcpC10daa8hyCoSVnNyHNos5ofpX05tG4Q==
X-Received: by 2002:a17:902:7144:b029:12b:24ce:a83c with SMTP id u4-20020a1709027144b029012b24cea83cmr8868904plm.54.1626294845162;
        Wed, 14 Jul 2021 13:34:05 -0700 (PDT)
Received: from fedora ([2405:201:6008:6ce2:9fb0:9db:90a4:39e2])
        by smtp.gmail.com with ESMTPSA id w22sm3677610pfu.50.2021.07.14.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:34:04 -0700 (PDT)
Date:   Thu, 15 Jul 2021 02:04:00 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] loop: fix setting arbitrarily large block size
Message-ID: <YO9KONjiBOYhQ7mN@fedora>
Reply-To: 20210626082406.348821-1-chouhan.shreyansh630@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just a ping so that this patch doesn't get lost.

Regards,
Shreyansh Chouhan.
