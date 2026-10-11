Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAE3630AC
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700607; cv=none; b=QFkuOQpDhwdu/rhE6FAyrwAjQuSZehmvt5Wc7ZgLb8P0hNv7JS7bwK4fqxEinYUYXP9jtzsn6+MtJ+6xEepkp4a3/8mJhAzYLLifwHYVmfmxUtkDP6YCJ6MpXs6RkDKeI5VnsnZe+1SzGpDIAUxeIb2tUO4K+qBk+4JTbC64IFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700607; c=relaxed/simple;
	bh=qh4hwJy1A4Dc07e6LEErqO0jiKfzaOKBZfypbSvUcYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYyfLXVi6o4o81+GaQkq3SdkMU/pIy4glB04sgE8sIlFj7P88bsiDWMY9R8/OwwqvSXhLaY5/5/tt03vEQvXi1UyjzOgC/EtP5smgC0l+8kPIHD14Ml2+rbzjcaMZgcyjcIiEa+ONFd5+fi+8/K1q0qd9lW/DbQA+UbNVH+0nRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6nX0/Mc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6nX0/Mc"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7fccba9c675so3571903a34.0
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700605; x=1792305405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzI+GomAPiikqf4PmaQLaS9iBLTMVvJKMfWT6zXyTF4=;
        b=P6nX0/McAfLDKPFh/LFXmXf/jC/StzuZ2tobLg62Lst03obiaRazMtl1/RwvfzcUmJ
         WQq/uJJ/GDO5bDAby7jO79KArr4lgXRVRR0STWoLpi8qu40vi2vtGHlNxfWV7xDzNO1w
         KR2tjx19HP1ni8MFqEUAsAFPKeS2x+DDREfuHywzJofuamKpvPasDGjuyBjAcNSgX+7P
         gY3r3m380BeZmaeWxKP2DSCltMfhvTTdzxAhrDAI/kbTL/3v0VEh9KPWwwTBB/Fz3l/N
         Rcmic+lOpSP2XDoegsiQ4MKzxJUPg5Ypbx2JJFqYJpRzYWUagapG2Z5rVqErkxZP0+fx
         7PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700605; x=1792305405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzI+GomAPiikqf4PmaQLaS9iBLTMVvJKMfWT6zXyTF4=;
        b=YEBdDUzBl8hJZtUzOQziC2SiHNiy80fpUDj66whIcVNlb64Z8whW0RthCVgec8x7q+
         kjKYiQ/d5YwD6FVaSiETnn3xTA8M6YdFU242+Uk2BIe/K1WyUQJaHSyIWhxAI34RVWv/
         CQdhW5OPly2qQrIAoLhWtBMcPZa3obrsVtgGIrBrtHZ85r9fK5/Z/CBkjeaAEOXlpWa4
         q3l4qh7Yozy5vxxDsfvUyKI4dlNcxb4V8aAiQNbqXlUgGMq5IiUn3G3Lu8BeHcUlyPzg
         xcb6q4M5HGBHUCAOxvuAOVKk7ROsJlFwT7344CsmBDnNJBf7fCeNKmKb2s1yPnVHNdcX
         VQlw==
X-Gm-Message-State: AFq9FYJs/MMMhR2R65CCThvvPn+Fj1db7Xz02sgQLa+3zcRccTEvJJwY
	6K3KA6QTA4jWbExkLKZYKXGZuQAUALJgHJqh0k63F+2042y/j/PttwQOaI1ohBL4
X-Gm-Gg: AYBFou3lCkAFL4hEZ8kWGL08ObvcQHRboFUFnj58dYRaOEX8nEjwZBwpoTXXCcH5ZHJ
	e5sxuC6MZ5omgJ5VWmuBRHLq2zDUKkEj29Ah76kYUiIvk1i+sATsiDQ9kS3g4i+K6NRGZcFoUNY
	xd0bbzTrmma1+mM3xmymAgudzeJ15yPrnrjAt9UYijtuslwqjBT3em+aRxZd8jaiAoPDwS9GmQx
	p6ZELBn5SM9pMTRP9ENlCaLaLptltd5cz5qO+NbZk8SA85mAz4MYuMYRUiLMFc+jPiwUqDaBD4Y
	9pBDCp0OTbtBedN7/eNogrOzmGjAyZfzFAqjOWeYrbIfcCmhYOLl0kwDN3MBBseZN4qeRAlrgGf
	wtnyMqK/TK/74HMS9tNHJmuT3U2smPNMeRzhLQyI3uTnXxugL/zJprkQn8+UTLoIFwlHTRtrkar
	OkPGJYHVkHw8eGjY8vbEa8kXNBIx0hZ6ZX5XlrzCMIzEAPS0R432ZmvJgCW7t7x0kJ03UAMCRMv
	DVWDcrrKblGjerdUHa/NZSfJTbYerKUo9+0wk9WbVyj7nxRTpjkSwLzKZWifSKLUEwJuEkXsU9q
	bOxHkiW5vSAeg88z9EyKIlv8KHaJpxHYU0vQgQ==
X-Received: by 2002:a05:6820:1612:b0:6d7:bbae:b523 with SMTP id 006d021491bc7-6eedd48797fmr4098669eaf.5.1791700605289;
        Sat, 10 Oct 2026 23:36:45 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:45 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 10/12] selftests: ublk: stop a batch thread when PREP_IO_CMDS fails
Date: Sun, 11 Oct 2026 01:35:53 -0500
Message-ID: <20261011063555.1142277-11-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since STOP_DEV turns the server away until it closes /dev/ublkcN,
UBLK_U_IO_PREP_IO_CMDS can complete with UBLK_IO_RES_ABORT when it
races STOP_DEV. kublk asserts that PREP succeeds, so the daemon aborts
before it reports to `kublk add`, which then waits for the start event
forever.

Stop the thread like a failed FETCH_IO_CMDS does. The daemon's
START_DEV then fails, and `kublk add` gets the error.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/63d8149c093169706e7478e779116b61.josef@toxicpanda.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/batch.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index d8d9ebed5979..dfc81ee17d07 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -410,9 +410,16 @@ static void ublk_batch_compl_commit_cmd(struct ublk_thread *t,
 {
 	unsigned short buf_idx = user_data_to_tag(cqe->user_data);
 
-	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS))
-		ublk_assert(cqe->res == 0);
-	else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
+	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS)) {
+		/* e.g. UBLK_IO_RES_ABORT after STOP_DEV: stop like a FETCH */
+		if (cqe->res < 0) {
+			ublk_dbg(UBLK_DBG_IO_CMD, "%s: prep failed %d\n",
+				 __func__, cqe->res);
+			t->state |= UBLKS_T_STOPPING;
+		} else {
+			ublk_assert(cqe->res == 0);
+		}
+	} else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
 		int nr_elem = user_data_to_tgt_data(cqe->user_data);
 
 		ublk_assert(cqe->res == t->commit_buf_elem_size * nr_elem);
-- 
2.55.0

