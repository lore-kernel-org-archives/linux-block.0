Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0801C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A930C61C1C
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhGFPeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhGFPeG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 11:34:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981D6C061574;
        Tue,  6 Jul 2021 08:31:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a13so26526049wrf.10;
        Tue, 06 Jul 2021 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpJ5e6/H9nBs7AiTXYB7WRSVldPScWaLxVZhtkaEirs=;
        b=Ep2TA8yF99/JsCXc85e6K8nWHppODCz+pieZYSBABCufpvRPVgq/aJIDXJ5A4Bo2l6
         4QtqQNtpeFLXAgl6EcDBRS2ddZXJnwFJeViQZeyVyD8n91zuitnTnJjL/Eq6FbsBfHYF
         sDQrVgKPoDjT5GDVf8bVC9Sx9RJZog5+P85Zm7tCm77G+dOohgEsieb1qYYo6w2cCpwC
         gbuFCGGZHm8blWpCv/1Fj+0hIlpmpqobzBMlFg8MBj8U35JDqfKJb5ZKQp5+EwaGeFyN
         BPRIg/Mkur7CYKz4Zyq2E4Ra/chyN1KE8j9RjVNTJNO5KAsXvOZkebXmlUi8jN5TkgtU
         b/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpJ5e6/H9nBs7AiTXYB7WRSVldPScWaLxVZhtkaEirs=;
        b=drkrRl+4jZHBiTwJaX1WB4US7g5BCCytwnDFSl9OUmjFVSQAkK2Dpsd5pyisZBSNWD
         Tz1ZaeFD4dTml+OBx1a1tHZ+O1YYmu71H26LIOx4gpB30htAVstnL+LWin+T4LUDWAnc
         fA1bP6+3Ov47BxW+eHH0D7dmIzPAsPP0ie0X7Xp3k+8W4qBAdShEFKP1Gv7YlOwArpDC
         3n8WD8Zr/fN3ryYrmPAltT78fOGjh+D1d/Vz+7zti0Wubps9JmHWZqHySBtDDmh5Zcgq
         YnvRsahXUCd84IF4QX1miSDpDBoptaJEXr+63dQpOTqTG6n2mH2tUDgYr2vyUkEqj9zZ
         xenQ==
X-Gm-Message-State: AOAM532Y1aZ6MOZu/aGAfZfJ6srwcLIRkVIbSuei7OLXEcFVKjxIArWV
        I12mPve6mEuawRQ2hzfP9JM=
X-Google-Smtp-Source: ABdhPJx2HHX0AFC4lWpKc90DbqaW0ohX2g77K7qgTInrwWY/jyss5NWimnErwdo2Y+fkvO24hPR5fA==
X-Received: by 2002:adf:e507:: with SMTP id j7mr22482610wrm.152.1625585485303;
        Tue, 06 Jul 2021 08:31:25 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id m6sm20488298wrw.9.2021.07.06.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:31:24 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     hch@infradead.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        kbuild@lists.01.org, lkp@intel.com
Subject: Re: [v3] block: Removed a warning while compiling with a cross compiler for parisc 
Date:   Tue,  6 Jul 2021 17:30:54 +0200
Message-Id: <20210706153054.145461-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <YORh3XGNiRKzjDbS@infradead.org>
References: <YORh3XGNiRKzjDbS@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Christoph,

Thank you for your comment, the div_u64 function is called 5 times inside diskstats_show function, so I have made a test case; I have replaced one call with a constant number then I have compiled the kernel, the result was instead of emitting "the frame size of 1656 bytes is larger than 1280 bytes" warning, it has emitted "the frame size of 1328 bytes is larger than 1280 bytes" warning, so I came to the conclusion that each call to div_u64 will add 328 bytes to the stack frame of diskstats_show function, since it is an inlined function. so I thought it might be the solution that to preventing div_u64 to be inlined in diskstats_show function. I have used the new printf specifier to print the bdevname as you advised me to do and it has reduced the stack footprint, but the reduced amount was not enough to not emit the warning anymore, so I looked into div_u64... do you think the approach that I have taken is the proper fix?
