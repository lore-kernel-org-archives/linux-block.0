Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FAC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E723B2081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="XOFZAOXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E723B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLDRrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:47:41 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:37116 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:47:41 -0500
Received: by mail-yw1-f46.google.com with SMTP id h193so7325575ywc.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=cpp233uzRBKsfChjZCjS2W9+E8WvGYpADU5EZ/6mWnM=;
        b=XOFZAOXbXNnB24Q+VnpCwHdQbgo7YSQQ1kzaisYwmy7yBW384jZdStbtQRFsuvNki4
         lmCDAq6YdzHZ75eXG9y0AuGZFml2aSES2od/ielYM+ku1HDBttHKP/VpWyv0Xgry6XSe
         y9c6DDTTNxVe77ftqUIVYFafipJBOI5ieIbyNRxtGYHw67aNQSyvw0xl/yYrd/TrsKtI
         UiwZ5A+eGq6aRwEIropU0aEE6+6qSpYZXZLMK3t5bQ85rVkxwG/fbB1ufREts9X9vaxj
         rszpRbnWzL0ttvtVI1uh3mkEYb09BzXQrlQ6Bh/uYNe8hetV1N4UDIV/pf/dC/BUOm8V
         +7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=cpp233uzRBKsfChjZCjS2W9+E8WvGYpADU5EZ/6mWnM=;
        b=nFbUH424xmx1KJs4q5fQFBk/nSj4QRp8kGZuTug50X3Ak/5lFBPFWW8nbfTvG6JR1F
         W9GiF8VEEjGKnF+dXn51kkM2QOO50MMO+/n/nhx+UNAoTv3U+1pcNjr1rjs9HnmEc2se
         AZqNzzljXmPhCPcZ/OLFiLpnnW9pK0H9lfrgHpn8l6+heELFmE2mwwKD3gfIN8ZltFMe
         lAcKU5OZmpmkSupq7Ui85DGFHK+xaGJI4JaSYUSib5Wgfs4kowFJdxbqIuL8EGQimqDy
         JJb8ZPGtI9/L4fbM+5nilMDQd6IiGDhGvE/T9OWFySNM8OwiSDTVFoYHRiPdx8wJ3+lX
         vHQQ==
X-Gm-Message-State: AA+aEWbTEOpjm9o67rA8cswGR8/fW5cvAcgyyah1U4pB5zK0qr0Jzzlh
        PklUtARFA08V7VgEJUmG06ZyAR0NJUs=
X-Google-Smtp-Source: AFSGD/V+zWLF67PUUZz7prKD5rnNXU3P2G4snpofixYia1F1R1WlfD74mh0IElz3IntOV3CgFu841Q==
X-Received: by 2002:a81:3e05:: with SMTP id l5mr21292101ywa.508.1543945659843;
        Tue, 04 Dec 2018 09:47:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m67sm5385553ywb.54.2018.12.04.09.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:47:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 2/3] blktests: add python scripts for parsing fio json output
Date:   Tue,  4 Dec 2018 12:47:32 -0500
Message-Id: <20181204174733.7423-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204174733.7423-1-josef@toxicpanda.com>
References: <20181204174733.7423-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I wrote these scripts for xfstests, just copying them over to blktests
as well.  The terse output fio support that blktests doesn't get all of
the various fio performance things that we may want to look at, this
gives us a lot of flexibility around getting specific values out of the
fio results data.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 src/FioResultDecoder.py | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/fio-key-value.py    | 28 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 src/FioResultDecoder.py
 create mode 100644 src/fio-key-value.py

diff --git a/src/FioResultDecoder.py b/src/FioResultDecoder.py
new file mode 100644
index 000000000000..d004140c0fdf
--- /dev/null
+++ b/src/FioResultDecoder.py
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+
+class FioResultDecoder(json.JSONDecoder):
+    """Decoder for decoding fio result json to an object for our database
+
+    This decodes the json output from fio into an object that can be directly
+    inserted into our database.  This just strips out the fields we don't care
+    about and collapses the read/write/trim classes into a flat value structure
+    inside of the jobs object.
+
+    For example
+        "write" : {
+            "io_bytes" : 313360384,
+            "bw" : 1016,
+        }
+
+    Get's collapsed to
+
+        "write_io_bytes" : 313360384,
+        "write_bw": 1016,
+
+    Currently any dict under 'jobs' get's dropped, with the exception of 'read',
+    'write', and 'trim'.  For those sub sections we drop any dict's under those.
+
+    Attempt to keep this as generic as possible, we don't want to break every
+    time fio changes it's json output format.
+    """
+    _ignore_types = ['dict', 'list']
+    _override_keys = ['lat_ns', 'lat']
+    _io_ops = ['read', 'write', 'trim']
+
+    _transform_keys = { 'lat': 'lat_ns' }
+
+    def decode(self, json_string):
+        """This does the dirty work of converting everything"""
+        default_obj = super(FioResultDecoder, self).decode(json_string)
+        obj = {}
+        obj['global'] = {}
+        obj['global']['time'] = default_obj['time']
+        obj['jobs'] = []
+        for job in default_obj['jobs']:
+            new_job = {}
+            for key,value in job.iteritems():
+                if key not in self._io_ops:
+                    if value.__class__.__name__ in self._ignore_types:
+                        continue
+                    new_job[key] = value
+                    continue
+                for k,v in value.iteritems():
+                    if k in self._override_keys:
+                        if k in self._transform_keys:
+                            k = self._transform_keys[k]
+                        for subk,subv in v.iteritems():
+                            collapsed_key = "{}_{}_{}".format(key, k, subk)
+                            new_job[collapsed_key] = subv
+                        continue
+                    if v.__class__.__name__ in self._ignore_types:
+                        continue
+                    collapsed_key = "{}_{}".format(key, k)
+                    new_job[collapsed_key] = v
+            obj['jobs'].append(new_job)
+        return obj
diff --git a/src/fio-key-value.py b/src/fio-key-value.py
new file mode 100644
index 000000000000..208e9a453a19
--- /dev/null
+++ b/src/fio-key-value.py
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import FioResultDecoder
+import json
+import argparse
+import sys
+import platform
+
+parser = argparse.ArgumentParser()
+parser.add_argument('-j', '--jobname', type=str,
+                    help="The jobname we want our key from.",
+                    required=True)
+parser.add_argument('-k', '--key', type=str,
+                    help="The key we want the value of", required=True)
+parser.add_argument('result', type=str,
+                    help="The result file read")
+args = parser.parse_args()
+
+json_data = open(args.result)
+data = json.load(json_data, cls=FioResultDecoder.FioResultDecoder)
+
+for job in data['jobs']:
+    if job['jobname'] == args.jobname:
+        if args.key not in job:
+            print('')
+        else:
+            print("{}".format(job[args.key]))
+        break
-- 
2.14.3

