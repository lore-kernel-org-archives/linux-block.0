Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7269DDC3;
	Mon, 19 Aug 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027020; cv=none; b=k4U167QT8aJb89A7xLWsiRMC0LrGKEhIoDYXrH2Dola9/Qdw10MtkSA8TzaHrjKJ9U++OZHkhgTRypd3OIJcFh1FfmpeYglGBBWaUgRLdXdo2vtKj4pDmk93N9vZfcVIdBWykjQJEEE+Z9isVIPCeiZvvuK7md4Oti9CrnJdiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027020; c=relaxed/simple;
	bh=wpcg7t4o28QH7aKzgvSi6UVSatjR3H4pOrFapXLicBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMmjWMJsVr7uj88ppe2ParYQOQItjG6qvQWvFbCyYoxwKJ3m6gX6HTVNEK5tLAsbbWHdI55N5LzLy79RTmS4Jvspxi/RcoDkeeu0G/unmU1qbmIMHAzxgMKLkEY7L8lyyVO29qnUBIwuc5nWVYXCFjYBe2eIMPtNbImmRVpD89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvlJ/QmF; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvlJ/QmF"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f89c9a1610so1370587e0c.3;
        Sun, 18 Aug 2024 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724027017; x=1724631817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvwKZ3KV/qPNBeAd7UjnI/bjjNzMY8XNArJ60I5PRTU=;
        b=GvlJ/QmF+2I2U1kmS3aee3vRofsBHCXZmhdjkZYvWag5XiUK/ZPe6hnOtGYB51KB9W
         6lb1olQEYpTzjPSBt3lI5x+rosOROe4KpAyhSfL92yD59osNjibXDc+F7NIDfYBHM1dc
         Wn+7oA2XwscCrDQkljXTgcRNnVj1eTYlsB42fh18I5PqojLmqaHbd9GCM9XjkyRmajyg
         wR+BEuoC/ZGEGMEam9nrO1jw8xqyd+XRfxA+fZ+MADSAHlEVvHMXAnMfuwRcYOHSQoKQ
         EdiKjgPI0b0EvSSAfEGBWtVXBjPVdVtiHj93EtQjBrs6DL/NstnPEFlHUWOYnWYcO/5Q
         lEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724027017; x=1724631817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvwKZ3KV/qPNBeAd7UjnI/bjjNzMY8XNArJ60I5PRTU=;
        b=Xtvyd8ann5K3LQu4TYuY3U5UCHqJI6L5/Hzn7bXKGXvThJsRvWH2qXifxiFOBswfhQ
         l2Y21TbM7u1XnwDhLIjU9+fAFk7bCgDAl0ETlUD2A1CaqcZfbI9HLiBicxJvU6WFlkmx
         BtZZrRiig6TKhEGHCUHgJlv+C3+G9lSPHtSuaqndyXQhatQhRzAmzT/G6NTpTwTRZNVx
         Oo2ugQxc2FxkHdw+14zfq9W2s8HzVqcxJ0MM7lPA7hvaRFHHko4J3zJ+PsFtEF2YWh07
         J+XJK195qtc/U012B1HcgFQajW6vWgz3uPuHHf50D6tLIIfy+lvkoSw409PWNiiUPzOM
         SSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUOBtBlIOTWOcaG0t0IuYDxb9PXZKd/xi8wJMcrsaMQpotu1zmJpP7Inbe5IIFVhXdN7rjF+9ITScKtP86BrZ7wf/4jrVj/Qx/kYWjJUZjzcRdLUaIMyLVGZCrIB4jlNVYTUWnijWfrcms=
X-Gm-Message-State: AOJu0Yz0oeuVXHSQZfPsdWCgj1P+LZhpLEL3QbwMYCI7cltu35AWXhaP
	bon/JIOybz7cdiShA/v4saud/Tcfn0Tn+LP7hmfDmbKeyZVXQpC02tZgiKMc
X-Google-Smtp-Source: AGHT+IHstvKWqGDxjqet5zKkfc36FjxGoNYhBSQkTV7AZumFbTaixY/x8lKn1K+/Ieapm+CDEPHvBg==
X-Received: by 2002:a05:6122:3b10:b0:4f5:26df:690c with SMTP id 71dfb90a1353d-4fc6cc4310bmr10172187e0c.12.1724027017288;
        Sun, 18 Aug 2024 17:23:37 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b903c60sm942545e0c.32.2024.08.18.17.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 17:23:36 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	javier.carrasco.cruz@gmail.com,
	shuah@kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.15.y V2] block: use "unsigned long" for blk_validate_block_size().
Date: Sun, 18 Aug 2024 20:23:24 -0400
Message-ID: <20240819002324.2284362-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

[ Upstream commit 37ae5a0f5287a52cf51242e76ccf198d02ffe495]

Since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) and ioctl(NBD_SET_BLKSIZE) pass
user-controlled "unsigned long arg" to blk_validate_block_size(),
"unsigned long" should be used for validation.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 37ae5a0f5287a52cf51242e76ccf198d02ffe495)
Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
V1 --> V2
	- put upstream commit after subject 
	- put the original Author
	- Added a few people I needed to CC
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 905844172cfd..c6d57814988d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -235,7 +235,7 @@ struct request {
 	void *end_io_data;
 };
 
-static inline int blk_validate_block_size(unsigned int bsize)
+static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.43.0

