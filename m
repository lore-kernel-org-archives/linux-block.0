Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93B35F173
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136435; cv=none; b=GpVUf+i3WGNxbaDT4FzW5YlpjW64i5o1J4yUqmc9TBpwp2xkio56F9OdbbUIqhdWBjXtLjybLlIqIZx/cAd6FSmrVGy0m4cdfOlvUu10HdkPrKgbWPWNnXWzLxKg7xE7m568TgtcGoibv7GRp/Zf5AK8w1oM51/OmZAt1dDuq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136435; c=relaxed/simple;
	bh=k2XTJ12uZNCBD4r+iG/TlhCbbIuhDxZRCbLzoXGtpI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO+kWkanrFsGDkRKCrHpAd6wmNT/+3XLno6WyKqgEJ3a8P0fZKGiVd5BRF5K1oMusbas0N0LKiUrkMupZTgcMTr7A7lrK11AQ9dWtmb9EzS7vsCilp7rQR7qefvBIC4TkFyyXOaoGcuTAiQIOd1g4hs/DWBMA86z2PMDD0sD38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN3IlXVl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN3IlXVl"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b611274bso5961571f8f.3
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136432; x=1773741232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uckjMLEO1xoDzM8E+YJ/FlzjI6xsss8CmgdwwHq5W7s=;
        b=VN3IlXVlfd/fP7lbK4GkuPe5U+U6buWEph6lWeUB2xZ19Ii4Th4HjkOiWCssbhqGAK
         nCntRIJVpiFCdeA3q+0jhSzjIzGITDh4SF5a+Yrpi0Ip/bjP+4Hteub02RbhIQV+2EMg
         LGkJwVSkgQBn7e1hltmtafTxH4HIatiuEWwe8PRHlyRWf45UqlWjpPLhgbZUJ6sgBFBb
         jd+vj+/74fPT//2M1YpJvv6TEEuPz8cY92CLwl/l2ItMo9nxb1ESoVBvUlB+mzwG/ijc
         KMKTvXZ6F9cf66XSVFe/xE5GFQMKQPloLb7kZPusYSvJcUXfbjMhQjqdGUItqoyJgJi7
         oL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136432; x=1773741232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uckjMLEO1xoDzM8E+YJ/FlzjI6xsss8CmgdwwHq5W7s=;
        b=W8yAjustt0jGvhd7oadPaiSLE+rG1rMHYxLVCWwNkDUAQ/pe1227zEzBrrLgkQ1VvU
         SYjJUnp2+FEeMmOZ/KiNkhClcwuRz8oibV1mZYyYLZL4vmA3G534cobnQiyGW4ekDE22
         TQ7NZ/5lOeqm++XWmqEpy6Z3+omdmSuYwn+Ca9HiiEEnOaaso/PKmrI9nwacjAnaNmnd
         wAE98QR7d2GqG80loK+xnMxNAKF7uZ2nHuvTVtXhYJ+Wf3gVHXIdvI23Nk9YjplmTq22
         dli1RG9uu33f4Q5/rOLLr+AL0LqenJ9P0DvVvp6m9M3ZPh/NbwjuUxXld3/S3XzlD1vz
         Uf4g==
X-Gm-Message-State: AOJu0YyeWn8LWJZHpeSBF3Vw1/9UNH1+brjTmhVmZ2ZIKkJ/2dv98hRO
	EWaEs+Xkk9SjRlHHf3AUxNg6t/VmkXC4Ai4paMIGesCGxYaBlTYBSlsw2UDxGA==
X-Gm-Gg: ATEYQzy9I2M4w5LdutQz6bJTodP19HgaLi6pI6m3Qbu3D0PLrzyr84MA+qZgJHRARrn
	FwKu38S2F5Tfn1BxrWzDayUTUbOV2PQzqYn8h/7c9qaMNTvZr/mbHJhfR89eOrJq7BV7YxM5F7S
	ugHu9YAlOF56CkBXYVivsy+u4rJZZ4aQWEeykOr4pIXUFr1soBaeH584D7VbyrpQ11X/wVpX3jC
	6qXce8IqNQ4oTjRsw9QhJ4zXv7w72ubo+loWSRNWvJc8fqbeg3ymwjKjqh4wtWgMravvebU4oCR
	2EgTZOFOtmsBoSYkx8sjIyiAc6MsRf8RqBN33JEE/nFq2LCRZUKlg/mSIhzwXr0QMS5hV47A7N2
	5ZdRSkjVJnpILBByHIJONeSxnGUFwGz/ByzGwg4LwFp1TRpDVeHV0G6M1IIFAKoyy1UbaRbNdRS
	4xw749Xp4Hdm+GfFAWo96eCGFRcsm8/CSgxNtf
X-Received: by 2002:a05:6000:1846:b0:439:d93f:9b6b with SMTP id ffacd0b85a97d-439da65cef7mr24323131f8f.20.1773136431743;
        Tue, 10 Mar 2026 02:53:51 -0700 (PDT)
