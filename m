Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B359C3F6B0
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiHVVF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiHVVE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 17:04:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901533C171;
        Mon, 22 Aug 2022 14:04:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p9so10453062pfq.13;
        Mon, 22 Aug 2022 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=ThAxsZe7xP1RHquTEZP41Gl6OfvmKnzQXlkVZjrDUs4=;
        b=BqcoqA2D6ZOhMpXVVdloGVJSsZhXlBEaZJZP5xx75RbjzE+dsy15iyB02JGlvH6qIg
         4NRBNDYx20cFOayFEto5cZu0fX6d9Zko2q1o7uyLpgi+GD1b6jK/Il99Zi7Btj8Vqy6g
         RDp1fOlvYXQsQI8iQVSmfJ0AVDLsuB1g2vTOAOBz/n8HbwWGHhu9+VNcj4pyvhW1QqVz
         UkN7HReuOXxwMKNqeHTRBmN7YhGHCarceyh6+KeQB6jeld4V/Irh3VAQzdHoK6wYvUeT
         JLXUnWMRaILBEJAdgQJ57mX86kgkUUi2ipi0nzrvqJj0ZcX3S7winvFE1A2rN3H1NihJ
         jVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ThAxsZe7xP1RHquTEZP41Gl6OfvmKnzQXlkVZjrDUs4=;
        b=XCgb7rels8iNVMcJIFowwaTWU9ZL5ZSMDc4laTHd/54DGySAnTsrMh+iXFUqVdgUIx
         JBdymCraYCDyzJtla2Cmz72qO4Gj5uTkkr8wTKs/sV+QjPBmt8NQ4yuA/qtL18+drPn+
         Ar6pEZzvdW2wFBsfYUp5kr77ZpcxAd5INzmhYAisNWipBoAHhx82VZc4AUUBybu2hsvf
         P0C4E6m4PmyyVFZ1SjFnPcdAGuz+hgAkQpnbT71v4evmq8rgUZVZ1o3u22c5uDVW3Ejz
         VmVlilJyQH4rIR2D7CD9MOTZ5REmuROz3Eiw6AqaKdmwdDw6fEwTevpnDv102EQCOBGV
         sSMw==
X-Gm-Message-State: ACgBeo39j4IkxUIMPDqIVaa4Eo0wEKgIRYJQgFags3UZ8pnMT53BpqfP
        iomK/lOiInccWmHfQjjY15c=
X-Google-Smtp-Source: AA6agR6bElHHODtQySZrMfK4BFWqS5Ga7OaABQBRBLho0uQcFCwqZ62PwcZjnUJ7AAiGeICJXk+9UA==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr18407844pgj.539.1661202266156;
        Mon, 22 Aug 2022 14:04:26 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id i123-20020a626d81000000b0052e7debb8desm9005514pfc.121.2022.08.22.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:04:25 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 0DDD036031A; Tue, 23 Aug 2022 09:04:21 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de
Subject: [PATCH v9 0/2 RESEND] Amiga RDB partition support fixes
Date:   Tue, 23 Aug 2022 09:04:11 +1200
Message-Id: <20220822210413.8603-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The simple fix still leaves ample room for overflows in calculating start
address and size of a RDB partition, though such overflows should only be 
seen in rather unusual cases. To address these potential overflows, checks
are added in the second patch of this series. Comments by Geert have been   
addressed in full. 

Reviewed-by tags by Geert and Christoph added. 

Cheers,

        Michael


