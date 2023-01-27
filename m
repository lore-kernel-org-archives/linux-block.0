Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A888C54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 15:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjA0Pn6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 10:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjA0Pnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 10:43:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666B8395B
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:43:49 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id v6so14808001ejg.6
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XbD0jJdU2x+omBw0qnilPtQJrXIbuZZfbb07Z77I0=;
        b=rhn6HiKjfZwLaFGQK38vDp9w1cvhdoUbh8rp3/CF5hFP/JeLDKrD1AwCYvOyo+ftVM
         hva82F6VMCtIlwPj7I2iC9zPtpKPz5QijVb1HvKPXjwS1GLz0LoGMTr1spq7AeDUg9a1
         WxU/bfsL9xGibKLvrEXk9auUZmnuqUR1Ui3yd4dUnUCYMLfPr3CCn9o09ipOLmqpfy92
         i383zdPhTal2L2M2CWT9NdysSC5DoWiWD0OodJk3KEJSfuOrMYgUIp8c4YhcVq3VN20R
         ziqnBJsRLSt3BKSMMP2DlnTjJVakTNBGvdRuMe5JPN15DqlmH1PTnR+9KpUA4WwPGg+I
         Nkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0XbD0jJdU2x+omBw0qnilPtQJrXIbuZZfbb07Z77I0=;
        b=bjOCdRDa+rPkYhqmtmaLHPRci121Aixf+/mJNOMks1N7iAnt6qJRBaXtHdiKtsa7zP
         ay1bQXDvcrgd4qLabCW15bWwMOb4T3ytETIoBrRiLkjNkhldPqgMgyZ0Rf6dfX1tVO3J
         iMMudEHPFgF5LA4Ig/t00j7X319u2gMa5hoE3wr1QgCIQr2dYv5EtPwVMt0dsFMKS2i5
         cqycZuL01G4UAbsomLkJwJ28hfxrmi18WJb0byFk9MbXXbQFdzRabZqH6tACTBho6ncn
         YAq6KmJtfpS7KHDUhXDTVEcuJdzC9n137aH0NbwHQMHyxurgGKKQDkXbk4RNfE6Em2bU
         AvWw==
X-Gm-Message-State: AFqh2koMvucHYUiuIMwzM9m0kev7ptX0O+S5ImxlQENXSwPl1cS0qJek
        wakmqJO8ZLxGmuaWWvRR3g0pVQ==
X-Google-Smtp-Source: AMrXdXtIPa2FHgXTbsBWuFGKqryY9aFAnBphBxSv1zAdzgW9cAzkyCKlcCl0N7aLR0cMGtIDblr/Sw==
X-Received: by 2002:a17:906:3291:b0:86f:356e:ba43 with SMTP id 17-20020a170906329100b0086f356eba43mr40042800ejw.18.1674834227901;
        Fri, 27 Jan 2023 07:43:47 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b00876479361edsm2467611ejb.149.2023.01.27.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:43:47 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] block: Default to build the BFQ I/O scheduler
Date:   Fri, 27 Jan 2023 16:43:39 +0100
Message-Id: <20230127154339.157460-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Today BFQ is widely used and it's also the default choice for some of the
single-queue-based storage devices. Therefore, let's make it more
convenient to build it as default, along with the other I/O schedulers.

Let's also build the cgroup support for BFQ as default, as it's likely that
it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 block/Kconfig.iosched | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 615516146086..221739143d44 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -18,6 +18,7 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
+	default y
 	select BLK_ICQ
 	help
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
@@ -30,6 +31,7 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       default y
        select BLK_CGROUP_RWSTAT
 	help
 
-- 
2.34.1

