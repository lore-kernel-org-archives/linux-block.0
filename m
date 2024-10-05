Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE8AD4B
	for <linux-block@vger.kernel.org>; Sat,  5 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087251; cv=none; b=owiDR4X9XUv9q/eK8htYbYHEpeJWy1p1sL6SKMiUNpbPpLkG2TkcFbXmPtfsKVhPOwY4M9KbSV0o93i3NxG1/5XYyzapirE5niuw8PFo+CpCFPD6IbP5+u4kBlj4axhW/Xke/bphkOWxYVGpJVcUQBjpMGUtIW0e8sNEojrMUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087251; c=relaxed/simple;
	bh=T0W0KBZI5DkiCjtxQ7TpePJYH2d/3/oGKPm/Q6dRQDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnTAJdb2Inx+cTP+xv/uR4tWXFfGFfVpxtnAY11oq79i3R/g7W+0GZzYJ8rMiACzRPy2sVCVQHMe7nQ4rhtSEkNp2d/8q00DJOSG9a9m43khw2Kdyyr3BRD9xBgnXD3pbYXsvlniwESxlzw5FXllljRL07Uf8AinpliA21fxRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jqgsak8Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqgsak8Q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b6c311f62so24128075ad.0
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728087249; x=1728692049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdvgpKhmD14lH5DEz2GjjZadZ28c69PHIkDv34BVtjY=;
        b=jqgsak8QsIQ0alVyGBI3WHFcIA11Y0wF8K1uNNlhSzk9Ab3pinrLVBqoaNx8Xac70V
         f8WQeLptSwLq7RsNFBgNffUXXrHepegJVD0vGcGgLTgV2HjBfU1S003tw/fA8bK7PNxc
         CCg/bAVp4NhVDhrCI7vE4VU4KFUF2iVtH5d18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728087249; x=1728692049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdvgpKhmD14lH5DEz2GjjZadZ28c69PHIkDv34BVtjY=;
        b=fwjnUW4bWrYAX6NuUFcUXnSkcDnMKya3TUp9bLeJ2h9QnFeYXhXinawq61mx7BEIsH
         2AFmXFRmDVesJp0lMZl8L9pN8ADX78DlmJSxu02SO9+GYglW/X08gp0OQiCo2qwiZ3Rr
         jSMRIEZwdzsOjckCHvgLr0nutRts9WeHWM074+3Nwgg5sq5RS6mKQ+MqczHjhiwfVhIT
         uWmU0OvWn3TahrxICVdF7SarlpIfq2nClZ/8IoWznfnK9zRw06xqMwr65xbNanyRG32p
         BSw3drzBdTJxq0EHiTUhJLCY0uQ7lccG+P93gdbSP5Ni1GROJ7UxjztkDatFI71TFQEN
         oq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWbUXVR9Q2JRA9WJkxf8FXWmOoNUjaoQIiKpoKGhixiNiAbdT2HdpKKpCrop5p86XJ1y2MC1tuRuZ8WBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKraqlyTKzR1q7Rugy36PaulY/rgzq/VuuJT7BbEMMXXmTyXh
	vbmCBc1m/nzUrSJ5lHnQ86+j8cVyRt77RjLKTBvlZ3R+3P0LMuLp90juepBWug==
X-Google-Smtp-Source: AGHT+IHv9C2jX/9/LO7J+EAweNR0wJaRJh/hpB23twcLNfojV9w8IEn9Gf8JDOL0bDIVCXkQV6JdPQ==
X-Received: by 2002:a17:902:d485:b0:20b:b238:9d15 with SMTP id d9443c01a7336-20bff1a8709mr49363695ad.41.1728087249288;
        Fri, 04 Oct 2024 17:14:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8252:ce4b:5690:56b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c30sm3950575ad.142.2024.10.04.17.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 17:14:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	Kyle Fortin <kyle.fortin@oracle.com>,
	Douglas Anderson <dianders@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: add partition uuid into uevent as "PARTUUID"
Date: Fri,  4 Oct 2024 17:13:43 -0700
Message-ID: <20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8ae8514dc004@changeid>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Both most common formats have uuid in addition to partition name:
GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx

Tools from util-linux use the same notation for them.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Kyle Fortin <kyle.fortin@oracle.com>
[dianders: rebased to modern kernels]
Signed-off-by: Douglas Anderson <dianders@google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I found myself needing the PARTUUID from userspace recently and it
seems like pretty much all of the solutions involve a lot of code or
including some userspace libraries to solve this for you. This is less
than ideal when you're running from an initrd and want to keep things
simple.

Given that the kernel has PARTUUID handling already and needs to keep
track of it for using it in "root=" matching, it seems silly not to
expose it, so I wrote a patch for it.

After I wrote the 2 line patch to expose the UUID, I thought to search
the internet and found an old patch where someone had written what
amounts to the same two lines [1], so I'm grabbing the old patch and
resending as a v2. I'm keeping the Reviewed-by even though I rebased
the patch (adjusted for file moves / name changes) since it's a tiny
patch and the concept is identical to the old patch.

Crossing my fingers that this looks OK to land.

[1] https://lore.kernel.org/r/150729013610.744480.1644359289262914898.stgit@buzz

Changes in v2:
- Rebased

 block/partitions/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5bd7a603092e..aa54c1f4eaa5 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -253,6 +253,8 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	add_uevent_var(env, "PARTN=%u", bdev_partno(part));
 	if (part->bd_meta_info && part->bd_meta_info->volname[0])
 		add_uevent_var(env, "PARTNAME=%s", part->bd_meta_info->volname);
+	if (part->bd_meta_info && part->bd_meta_info->uuid[0])
+		add_uevent_var(env, "PARTUUID=%s", part->bd_meta_info->uuid);
 	return 0;
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog

