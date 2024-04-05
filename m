Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2D79E3
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336049; cv=none; b=UiCMqDCrOtqC79ZrqGwGoqT6Q2+IxmWDeaRHzj0upcZQpMw0DX6Bh7Jde7IftzKov3tNtxMYX3S3X87Mpr3QHxjReMiUTCewgSdkdz3Dbu+pAktXp+4baKmn773ZDTKZsoHfMfhHXZ4Q7vvOdqhSHLAKo65wooU8VyJ1jLyPvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336049; c=relaxed/simple;
	bh=0fjcQnLqusZfsdTC0rqdibqpq9ZpiGpUwYGDbMI51bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PMWD9L01J4y/SMB/AYpyLDTYd33KBvUwOeVKfpSjiA47eL6ltfo4TDdD95ilLVyK33UXgLaDKc5edL+shiOO7VefnakTfOm9o/1nWmhKDpSvjbmfeXRNKLzOR0MqTZQ2gwu6YLDNJkooyxYUAgwcW4Z5w4FHu84O1lKAK71mp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZHmpUIC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZHmpUIC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2bbc2048eso17184715ad.3
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712336047; x=1712940847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ2PSbpWVu5URvpzPkpOvHrMnaNC1YMZnjtTV8rnnpQ=;
        b=NZHmpUIC/0gqZc4uxpwGh0TC+UyT01B9b4PG0b0wZpOXDoT5xEoF5EYx+faGaC0i+H
         jxb7Ch+54k7Y2O7Ov/6dceja6K4HgqAFqb3lUom/VlCrlaWYn22EmqFjm177tPBnUMDs
         dAFUSvwbmIDSdrkjtevNqvctfcvf62bSa8nMFvz3xAnDLog8X6hKJ4JMS3m5GBwXT/VT
         Z9C5QIcPk0tXe4fwePO+28iC35fk8d7ccYBmFZA0XJnruJgLxnGUgldcEylphxCyoq9z
         6wYaeSt2p+YQ/FS8IhFl543XqeX+VbCnxpoEuhnMrsTJ1QHDujsw2VIfadQlZVeLm1pB
         0i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336047; x=1712940847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ2PSbpWVu5URvpzPkpOvHrMnaNC1YMZnjtTV8rnnpQ=;
        b=K7uFTO4a/UeB8MwYkwer9zW4MuwyXhB74QILx+vNadSYvH+4AEKBAtZqkbJl4tTyws
         O6wV7lmjX9uF2JtzH8TPD4zRMUofDMXnJBlGTzVDmJN6CwqTqyQ0DXF35ZeYZNpwIScN
         lv8agyo1JegEvLTHGhDiHhEgh/KsarRh3szkNdZO8f88EyCFr+PVnGMlSfjZGQBx3JWf
         t+FYuaMCxSX9Yf4v5fq6t2XRVXj0L14N+MgAIkRjRhGItN/lmR7hTG5qJ7K+6h4l4PNM
         eQubCQOyv092tcHQ8LG720aEgqFVX+fI9v0xyQnMSeAdiJWA4lo7maTXYUAen3I+yC8L
         o/IA==
X-Gm-Message-State: AOJu0YwlZcqeqdJJKCR2lsAfTio1SP6g8H8eytzf/0LMKlt6qGCdGZj0
	el9qpTlzdUXpza5Oczluro98WJes6xkmKK/jZMSpqZZci8VFqEiP3JtTu8SrgA0=
X-Google-Smtp-Source: AGHT+IF+j9BTMX4+Y3x2FNgOTqXDzIe2Ya+JROFH/R5iGlcJv7rTwUPWhpqlWeux/MLzYF1X3lOElg==
X-Received: by 2002:a17:903:41c7:b0:1e0:9ee1:d4cf with SMTP id u7-20020a17090341c700b001e09ee1d4cfmr1669426ple.41.1712336046758;
        Fri, 05 Apr 2024 09:54:06 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:6bf8:8d28:8374:5b7d])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001e2c1740264sm1803242plb.252.2024.04.05.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:54:06 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-block@vger.kernel.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] docs: sysfs-block: change hidden sysfs entry listing order
Date: Sat,  6 Apr 2024 01:54:01 +0900
Message-Id: <20240405165401.12637-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

List entries in alphabetical order.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 Documentation/ABI/stable/sysfs-block | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..7718ed34777e 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -34,6 +34,15 @@ Description:
 		The value type is 64 bit unsigned.
 
 
+What:		/sys/block/<disk>/hidden
+Date:		March 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] the block device is hidden. it doesn’t produce events, and
+		can’t be opened from userspace or using blkdev_get*.
+		Used for the underlying components of multipath devices.
+
+
 What:		/sys/block/<disk>/inflight
 Date:		October 2009
 Contact:	Jens Axboe <axboe@kernel.dk>, Nikanth Karthikesan <knikanth@suse.de>
@@ -698,15 +707,6 @@ Description:
 		zoned will report "none".
 
 
-What:		/sys/block/<disk>/hidden
-Date:		March 2023
-Contact:	linux-block@vger.kernel.org
-Description:
-		[RO] the block device is hidden. it doesn’t produce events, and
-		can’t be opened from userspace or using blkdev_get*.
-		Used for the underlying components of multipath devices.
-
-
 What:		/sys/block/<disk>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
-- 
2.40.1

