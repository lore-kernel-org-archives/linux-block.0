Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EDC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1071218D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545329912;
	bh=NZIhO5AfwvmEiWz5d+dpa/D/+Eu/ZySEOT/8TkSu/qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tg821pgO98+vL+7LGDXiNdfaiUYbEwv5mQtncAZzidxg7I7jnX3J3vqC7TXkxRcti
	 Kqxb8NsvHgs7g9C1RdNekvcUQz5SBvDD4nPzt7N9g6hSgmYBKNelkKS/uEp9dMng5l
	 DhXjkfFwtAcl/9FURCVoA7Q6FylgGD1N3FhBP7pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeLTSSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:18:32 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43261 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeLTSSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:18:32 -0500
Received: by mail-yw1-f65.google.com with SMTP id n21so1046769ywd.10
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DjzoohP8ri7b1Fvpz3Cnv3WgJh5EJUJ6dAteQ8S5u2E=;
        b=j1z6jHCmy7VnMtaD3x9054tHI3510vU0C41qaePl0Z4sGtXjORr0y0mIBSqcz1g2UE
         8OJQy8j2MVy1c+pioNshSZFcteNiuJRGbXy5iglq4orh1CoZ6dFHqnMyvrsq9cQcIkzk
         LyHjz0YwJuhfRxuGK+6RV3xu1OwDOrF57IkBc8oy/c57lIP+/vkr9mQnYGnb0fNjEWj2
         y+HFhS4fhRCdvHyvY/JuNJ0WPhiH58TZG10SUbjjn+k3vauqeG9MeqUVkohHoDO6jEhC
         VBpctSX1kOvutHfMUR6Oqbq444cb8bFN+BBk2B3H6O6/ehFyNYQR1rTGxM31TOMsE4WX
         YIMA==
X-Gm-Message-State: AA+aEWYjR6clo8GjpXNibUdrNQKzgTlrGKXXZMYum2iCythjGQMijGdp
        953KMPAMEB5ZJUY8rGAQa7Q=
X-Google-Smtp-Source: AFSGD/W+UTIk4F29XEAzXqhA8I9IzzPlMRxNgv1BPQ1tmR+DKQ7o/aslSIl+z34mzhcyvGU00l2Now==
X-Received: by 2002:a81:c44d:: with SMTP id s13mr28473829ywj.411.1545329911278;
        Thu, 20 Dec 2018 10:18:31 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id q185sm7115113ywe.87.2018.12.20.10.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 10:18:30 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests 1/2] blktests: split out cgroup2 controller and file check
Date:   Thu, 20 Dec 2018 12:18:25 -0600
Message-Id: <20181220181826.55481-2-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181220181826.55481-1-dennis@kernel.org>
References: <20181220181826.55481-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a prep patch for a new test that will race blkg association and
request_queue cleanup. As blkg association is a underlying cgroup io
controller feature, we need the ability to check if the controller is
available.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
v2:
- fixed minor typo.

 common/cgroup | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/common/cgroup b/common/cgroup
index d445093..48e546f 100644
--- a/common/cgroup
+++ b/common/cgroup
@@ -37,19 +37,27 @@ _have_cgroup2()
 	return 0
 }
 
-_have_cgroup2_controller_file()
+_have_cgroup2_controller()
 {
-	_have_cgroup2 || return 1
-
 	local controller="$1"
-	local file="$2"
-	local dir
+
+	_have_cgroup2 || return 1
 
 	dir="$(_cgroup2_base_dir)"
+
 	if ! grep -q "$controller" "$dir/cgroup.controllers"; then
 		SKIP_REASON="no support for $controller cgroup controller; if it is enabled, you may need to boot with cgroup_no_v1=$controller"
 		return 1
 	fi
+}
+
+_have_cgroup2_controller_file()
+{
+	local controller="$1"
+	local file="$2"
+	local dir
+
+	_have_cgroup2_controller "$controller" || return 1
 
 	mkdir "$dir/blktests"
 	echo "+$controller" > "$dir/cgroup.subtree_control"
-- 
2.17.1

