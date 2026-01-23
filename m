Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62B30CDBC;
	Fri, 23 Jan 2026 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167773; cv=none; b=fI8bk+tajl6pfG0XE/NYPbC5D52PPgUX4Ij6j4g7S2JiMu+ylwp+CaFAYgsk+bO09JyVvCPuqgq2FPg2CGFZuxiPJSsLDD8fbAJTqQ0xuuLEiR1H2VX+0r8qKH/ov4hBiwk8s2bbZOJhlPujHK/goA5XDaXfh0xIDM6tR1Pa6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167773; c=relaxed/simple;
	bh=dzJBpSf1nhpH3ORKnwydt5RqNbxmWVNk2rbSEtCJ0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxjYFuCxhf/tCLP/yVDNQCAN4/HMUT3klgk7VRlHPkVkaKa0wyIwdYvnKIhWBZrjkCooowhIjM/Gp3WtiRFtGDAVaKDw1rlZHTfKqOsvOJgWc/5BMx8u4Ds0fTVOrxuKf01qo5OxTxDDIrz8yHqP/xegg9lzcw0LBIAg0eYYZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=c7XcLdQB; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="c7XcLdQB"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769167768; bh=dzJBpSf1nhpH3ORKnwydt5RqNbxmWVNk2rbSEtCJ0VM=;
	h=From:To:Cc:Subject;
	b=c7XcLdQBuYOLWYE503QcgUCOtYstzn7tg3PgEqpUvmEsVZJ7oFG+149F1ySzwgbjK
	 5OcQBVeiG2CDxW0UG0jCQB7R8uKUD8RF2YK1yQogG4xaGMucjgyC3AKB4hShXAoVAy
	 ssigotD9Cqp+tJ1e2pgVt2LB/9kkutJ1OP6Iv3F35SZn5rIKc8Iue5co7dz6LwSuss
	 GMan4ruIlV3DELTDSh+ks7T2tmW/W48q9oY5sOE96xop3NfElN+QcWpK7KOdRB5Hd1
	 JCUiv1iUGHzTgnFjTb+zcb1smGQ5xS3lkH43PnDy+hUDHT16EzfiaE3zoGJbzwpyKM
	 F+doyEffWQ6eWO8xNgDG/TwRgCKaxukOoZhI/KQR7Fhom1kf3X9McZLhq1fhZrT341
	 OrhGR8tReQa5O4DhMsM1eF39HhqCFbhFTrztIf1hvJAd9TFk6nw2axEqpW5km3hSxl
	 1hq5HNHffZfGX3PuWmvBA79P/rgB3PpDz74XlVbOqNkNWFx1UdOeHVcoxpEXbUQEHp
	 f0+6cSmsR0dshLdqgup+tE2sP2QlOz4HV6ZiV+5UMtsP8DNlq1qJ96Jh1iv4Fqposa
	 YOROGfIbw/K3zD2IYTZgobX7lPM+1AuEQMa6dJWZCTcktU544RN46vOyH7tMExNiBr
	 eahRMMhOF/lBELm4Yclr9bw0=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: add missing gitignore for metadata_size binary
Date: Fri, 23 Jan 2026 11:29:12 +0000
Message-ID: <20260123112913.1371323-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new utility metadata_size was added in commit:
261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
but it was not added to .gitignore. Fix that by adding it there.

Fixes: 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
index 8b2871ea7751..95052c32fa09 100644
--- a/tools/testing/selftests/ublk/.gitignore
+++ b/tools/testing/selftests/ublk/.gitignore
@@ -1,3 +1,4 @@
 kublk
 /tools
 *-verify.state
+metadata_size
-- 
2.43.0

