Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9BC43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558FE2070D
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecj1mEMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfDBCve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43057 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCve (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 22:51:34 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so9613198iol.10;
        Mon, 01 Apr 2019 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=miyH2II+miP3tXVxsQJN3zlkey8N5ncDarOpVZMD6ek=;
        b=Ecj1mEMehLkxsyS8gmIeF4HIoQHVcZ5eJjnvUBHznre0t0AnDK5dzb7i2KXZE0Ktz6
         0TzRBKfAilMgESp5TdYnLFmEhSPXNCpa5pQ/QcImfB+YG3xsi0JRL01Ggx4WNaj+5c/t
         +lcU/5iuIEOq4+ZsGP1+GDJBnf056jmemtN7kEflLouR+toWlA1BjRN41vEgme5EZ5ds
         ff/HRbZEPoB5cd4t4HeXPfwxqCiQwQa4IaqfH6ffJ8GaKJGG53L55tDF/uH9yekRuOdL
         n8ZxOi32Gm7RpvsB++nVsvZLh0SmUa16u3tVaSwltzPntzPvWtpnSTrkZVjNkQ1nK2zP
         MppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=miyH2II+miP3tXVxsQJN3zlkey8N5ncDarOpVZMD6ek=;
        b=MH75lOGbnD10h9WisY/Ru8BkpP5HeNsHfzUdDCQze6ZrKjhAkPd5QUi0dFZrqOPjtE
         9m3BBlA2rIOVt/fDTBfe9i25w4ll0sc0fBAQ97WGlhbRrp+Rhqva8a1GYtUHpW/4Einr
         Y6CM9vW9KyXUTNqZ+XYOOi+tfF+o3+3SH/V27kv+cimMOPOsqsIuAczMQ0f4Mo8V/qr2
         EFNnOGfbE8olnl46mCuD9V+wJ/mbSeYq35jxdl2iAht1/PyaLWDuYvnpmgMx6vL8781O
         W1PQGqw7si0BweN67JrJA6mASjFRgobr1iBmdZPZgIdbUu3Jydt40TleBEnFKm1+C2b5
         FANQ==
X-Gm-Message-State: APjAAAVfu0kvyYa9GKlK4WyWBfZLnIxTsQLFSkNit7tgPEMhyTFN1k/T
        55RDxSsT5+IFRQuKR/1mBko=
X-Google-Smtp-Source: APXvYqyUyZKl4cmApxYxLNGuYexxWfhbn4qo0LZjwmmFQO2Ji7F1jp0FTEoD/xnncUf07i7ewonPhg==
X-Received: by 2002:a6b:ed0c:: with SMTP id n12mr33168370iog.259.1554173493353;
        Mon, 01 Apr 2019 19:51:33 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id w184sm6369080ita.9.2019.04.01.19.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:32 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:30 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] block: Replace all ktype default_attrs with groups
Message-ID: <e3b82e2105d1e2b4d6313d862172007e0f4477e2.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace all of the ktype default_attrs fields in
the block subsystem with default_groups and use the ATTRIBUTE_GROUPS
macro to create the default groups.

Remove default_ctx_attrs[] because it doesn't contain any attributes.

This patch was tested by verifying that the sysfs files for the
attributes in the default groups were created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 block/blk-integrity.c | 3 ++-
 block/blk-mq-sysfs.c  | 8 ++------
 block/blk-sysfs.c     | 3 ++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d1ab089e0919..85864c71e858 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -365,6 +365,7 @@ static struct attribute *integrity_attrs[] = {
 	&integrity_device_entry.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(integrity);
 
 static const struct sysfs_ops integrity_ops = {
 	.show	= &integrity_attr_show,
@@ -372,7 +373,7 @@ static const struct sysfs_ops integrity_ops = {
 };
 
 static struct kobj_type integrity_ktype = {
-	.default_attrs	= integrity_attrs,
+	.default_groups = integrity_groups,
 	.sysfs_ops	= &integrity_ops,
 };
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3f9c3f4ac44c..5315e538b3b1 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -173,10 +173,6 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
-static struct attribute *default_ctx_attrs[] = {
-	NULL,
-};
-
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
 	.attr = {.name = "nr_tags", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_nr_tags_show,
@@ -196,6 +192,7 @@ static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_cpus.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(default_hw_ctx);
 
 static const struct sysfs_ops blk_mq_sysfs_ops = {
 	.show	= blk_mq_sysfs_show,
@@ -214,13 +211,12 @@ static struct kobj_type blk_mq_ktype = {
 
 static struct kobj_type blk_mq_ctx_ktype = {
 	.sysfs_ops	= &blk_mq_sysfs_ops,
-	.default_attrs	= default_ctx_attrs,
 	.release	= blk_mq_ctx_sysfs_release,
 };
 
 static struct kobj_type blk_mq_hw_ktype = {
 	.sysfs_ops	= &blk_mq_hw_sysfs_ops,
-	.default_attrs	= default_hw_ctx_attrs,
+	.default_groups = default_hw_ctx_groups,
 	.release	= blk_mq_hw_sysfs_release,
 };
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 422327089e0f..7a95a1eb27e1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -769,6 +769,7 @@ static struct attribute *default_attrs[] = {
 #endif
 	NULL,
 };
+ATTRIBUTE_GROUPS(default);
 
 #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
 
@@ -890,7 +891,7 @@ static const struct sysfs_ops queue_sysfs_ops = {
 
 struct kobj_type blk_queue_ktype = {
 	.sysfs_ops	= &queue_sysfs_ops,
-	.default_attrs	= default_attrs,
+	.default_groups = default_groups,
 	.release	= blk_release_queue,
 };
 
-- 
2.17.1

