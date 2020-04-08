Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC36C2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A3206C0
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586376913;
	bh=8VmrQ6jz3iEwcnir3jeM3aawg7hgug8AzuR6T+WgcgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MhkX1ThaJZedESe6ToTO9eaE3slBHbSvTRJBghuNHKEb9AbEfvIIl7Z7OzeV5Qqo0
	 69ovK/pBQvyMFa/6kJ4FdqSKqZhkzbA5zz/Xxp/8XVaitKLWiC4RoNOb0Bxru7JQWy
	 RJnfR+IVgtdKw4LW/9Os5L/+vTj2ebMKvg4qbj1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgDHUPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:15:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35389 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgDHUPE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 16:15:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id c63so1694922qke.2;
        Wed, 08 Apr 2020 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrEanY8wxDtok+RTWBGcNDaSQ4QB8ANJ03cLIKdV4tg=;
        b=ex4iZHeH4DOVQuYBmfQMJJYYtzF1WGnnyQk5oSf5kQrIww5/9iaUeRu+xrFcO35QBm
         uTEZUmfC8pKrLoa6CIk++HA89Fr1LmqClmiDzN9WbnfFagMGE44s/rkrv9pp8Ez3VOaL
         rYDsmvOpo6L1AUjud8ciac302OSNuwwlHqWUmgAYPehNYqfBKvjNUkRh79ZIcW0cr/xP
         HGSpOuYozYntvjo/7Wq4Pa/GI11OHsXmIQa2eLRaJ23D16kgN/GmYDGXACIPyUzyQsme
         mWTyM2ehCqgLfRKNhKnyQWWwhUhCsgWwlUjpZX6XpYvz3DKyIhCmpO6sSDNjZB6RGAb5
         HCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vrEanY8wxDtok+RTWBGcNDaSQ4QB8ANJ03cLIKdV4tg=;
        b=a+r3F/um07AK3YKhnYp1oG5qN7gysGh/T/j67EZ2m2jkTTn9idiaxZy4TUa4XCsw3e
         4KAZts5WYT7iC+m0Jb//afxUunugV2M2Vl0y61IXymWSm42eQlGyJO3zMDxwmrtzFNIr
         EmBNC9UnQaUEQ8Ch2V6KGz9FTCB6oIA3mpniWl3ycZnBxc4Yf56QbX46imt9hZjs4//f
         xiivSj87e4L5QdRezOlrzetLvLJBgrBpMuImUYu3oTTCsfT/3OZ1BpwXYwdCIfiQze0X
         ISaBQAT7+ytWtFI6bMWZqwGCvglZcj2fbX7XgNCmX0lR8nDRx2u48iIdle97WCU43XsJ
         zbhg==
X-Gm-Message-State: AGi0PuYgEEToing1P6E+BperhhZuHU/pbIrI228aRPwxyGxKjXKFDyK7
        Z4bTVLEHFioS7fvWNG+g+Zs=
X-Google-Smtp-Source: APiQypJafVvTukLL2cplRfE6mMKqbxOimy4N5GBauz/EWg7/lRjK1fmuOArhy09GhZPxWY4iS0SmMw==
X-Received: by 2002:a37:d0a:: with SMTP id 10mr9249174qkn.288.1586376903087;
        Wed, 08 Apr 2020 13:15:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id o128sm14651009qkf.116.2020.04.08.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:15:02 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] iocost_monitor: exit successfully if interval is zero
Date:   Wed,  8 Apr 2020 16:14:49 -0400
Message-Id: <20200408201450.3959560-5-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200408201450.3959560-1-tj@kernel.org>
References: <20200408201450.3959560-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is to help external tools to decide whether iocost_monitor has all its
requirements met or not based on the exit status of an -i0 run.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 7427a5ee761b..eb2363b868c5 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -28,7 +28,8 @@ parser.add_argument('devname', metavar='DEV',
 parser.add_argument('--cgroup', action='append', metavar='REGEX',
                     help='Regex for target cgroups, ')
 parser.add_argument('--interval', '-i', metavar='SECONDS', type=float, default=1,
-                    help='Monitoring interval in seconds')
+                    help='Monitoring interval in seconds (0 exits immediately '
+                    'after checking requirements)')
 parser.add_argument('--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
@@ -243,6 +244,9 @@ ioc = None
 if ioc is None:
     err(f'Could not find ioc for {devname}');
 
+if interval == 0:
+    sys.exit(0)
+
 # Keep printing
 while True:
     now = time.time()
-- 
2.25.1

