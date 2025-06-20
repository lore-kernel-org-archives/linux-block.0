Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560A2BDC33
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432220; cv=none; b=oOlYTK+uOq/BnczU0sZ98BNk9mLzWcSe4z/my9YhkusNI5QWWZiU+mNEqxm/Mcz1aPCi3flKVH0y8Pg5nQenl/Z+Ouv8vq3yPQn+JdUI93UbSP6l4jsKn3oSiyvInXOdzY9Yrt0YdkZWVG2kBQwgOqhKbP24GfVGFhySZZOve2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432220; c=relaxed/simple;
	bh=pJ8BOYMsyiTChLJH658YyhvkLGVcbkAMXtlTgtSiOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV+Zn2VtM3HSQ5i8/6WkgZlcYsz0a40cwSBYGasmpC+j48z337TO3NiyRIU9Bp8YaH1z4K8YtFp1TGl+htk0YEticF5prR8Dp+x7KQPt2QfbOlQzyvy1D1UeH74lt12Gr1segBJotfoZDb1rI3rhCJmmBrHVsrAMqZro0l1uif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F+ExqwGP; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F+ExqwGP"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4a782768db4so115261cf.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432217; x=1751037017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZdXD0IdCb5Mfaq9Fh0hDvYHAXSwZZ5gwiKFSUhG+q0=;
        b=F+ExqwGPZPuzC5iw/x9YutqFBDiNb3Of6g3VghHdYseal3ZKsp9C8XQW98iynXjOKG
         lnHqmtbvxN3bvO8ibQhFDLsMv3rhc5h5AOXk2rOelzaxTYkfxV3LfnAGBzZhogALbMnf
         kiL5crGS0hGLYOvijU4Q9tRjQOs4nqSe3lnEl3DzS5iIt0AHabhTHPNYNO4pbuy8nM1F
         OcuPkMKt9TFcnjMTzJlNv8fN8nW8gn0fBVqa7KQx/YTVESDWxK26SLjIQyZ2fTMo0w13
         QnFrt4hHqOHBKsnOBaRQ7MDME8oDOClLoBTF+lmkgw4qryYMDp8dVCCw5D2HzbLpqS1I
         1aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432217; x=1751037017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZdXD0IdCb5Mfaq9Fh0hDvYHAXSwZZ5gwiKFSUhG+q0=;
        b=H3tkahn9OaheN9j3a9/WOK00ZnMwdhKAtTBCEpCPp5YLEEUcryk/2cUy+XW3eSBbTq
         ajP8H3VhwTvn/61IvLR7tA0cH4GK6nbET+zMblpqL13Mk6mYhv9p/+OIsJeJnZQ/Nr0d
         TtCx8wtAGm1PTFqQu2uFX0z2NYMGMYhG0vuujjpUbzyBbYsPay9fCV9PTWdtkTefgYPl
         v7Rgshj28VUZ6DwMpg6qkxKt9LyynMDaCKThBAFQ9T9lhh0tqmQCF+pATEkthBGMfNLL
         SIViUqtZGNr2GMEHYa9cgOqnuHQwgdY7TfXRvIIDnfd/D5Quywk9lDESv1zOkeXnuK2k
         5Klw==
X-Gm-Message-State: AOJu0YzcHbmmN2sGahDz5NqoO76rfooaF4Q0g0D5i3S5yxUya0XmFU2n
	ZxT+7kISEWL7WXOeq00JoFNaIDoj+iEETrMZjAnAJYfoeeYLauNtVQUb/JNIW91+cXzLWqjRZY2
	jkSR+mzccxCHx/R885P2T6bqga2ztTFJL7VTZ
X-Gm-Gg: ASbGncsR84aSmbYw+r22k7ucnLyDzBTvhd34iKOfecTsMOQoJFG5FVKoBxoInqftFUM
	DokniiTOduN6rd3zxE0f8CvwllkRGiqixxf+lbFvi4gOTsP6f4D0WoCgfUm+mqkeQGiuCdEs7rT
	Ydykt1FMeYJe7/ppvG6us04OUNJbs2lmIYXBefZ4POwrFQnzf/hgr1eTYGPxKLhMeNf2e16rzW0
	IgEQ9URdnCgk2IFrBmJcgwz7ww+0xTzwQ5Ayu/dXxXUQ1U9BYdgdgz7ch6//oRJ7UV9etLYqSNi
	c0FpdAjv2lREp+bNS/XNZiw1jsArOgrDFPEJskvcqq83ZDfqhif0bEc=
X-Google-Smtp-Source: AGHT+IHqxLgDa17U4E2y9tUCTRqn/Vz/PP8bmW8+AiNJR0czoc7jFcSBVBgUgEhsuf4/wUSTBW7yaOucXRL2
X-Received: by 2002:ac8:5756:0:b0:4a5:a4ad:c55b with SMTP id d75a77b69052e-4a77a27da81mr16873861cf.12.1750432216367;
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4a77a15778fsm694721cf.11.2025.06.20.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 994BA340D6A;
	Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9829EE4548E; Fri, 20 Jun 2025 09:10:15 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 07/14] ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
Date: Fri, 20 Jun 2025 09:10:01 -0600
Message-ID: <20250620151008.3976463-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_IO_COMMIT_AND_FETCH_REQ is the only one of __ublk_ch_uring_cmd()'s
switch cases that doesn't return or goto. Move the logic following the
switch into this case so it also returns. Drop the now unneeded default
case.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9bfccee3c2b7..893519f74625 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2232,22 +2232,20 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
-		break;
+
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+		return -EIOCBQUEUED;
 	case UBLK_IO_NEED_GET_DATA:
 		io->addr = ub_cmd->addr;
 		if (!ublk_get_data(ubq, io))
 			return -EIOCBQUEUED;
 
 		return UBLK_IO_RES_OK;
-	default:
-		goto out;
 	}
-	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
-	return -EIOCBQUEUED;
 
  out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;
-- 
2.45.2

