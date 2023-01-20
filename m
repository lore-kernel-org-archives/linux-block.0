Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE6C05027
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjATW0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjATW0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 17:26:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040C71BDF
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 14:26:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 800275C94A
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674253564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Izntz5qxQBRNdHj/e+L8YxlSPXyZSgP88+HNDf01GKU=;
        b=RvtjSNpa79IeMKnhouteWBU94muoLSMe5I4ksmqhqvJ1S5AZUhq6XyBWj4jm+GiE5kqSum
        QXaTTDArjBcSxuL0nXXvvXjCQ2kH0y2WuV9JbRxyt3LL4XBeKSOTb6FVDxgg6rtWzb90GS
        Qf4Ia43oOnljmJY+Bva/lNbOVDTXK8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674253564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Izntz5qxQBRNdHj/e+L8YxlSPXyZSgP88+HNDf01GKU=;
        b=a6gVZ3/1JdMsR75sqUU8qPCjIGeM8HLCbAoxgXBnD1sB4PzoImeljmo0JdgH435ku2E+Mp
        PfHOuA24F3sO7vDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34EE61390C
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 22:26:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t3CLBfwUy2O1SwAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 22:26:04 +0000
Date:   Fri, 20 Jan 2023 16:26:07 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-block@vger.kernel.org
Subject: [PATCH] atari: stricter partition validation
Message-ID: <20230120222607.gjyi4uxyg4in52sp@kora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The atari partition detect sequence has a simple sequence, if the three
consecutive characters at the offset are alphanumeric, then call it as
an atari partition. This results in many false positive where devices
are shown as ATARI partitions when they are not. There are many users
suffering this and they are finding ways to circumvent it (Search for
"linux atari partition" in your popular search engine). This is more
common with cloud based installations where a device with garbage is
used and is falsely detected as an ATARI partition.

Make the detect condition stricter so Linux does not detect them as
ATARI and continues with the detection sequence. There is already an
existing function OK_id() which checks for legitimate partition strings.
Use the function in the VALID_PARTITION() sequence.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index 9655c728262a..5f4d5faab399 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -20,7 +20,7 @@
    least one of the primary entries is ok this way */
 #define	VALID_PARTITION(pi,hdsiz)					     \
     (((pi)->flg & 1) &&							     \
-     isalnum((pi)->id[0]) && isalnum((pi)->id[1]) && isalnum((pi)->id[2]) && \
+     (OK_id((pi)->id) || memcmp((pi)->id, "XGM", 3)) &&			     \
      be32_to_cpu((pi)->st) <= (hdsiz) &&				     \
      be32_to_cpu((pi)->st) + be32_to_cpu((pi)->siz) <= (hdsiz))
 

-- 
Goldwyn
