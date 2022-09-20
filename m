Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F09ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiITO3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiITO3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 10:29:23 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52354237CF
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:29:21 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x2so1437297ill.10
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=b4h6CnwfloglB8BX+JRYg+NYPY8n41O96rCGRmQYplY=;
        b=OHhSlzb9MwYwEhBf8fpJH0U5e1L2dVexdla0WM5KyZ4zbRtBzUfJn2XILD5bMabmkP
         ZDYLnP31LdiaWYG0Wwb/fO+FheyanTUkNiqNEezV2RWKBdzf9LIHsYrhplxM5eWMuejL
         KZOJLg2ngf0JRvBS5tOyMTJUbMN9/459HyY/2EgN/g+Ny+osHq7pvp8FqIKAflkSnnr2
         anLXXixBEMhRLTX7B1jKf+VfpB1h3vILSD18xhMHDC8+EoZDZB2LtCJvDLYRKim3SmJf
         nDquTgYKNxta4EhxfFuVtOCH3u0hhSa9xkNOAUkf+DHo1PrdbMxu8Fwcv58DUpJKNwhI
         VUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b4h6CnwfloglB8BX+JRYg+NYPY8n41O96rCGRmQYplY=;
        b=g3IyboUvY6ZpQF6Vomc+UCD4LgOJ6a3GPxMFm5g3HLXBi2WSagS4nslE73MYCeq1++
         yGSX9YR4thaPbLknT0xC42zTxH4rPsBYOuJcq0q9vBvilJESvrvcwH+n/QL7Amn/vax4
         CtTk21AkndYoIAUpSR/QkhFDb+gFJfQ5Ii7L18p18fHDgfdZhusJGbt4x7NXJ04wx+tS
         hhTpHB3V0THN1N1/CwHN1X+bcz4gOEQBHZrysYC+vKpoaDUAqTM5iYh4lRVzS+yNY91Y
         UNk+1lmU63zXnPed8/VV3XoLMuTcGJmbBUi9lNtecuHVjATk3g2ZwKyxTo2YC8zST6Qz
         YIYg==
X-Gm-Message-State: ACrzQf0HALE/8SIm1yyf24nUwSNGmveCpM/fq3+Fjg7HYu3ig7VWnfEI
        GW8fdsNpw1dj4Qh6GWmBewPw9yI5HtmtBA==
X-Google-Smtp-Source: AMsMyM5nQxxF50sNz7iolWQkkg2CR+NmBFf2et7lsbUK6kUIMnUm9voaFO3QFZyqwuacx1Bc42tS0A==
X-Received: by 2002:a92:6a12:0:b0:2f6:3bd1:fbdf with SMTP id f18-20020a926a12000000b002f63bd1fbdfmr1308703ilc.205.1663684160490;
        Tue, 20 Sep 2022 07:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d71-20020a02624a000000b003567503cf92sm683241jac.82.2022.09.20.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:29:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Li zeming <zeming@nfschina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220919012825.2936-1-zeming@nfschina.com>
References: <20220919012825.2936-1-zeming@nfschina.com>
Subject: Re: [PATCH] block: Remove unnecessary (void*) conversions
Message-Id: <166368415982.11026.4714198976076323254.b4-ty@kernel.dk>
Date:   Tue, 20 Sep 2022 08:29:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 19 Sep 2022 09:28:25 +0800, Li zeming wrote:
> The key pointer does not need to cast the type.
> 
> 

Applied, thanks!

[1/1] block: Remove unnecessary (void*) conversions
      commit: a7609c68f7a117a77b3049c2353f555854be69e9

Best regards,
-- 
Jens Axboe