Received: from tawny.brq.openssl.org ([2a00:9c80:800c:0:fcbc:81a9:b94f:4b52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm33489248f8f.6.2026.03.10.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:53:51 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev,
	axboe@kernel.dk,
	okozina@redhat.com,
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] sed-opal: Add STACK_RESET command
Date: Tue, 10 Mar 2026 10:53:49 +0100
Message-ID: <20260310095349.411287-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCG Opal device could enter a state where no new session can be
created, blocking even Discovery or PSID reset. While a power cycle
or waiting for the timeout should work, there is another possibility
for recovery: using the Stack Reset command.

The Stack Reset command is defined in the TCG Storage Architecture Core
Specification and is mandatory for all Opal devices (see Section 3.3.6
of the Opal SSC specification).

This patch implements the Stack Reset command. Sending it should clear
all active sessions immediately, allowing subsequent commands to run
successfully. While it is a TCG transport layer command, the Linux
kernel implements only Opal ioctls, so it makes sense to use the
IOC_OPAL ioctl interface.

The Stack Reset takes no arguments; the response can be success or pending.
If the command reports a pending state, userspace can try to repeat it;
in this case, the code returns -EBUSY.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 block/opal_proto.h            | 20 +++++++++++++++
 block/sed-opal.c              | 47 +++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 4 files changed, 69 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index d138785b8198..7c24247aa186 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -19,6 +19,7 @@
 enum {
 	TCG_SECP_00 = 0,
 	TCG_SECP_01,
+	TCG_SECP_02,
 };
 
 /*
@@ -273,6 +274,25 @@ struct opal_header {
 	struct opal_data_subpacket subpkt;
 };
 
+/*
+ * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * Section: 3.3.4.7.5 STACK_RESET
+ */
+#define OPAL_STACK_RESET 0x0002
+
+struct opal_stack_reset {
+	u8 extendedComID[4];
+	__be32 request_code;
+};
+
+struct opal_stack_reset_response {
+	u8 extendedComID[4];
+	__be32 request_code;
+	u8 reserved0[2];
+	__be16 data_length;
+	__be32 response;
+};
+
 #define FC_TPER       0x0001
 #define FC_LOCKING    0x0002
 #define FC_GEOMETRY   0x0003
diff --git a/block/sed-opal.c b/block/sed-opal.c
index c34d19e91201..79b290d9458a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3545,6 +3545,50 @@ static int opal_get_sum_ranges(struct opal_dev *dev, struct opal_sum_ranges *opa
 	return ret;
 }
 
+static int opal_stack_reset(struct opal_dev *dev)
+{
+	struct opal_stack_reset *req;
+	struct opal_stack_reset_response *resp;
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+
+	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
+	req = (struct opal_stack_reset *)dev->cmd;
+	req->extendedComID[0] = dev->comid >> 8;
+	req->extendedComID[1] = dev->comid & 0xFF;
+	req->request_code = cpu_to_be32(OPAL_STACK_RESET);
+
+	ret = dev->send_recv(dev->data, dev->comid, TCG_SECP_02,
+			     dev->cmd, IO_BUFFER_LENGTH, true);
+	if (ret) {
+		pr_debug("Error sending stack reset: %d\n", ret);
+		goto out;
+	}
+
+	memset(dev->resp, 0, IO_BUFFER_LENGTH);
+	ret = dev->send_recv(dev->data, dev->comid, TCG_SECP_02,
+			     dev->resp, IO_BUFFER_LENGTH, false);
+	if (ret) {
+		pr_debug("Error receiving stack reset response: %d\n", ret);
+		goto out;
+	}
+
+	resp = (struct opal_stack_reset_response *)dev->resp;
+	if (be16_to_cpu(resp->data_length) != 4) {
+		pr_debug("Stack reset pending\n");
+		ret = -EBUSY;
+		goto out;
+	}
+	if (be32_to_cpu(resp->response) != 0) {
+		pr_debug("Stack reset failed: %u\n", be32_to_cpu(resp->response));
+		ret = -EIO;
+	}
+out:
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -3642,6 +3686,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GET_SUM_STATUS:
 		ret = opal_get_sum_ranges(dev, p, arg);
 		break;
+	case IOC_OPAL_STACK_RESET:
+		ret = opal_stack_reset(dev);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index aa006edb612b..0630430cc01a 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -57,6 +57,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_LR_SET_START_LEN:
 	case IOC_OPAL_ENABLE_DISABLE_LR:
 	case IOC_OPAL_GET_SUM_STATUS:
+	case IOC_OPAL_STACK_RESET:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 9830298ec51c..ef4d3be6ca7f 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -245,5 +245,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_LR_SET_START_LEN   _IOW('p', 243, struct opal_user_lr_setup)
 #define IOC_OPAL_ENABLE_DISABLE_LR  _IOW('p', 244, struct opal_user_lr_setup)
 #define IOC_OPAL_GET_SUM_STATUS     _IOW('p', 245, struct opal_sum_ranges)
+#define IOC_OPAL_STACK_RESET        _IO('p', 246)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.53.0

