Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6734AB19
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832481; cv=none; b=FgkXuWBLfmSFZkz5NyySvHFTxQ1QHKSyYKb7Sn1OkLu11k7gxNiAO2z6a8FWmSEA8H72fjPFBCA6CaF424G2n/cfI8pf2r5JVOZ7T546Lsm7nGLBDkojQbqdmY77Kh04Flxk4U7YRqOu2XVOgs7dZoNFFfDzkIX6Nfyw1WpkKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832481; c=relaxed/simple;
	bh=z7EHGTUJatx1XpP3ZQWdxqIemjSrwDl6rN0F6p0eYCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5MvsAxqqW/Aon7Z3JmYjmZHjhBJ6eJmLmrk34/lkY3jX1xDMEbONHvZRSAImd1btOW1m2mpawKbssOfkQXBmuaGrQzEYCM6Ye412ZA4MJIuXhRB9fZqHP+FFttRilHsKsJ0jUng0m0k6GRjUyiMYjLHN15skv9EaPlQp5hlXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P1CCM0so; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P1CCM0so"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832480; x=1803368480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7EHGTUJatx1XpP3ZQWdxqIemjSrwDl6rN0F6p0eYCY=;
  b=P1CCM0so2vNWF8juY3VlN77qUqn+p2fs+iIxrKOzSuT3gyi+P34jWhbV
   vRkM3t1YnWIRk/2TmYZKJKKJ9mTXvQf6dGF1J5nfa46O1fSu5s6PozKLR
   Baiz/iZOl42zWqQPjyrzr7fAzvdxhm0NdpAb5yeDS4UbwcjdTvBrLk4kO
   vH2ajiOQmdVt2kfQia6hxGoSpXl6XF0D6miZkvS7P63lOMLMGMUZ43+3F
   t7X8eNGnuK7gyRS+LX+gyDsCAupiDdddOVtfzGdgul4EbtHyWIhcoDpJu
   dRdXGcg0BoslHgE6fRiLzrm6NK3YE9LXfHmx6+LdKGBZ4VAMj7RCP96cm
   Q==;
X-CSE-ConnectionGUID: 1WwDwG4rSfe8S1t7fxTu7A==
X-CSE-MsgGUID: If5vO5ZxT/yPhIHXspR7vA==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140846178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:14 +0800
IronPort-SDR: 699c049b_XLfcFzWNUt+idXvcf9mXmLVhdo6YKEtuBgE0/sXPZKTKGgf
 ezv4dvtHzqLDmc/hpGNS6yeAchyzgBrJ+6Ou+aQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:15 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:14 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] check: increment bash requirement version from 4.2 to 4.3
Date: Mon, 23 Feb 2026 16:41:09 +0900
Message-ID: <20260223074110.144758-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper functions _get_nvmet_ports() and _get_nvmet_port_params() use
the bash 'nameref' feature, introduced in the bash version 4.3.
Currently, blktests README and the check script declare bash version
4.2 as the minimum bash version, leading to a version mismatch.

Fix this inconsistency by updating the minimum required bash version
to 4.3. Note that bash 4.2 was released in 2011, while bash 4.3 was
released in 2014. This change is unlikely to affect blktests users.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 2 +-
 check     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index e993105..b137a43 100644
--- a/README.md
+++ b/README.md
@@ -12,7 +12,7 @@ filesystem testing framework. It was originally written by Omar Sandoval and
 
 The dependencies are minimal, but make sure you have them installed:
 
-- bash (>= 4.2)
+- bash (>= 4.3)
 - GNU coreutils
 - GNU awk
 - util-linux
diff --git a/check b/check
index a2c19a2..8c113b3 100755
--- a/check
+++ b/check
@@ -1074,11 +1074,11 @@ _check_dependencies() {
 	local -A required_commands_and_packages
 	local cmd
 
-	# Require bash version 4.2
+	# Require bash version 4.3
 	IFS='.' read -r v1 v2 v3 < <(bash --version | grep version | head -1 | \
 					   sed 's/.*version \([0-9.]\+\).*/\1/')
-	if ((v1 * 65536 + v2 * 256 + v3 < 4 * 65536 + 2 * 256)); then
-		_warning "bash version is older than 4.2"
+	if ((v1 * 65536 + v2 * 256 + v3 < 4 * 65536 + 3 * 256)); then
+		_warning "bash version is older than 4.3"
 	fi
 
 	# Check dependent commands to run blktests
-- 
2.53.0

