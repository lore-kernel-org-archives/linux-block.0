Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLUKf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiLUKe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A65C758
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4WoCl1SIQbDhatQ3/vSDaEL62NDZ5t6fuJwpEfQSHQE=; b=X1RK5iEb0GoqcyTQ+oHnHwgocx
        JOhAf7J4xUitzhwBb6VyXA+xeev6J00hODSDK4ROdu+ZsWIzo0Eafd0h1s8lBmEO5pLx8BVkw8jwf
        xKBYKVWB+qycrjVE6i9zFjlVLXlSx4YevE9oYuRTTyrCaCssRMR8TgF9q6CM8Evw+C9JZ3WswwCSL
        uRxyiaQMcF/ijRnCMRzw/jD5vXqutOPX54xVvSIZxFQxJKC6v5//fVECCIjQBJWTtRpydeFmRJBfY
        gMvlpxs4Y5Fzx48xp2VaeetUJo5J6sU2x0gXektRPu9WhFb4aXpIeCUXcyHTKBD8PWwr+oI5HXKRK
        2akMzTPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQw-00DUqR-UZ; Wed, 21 Dec 2022 10:34:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/6] common/fio: add helpers using io-uring cmd engine
Date:   Wed, 21 Dec 2022 02:34:36 -0800
Message-Id: <20221221103441.3216600-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will allow us to add tests which use the io-uring cmd engine,
part of fio. They are inspired by the work by Anuj Gupta and
Ankit Kumar which added sample fio files onto fio for this exact
purpose.

We can build on those to expand test coverage with elaborate tests.

We don't specify the cmd to allow other types of io-uring cmd
users to use this other than nvme.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/fio | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/common/fio b/common/fio
index bed76d555b2a..4da90804ed21 100644
--- a/common/fio
+++ b/common/fio
@@ -184,6 +184,53 @@ _run_fio_verify_io() {
 	rm -f local*verify*state
 }
 
+_run_fio_rand_iouring_cmd() {
+	_run_fio --bs=4k --rw=randread --numjobs="$(nproc)" \
+		--ioengine=io_uring_cmd --iodepth=32 \
+		--thread=1 --stonewall=1 \
+		--name=reads "$@"
+}
+
+_run_fio_verify_iouring_cmd_randwrite() {
+	_run_fio --bs=4k --rw=randwrite --numjobs="$(nproc)" \
+		--ioengine=io_uring_cmd --iodepth=32 \
+		--thread=1 --stonewall=1 \
+		--sqthread_poll=1 --sqthread_poll_cpu=0 \
+		--nonvectored=1 --registerfiles=1 \
+		--verify=crc32c \
+		--name=verify "$@"
+	rm -f local*verify*state
+}
+
+_run_fio_verify_iouring_cmd_write_opts() {
+	_run_fio --bs=4k --rw=write --numjobs="$(nproc)" \
+		--ioengine=io_uring_cmd --iodepth=32 \
+		--thread=1 --stonewall=1 \
+		--sqthread_poll=1 --sqthread_poll_cpu=0 \
+		--nonvectored=1 --registerfiles=1 \
+		--verify=crc32c \
+		--name=verify "$@"
+	rm -f local*verify*state
+}
+
+_run_fio_iouring_cmd_zone() {
+	_run_fio --rw=randread --numjobs="$(nproc)" \
+		--ioengine=io_uring_cmd --iodepth=1 \
+		--stonewall=1 \
+		--zonemode=zbd \
+		--name=reads "$@"
+}
+
+_run_fio_verify_iouring_cmd_write_opts_zone() {
+	_run_fio --rw=randread --numjobs="$(nproc)" \
+		--ioengine=io_uring_cmd --iodepth=1 \
+		--stonewall=1 \
+		--zonemode=zbd \
+		--sqthread_poll=1 --registerfiles=1 --sqthread_poll_cpu=0 \
+		--verify=crc32c \
+		--name=verify "$@"
+}
+
 _fio_perf_report() {
 	# If there is more than one group, we don't know what to report.
 	if [[ $(wc -l < "$TMPDIR/fio_perf") -gt 1 ]]; then
-- 
2.35.1

