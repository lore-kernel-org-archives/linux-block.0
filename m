Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE6C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A5020831
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 03:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="d01qCBbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A5020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLJDYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:24:12 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:58711 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeLJDYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 22:24:12 -0500
X-Greylist: delayed 918 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2018 22:24:10 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=zlV1B26Pu94XGlR9wFWUgID6JyhsXKq1x0vAk7+3z8k=; b=d01qCBbX9WFA
        /Yma26b44gpTEfrrWV+TxEK4vqwlbtF4Jh17CYHWds1AQsGhsihU08hb0lhG+jmQXtR8j3nzPg04a
        qpLzOMTYcB7VPtE+63k28c/zjZQeLjy3Y6rozYxYSVyq9FF93mQmbw1CjvFNaCjgYWjPrM9B+eGoV
        uwIIPbva5t0tQSWid/HOn4IaiYnbNwyI2F1tyi+pmB8JWPTSyc8Wv3DmUKkUA0NfklfMxsBWIhpOq
        1DYskCnyrImIo825yvIFOHE32PzHLfPqNhnXRI2qMgMV5JyUr/cUr5bb1uss+F5BPOojZsPLPCAyv
        SFEsqPpweFXdtsmXKcmeyw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWBw0-0006Sd-Jl; Mon, 10 Dec 2018 04:08:41 +0100
Received: from asus.hsd1.ca.comcast.net (c-24-7-51-64.hsd1.ca.comcast.net [24.7.51.64])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 7E3FAC05C6;
        Mon, 10 Dec 2018 04:08:20 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Todd Aiken <taiken@mvtech.ca>,
        Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] block: Restore tape support
Date:   Sun,  9 Dec 2018 19:08:14 -0800
Message-Id: <20181210030814.13235-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sX5xZERB5ZYfSk4dSbXkIN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTa0hZW3miwWUwYQUoxPMYN0/vElarfOomUcabrov8z0PeyO
 hb5GDj0rq8D+3HFJ06Dxr7qaG4fgWdY0QrMiiTmewrfgTMUWMtvWgegpvfTaAXNUcb+K173lNmeK
 aXSVkZ0DTnWiPmsvrDOE9sQjLDo1rBQRDMCPoVIktGfXqz+K7yyw5/aUKPFnDw4Bf7lOa4oclUw0
 /8UoTm9tFaQ+tM6v2Gh/Qfgu9chLVc2vRhNMldxqFl97Y4E3SNMknNYplPEk4Ndu06h2Q8QP5GQe
 NUYfzfh+1hTlNmKlqsmcMQ3aemJb4oRxP5STU+xUtRhnzoXNsFlW4xzv3KSabGJbxYTPkxkQ0H6O
 L7P/NDQJvXLBFogkcrMa30IAuQwcvqfu8p8T9oXmckUtTiqujG9MEAys0Pj+CuspuqIywLM1+yFE
 28W6VmkUOCR75FEzGh68OC8qjedQ/jV+CiBePeEy87fciSrlgXUe2FRrt3Q/saIuu1pdVjRHzTdn
 z3Xm0z5QCuv0rPJtdXKhkIUdbjJccbATbEI0+1qiZCID5pC0mn1iDfxcb3XRuJkRyiZZ6HPi7yzM
 ODodi5MLJiAvrVIiQFNhysatj2pSf8Y/sjw2Tx7jGlOIjEOAq7+zlZIMXkjo8jedyeqIoZhC5dHo
 yWeT+unFGJ9FFggCAznkY0NIg+2syH6jN/zrHSgTBXY75aL7Lf03C+PU1KMusNosSbRFhiuotUnQ
 FPKmSccSJtKR11Ka7CmEMUMorS5RhJIX8IV1I9NfaQM3FyOrMjT6Cfa6u2EHZ2ITRsTxrfq0Mm6B
 rCqJogELL9VzWOhnEfGvIkwyA7rBRBZgCikvOAMF/4pY8933AXWdvuMLZV3bWhmuaxt6pwQCpD0P
 7cLlLBv1Ynl6wdtAYEdHjLsc3JXQKB4EYM/Uw+714f+1zhJBVGCf6GMd8tnbrn0+3UKhngm7Vtb0
 +GDDqcigOvSxdRnthmhn8Zn6Bu3R8b/TlH3rj3agBo/83GDgWGooLLZtQVUvlagFdKneNHk15Vol
 AGHS5rCXQKDyKm6UHkvMKTco5nAg4mA05LI0q854skGDr1SFWz9TrEaeJv7ulMm8/tzYx+4R1cCq
 iTlhJVWE1Tu7G2kCq+1xQG9E3lUgISRJWe2MG18u+0Y=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

According to what I found in
https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block: Clear
kernel memory before copying to user" broke tape access. Hence revert
that patch.

Reported-by: Todd Aiken <taiken@mvtech.ca>
Fixes: f3587d76da05 ("block: Clear kernel memory before copying to user") # v4.20-rc2
Cc: Todd Aiken <taiken@mvtech.ca>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 06760543ec81..90c32cd3e0c7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1262,7 +1262,6 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
-		zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.19.2

