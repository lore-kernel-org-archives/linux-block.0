Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD8C00454
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C422A2068E
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=selectel-ru.20150623.gappssmtp.com header.i=@selectel-ru.20150623.gappssmtp.com header.b="w4IiwbLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIN6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:58:15 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43071 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLIN6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 08:58:15 -0500
Received: by mail-lf1-f44.google.com with SMTP id 9so10762291lfq.10
        for <linux-block@vger.kernel.org>; Mon, 09 Dec 2019 05:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selectel-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vmAxRQslN1WHtzKAEDFfm253H8OO/woF75J8QZOpX1A=;
        b=w4IiwbLBkv+mh/w1I0VAZeYraO8DLmQ0bkRsfCVNYbIxC6HkaAEWHa6fKvhK7uB2Er
         d9ueZVPK3wUfdQ9UoRwmKRXxjmFHjOKj5kksmogMsY6b8tDo/GE3MhycixKfGpagHWbQ
         OaJlX0R8xWjkgqF8yNJ7BGcafVosOm8mVrYKUYJjRtn16MxZvQQGZP7bRrbhpxYKBs5v
         FUI51DysfkiG8CHDRzdHhklcRHchYmdn+xxs8fdcgCIc1mSMcAGuxTWKZVSlyRRO5MDW
         PNdGJrqDPfXuspOH2DWBi4hdUmmL53qmpIjxZ0w2M2BiV4wBKqE0uPDTIPXF9uU0lUbN
         LTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vmAxRQslN1WHtzKAEDFfm253H8OO/woF75J8QZOpX1A=;
        b=rw0oxppW5L7iOH+pmof0h8+coJahPhrVLr0VqpiLlfY5ucdgHRSbJqfmcFgnhFeI3B
         6acZiaULD89DVNf+LTZAR0hpjkonpTVT6pX4Dy2VgdXfWHy+WY/yTnPYXfA1M/FXdYwA
         EOPCfkfYetOfwkxpR78w0zwqxJ2eey++IJ25SrP5C7xRl7OUvvTzO+EDO68rV+QL6Idp
         kxjvtNMbzYjAetSlrj48VvJBm6YS8VGEy1KJKIDrH0Wjb5XTqPlXG9wxuMKFtFmFnmXT
         tnUdGO6sxIA6b5M2FBBBYY86Twz/hNJez1+gOebQhJDj4Bbjn2jTk1i22at6VS37CDmR
         MSeQ==
X-Gm-Message-State: APjAAAU32t2vmb3lRMsTtjCdQUCAt0JSatCyX1Rfg/UiQCih8iiOwlqo
        hh1x6L6wf69Koh4+haOe5y3DX0oI1xY=
X-Google-Smtp-Source: APXvYqzkN0sWVjzjz/VJIQA6D10J5CMv9WRou3NgLB3buyN3m3NKvH7bj65BFnrzTNbpJDFiR/03gg==
X-Received: by 2002:a19:4f54:: with SMTP id a20mr15867769lfk.39.1575899892709;
        Mon, 09 Dec 2019 05:58:12 -0800 (PST)
Received: from some-laptop.eq.selectel.org ([188.93.16.2])
        by smtp.gmail.com with ESMTPSA id g14sm11099511ljj.37.2019.12.09.05.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:58:12 -0800 (PST)
From:   Aleksei Zakharov <zaharov@selectel.ru>
To:     linux-block@vger.kernel.org
Cc:     Aleksei Zakharov <zaharov@selectel.ru>
Subject: [PATCH 1/2] block: extend bi_flags to int and introduce BIO_SPLITTED
Date:   Mon,  9 Dec 2019 16:58:00 +0300
Message-Id: <98a5873acaec4ef4b3f58eeed5b6eb65a445b2e0.1575899438.git.zaharov@selectel.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575899438.git.zaharov@selectel.ru>
References: <cover.1575899438.git.zaharov@selectel.ru>
In-Reply-To: <cover.1575899438.git.zaharov@selectel.ru>
References: <cover.1575899438.git.zaharov@selectel.ru>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BIO_SPLITTED flag will be used to gather statistics for
splitted bio's.
---
 include/linux/blk_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..7ff32e7c48fb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -148,7 +148,7 @@ struct bio {
 						 * top bits REQ_OP. Use
 						 * accessors.
 						 */
-	unsigned short		bi_flags;	/* status, etc and bvec pool number */
+	unsigned int		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
@@ -207,6 +207,7 @@ struct bio {
  * bio flags
  */
 enum {
+	BIO_SPLITTED,		/* set if bio was split in bio_split */
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
@@ -240,7 +241,7 @@ enum {
  * freed.
  */
 #define BVEC_POOL_BITS		(3)
-#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)
 # error "BVEC_POOL_BITS is too small"
-- 
2.17.1

