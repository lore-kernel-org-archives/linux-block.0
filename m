Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B348292B42;
	Fri, 18 Jul 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826977; cv=none; b=Kb0qCdU1jwrytQMxvARrMdOIiIPhknXTi/6pKSBeA0LF/Vq1auf8LYkGsk36K3bgZltVVMm7I0eHg3sDhAjTGLfY94XbrdMqEmagpJ8CwMDJbPWpIJ6v2Ll2ozAClyWDC5Ij34nse4g1+v9koixfPSSd2sx7SuJukiqB0iwDQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826977; c=relaxed/simple;
	bh=dIxQv9AtZEsjxl9mVLC6wMDHglO4W89UwiGmgJxhBFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t5JfK4URghOfHJd/Nd5iNadlKn+LBcd+sC+5/9N3+ut3q5w4E+S5PYEiY9NnlyJYIW+T2zxpeMqyxt/vVCFn2crwsl3/rXAmbdf7KxlgNOX2E6drqQXW0cry+PSOhuccMnhi1ut+Lu1dpA1IyWA0SMyv50Nwq7a8W02CmLCZI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-01 (Coremail) with SMTP id qwCowAB3oKROBHpo+xghBQ--.35899S2;
	Fri, 18 Jul 2025 16:22:47 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: axboe@kernel.dk,
	sln@onemain.com,
	Jim.Quigley@oracle.com,
	liam.merwick@oracle.com,
	aaron.young@oracle.com,
	alexandre.chartre@oracle.com
Cc: akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sunvdc: Balance device refcount in vdc_port_mpgroup_check
Date: Fri, 18 Jul 2025 16:22:36 +0800
Message-Id: <20250718082236.3400483-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3oKROBHpo+xghBQ--.35899S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDZw1xAr1kGFykXryrZwb_yoW8WF48pa
	1DCa45XrW3GF17Kr48XayUZF1FkFy0v34SgFW8Aw1Fkr93XrWIyrWUt34j9w1UJF93JFWD
	JF17ta48JFWUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeYLvDUUU
	U
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Using device_find_child() to locate a probed virtual-device-port node
causes a device refcount imbalance, as device_find_child() internally
calls get_device() to increment the device’s reference count before
returning its pointer. vdc_port_mpgroup_check() directly returns true
upon finding a matching device without releasing the reference via
put_device(). We should call put_device() to decrement refcount.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 3ee70591d6c4 ("sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/block/sunvdc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b5727dea15bd..b6dbd5dd2723 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -950,6 +950,7 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
 {
 	struct vdc_check_port_data port_data;
 	struct device *dev;
+	bool found = false;
 
 	port_data.dev_no = vdev->dev_no;
 	port_data.type = (char *)&vdev->type;
@@ -957,10 +958,12 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
 	dev = device_find_child(vdev->dev.parent, &port_data,
 				vdc_device_probed);
 
-	if (dev)
-		return true;
+	if (dev) {
+		found = true;
+		put_device(dev);
+	}
 
-	return false;
+	return found;
 }
 
 static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
-- 
2.25.1

