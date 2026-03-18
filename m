Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298335B63B;
	Wed, 18 Mar 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830945; cv=none; b=Y+x7gEP/+dpI6YO7FU9ZuqvxjmR85m2BNpX1/oCJtM4b3pEqG/yW+SPTG+nZRjR/jJVC/qAeI5IEy2rxJNssqrA+7NBqxx+7r5kGCbciHAEUhZxZUvebQpxv+HHykOLmsoRGmnGp5fpSCpJgZKJDhiBDM0cxA4XPbZrBivqDka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830945; c=relaxed/simple;
	bh=rPI1z+CLJKD2kXzKIunBdArVZmP56Ja3EB7Q6RmZlww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htq6G4V80iwCw8i4NeHKl0G4mjJesWcS2P0wFmpPGHZ79VKOEV+sIKFhJLLs8ciG3IVwJz/u9pPwoElqX8H/oF9T+mDh9uSx4QcMKS1E9Eb9taEmGqTY3S7G9eFnTbNgUKh0yt+LbzyJ3QU69EhnmkwtV8irl/MvUWQU/FNjZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJaQhboK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJaQhboK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B134FC2BCB2;
	Wed, 18 Mar 2026 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773830945;
	bh=rPI1z+CLJKD2kXzKIunBdArVZmP56Ja3EB7Q6RmZlww=;
	h=From:To:Cc:Subject:Date:From;
	b=bJaQhboKRHX5m6x3lAqpDzlsnvr3W82yjDezpBlk/2+FqorFURXJlCQ46Nl3+lN1F
	 1MF2E2JeJGYlPZT1RTHdx2tfKIshB3cT6ls0MCJ+j8rJOD3CNtFdZ2k2cdKH7d4GPj
	 Qp6uTgmrv3uo0nqRKVKRI43Az0o73TVwoSdJDhWEz/RvBjY+gR8xa36NswlqPW5ia+
	 9c0B0PfWYHDJe6ZyQvAsRIkQjsRaA0+NDz1CfW7iNAAL6t6ntgE4TdVg2E9tW9BBxX
	 /LKVwdHFT1ZutfRJdyANSQlpwaln1UpG8PTvXvaI6mycJ3s/WQ4j621ZCIRuv2jsUa
	 sbI1YX685wcVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drbd: fix rdma dependency
Date: Wed, 18 Mar 2026 11:48:49 +0100
Message-Id: <20260318104858.1868731-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new rdma transport module uses a trick to only build support
if infiniband/rdma is enabled. This seems to be done the wrong way
around, as it gets built if RDMA is in a loadable module, but not
if it's built-in.

However, this fails in configurations that have infiniband support
in a loadable module but drbd built-in:

ERROR: modpost: "rdma_bind_addr" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_listen" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_destroy_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_destroy_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_disconnect" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "__rdma_create_kernel_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_resolve_route" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_reject" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_accept" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
ERROR: modpost: "rdma_create_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!

Address this by moving the logic from Makefile into Kconfig and
describing the two conditions in which rdma transport can be used
in drbd.

Fixes: 038cb6e644e4 ("drbd: add RDMA transport implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/Kconfig  | 5 +++++
 drivers/block/drbd/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 377f0d040031..29ec6ed84251 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -39,6 +39,11 @@ config BLK_DEV_DRBD
 
 	  If unsure, say N.
 
+config DRBD_TRANSPORT_RDMA
+	tristate
+	depends on RDMA=y || (BLK_DEV_DRBD=RDMA)
+	default BLK_DEV_DRBD
+
 config DRBD_FAULT_INJECTION
 	bool "DRBD fault injection"
 	depends on BLK_DEV_DRBD
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 99a1cfeed423..caf888235d53 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -13,4 +13,4 @@ obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_tcp.o
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_lb-tcp.o
-obj-$(if $(CONFIG_BLK_DEV_DRBD),$(if $(CONFIG_INFINIBAND),m)) += drbd_transport_rdma.o
+obj-$(CONFIG_DRBD_TRANSPORT_RDMA) += drbd_transport_rdma.o
-- 
2.39.5

