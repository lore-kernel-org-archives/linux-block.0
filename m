Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C1235C17
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246061; cv=none; b=tEG6duve3ELCu/ukPlGhYvDeuQM2iseBdLBdxmeFIvFPiqouw7l0voCV9pM23NP0dafqp83c1QdZ9bJvEJLXzff7pPn1Q563mR2Ky42OMUnbPwAmzD90WlzKfdbwr4EA8dqEuPe7dHf3/JW/b1SC2Fid5k7QLBeeCrwU1WTZx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246061; c=relaxed/simple;
	bh=VJ1uBSFQUU5I76rw/4EPVEjbb1S8crfjG9c6O5+jJA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvhCaNW5VWZYi1qiqDDtRRoczXTzY+HoLAXpG1U48EZYqEhDV7b1ce3PczVMJXNWNfnNYx/rsBawgy0n+TyjXL427+8qPHVg5H5uv2mUAwdOd2lWadkN2t5rpNtSQvUTQ+8jBUP3AxwcF8Pkfl+qQ16ShdEoQ5iTHWwfRRFFSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I/Ytx3cB; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I/Ytx3cB"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-864a29cf2daso7501139f.1
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246059; x=1749850859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMrPUhUb/8TdVD2oy+nL01Y3eeDJhjWDZ+/BYqw+cJk=;
        b=I/Ytx3cBsu8Wy4zMdaFeq5S/QcjrqazwKSt0V7/FRvo1b7xEZ7oP/dkwAee6icsGeZ
         sksijds7tFMRjP4lKVtQSVItmizSRwkxIQos57KFtptV6Dj+/WUEodQ/ai8ULBbg/EG6
         Smyzmm4j23ue1tNOXXHs4jPKW/jVhKZKvS1KyStnHFflmnvHPUBlL8/FotIxLeJ7iZDh
         SbNTFyTu7Z7CJ4Nm8PcyPsioRqwoJ1N4OCEqZ+3eGtajaJJF7dhkZawQbGwIO9mAsSa4
         bAuY5nBc5vSxu5H+K4XKLZMxrr+B2RF8thB1itqPPhcFgJ3do1e2VYLmxOnYg+3xEHiR
         qMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246059; x=1749850859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMrPUhUb/8TdVD2oy+nL01Y3eeDJhjWDZ+/BYqw+cJk=;
        b=oikIHK7uLZo2IvUEj/8CfcJ/eVTtI6PmSNN8Ai26ufTHGT2l036NEmy1Pih8LlrJfZ
         nkzULn1ns2Bn5EEN5ZHdCHW24Cba1lhfLIU5IBiiW+FQIOXFGHEPtBECcNx2qe2Q/ELv
         tZz5btk80BogIPA/+X2BREIjG5WgsXeUDM+GHKZBzVE7BEq4SwjXmTwR68Z7a9lLtRkf
         aZ6s0rgqTmnt943sZ090Xq6bB8gx32Kr2A5T5jQPYo3W8A7yMrLKGERdK7DEq5JK0d+i
         epS8swFtseMcUKJwOUtRJ6nX3k81UxDRd0GxIfuu+sOpJvYucYCs2Q/t01G3z7PTCr/b
         EbXg==
X-Forwarded-Encrypted: i=1; AJvYcCVbXn5Tr4aaDYFf+Z7AuG443QOlJFL/fehYmCWQdyC3Yp7AAmqwZsy8cZpKYKKOZrlahNkWzAfoOBcLZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyMxhjRHPuojwOdK91W0L0CcM3amd6jCcpcuXkr0en4bhSpXC
	8t/0V06rU+94OeSmQdpfnI4EyCaopv7YaUAcLtWECJRiuw/zVfk3Bp7AQGgmyMgFZLNC5FWTEVA
	q2vbL0kte6H+QwmeNQD0x1Xsxj45QBAtBnabp
X-Gm-Gg: ASbGncu0BxfmEpRcX4hjsUR25tOnSGrsUhXe0jX22DJpciXK5701u++yvl2HXF8vXqt
	20skW21iHVW92wgmHq9FkxO07kalku+KkP3WTPHlrZGVF6trG/g9FkSyHZzW1SpknOdzsv1fgDY
	PnRY0lu9bQ04rRUsKMGckrxnIZANHR9enRDb1yP9qayTG9dg80djeasakwNl6ybQ8k9YXS87rNX
	gtw6v2gmwsyGHieMScA36HGRnEoGdCrTgE7VGHvhbd4EpKjXSv4Mb820Uhswu6xQtJafL8OqIpk
	HFWzMh8qu900HtFYEHI3jeMzvjBH3Kn0tC4xCqevO6tL
X-Google-Smtp-Source: AGHT+IHjnwoig0tCI6n1sB8rFBprBh4q+MylJUBfTT8gfLG4NGVuBFbOAZDNZrygDRguW06+zbDz43HiSOo+
X-Received: by 2002:a05:6602:6d07:b0:85e:5cbc:115 with SMTP id ca18e2360f4ac-873365fc37cmr182238739f.1.1749246058842;
        Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-500f210596fsm18519173.60.2025.06.06.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 00A81340332;
	Fri,  6 Jun 2025 15:40:58 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E3807E41EE9; Fri,  6 Jun 2025 15:40:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/8] ublk: move ublk_prep_cancel() to case UBLK_IO_COMMIT_AND_FETCH_REQ
Date: Fri,  6 Jun 2025 15:40:08 -0600
Message-ID: <20250606214011.2576398-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
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
---
 drivers/block/ublk_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 295beb6ab4a5..a8030818f74a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2230,22 +2230,20 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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

