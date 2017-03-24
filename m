Return-Path: <jinpu.wang@profitbricks.com>
Return-Path: <jinpu.wang@profitbricks.com>
From: Jack Wang <jinpu.wang@profitbricks.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: dledford@redhat.com,
	axboe@kernel.dk,
	hch@lst.de,
	mail@fholler.de,
	Milind.dumbare@gmail.com,
	yun.wang@profitbricks.com,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Kleber Souza <kleber.souza@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH 21/28] ibnbd_srv: add header shared in ibnbd_server
Date: Fri, 24 Mar 2017 11:45:36 +0100
Message-Id: <1490352343-20075-22-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
References: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

From: Jack Wang <jinpu.wang@profitbricks.com>

Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Kleber Souza <kleber.souza@profitbricks.com>
Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
---
 drivers/block/ibnbd_server/ibnbd_srv.h | 115 +++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 drivers/block/ibnbd_server/ibnbd_srv.h

diff --git a/drivers/block/ibnbd_server/ibnbd_srv.h b/drivers/block/ibnbd_server/ibnbd_srv.h
new file mode 100644
index 0000000..764a31f
--- /dev/null
+++ b/drivers/block/ibnbd_server/ibnbd_srv.h
@@ -0,0 +1,115 @@
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler < mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *   	    Kleber Souza <kleber.souza@profitbricks.com>
+ * 	    Danil Kipnis <danil.kipnis@profitbricks.com>
+ *   	    Roman Pen <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ *
+ */
+
+#ifndef _IBNBD_SRV_H
+#define _IBNBD_SRV_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+#include "../ibnbd_inc/ibnbd.h"
+#include "../ibnbd_inc/ibnbd-proto.h"
+#include <rdma/ibtrs.h>
+
+enum sess_state {
+	SESS_STATE_CONNECTED,
+	SESS_STATE_DISCONNECTED
+};
+
+struct ibnbd_srv_session {
+	struct list_head        list; /* for the global sess_list */
+	struct ibtrs_session    *ibtrs_sess;
+	char			str_addr[IBTRS_ADDRLEN];
+	char			hostname[MAXHOSTNAMELEN];
+	int			queue_depth;
+	enum sess_state         state;
+	struct bio_set		*sess_bio_set;
+
+	rwlock_t                index_lock ____cacheline_aligned;
+	struct idr              index_idr;
+	struct mutex		lock; /* protects sess_dev_list */
+	struct list_head        sess_dev_list; /* list of struct ibnbd_srv_sess_dev */
+	u8			ver; /* IBNBD protocol version */
+};
+
+struct ibnbd_srv_dev {
+	struct list_head                list; /* global dev_list */
+
+	struct kobject                  dev_kobj;
+	struct kobject                  dev_clients_kobj;
+
+	struct kref                     kref;
+	char				id[NAME_MAX];
+
+	struct mutex			lock; /* protects sess_dev_list and open_write_cnt */
+	struct list_head		sess_dev_list; /* list of struct ibnbd_srv_sess_dev */
+	int				open_write_cnt;
+	enum ibnbd_io_mode		mode;
+};
+
+struct ibnbd_srv_sess_dev {
+	struct list_head		dev_list; /* for struct ibnbd_srv_dev->sess_dev_list */
+	struct list_head		sess_list; /* for struct ibnbd_srv_session->sess_dev_list */
+
+	struct ibnbd_dev		*ibnbd_dev;
+	struct ibnbd_srv_session        *sess;
+	struct ibnbd_srv_dev		*dev;
+	struct kobject                  kobj;
+	struct completion		*sysfs_release_compl;
+
+	u32                             device_id;
+	u32                             clt_device_id;
+	fmode_t                         open_flags;
+	struct kref			kref;
+	struct completion               *destroy_comp;
+	char				pathname[NAME_MAX];
+	size_t				nsectors;
+	bool                            is_visible;
+};
+
+int ibnbd_srv_revalidate_dev(struct ibnbd_srv_dev *dev);
+
+#endif
-- 
2.7.4
