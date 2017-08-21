Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38339 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbdHULoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 07:44:02 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        jbacik@fb.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        manish.chopra@cavium.com, rahul.verma@cavium.com,
        Dept-GELinuxNICDev@cavium.com, harish.patil@cavium.com,
        cascardo@holoscopio.com, don@syst.com.br, dvhart@infradead.org,
        andy@infradead.org, sre@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd-general@lists.sourceforge.net, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/6] nbd: make device_attribute const
Date: Mon, 21 Aug 2017 17:13:08 +0530
Message-Id: <1503315792-14837-3-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
References: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make this const as is is only passed as an argument to the
function device_create_file and device_remove_file and the corresponding
arguments are of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5bdf923..49d7763 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -165,7 +165,7 @@ static ssize_t pid_show(struct device *dev,
 	return sprintf(buf, "%d\n", task_pid_nr(nbd->task_recv));
 }
 
-static struct device_attribute pid_attr = {
+static const struct device_attribute pid_attr = {
 	.attr = { .name = "pid", .mode = S_IRUGO},
 	.show = pid_show,
 };
-- 
1.9.1
