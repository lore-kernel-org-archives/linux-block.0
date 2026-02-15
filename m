Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31828371;
	Sun, 15 Feb 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771181711; cv=none; b=H5BuBWqdKRBlPvcaPx4+vPVJLZIVZti149p7ifaXMMaUjF2+w+ag81vLNGk+6XCSV8vGzpmBEHWHNrC//K5ZBlRf/TjmL5FzWBNIvXnyFgQFucqqMRXt1h+FfE10lCmy9dr/y6Y+GfWHPw7SxsoWW5BxGldlk/rmVwPVK7/hmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771181711; c=relaxed/simple;
	bh=52rk4431vTIwEh28KLsOORuISrOm684BpcHiRK0ikDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/zvacg3oseK2uPJ0+z79QA9lyc75pTr2CgX2EvPxW0r7LbY+EAW9vu0Z/tUXVvFGJoMhhNkO+3eaeUUoN5qHIobbTsAolX3jTvlecKzEb7RDcMLiAMvILSe9WLmEFjqMj0QN0GOEb6d7YkB73PqpUWRIyyJJUdCNcIcsDD0jkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=lKdzryJK; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="lKdzryJK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-ID:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=HT0C8IQtP6ll2eG6quVPn4D1EGUnvCU9+Ng85cw2CDo=
	; b=lKdzryJKkZ+EVYmAIQxQdwhNCKVztbSAPr1hm5d/pq+uCirMrZxueRIaHaDpQW8vZDOt56x+0
	iO2VBKZKduawDOSIV0NXcdL8p7KumYEHotDfvhmZZxOBclKu0VNckWM/1GRZYvlgWVwCmUPRhUaWS
	euW/2O61gS72JGuXWmlyizlMWd9l9arXEgPh4KBx5GFspOIRemywHoKSjx4IBo0J2WRANpENKN7EV
	JbNLJy1dfntVd3X/ronNf7ZhOHYwIcwidKpNB8C/ZsfPSE+BPbJ4cgXGtVwPGFoMqItcehCEkoqcc
	jgnoTCHDENFO6ElQixvc//woqgS7GgaGSgtA3FoVYWZSSiQULKkL5Yx00CUcCWqUDzYw5xJbTwT1Z
	KNEAI6xuVugEZkivqxfrl6h45nEW47yQjbccsCTVn8gH37mxkQYL6IUTieysj5omIHHkG32qwdprL
	8D937XiGh1n7wQRJKl3LBTLUnAof5k+R7jCILkvxyQwwuG7X7xzmrN7rBFb/N4TQv4VKzk57AEdDi
	DTVYBy4gijQjqnrnWckHcEz7JhYH5ufzyBKnPtiSSBA3/oQWJyuVK3tThALl8U4/3FsSA9s8VyBJ+
	SwLDXmktOL4qlqJfGFt6ots35moKi5DFnBGSq8fQuhOOqiXgNy3q0K7yiUtCrapbgzNb5H4=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vrgV3-00000009U7A-3lW3
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sun, 15 Feb 2026 18:05:41 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id wgezEPUKkmnpfiIAdB6GMg
	(envelope-from <hristo@venev.name>); Sun, 15 Feb 2026 18:05:41 +0000
From: Hristo Venev <hristo@venev.name>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] netlink: specs: add specification for NBD
Date: Sun, 15 Feb 2026 20:03:02 +0200
Message-ID: <20260215180309.2255721-3-hristo@venev.name>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds an initial YNL specification for NBD. The specification
can be used to produce a UAPI header that is equivalent to the one
currently shipped in the kernel.

The spec appears to be accurate enough so that commands can be issued
with pyynl.

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 Documentation/netlink/specs/nbd.yaml | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 Documentation/netlink/specs/nbd.yaml

