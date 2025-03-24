Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5D25E476
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824177; cv=none; b=BasOkWEcIJDhPmkuXexaRIdeK6+BzwsCmDt/Hx1qldbSOQcjgIk33+Bjo6dNox/gmhhsYSJ1shGkmd7p1S0ztHtaCaYcN/CHueHV5gx5vnrq9dGljoTGnfPxEtUTxx6ptdpUMaDL0Q7RmlrHGUdIxRwIR1DpClcLEyrgj9Ga9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824177; c=relaxed/simple;
	bh=o3dJTOgWaps3rPx64047Bic4hGfeHCh6I9fy6NsYZ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fozn9USivFL7UKlXHp2qwdwxiyUHIlR9ugYLIKQL/PfFoe1jsiupsrlNiYocQ8n70tDqkGY7fMEJd7UycbONdzlEoN5S0Atw1xDdm6yC66xI9smZSM5gFNSnMg4pus5ZfozPI+1uTPYV6CUwUL+ELr1XnKK6a7KdbuLuUjtURdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA83rhCt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA83rhCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZjC/shfJ2L2Y5gqsqLUdZeCpN8x/Tq1NA2slRLUaO0=;
	b=OA83rhCt/m3XmGkEHfKzOzE+VeNwJQJ0V6tPzEco3+62Pyax7K3KSpSuLcDJ9lHsGRpFK8
	Kipb+w2iTeXsP3RtZpDGDGTi9vYSvEF/FAMkjt8NWp8wdRkRa/8VXuMuUUAZ1WsI7B+ibc
	rDslsPLL+UK6Wr43UM+FvacINvV5CMs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-HK9jKe8YMJybS15EO2Dpfw-1; Mon,
 24 Mar 2025 09:49:28 -0400
X-MC-Unique: HK9jKe8YMJybS15EO2Dpfw-1
X-Mimecast-MFC-AGG-ID: HK9jKe8YMJybS15EO2Dpfw_1742824167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA60518004A9;
	Mon, 24 Mar 2025 13:49:26 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD151801750;
	Mon, 24 Mar 2025 13:49:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 1/8] ublk: remove two unused fields from 'struct ublk_queue'
Date: Mon, 24 Mar 2025 21:48:56 +0800
Message-ID: <20250324134905.766777-2-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Ming Lei <tom.leiming@gmail.com>

Remove two unused fields(`io_addr` & `max_io_sz`) from `struct ublk_queue`.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c060da409ed8..2ea1ee209b64 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -143,8 +143,6 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
-	unsigned long io_addr;	/* mapped vm address */
-	unsigned int max_io_sz;
 	bool force_abort;
 	bool timeout;
 	bool canceling;
-- 
2.47.0

