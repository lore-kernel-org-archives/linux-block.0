Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED210E8
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qf621fIJ"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906610EC
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 18:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699412090; bh=OoHZhupQT0syz3NABiz3twQuFX1FUlbXYEoR4/ntNEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qf621fIJZw9UKGLNkrLLBTYjpBSHr64VzCkhfQrjmb93H8Zia1B97zBu3Oa8f1eer
	 8ejxRYR2t5OBSdOLNQtj97SBEg2+N3yBAbI7g8Qq0A0p717UDENt2IuWPrZuLjirGd
	 1ZcTqSBlCpPAyS6ae4nQ9dAKCiY10Cq3UrdDrUgg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id BA90F623; Wed, 08 Nov 2023 10:46:41 +0800
X-QQ-mid: xmsmtpt1699411601tmxgwi2h9
Message-ID: <tencent_03A5938DE6921DDDE9DD921956CFAD0DE007@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j881P8xi40ZkgZezPcmjH4JPChzWAQ20X6Rxjhui/zu5RqdhICI1
	 YphZM7ck/cnXvp95Z3JMTM7exYeuCf0HBAd1IJKTKakpa4sv3tl5gt1LwxAduOgOzuGUL4xd9Swo
	 oRKYYA6fWwN7WBU/ZTY7ODDe/a8sJPlEd6fzUezAvTGDa5QDUJcXvQiVYDY489KTBt55i5f+++F1
	 bY5fefSvEm3jvLmQdBN28+8cSQaeMEBMKnMM9sleOXd8ghCTOIawkfqa5NGGDMr0xQj9K2YRtTE8
	 6LtSBSMu5gwng6glB8D7lnTfQ9Qd0nMG42FyTiQemGWSWMGxmKtPQtxQ19xeoT+kE2XMUHeGVRrS
	 zo9UNkY8wNHgT1/jmj/SZGuDPKuN1p5WKB3x6l9Wpi63Be1dJzTWbR/YUrWU5h7VwWbRo+RI+xNg
	 /MBbuK9y/QXzowzPVoL1TmnAi4hLVNsPfPfImf7QU4X1lLzvkaOtXgS4RIJr182yAbTBJPc3Ys5S
	 Y1kH2ZeAc3cRkcXCFkeOwQ79K0N+Sd4KO1sadm2HRDtdCPHWAKwrofgXOk4oX8EIfE8r9wSrwiOD
	 tYR9jv+yOhJxc9uJpSBn2jJ+rJ7mBlF3tejK0A2AN3Z9R1JR8IABwcjzTIPeOnTEq7xxOrijb+66
	 uiyNEl6i8zcyLI25glX7NvLDOgUpZGUVKngAPjT/ZMkgBQpBxy7cv2iaeryCk5hNHjAwQgYTo/A4
	 kSHtAZm+onze10xf0xZFtXivpnesPnG0xImLYzGB4iWsRGEbxYfmTFgb+t/Qb63v2NCBbNRUUynj
	 Y+5iIUNN3Stm/OQs11wTBYodnn+NfnvcCa9aG/EEp3tWU//zJg6xh8pUvgX5hpsjRU3LVjt7SC4t
	 MF6FgGXnG82h+jwheZbTEzEmWa0BsBhmz8VuFnULJxPWXoa4UV9yqziUdQ/EV8kI4W6pJb0dQn
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] null_blk: fix warning in blk_mq_start_request
Date: Wed,  8 Nov 2023 10:46:41 +0800
X-OQ-MSGID: <20231108024640.1148886-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000000e6aac06098aee0c@google.com>
References: <0000000000000e6aac06098aee0c@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before call blk_mq_start_request() in null_queue_rq(), initialize rq->state to
MQ_RQ_IDLE.

Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/block/null_blk/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 22a3cf7f32e2..0726534a5a24 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,6 +1724,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->fake_timeout = should_timeout_request(rq) ||
 		blk_should_fake_timeout(rq->q);
 
+	if (READ_ONCE(rq->state))
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	blk_mq_start_request(rq);
 
 	if (should_requeue_request(rq)) {
-- 
2.25.1

