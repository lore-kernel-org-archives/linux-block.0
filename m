Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8465C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9F6109F
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhIFV6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 17:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhIFV6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 17:58:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD2C061575
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 14:57:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so11544908wrr.9
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nl4UdkBQ7HEJuIon2i0m4CGAozrtIsEtCijcNI4PowY=;
        b=jpuPsfDS3GygW3+ge+VblX+DoDg6I9S8X+v+KdIehGaPgFl7BfrGvjNkNq7vuYl5/d
         SGydYGj0BZAw85vDmxftr8U176mtQcdLC+BeY2WXJfMWlcJh2G6Q37UekyPSpa7Iu2f5
         1YLeHDT6KsUA/Xxng84eD/MBnefCOyOtgUPPhtwKs4DEOYs6oObvW7jdwykG7lEMPiiE
         uHDDOfnRMe987aAr1MZfsFCL5t7JAOlHLMf08w2AtuCb9esgdYTAaAgPmSuisC5z3XQ3
         Z4BYt169I1KQJWNDKFdna6uyhF9Ptd99Jqoc4vrNOqd9UX3erUsA/ncwEYFYRt5clN9J
         ff1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nl4UdkBQ7HEJuIon2i0m4CGAozrtIsEtCijcNI4PowY=;
        b=gakQ291LbfycxYmrZTL53bbaiP7Cm6RgkYccdCJ7Qzse07FGkO15Tt+cxWC7ppfQo/
         LoxypbX7BrPxB5SnMM2Jdhtj/SEjWLNWjG0OnM60brimz4vRdi7vJGnX+eNWYcA+06e+
         ZZpVFSy7UGjS7FryScUgc/Md9F+e1oV8eFnDabdGoXCDhu7se9jekWpLGQpIPlmTaN3A
         YTYOK6Hx0rDcHvA/nq9xu3ZraGqPmEHEXltHM6LqaHsSoqXUy+DkNpPbAxW/2Wnh58CP
         ej7/lToWksMGG2EbWxIjhiV+D+uzrNacH6WkOTBjNLp+fKI6euLHpA08PSVxOWxN17bY
         QFaA==
X-Gm-Message-State: AOAM531KqfzC/b16NsMnAxB1oMJqYOFdLQtYx2yDG9mz+OdSWcIkXPHr
        +Gk2hEWNDxtKqDoV42s7GePo1A==
X-Google-Smtp-Source: ABdhPJxhpbn1cUAW+wGq8Y5Ixb+LWhKQVpWfo6cMWbbPe/7vxjiARD8LWpRN6KP59y61J0u8DX5zMQ==
X-Received: by 2002:adf:dd11:: with SMTP id a17mr15220652wrm.132.1630965466407;
        Mon, 06 Sep 2021 14:57:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id e3sm11269424wrv.18.2021.09.06.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 14:57:45 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] cdrom: add linux-block list to uniform CD-ROM entry in MAINTAINERS file
Date:   Mon,  6 Sep 2021 22:57:45 +0100
Message-Id: <20210906215745.1992-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add linux-block mailing list line to the uniform CD-ROM entry in the
MAINTAINERS file, as this will help submitted patches to be seen on a
list that is more focused without the level of traffic of the overall
lkml list.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17faeab92f6a..67f73e40869a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19145,6 +19145,7 @@ F:	scripts/unifdef.c
 
 UNIFORM CDROM DRIVER
 M:	Phillip Potter <phil@philpotter.co.uk>
+L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/cdrom/
 F:	drivers/cdrom/cdrom.c
-- 
2.31.1

