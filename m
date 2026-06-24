Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A12263F4A
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304621; cv=none; b=AqtzqhNStUGdAjcFSHo9YJrwcgyijWxoGrb6kdoYlsD5AEBC/Ax6tu+C+NEVsU0Xsc5oJkWEHI3xVL7s3PNslVt88Bpw6yTbJK4aRQeTs/wR7LMY0IS1/W6oTtZCq7E1XD/D8YCmE0+/3D1A9ve4mJWKuEPwAMVvwbclUL2AWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304621; c=relaxed/simple;
	bh=n7yeLGokqqCEYqPAMP4LCZTg50ntP6woAwtrH9YhnIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdasYNka1Dfmg9WVwW+ZIGicQqv86mzadOOh/aKnhaPlOZMWcvcYY/DFmDDkq+RtTPwIeMNl1HE8Y1rW/91eo9sUPVn4IDmq14KoBuwKKaYlk9v+oAWLuQCcrFz7ly9R44tB8prbA+tGFvWnaN+bIFYGaJpVEvKYZ/TILDl96UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVRfEuUJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVRfEuUJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-492329c5514so4084425e9.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304619; x=1782909419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVVzYHaalnDwmrRDCXsQm1lcc3hZBz2mEnxrShCLD2c=;
        b=jVRfEuUJ1wAJ8mVKScQhvSR7fHYlYtfH7rwKA1RK1Co6ZDlmEosW7vQgATt7R0sgV7
         lPNO5UynbCc2RgSQx0Ii2V+fmj31w5E31k4MX37wEyIePdXUp7AumSFVyrH01XRIqTjf
         hVjpfdhFg6Olraa4rDeL6OAa27Exu/gSKcTiwz/xIfww+lthnQAxhOypazA6TA1Be/I8
         Sj1vRKqmk2A+m51NUNAh/f502DEiPfOxG5prwe92UawZN0a0OKw+j0y47KDwxPDBWIz5
         bEBuj8DsTmtQGZPFA8bgdWSVqKKetshqUtNFI2rs/j7JxT8MtDsqVJlIhaLe1miZEHwq
         wP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304619; x=1782909419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVVzYHaalnDwmrRDCXsQm1lcc3hZBz2mEnxrShCLD2c=;
        b=a+nbLsyv8psOqEE1FSWw4V8FDKoSNIi4GVOpIirojkbBcAk5UcU+faZwXGa7VF9ajI
         Vmp1F2n3WsdP65ZagjGz6ftIUZUEP1Jc/FqSfGRNaxq3tllaiNFXvZIUwCGcLZHDM3iA
         1bh2P60exx3KW4OhSpjjWjMqzUFtFhBX5y5+1lqjrSfT4pUWJSDYUjF2r1L6yFWpGUV6
         9zsp0/IclsGJvelFNIcr/OPmvv2wkUB7sgZvMILeNsDMEAlqhvuL8fxQHnYOwHcEEmXP
         wi3ykJUw9yy0CA0/FelR90W4xPwUxz/03oO9ptE9sFv4FVRh4ifWhKbpzWLpvECtla03
         SQ+g==
X-Forwarded-Encrypted: i=1; AFNElJ+PiDRyf/1B/W5XaanANT7nj2VK0YvogC4LX1+8kXMGA5be9/sMhu2Hn0NaDb38p0Yt/DN3C/e1bFQWkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFumi54Xmilxr9sE1tqVRAP8odxahcc9g+w6gRboXbLCkdg/d
	692jIb0zYowA1oRmlzXkrn+kdeUBhNuhY7tW6L2t5w6OjW5ekglOQ7Ft
X-Gm-Gg: AfdE7clwrLQUFutynBHbVn9rCS4QKk4SdroiLwfqv6tJPH54BWTvClioQw8RSDl6F78
	HOgX5sLr6clsOaSUyoVrY9D7vubX9LXvjXHHHwEHe3KsrjiRhiE5QwcCmBfzAqYQr6tnyNCsY6i
	tjHHk5/VTW+rXh4z/BKTh8ELJ0Mp1yh4+FWgnzZtPju90Tz7Zt1wD2YsZ0T0i3Z6adfPAMxPI/K
	JRlUoOY3ZH+RgZQa8Zt1zLWC/KVlCFQVQM0CP0bjrp6ydP+VQ4l6pcwqsAXVW9pEXtmraakYe3X
	h930jOsYRNIKpX1KAPprZtaf6EhBaLiqgRCk+rfUKeHo628ThPf7OuDMz9FvrPce5Se2FkcJxyO
	9CmMBuLrJYOIlpvijxQbecMROxvmOdFz4cinlCnQO8yd0S+ibb5RsGacL0Abu/jorR8KI4P6AH+
	Ze/V+62ZRmf2pHUemhn2rqkKmiNQ==
X-Received: by 2002:a05:600c:4747:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492632b20b7mr4090775e9.13.1782304618712;
        Wed, 24 Jun 2026 05:36:58 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b359sm432036495e9.9.2026.06.24.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:36:58 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tools/cgroup: iocost_monitor: parse help before importing drgn
Date: Wed, 24 Jun 2026 14:36:52 +0200
Message-ID: <20260624123652.8108-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iocost_monitor.py imports drgn before argparse can handle "-h" or report
argument errors. That makes basic usage help fail on systems where drgn is
not installed.

Parse arguments before importing drgn so the help and argument-error paths
work without the runtime debugging dependency. Normal execution still
imports drgn before reading kernel state.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 tools/cgroup/iocost_monitor.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 933c750b3..bdd78ba27 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -15,11 +15,6 @@ import time
 import json
 import math
 
-import drgn
-from drgn import container_of
-from drgn.helpers.linux.list import list_for_each_entry,list_empty
-from drgn.helpers.linux.radixtree import radix_tree_for_each,radix_tree_lookup
-
 import argparse
 parser = argparse.ArgumentParser(description=desc,
                                  formatter_class=argparse.RawTextHelpFormatter)
@@ -34,6 +29,11 @@ parser.add_argument('--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
 
+import drgn
+from drgn import container_of
+from drgn.helpers.linux.list import list_for_each_entry,list_empty
+from drgn.helpers.linux.radixtree import radix_tree_for_each,radix_tree_lookup
+
 def err(s):
     print(s, file=sys.stderr, flush=True)
     sys.exit(1)
-- 
2.54.0

