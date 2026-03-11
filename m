Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C030E835;
	Wed, 11 Mar 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236244; cv=none; b=G4UWU8UI1EcstUyF4422brbN6UsfzFexACUO3AKiwexbLKGE1wT7R/kuzbUF10LVffhp576APioZ4F7hDoLYCvJwQnSQjaNr89TD9bGHI6uwvocRAbwaQ8jrdLnxd2T+3Ui+XNh5Xni1cq8wAZ3IPKkqzGMO+TftelXqIDbUSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236244; c=relaxed/simple;
	bh=t5ddBihkMNUsbSDRq26reWfF1wY+hs8LgsUg6aShI7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=le6Z86o3173xtaiKA2+ZUL93X2NIsMEeHXAF4VBnK9kb3UozVwOuIUbsX/zY+dbmuCov1UYuW0iTijHnavzo30bvAwAa5O++5TmnNsxvlPstKF//CFv/1Qj9MFb0BLsKBH8Hmojth74LAUnbsDvQL8wPShNZ2bshOorvi4xDmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=a5K3KrjR; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="a5K3KrjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1773236208;
	bh=NgYQu8qA3CPixAhgCXMXVe6FltX9S/NBD5iTNc4fUZ4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=a5K3KrjRp6zv0jWCGUGJXWuOx0mIcaqgujm1wITWZLmNtTFRXTFE7msjV6gXuscUJ
	 rgWjinm7XsJKi8KVTcCTDr5wX6jpfYFED5J2xA+hG2Kwqvur9e568VOHzqm1MRH4go
	 O8QlOKZy2Bij8RUeDoxRdBsrindZKGjoafE0ZdIc=
X-QQ-mid: zesmtpsz2t1773236206t33ccf30e
X-QQ-Originating-IP: 587R2k4EV6s8vkyKuiaZY+ruEB9N1K3Ek/wsVBvcPjE=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 21:36:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8780969751876626259
EX-QQ-RecipientCnt: 8
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH] sunvdc: update outdated comment
Date: Wed, 11 Mar 2026 21:36:40 +0800
Message-Id: <20260311133640.743-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NrtPN0vDBdhOtf9ZSsPby0fshJMsMIFjH/UN4ivV4TWeDv0SMdmV7zZC
	Ju72JOZKgef3t0zvz2BE/BHvjEWIlkTROVLnABRtr5R4ZSjivpU6kXCwS1vhmvpgDmPqYIt
	lY8TG0ksHshDrfG+yO6Z3YOT4oQg1DBisQU9/LgbNwgFriOYfUQaFJmJr8sGYv7O7CkhN4E
	LaqyCr6us/BoH0FU8aNKuibjQFnHb1FgnmSfF9SwmDaZPqDGrQ5rg6MVYkH7BGMU0SlpP1c
	Wr76fxfgudBVTZxt/m2gF+oE7u3DxboyP2FOLE7QhIbj6vjGgMQ4QutEOzVBojACeN7MAkp
	dQAqKt+39PHy/MJM5/qCPA+yzEdpiN6UjA8LhRfED/mHW/gtFD5qSnBYiJLoKcouthGkZQc
	SugR9Npb4GqFQcNNoT7P6XICcnkamb1iI/F+8SCq+6DEDt0bD3Dulwro0uXFS75VsQevqMU
	AIYSIXyNgOJ/Txw38foj+RAmUBi0lDxcCG7dxLClubbXLX36WxRuiQpnLkA4P1oKCXiaNjq
	XFTGOsm0t0213ehhzdM2zy50Tk0Sr0un7Z/zqk6LmENONtoqnhqmTsptba9gVVlLKio/T9Z
	bNgPpxqG7/T3ag52La8BKiZ4A32JkoAVjd8csTWaQwSiSFPPQHXl4bfFXLf8RxZukqPb3Qw
	IfEdCmvOL/PlAXzT2jHmmbTb1jtQ0HM6Le/50+F2kCpg8UWGnAI7/G2Uk/2GKmvtXJRxKNX
	n5qmRMCJH2cCgjnBE9LQfDawbRBYhR6SGEHxvfbTXy7ejRiu0NRKKOznmy7FcGOIET3rpSs
	m0vXk4jpdIG+g/jvIwFQ/dsYYQJnJV9GdwDkrZAUNTNSQGGcStKLC8BICk3zEoxPBaGPj0t
	WWOejZf5SrdTwZ+SQrxs1VlCH27Zvas2khiAk7h4VYI1mKIFJnOFMxadlAO++nioYdE/nrB
	DqpekAWJNHH92fSmUW3dMrivtRcr4Ze39CVTL2CkivZdSp5DTtpdkAS/4nsRjb1A1935fQm
	vzFtQll+J8kb2Dz07HIZEC1CCDZXqJr6rqjFR3LGiopQ6eCvEGw0nMgxku4oTxQAY8FMHDi
	t8jnze9ZVDpYiokhO26HT3IcY1ddFj9AJnvV8Rh7mIIr/rmK1NkP00=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The function do_generic_file_read() was renamed
generic_file_buffered_read() by commit 47c27bc46946 ("fs: pass iocb
to do_generic_file_read"), and later renamed again to filemap_read()
by commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
to filemap_read"). Update the comment accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/block/sunvdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 020bd9f1a7b6..0e6107d1d179 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1008,7 +1008,7 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 			 VDCBLK_NAME "%c", 'a' + ((int)vdev->dev_no % 26));
 	port->vdisk_size = -1;
 
-	/* Actual wall time may be double due to do_generic_file_read() doing
+	/* Actual wall time may be double due to filemap_read() doing
 	 * a readahead I/O first, and once that fails it will try to read a
 	 * single page.
 	 */
-- 
2.25.1

