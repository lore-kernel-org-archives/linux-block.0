Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6E44B662
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385356; cv=none; b=pc2PYy3oVOu59CcvmW9a3xzrVjuvxBlEHZPLkMG1IeB+9Q4+6F9fB9GM/AqRk1uOoMnaEJQD3C9zIIv2ykdE2AQV29yqF2shtpkOw1xm3ZsA0gLl9XdzcfbqtOtSu6IWUmsiWL8R8SOtMkwTUyKTep8rTua8Zv4aN9rOfllsT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385356; c=relaxed/simple;
	bh=A1geN9J8a44aDD1ejAUMcNB78AGiuUN0Urp3C6DFhSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkDcbxCXWdQ4nGS9RS55lfh++VX7LYiEKlaOTkBVekP+tHbHMhjHL2I2cKp6THpk8fHN82oRZg+LnjP77hFEr7Xg8q0JeF+2coeDbu1Ll+wtAS07ARPs1o1xMmoW1xVxANv1OAOWl+BTADM1YoUT97On3czXXzxo7cVRI7huuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vWzJsDWq; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vWzJsDWq"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g4j3Z0lmxzlfwHM;
	Tue, 28 Apr 2026 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1777385350; x=1779977351; bh=4w3twslmrYvzC03JN+cGXt77cV3qJlezvVm
	4xXyzEgE=; b=vWzJsDWqyJD0Hx/JZf2I0Gc1b3z2huyWdXtziVdkAbqnxbKDJlG
	JRAH7cdsUUzxOftrBgxqv0IDEckofRGK4cEvzmPXyiJKNiipK5koL4XChMLVBSyN
	J5VDRePMraUk9JAvU18h1AVlMBOLWyLZL9A7r4NzM9TunvWu7Z7YpEOlBWF7WLhc
	tLGwYlz736760q/4W0tT3katnUgh5HDFYP4yISvDnzmqh2IYdg/jf/tZrSBUrs5A
	hhD3K0djMY4nwN0wFqHFd/f8ooxV0TLZ0HsTj/5L4UHvhBWpimTwv6I2R3yKnxZj
	Laxm++YrFmNiSCJFOCTkeNFQ62r3dWOPuKQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bDvVLhzG6A22; Tue, 28 Apr 2026 14:09:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g4j3T6zd7zlfl5k;
	Tue, 28 Apr 2026 14:09:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ci: Switch to actions/checkout@main
Date: Tue, 28 Apr 2026 07:08:59 -0700
Message-ID: <20260428140859.445516-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Suppress the following GitHub warning:

Node.js 20 actions are deprecated. The following actions are running on
Node.js 20 and may not work as expected: actions/checkout@v2. Actions wil=
l
be forced to run with Node.js 24 by default starting June 2nd, 2026.
Node.js 20 will be removed from the runner on September 16th, 2026. Pleas=
e
check if updated versions of these actions are available that support
Node.js 24. To opt into Node.js 24 now, set the
FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=3Dtrue environment variable on the run=
ner
or in your workflow file. Once Node.js 24 becomes the default, you can
temporarily opt out by setting ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION=3D=
true.
For more information see:s
https://github.blog/changelog/2025-09-19-deprecation-of-node-20-on-github=
-actions-runners/

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .github/workflows/ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 5a6ca1a26b34..9946b289540c 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -10,7 +10,7 @@ jobs:
         compiler: [gcc, clang]
         arch: [x86_64, x86]
     steps:
-      - uses: actions/checkout@v2
+      - uses: actions/checkout@main
       - name: Install multilib
         run: |
           sudo apt-get update
@@ -28,7 +28,7 @@ jobs:
   check:
     runs-on: ubuntu-latest
     steps:
-      - uses: actions/checkout@v2
+      - uses: actions/checkout@main
       - name: Install ShellCheck
         run: |
           curl -L "https://github.com/koalaman/shellcheck/releases/downl=
oad/stable/shellcheck-stable.linux.x86_64.tar.xz" | tar -xJ shellcheck-st=
able/shellcheck
