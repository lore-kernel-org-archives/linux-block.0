Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C6EC282E7
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 06:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiHPGaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiHPG3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 02:29:36 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209067645F;
        Mon, 15 Aug 2022 17:44:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-33387bf0c4aso8394877b3.11;
        Mon, 15 Aug 2022 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=CsC+j0kptQXyDU8jUOJJkLIgy9EO57j1cJI24xW/Lks=;
        b=HR1SRzlAc6A+jKkxiSeTn7zBxq84sbDNzQ8EjnD5LQjD7/Jv4uCKQ7PsK4ShUN598D
         YJ44WChMo+PTbLKHC939js2KpEenZpa0W6/X4lembTFpYdEySWoBKzMuqtGzARQ3KacB
         JXqs+N6zQe3GNtFq3ya8BKPtYHhMltx7R5t38uzRMmO/utU/vyhaWt75JR1IZq+Lsih+
         DrHoKI0NaeBpDZGdzn+ldMsTQCpENA9O5dOtKZdD/d4F47hFtJNl5SUlKRrisRD33t1F
         eHeSDlq2Cs6guhlFXtEAWaa2NR1gYTRj8HBDamjN8gmXpmFfTN64ufkQ+bTcUEzEFN6c
         /OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=CsC+j0kptQXyDU8jUOJJkLIgy9EO57j1cJI24xW/Lks=;
        b=mb1DN1siBbGfxtw68xUpMkZYKHScGtdXE1JbTxnLDLYWF02RA8RnkedHmCyKkqIiR1
         FOynfoC6Uk/hpzdGHn1JqR0gCEUDc1uay2+geRmnRQnhSoFuZZBHimdnxCEVhM3l6yr7
         WlXg4M0Vkj6QDeM891qMG9GjgxIu0x0PBfihwBvHu5Nc6dfy0Jwk1zbregjGN/38oEpQ
         oW2V+FTSemTrpIBA2NeTRMJiEBAtiGGr1hyr6k05BJGLMODZW7SxJa/UgKUUUrBmA/19
         JOEMKcMBPTO/TLPJu53x9QPbfoiVQMWg6naam/T/XqY9evg1k6ZyCfoLwpZbg1nb68G5
         dWjQ==
X-Gm-Message-State: ACgBeo1FEzm744jHGo6vgtYi2irfodNMeiKqnfRftdb0hcJiYCx+adDP
        bNYbGOE6TXsx+qNK1ZfHlR7+jkdlRIRt3K8YgaN1VuxXAg9625A25OI=
X-Google-Smtp-Source: AA6agR5A7f3m84c1TtI6f2r6XmTxvD13yN6Dg+5eE1cWCdEqLisdawEIlErejWKWe55LX3f7hyEwsc6WKkkCnwttmQc=
X-Received: by 2002:a25:4282:0:b0:67a:6a4a:e138 with SMTP id
 p124-20020a254282000000b0067a6a4ae138mr13665637yba.395.1660610650217; Mon, 15
 Aug 2022 17:44:10 -0700 (PDT)
MIME-Version: 1.0
From:   Alec Ari <neotheuser@gmail.com>
Date:   Mon, 15 Aug 2022 19:43:59 -0500
Message-ID: <CAM5Ud7OqLyi=iSAT7fUuA2yZSqvhJ7hNZND=L5woMV9UxnBn8A@mail.gmail.com>
Subject: [PATCH] init/Kconfig: Preserve mtimes in initramfs only if BLK_DEV_INITRD
To:     linux-block@vger.kernel.org, linux-config@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alec Ari <alec@onelabs.com>
Date: Mon, 15 Aug 2022 19:13:12 -0500
Subject: crypto: Make FIPS_SIGNATURE_SELFTEST depend on CRYPTO_FIPS

Would running FIPS selftests be necessary if FIPS is disabled?

Signed-off-by: Alec Ari <alec@onelabs.com>
---
 crypto/asymmetric_keys/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed..562bbd774 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -81,6 +81,7 @@ config FIPS_SIGNATURE_SELFTEST
          This option causes some selftests to be run on the signature
          verification code, using some built in data.  This is required
          for FIPS.
+       depends on CRYPTO_FIPS
        depends on KEYS
        depends on ASYMMETRIC_KEY_TYPE
        depends on PKCS7_MESSAGE_PARSER
-- 
2.37.2
