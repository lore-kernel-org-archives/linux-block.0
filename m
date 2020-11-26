Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA94C63777
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D60C20DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="YsQprvax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgKZKrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbgKZKr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049CC061A04
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq7so1781061edb.4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4l2Xqa78nl3oR6VwhQJgJaGGROL4T6jCJNlZ9gmwMo=;
        b=YsQprvaxw13SmjJexNHzbTRRUYnFqy5roaSWRaF1Sct3CIs09LIO6qF8rA/f0RfsKm
         wKcqVrw5c4EZFI/WrQd8i8hqEmnOEIBKDj54A+pWrWpC2KuIJNVmrtsD05k9zRgDxiy3
         mFQJBjbp3cXM72XKuIF8EzL6ytE++S+P7L5rFNeMo56BjeaaK+ULUQWAaxx3Vd1qVdWX
         3XHO/+wxBDPt3acl5BMG5o1zlmFs+EOGTYhSSeypHpoe+fCyXgbiZND/v6+mhaI4gA1K
         2wXjxEbMtr1CqyQm3347BQTibeB1GGtHRTi28A85bCIsWdWCAbzdFfZK6jI4gr3vO9sX
         SHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4l2Xqa78nl3oR6VwhQJgJaGGROL4T6jCJNlZ9gmwMo=;
        b=gFR4K42/09RdBHtchIqK0mcqstZuGDKr56LEsn/Gs8UaQ/FmNAyAfF3HNoH57PSKYc
         WTb2+NLHHWjI3uKhAd/fXZnYAXlSCy7thgjGvt3i5n+QnX20O0SHaMM5VUxr2P+tegGJ
         KnV3g7SLYb7sNl6SFNw6AOcIj+NxSDE3SFbzjElv30jpiyIM2keg7Ue+SbA301SzJ76X
         fjsR1WH5sizLnVpUJu1OuJwSUBzI7tOugPXDrgVZ0kMNVEsA1TfTvWDGXtu+XIG7fRMT
         tTiHEUz2iKjpnTOr5na2OdYLnb8Cq2m7nrDCUtm3JDihDg4uivvb+Hyj6L/HeHPR+NhE
         sAXA==
X-Gm-Message-State: AOAM5304xReTUUZcCm9zGOfFcZuBIaJqxhdOsUrilvTgSjJ5oULqk6Wr
        XRVaFxMjPfLx1N+PpZdL0frd7wQILQeW/w==
X-Google-Smtp-Source: ABdhPJzs4COBh7IKll7uR58uJBngUFAxQWSDYvrsmjMWQdv4xbgTlO3aPUpH87lLRB6jZPi6Bk7iWg==
X-Received: by 2002:a50:e8c7:: with SMTP id l7mr1948772edn.356.1606387646564;
        Thu, 26 Nov 2020 02:47:26 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:26 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 2/8] block/rnbd-clt: support mapping two devices with the same name from different servers
Date:   Thu, 26 Nov 2020 11:47:17 +0100
Message-Id: <20201126104723.150674-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Previously, we can't map same device name from different sessions
due to the limitation of sysfs naming mechanism.

root@clt2:~# ls -l /sys/class/rnbd-client/ctl/devices/
total 0
lrwxrwxrwx 1 root 0 Sep  2 16:31 !dev!nullb1 -> ../../../block/rnbd0

We only use the device name in above, which caused device with
the same name can't be mapped from another server. To address
the issue, the sessname is appended to the node to differentiate
where the device comes from.

Also, we need to check if the pathname is existed in a specific
session instead of search it in global sess_list.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c |  4 ++++
 drivers/block/rnbd/rnbd-clt.c       | 13 ++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index e7b41ec7cd6a..5d3c3c80dab4 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -480,6 +480,10 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
+	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	if (ret >= len)
+		return -ENAMETOOLONG;
+
 	return 0;
 }
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index edefa0761a81..1bb495e50931 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1410,13 +1410,16 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 	return ERR_PTR(ret);
 }
 
-static bool __exists_dev(const char *pathname)
+static bool __exists_dev(const char *pathname, const char *sessname)
 {
 	struct rnbd_clt_session *sess;
 	struct rnbd_clt_dev *dev;
 	bool found = false;
 
 	list_for_each_entry(sess, &sess_list, list) {
+		if (sessname && strncmp(sess->sessname, sessname,
+					sizeof(sess->sessname)))
+			continue;
 		mutex_lock(&sess->lock);
 		list_for_each_entry(dev, &sess->devs_list, list) {
 			if (!strncmp(dev->pathname, pathname,
@@ -1433,12 +1436,12 @@ static bool __exists_dev(const char *pathname)
 	return found;
 }
 
-static bool exists_devpath(const char *pathname)
+static bool exists_devpath(const char *pathname, const char *sessname)
 {
 	bool found;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname);
+	found = __exists_dev(pathname, sessname);
 	mutex_unlock(&sess_lock);
 
 	return found;
@@ -1451,7 +1454,7 @@ static bool insert_dev_if_not_exists_devpath(const char *pathname,
 	bool found;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname);
+	found = __exists_dev(pathname, sess->sessname);
 	if (!found) {
 		mutex_lock(&sess->lock);
 		list_add_tail(&dev->list, &sess->devs_list);
@@ -1481,7 +1484,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	struct rnbd_clt_dev *dev;
 	int ret;
 
-	if (exists_devpath(pathname))
+	if (unlikely(exists_devpath(pathname, sessname)))
 		return ERR_PTR(-EEXIST);
 
 	sess = find_and_get_or_create_sess(sessname, paths, path_cnt, port_nr);
-- 
2.25.1

