Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101B15ECC1
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530252; cv=none; b=iicVcPfk/tRAMJJbn2UGaEJONp1BGmzyFTbiVSH+xsFsBEzT8NGSRv7KpOgYKMNEMdlaMPkFAJzGiZnFqwmW5BdbXLmu7zC8tTeIs6siigTTAWo7iL3Jyw6rx32bglXSO03eXOmdfpIi49e8iok9o8SU/61mJfFBuDVcZIQX7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530252; c=relaxed/simple;
	bh=lV2c8bWlG0rG+1b7v+KJ0Zk0vnKBB3kLOZOZzuXfTnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJcQvhqPSNNsaWrs0G7QRErXNe6OM7k/76XmPAOPBVuAP9lY/fWlm9rjJ/QpDU9TpHzyZgoZsIZuhR2y+N4lU+P8D3JflmrrVx55DJlBe/sbs4kdbJNNWOSXV3CowSgzWFCgVXqZmJtyR19bXbPpX+HOXsSLhds8iOiYZBIbBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KzB+C43I; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KzB+C43I"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3jlWOTeAJjlAO+1V1CKn0gATxdO3mNRFLZKZj4yxoE=;
	b=KzB+C43IYxLcnrg2/A4BKsTpOuvHKfhhmd3+L8WchMd0rjsoR+ZZnsg3uyjOsaFyVTlDfg
	82wJCqG2C32DlR8sDd1dQ6VTS74/98WYnbt5+aOAtCESM2mWBFpVRxlSFFEoQP+bL9p59/
	hjWqh8OB+fwNsNiejXtmGHXaxfiJ2X0=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 2/7] cbd: introduce cbd_host
Date: Tue,  9 Jul 2024 13:03:38 +0000
Message-Id: <20240709130343.858363-3-dongsheng.yang@linux.dev>
In-Reply-To: <20240709130343.858363-1-dongsheng.yang@linux.dev>
References: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "cbd_host" represents a host node. Each node needs to be registered
before it can use the "cbd_transport". After registration, the node's
information, such as its hostname, will be recorded in the "hosts" area
of this transport. Through this mechanism, we can know which nodes are
currently using each transport.

If a host dies without unregistering, we allow the user to clear this
host entry in the metadata.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_host.c | 128 +++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_host.c

diff --git a/drivers/block/cbd/cbd_host.c b/drivers/block/cbd/cbd_host.c
new file mode 100644
index 000000000000..8843e09e3a2d
--- /dev/null
+++ b/drivers/block/cbd/cbd_host.c
@@ -0,0 +1,128 @@
+#include "cbd_internal.h"
+
+static ssize_t cbd_host_name_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_host_device *host;
+	struct cbd_host_info *host_info;
+
+	host = container_of(dev, struct cbd_host_device, dev);
+	host_info = host->host_info;
+
+	if (host_info->state == cbd_host_state_none)
+		return 0;
+
+	return sprintf(buf, "%s\n", host_info->hostname);
+}
+
+static DEVICE_ATTR(hostname, 0400, cbd_host_name_show, NULL);
+
+CBD_OBJ_HEARTBEAT(host);
+
+static struct attribute *cbd_host_attrs[] = {
+	&dev_attr_hostname.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_host_attr_group = {
+	.attrs = cbd_host_attrs,
+};
+
+static const struct attribute_group *cbd_host_attr_groups[] = {
+	&cbd_host_attr_group,
+	NULL
+};
+
+static void cbd_host_release(struct device *dev)
+{
+}
+
+const struct device_type cbd_host_type = {
+	.name		= "cbd_host",
+	.groups		= cbd_host_attr_groups,
+	.release	= cbd_host_release,
+};
+
+const struct device_type cbd_hosts_type = {
+	.name		= "cbd_hosts",
+	.release	= cbd_host_release,
+};
+
+int cbd_host_register(struct cbd_transport *cbdt, char *hostname)
+{
+	struct cbd_host *host;
+	struct cbd_host_info *host_info;
+	u32 host_id;
+	int ret;
+
+	if (cbdt->host)
+		return -EEXIST;
+
+	if (strlen(hostname) == 0)
+		return -EINVAL;
+
+	ret = cbdt_get_empty_host_id(cbdt, &host_id);
+	if (ret < 0)
+		return ret;
+
+	host = kzalloc(sizeof(struct cbd_host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	host->host_id = host_id;
+	host->cbdt = cbdt;
+	INIT_DELAYED_WORK(&host->hb_work, host_hb_workfn);
+
+	host_info = cbdt_get_host_info(cbdt, host_id);
+	host_info->state = cbd_host_state_running;
+	memcpy(host_info->hostname, hostname, CBD_NAME_LEN);
+
+	host->host_info = host_info;
+	cbdt->host = host;
+
+	queue_delayed_work(cbd_wq, &host->hb_work, 0);
+
+	return 0;
+}
+
+int cbd_host_unregister(struct cbd_transport *cbdt)
+{
+	struct cbd_host *host = cbdt->host;
+	struct cbd_host_info *host_info;
+
+	if (!host) {
+		cbd_err("This host is not registered.");
+		return 0;
+	}
+
+	cancel_delayed_work_sync(&host->hb_work);
+	host_info = host->host_info;
+	memset(host_info->hostname, 0, CBD_NAME_LEN);
+	host_info->alive_ts = 0;
+	host_info->state = cbd_host_state_none;
+
+	cbdt->host = NULL;
+	kfree(cbdt->host);
+
+	return 0;
+}
+
+int cbd_host_clear(struct cbd_transport *cbdt, u32 host_id)
+{
+	struct cbd_host_info *host_info;
+
+	host_info = cbdt_get_host_info(cbdt, host_id);
+	if (cbd_host_info_is_alive(host_info)) {
+		cbdt_err(cbdt, "host %u is still alive\n", host_id);
+		return -EBUSY;
+	}
+
+	if (host_info->state == cbd_host_state_none)
+		return 0;
+
+	host_info->state = cbd_host_state_none;
+
+	return 0;
+}
-- 
2.34.1