diff --git a/Documentation/netlink/specs/nbd.yaml b/Documentation/netlink/specs/nbd.yaml
new file mode 100644
index 0000000000000..a84912a867d91
--- /dev/null
+++ b/Documentation/netlink/specs/nbd.yaml
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: nbd
+protocol: genetlink-c
+uapi-header: linux/nbd-netlink.h
+doc: See :file:`drivers/block/nbd.c`
+
+c-family-name: nbd-genl-family-name
+c-version-name: nbd-genl-version
+max-by-define: true
+
+attribute-sets:
+  -
+    name: nbd-attrs
+    name-prefix: nbd-attr-
+    doc: Configuration policy attributes, used for CONNECT
+    attributes:
+      -
+        name: unspec
+        value: 0
+        type: unused
+      -
+        name: index
+        type: u32
+      -
+        name: size-bytes
+        type: u64
+      -
+        name: block-size-bytes
+        type: u64
+      -
+        name: timeout
+        type: u64
+      -
+        name: server-flags
+        type: u64
+      -
+        name: client-flags
+        type: u64
+      -
+        name: sockets
+        type: nest
+        nested-attributes: sock-item-attrs
+      -
+        name: dead-conn-timeout
+        type: u64
+      -
+        name: device-list
+        type: nest
+        nested-attributes: device-item-attrs
+      -
+        name: backend-identifier
+        type: string
+  -
+    name: device-item-attrs
+    name-prefix: nbd-device-item-
+    doc: |
+      This is the format for multiple devices with :code:`NBD_ATTR_DEVICE_LIST`
+
+      .. code-block::
+
+        [NBD_ATTR_DEVICE_LIST]
+          [NBD_DEVICE_ITEM]
+            [NBD_DEVICE_INDEX]
+            [NBD_DEVICE_CONNECTED]
+    attributes:
+      -
+        name: unspec
+        value: 0
+        type: unused
+      -
+        name: item
+        name-prefix: nbd-device-
+        type: nest
+        nested-attributes: device-attrs
+        multi-attr: true
+  -
+    name: device-attrs
+    name-prefix: nbd-device-
+    attr-max-name: nbd-device-attr-max
+    attributes:
+      -
+        name: unspec
+        value: 0
+        type: unused
+      -
+        name: index
+        type: u32
+      -
+        name: connected
+        type: u8
+  -
+    name: sock-item-attrs
+    name-prefix: nbd-sock-item-
+    doc: |
+      This is the format for multiple sockets with :code:`NBD_ATTR_SOCKETS`
+
+      .. code-block::
+
+        [NBD_ATTR_SOCKETS]
+          [NBD_SOCK_ITEM]
+            [NBD_SOCK_FD]
+          [NBD_SOCK_ITEM]
+            [NBD_SOCK_FD]
+    attributes:
+      -
+        name: unspec
+        value: 0
+        type: unused
+      -
+        name: item
+        name-prefix: nbd-sock-
+        type: nest
+        nested-attributes: sock-attrs
+        multi-attr: true
+  -
+    name: sock-attrs
+    name-prefix: nbd-sock-
+    attributes:
+      -
+        name: unspec
+        value: 0
+        type: unused
+      -
+        name: fd
+        type: u32
+
+operations:
+  enum-model: unified
+  name-prefix: nbd-cmd-
+  list:
+    -
+      name: unspec
+      value: 0
+      doc: NBD_CMD_UNSPEC
+    -
+      name: connect
+      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_connect()`
+      attribute-set: nbd-attrs
+      dont-validate: [strict]
+      do:
+        request:
+          attributes:
+            - index
+            - size-bytes
+            - block-size-bytes
+            - timeout
+            - server-flags
+            - client-flags
+            - sockets
+            - dead-conn-timeout
+            - backend-identifier
+        reply:
+          attributes:
+            - index
+    -
+      name: disconnect
+      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_disconnect()`
+      attribute-set: nbd-attrs
+      dont-validate: [strict]
+      do:
+        request:
+          attributes:
+            - index
+    -
+      name: reconfigure
+      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_reconfigure()`
+      attribute-set: nbd-attrs
+      dont-validate: [strict]
+      do:
+        request:
+          attributes:
+            - index
+            - size-bytes
+            - block-size-bytes
+            - timeout
+            - client-flags
+            - sockets
+            - dead-conn-timeout
+            - backend-identifier
+    -
+      name: link-dead
+      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_mark_nsock_dead()` / :code:`nbd_dead_link_work()`
+      attribute-set: nbd-attrs
+      event:
+        attributes:
+          - index
+      mcgrp: nbd_mc_group
+    -
+      name: status
+      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_status()`
+      attribute-set: nbd-attrs
+      dont-validate: [strict]
+      do:
+        request:
+          attributes:
+            - index
+        reply:
+          attributes:
+            - device-list
+
+mcast-groups:
+  list:
+    -
+      name: nbd_mc_group
+      c-define-name: nbd-genl-mcast-group-name
-- 
2.53.0

