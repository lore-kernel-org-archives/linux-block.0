Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA98C77B73
	for <linux-block@archiver.kernel.org>; Sat,  3 Jun 2023 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFCWj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Jun 2023 18:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCWj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Jun 2023 18:39:58 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BABED
        for <linux-block@vger.kernel.org>; Sat,  3 Jun 2023 15:39:57 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62606e67c0dso31580716d6.2
        for <linux-block@vger.kernel.org>; Sat, 03 Jun 2023 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685831996; x=1688423996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avPQKTaRTbQOf47fI/68sylNjg8MrdY+tDB4lutGoKA=;
        b=bWPKjbX1WHje3OwsfHu50Fmv93XMVMAsfBHGy+qd0kone17LdtcvW5n1VFQtef1iCe
         kssIrs/Fuebjh7PxXv1PeE+uYdYdmE6mKScZA7F3qY5VgeOVCeG+5ubLSZJlpdr3400n
         6kEIb3hwFIPXqHtKCb01HWuWUb5itb85qUgJ04EZmLl3S+p8JffKN0BQuLCcc1fPBC1e
         4i2fbeitsu2Deec1uSXEp4ZDD11za9Q6uQWOQ4n8nuhRxZA71libo6Bpq4Emz1ekd2WB
         vnN0MvYxITTsZ4kmxsZENiMgLGI+AFHp5m2tUFYG9CnmNPZWmF0Ds2S6v4GWuAS+QS73
         fryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685831996; x=1688423996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avPQKTaRTbQOf47fI/68sylNjg8MrdY+tDB4lutGoKA=;
        b=I8MJGneWj0DtB3FSJRu9o0nk759YMyXWSEb3yOv6Ix+WncCc3ZUzQiheED+X8zflAB
         E0ed81FCeMQ5BprtH6lfsbdwFo+mkx1DRAeUcA+koeUl6c8mWJzr+oFkjJciT5wlEnAd
         JlVVvHFKep/cxff2hoyse3qbpQfsHdfzd2CW+MUCZ6O3y8+4BSJedYhyCxxcq11TspGT
         7e09gD8rxO4qdkcSPTgdnfBS4kPV0XH21yrm1rQJOrnrTa/xEyeRc+iRLEGZzC9/PrTB
         ZaeQB6GkUDdndRUeoyppV3jU8u6vHj1OkHgnh2EQ/9xiUkbhdIn5lvfaT6YQU2+WPTfM
         Cf9w==
X-Gm-Message-State: AC+VfDypjRRitozUCN5ZzBZ7RzN+20gItLMdXB1y75Mqb/gV39dvqdxy
        cHVTpaD2a7smUQ7qJRKpBos=
X-Google-Smtp-Source: ACHHUZ706ov2HEYCut18QtmMrGMxpPGEb5nd/bunaJ2kZs4pLG61SXSumN4u3AuwggHDaeEEmRXxaQ==
X-Received: by 2002:a05:6214:2687:b0:626:3bb1:b9b3 with SMTP id gm7-20020a056214268700b006263bb1b9b3mr3475548qvb.4.1685831996546;
        Sat, 03 Jun 2023 15:39:56 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id dd18-20020ad45812000000b006212456fd8asm2569896qvb.100.2023.06.03.15.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 15:39:56 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk
Cc:     horms@kernel.org, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, ming.lei@redhat.com,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com,
        tilan7663@gmail.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sat,  3 Jun 2023 18:39:55 -0400
Message-Id: <20230603223955.827968-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
References: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

I updated the patch with more detailed description of the issue. Could you
please take a look again when you have a chance and let me know if there is
anything you would like to make a change. 

Best,
Tian Lan
