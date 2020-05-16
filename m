Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4BAC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFF9206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M0Iw4FmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEPUWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbgEPUWV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 16:22:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170ADC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:22:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z1so2771599pfn.3
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xWeBoP2HB2V7PYJG2nFsOoxCJyZVAIU5TMhf9B3LHZI=;
        b=M0Iw4FmSV9xl8gCFFOF5iJfAlzKDMddzWHyw1q/DnviRYKjrNbyGbUVAxyvF3fLm/l
         ObTi28bb6XWr16DuhQRlrwmF2vJb1rBUkGjmmoPzE3q+17dUW/6fGTfqGlkFpzs190EB
         O0g0l2sjjkMDEUXubV8ULYA05Ysrjaj/MlsDdjsXuJRCBt/+4F5k/3wP5aQvSCH6WEIw
         14RNxl/Uy/DNDStMbemqJB+75iSVONbsmFPY1l5BDY0GWR5cLi+MRxtcjj8loT1hRvCS
         skJs4KCpHkgOK3YyNIPobUYNyJFs6DkgPxfPebOUtjhiHQhVymfRC9kw3BkW65wYFNdd
         SmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xWeBoP2HB2V7PYJG2nFsOoxCJyZVAIU5TMhf9B3LHZI=;
        b=DTXTbnvt1vZWHquoXMbrrVGmXdUUyGLRBE8teg2fsIW6o7QcPKci0EbG6j2SsZsOMe
         fumf2P2Ez11jJYQu3IYmGQIBfSJp4AG8ysxNz6VbIWmTj6cmJiinneaNCPLKrW3k5eLF
         NDQCle1xoQmrcdtQ4ps6G9GA6aHij9lafyfOh+NJMIK6mfILdR9+R7LCyCm3HctFcpod
         HeSBhRbqYX7y2jzgSPe0zvwFq6AsH3804h5bmpYFeOxXnvK1iHGM1yhdRXvC34N4gxzM
         v4NU4mrpl4gDlUjsttNlcg4E4ONLY64wY0pXTPrr7pIPSd5pu0bT9IHXSFExv3wCpapJ
         D06g==
X-Gm-Message-State: AOAM531J+7pXED+rmJXv/jGb4+gAEHrDBy0tknKTc43wxQG2UJTjiGTp
        M+S3LZiE307RQO/J/euqEYWHEb0Dud8=
X-Google-Smtp-Source: ABdhPJxI5W3KfzAzhjLgIyCd+EL52v9WV8on/0OQmlINx2TjNEA3dVS4uAg/p7TmrTxMrSMVY3BkmA==
X-Received: by 2002:a63:7d53:: with SMTP id m19mr9019591pgn.168.1589660540049;
        Sat, 16 May 2020 13:22:20 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:41fd:9201:9a30:5f75? ([2605:e000:100e:8c61:41fd:9201:9a30:5f75])
        by smtp.gmail.com with ESMTPSA id w14sm4377131pgo.75.2020.05.16.13.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 13:22:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc6
Message-ID: <2e7f23d1-9c9f-81b2-067d-bc6762982701@kernel.dk>
Date:   Sat, 16 May 2020 14:22:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single NVMe pull in here, with a single fix for a missing
DMA read memory barrier for completions.


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-16


----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'nvme-5.7' of git://git.infradead.org/nvme into block-5.7

Keith Busch (1):
      nvme-pci: dma read memory barrier for completions

 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
Jens Axboe

