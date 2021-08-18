Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C0C4320E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA7C60FA0
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhHRG0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbhHRGYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:24:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7EC06129D
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:24:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t13so1096684pfl.6
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+A9B+piI2a1pz1tZAhljlWwZX3AUujJJLfFoqwX48c=;
        b=Q+q1h03VOWqVXzc4UWVq6BvyCUjGxNglcQsoPbOnB43uw1Jqc5Ed9uK4QDnveHGz1L
         Kya8Q0vnWUuWLwq9hkYIWv7GxXRbMo2Cn56A77ympKTwr1zpeF0LpQAEZ7AZzIuS6Rai
         ktv4XVcS4xzeG7T6YIHvPnWg9yZ74XkeQethw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+A9B+piI2a1pz1tZAhljlWwZX3AUujJJLfFoqwX48c=;
        b=PZX7/6EsxlTCJbXMSrtJ2fFmLOVPUgjlM3EukFNjPbQqO1Y3hRdcawLHM68MVsXJvq
         /KpERuJQfTKHav2dzlXynUqvwJu2pFrmghszpfRkm6k6ct67L+9PkHubZZ3blo8bycZJ
         poHzyL5/ko0I0EBfZgKGYwsivSB1QQX2y9gNbcNGN17ODYYdBPBi8S7Ca1G79kXm4Ee3
         82QlieXOvop5Snyyw/3rnQJro0jyij8k00+MoUCrGFWESbX+fY51w8ux4HWCNTZwBIkq
         FeyY5fdwh+tmGNyHegBvHqCU3IWRVVIOww89N/qDIlhTQOacTSy4ZvlAPFwlogpI5Dzf
         oUYA==
X-Gm-Message-State: AOAM531c/oSB7WWBSJO029/Hv3hDzNmMXy9bkz/TcI/jZzBaERdksziM
        fiaXiZNvHww2vTECqVxxKoV84Q==
X-Google-Smtp-Source: ABdhPJxCPUoUEoBjNrtfl0W88T/NpydxEyxEPAEFUx/gyRjyJ4MO5rFkm2cPoNcf30Dno8o0XcPo0w==
X-Received: by 2002:a05:6a00:134e:b0:3e1:1ed:80ff with SMTP id k14-20020a056a00134e00b003e101ed80ffmr7575503pfu.34.1629267853688;
        Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p24sm4878901pff.161.2021.08.17.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:24:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 54/63] dm integrity: Use struct_group() to zero struct journal_sector
Date:   Tue, 17 Aug 2021 23:05:24 -0700
Message-Id: <20210818060533.3569517-55-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; h=from:subject; bh=RPEjx0xOcNjHRBM+3EZ1vHtaj+TxiBoxNq+cj1Ac9bE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMqKJz2SoJYeKtBFLmX4tcR3DHJFXvBbKzH4heh kSEkuyiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKgAKCRCJcvTf3G3AJuKGD/ 4n4SpuomtIZ+g22QufnnrQNKHA98zIHUxCFyPUWlldkaYq1yjxANA7kCeWzhMyhnDbNsMcPnBz0u8w gTumF2NUeGQx1DWnIYpoWchHj0biXBVmJ627d0qH4ZPJV0xVoCra7OxBNu9MzddxWpF6sdPcwkm6G6 KRyO9F4M4JhZ6wIx91tgVghgSzl5twheIhtA3njJ073Q8wNaDnBzfs/l9Ut/AzjfupZu1x3ki+jwpu WmD6nfcKbq0Iek6wuIdRHun0EOL5PBZd4fWR1bJEQePLiZZr/WzyrJktCcPBtbfNoxoh3Zd/RDOYxC Phqtb9d6KbfQDNPiqFq8A/FFx6Omeamuzt6AZrvZOtupVwaAqZxmTGL+T1t6dJrUD1sjtKDjGoNOLi 7dn6c/08XUE+My/kdCiaqMIMLvnXKeruIHQhrlJ6zoMYvFZ06D7/j39GezPIeXXaEJGwuF4EXX7UYn QzJ8yJKQqHgf3AnzSklDq7S2QgMQbMBg1H2HY21GsA89Wb8lyNm0RvImBjKDi+T7HWHtu01K2er3t2 O4+fb9meXQjoQXeBGEZ9RShjhKkgK9BaIxyiqfANsALqrrzQxMSMbRLvnALSRrEOGtrHi3ZBCAsQ/F uBwH2rx2bGKY/138CbdayzcXJ/PERuBisG0LhMFqbUDxYwVopHT1lxsnBtzA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct journal_sector that should be
initialized to zero.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-integrity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 40f8116c8e44..59deea0dd305 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -119,8 +119,10 @@ struct journal_entry {
 #define JOURNAL_MAC_SIZE		(JOURNAL_MAC_PER_SECTOR * JOURNAL_BLOCK_SECTORS)
 
 struct journal_sector {
-	__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
-	__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	struct_group(sectors,
+		__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
+		__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	);
 	commit_id_t commit_id;
 };
 
@@ -2856,7 +2858,8 @@ static void init_journal(struct dm_integrity_c *ic, unsigned start_section,
 		wraparound_section(ic, &i);
 		for (j = 0; j < ic->journal_section_sectors; j++) {
 			struct journal_sector *js = access_journal(ic, i, j);
-			memset(&js->entries, 0, JOURNAL_SECTOR_DATA);
+			BUILD_BUG_ON(sizeof(js->sectors) != JOURNAL_SECTOR_DATA);
+			memset(&js->sectors, 0, sizeof(js->sectors));
 			js->commit_id = dm_integrity_commit_id(ic, i, j, commit_seq);
 		}
 		for (j = 0; j < ic->journal_section_entries; j++) {
-- 
2.30.2

