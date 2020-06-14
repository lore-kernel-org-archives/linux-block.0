Return-Path: <SRS0=YUXN=73=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C5FC433DF
	for <linux-block@archiver.kernel.org>; Sun, 14 Jun 2020 21:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061D22065C
	for <linux-block@archiver.kernel.org>; Sun, 14 Jun 2020 21:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y66PACa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFNVWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jun 2020 17:22:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9509C03E97C
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 14:22:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e1so15101978wrt.5
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=vkKaGrZd8/FWch8LM+2Yi5Cp+VSHjNvxCe4v1yqHnQY=;
        b=Y66PACa0xEeXR0p0k+Sj1QGaaFQLBVtEYthGu0Y5lda8kfq7ElNI6rjrIIERYFu4sI
         AW157A/Nh0x0doDXjCxMDyUyxeAqMjaW0WclD53NJSRdtnLLKlu9zklXtJntPX2AGGU6
         3DoXRJekJSLkzw9gsfvICPgiQV01yVxGE/Xiclifqa6kSW3yeXJgImeMvJR7IKR18Tht
         tW0m0Txu0mehV/yBE+NoAChRsHWnhzty3ZXGyFukMtLzdmr0Baj7il6pSFmGiV5wYidg
         +4WTYq4zCBLB+5zq+fw4L3n35LYOYXmo1MzFHUFWN89a+SUW1KjMoliim0NTsERB5NVW
         yjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=vkKaGrZd8/FWch8LM+2Yi5Cp+VSHjNvxCe4v1yqHnQY=;
        b=RoJMj8slBSBQbZDB2rPtjt7bgVcCAD36pYsosjhdGNzUOEjF4v8Mg1W08xB404jiFK
         HpoBUiPEwsJEkgCYQ6MOc0rZgcdFxGFV+cKF1EoT/yt/HrUyQuojh+4WFxg/4+fUpg3Q
         Mv88zMgoXVIL0j9ERnUuPVB+MiaVpzb/BMst2RbsTcux61ifZGABHkMfDkPZb3/zJYQl
         sl3I5tOLyNV+ztYn/e7c/Z9OcSTtzlhQ09VjsPCl+QgCs3kuQfhyI+X/hBTq/4fcPJI4
         waV6EySAMbIVncULwz0S4Mi5cHWOPIWsxc+mC1VOk7ttk2n5ry7ci5XoQ5kH5Epcdvt5
         qT2A==
X-Gm-Message-State: AOAM531XcQY3ABF0BlC6U7pFrJdlUyxTAwhIOjnStTXhsYahh3c0BPvP
        qCIhYzzHqoqGBzd19A4ATrTr9jIQ
X-Google-Smtp-Source: ABdhPJyQaolGotz9SXOSrwPJuuV6YLtgC6hDN7YYMZZXZ0TlkewiobyFI4AKTz8EmXRuLWtrG0UN/g==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr28049023wro.60.1592169727858;
        Sun, 14 Jun 2020 14:22:07 -0700 (PDT)
Received: from mStation (host-79-51-202-241.retail.telecomitalia.it. [79.51.202.241])
        by smtp.gmail.com with ESMTPSA id o82sm20290844wmo.40.2020.06.14.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 14:22:07 -0700 (PDT)
Date:   Sun, 14 Jun 2020 23:22:03 +0200 (CEST)
From:   Enrico Mioso <mrkiko.rs@gmail.com>
X-X-Sender: mrkiko@mStation.localdomain
To:     nbd@other.debian.org
cc:     linux-block@vger.kernel.org, axboe@kernel.dk, josef@toxicpanda.com
Subject: nbd leeaves threads around even when unloaded (5.4.46)
Message-ID: <alpine.LNX.2.22.419.2006142249410.14412@mStation.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!
I don't know if this is an issue - still... I used nbd via qemu-nbd, and all worked fine.
Now, I unloaded the driver after finishing. But still I can see around a kernel thread:

$ ps ax
     988 ?        I<     0:02 [kworker/u17:0-knbd0-recv]

$ lsmod |grep -i nbd

Is this an issue?

Thanks for the great work!

Enrico
