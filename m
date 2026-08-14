Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A4426D16;
	Fri, 14 Aug 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695731; cv=none; b=j5YyIDCM6Cj6zCs4YMPbX1fP5G/ityqh9kyEVnT89V7ccHPOtWLRWh6wx6y00hX1s6lHkQ5C8yTxZwn+QxcViBV3bEB7kJsfSKtccQKCufnkBsbjf9rmYKJ4rzj4vIfcfd/OHSrXjqoyqeado0/I5Lw0SPSRaNZLAB8SxEbi6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695731; c=relaxed/simple;
	bh=9wGujagsvyq7nOmOqq6KAWFmSkO6SjIkdgAGzqGtNVg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bZTkbFMWoIk/jS0WY7tLKLr3+5zFMszdUV61z/FtVR1z6kVCKIZwTlbZxgWbKlxLD2m4x6kljVJ1+FVhFVRyu/U8YgJfgBXwHUA40URGwsyHIb3BZg3Tr4eRKUwaBpwXH0SGTvq5itPeeIbWJAYOq2aguQ4ud2iN/5DNYOJyITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=H3T5NIWB; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="H3T5NIWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786695720; bh=4NejMKt0sSD3gY6vlfWKK5TfwqyBCDnqt+NAHnlRF/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3T5NIWBu1Kl9vcYkUwYIFFDNGSPHOPib1CnUI5Q7mOroQy/7CI2x0bB5w1dVN4aJ
	 e99Qyt+kXU2ibTDbAPVPHsnHR8F7YwzP2libuO/M/znQ3jtNvp+72oJK6bEHsgxM/J
	 2/jvTNX/YPVYQ1nZqgPWkiA+/kibmXbzApM3OVyA=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 57986EFD; Fri, 14 Aug 2026 16:21:57 +0800
X-QQ-mid: xmsmtpt1786695717tqei5aaol
Message-ID: <tencent_2E6878C66E4C2CC96EFC9650EA82ECFACF0A@qq.com>
X-QQ-XMAILINFO: ODukwAJJE14zHIPSM3OC9KC74I/eSr3IuOGs7JldS0sv+Fh9z+TbOzwS3aNR0E
	 3WLwAStzyZvphEhtgn070V6h0wWDDX91dY8X615X0LTx2Ek5LsGpVg23pvWpcD3Umq06zrXx5eEk
	 c/xGI3V+uGHTginH//twP0T9otm66gpVEAiE/DxCtIGMSzd9WbgTBvvQxGuzKDMOx9pnKFOA8ZUe
	 bZnDp6oYjW2iw+jOIXmRIgNr/i4c/FmKnrJXEBkcY6ZuhwLtDaKo4gdLzy8vnmkRQvWTPZwcmArn
	 FHaNeHsdZDxqKN0Rz0q2GXUa7lTyAg3LpHlWaitI2DGFNYdlef/c3t1t2O63lCFKvaVPCoQgz+FZ
	 fromUQr7IrSgzGd5zGKRz05DKpNuwEASBCxk2MVfaIO3UOgKRKcrSDGimk1Vum0Zy7FH48djJvEx
	 ArY37YHvq1wF/cIZSYNIu1f16kZUlR/h4SDEwmdrD/Nz4dc6Ga6a9lH/pXYzYK+XRMExrEn4HJal
	 Ia28ofH9ZHYStJy3PerG989s3KTiOItz3t2cdoozqzmW34S5H33yHjfzBlHk+nfU8enMYkkJwUDe
	 peUt4va/0MoKdBgT3VyMEg9BWHyl6UTAL+JXB3Hp6rBieTQDuAeQu9T0SjG5eCTmmPe0OHxnTeCb
	 eVNR9ei6nhwGLzS6YVwOm9y4LOQfKSwtp3E0KJlEG0L3tcfUHnnZKRzep6JAkXnCNFOvOOGMuzCw
	 3cKK27D4nglLDN/8IQXmldAB6iMEXzj4lHR026TsaHcYPXRJeH3l2ChL/OFoL21NBXfdhF2DU4lM
	 hZsJcSqVvmI+8IoRm418Wj0DdtBGXZR5zFjecY+P5kmJH1c7B2VWeRtle40uTIItTqYmFv5F3pmh
	 nkZ5mZNo2CI7mqelkzMCvJdjO5Gufr7/m/1X8dosLi0AgnbAnZi+dBginIVBExwpRpi8Uiztg/Cu
	 YG8NX4nlbkuLwuqsCPTDFj0ieTFNZ87WdmID2bF666ZlE3zdfhPX/5nbax71iIEBBTgJ5ekYsw4J
	 UFeSsxHoS6b6YIU5kquVTxjIM2znyfVxqTy584T7OKa98uD5WJHG0w44e/HWx6bOBvpVPQ/w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	shli@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] nullb: free zones when device is power-off
Date: Fri, 14 Aug 2026 16:21:57 +0800
X-OQ-MSGID: <20260814082156.221612-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a7e5b5b.f70deec7.2acc03.000e.GAE@google.com>
References: <6a7e5b5b.f70deec7.2acc03.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user powers off the device by writing 0 to `./config/nullb/nullb1/power`
via the nullb configfs interface, and later powers it on by writing 1
to the same file.

When the power-off command is executed, the zones created by the previous
task are not freed before new zones are created upon powering on again;
this results in the memory leak described in [1].

Add an operation to free zones within nullb_device_power_store().

[1]
BUG: memory leak
unreferenced object 0xffff888126990000 (size 56000):
  backtrace (crc 5c9573f8):
    null_init_zoned_dev+0x108/0x520 drivers/block/null_blk/zoned.c:94
    null_add_dev+0x8a6/0xae0 drivers/block/null_blk/main.c:1993
    nullb_device_power_store+0xf9/0x1f0 drivers/block/null_blk/main.c:501
    flush_write_buffer fs/configfs/file.c:207 [inline]
    configfs_write_iter+0x10d/0x1a0 fs/configfs/file.c:229
    new_sync_write fs/read_write.c:595 [inline]
    vfs_write+0x3ac/0x720 fs/read_write.c:687

Fixes: cedcafad8277 ("nullb: add interface to power on disk")
Reported-by: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f57d67a92532a98a562d
Tested-by: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..fb001d002d17 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -511,6 +511,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
 			dev->power = newp;
 			null_del_dev(dev->nullb);
+			null_free_zoned_dev(dev);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
-- 
2.43.0

