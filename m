Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BA35950
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866088; cv=none; b=HVnNqwc2Q8O75Wtxb9/W+MB4rE4kCorE+di1nbFr+MaUo3L/aID7ehadU9F7HKoMrHrL0rkNdFkmxG5cBpWQAHOk3gUtZ/IegCXAery0ZCbi6YMwVZDFbQRh2cfQ8j2zbpVzWXkXm2v+JrIM2v/vvMA1ZcJQSA2x5uf08+vTLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866088; c=relaxed/simple;
	bh=A0PwD53RfrIKbpeTZtW9rrUr5NdT5j32+6ya5TuAfkQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QrZigy1Sm+GlrjFaIP/E/G8C001rKf5WX2wjoQ2qpqY4V+XbwdlVq8qDUwP6LcNYcJMGbtDgBf4uM8qAtWYyxWSBpkwTTuuyb+prRt/0E/8sNubEnuYPt18J3LO7GJMSyGWFmbXIbOmxFMhOQUytA0k93r/G4hVRespH70bVEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kkt5aZpG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kkt5aZpG"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso1728827f8f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 22:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758866082; x=1759470882; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJoz4cg4CKMKbQ/6eO0rpSJDp1OA2BFBQ8ruW4MmuMs=;
        b=kkt5aZpGI7rUkMr8UfTwJqkeinE+u/2oyKSV17Idz2kMIjYg6uK7q5eBI9VHhISclH
         Da/Oks8KOG5N8i3/Ck+u33hbWc/dZkUeoBxdoRiVow0+NqqkjIdpXCTUd3VdnaCYIcHg
         aet4SkUHJR9huewEuAXweEkaFATC/Y+4peABTgsbnYbqU+vDkGyQ/ub3MJ72AeS8/Hhx
         UCwA2RYpTFh4nu0fU+tJ2UMI2e1ZkhnhbZv4P+K5SM9Zx44fXd6BPUKTxsMENLjVB1LQ
         sGENuzpQuOlopx6agng3DKO/42fo7tLAMBK9omODeZyc1+vXf3jipvVo1Z9uUJszkgFQ
         9f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758866082; x=1759470882;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJoz4cg4CKMKbQ/6eO0rpSJDp1OA2BFBQ8ruW4MmuMs=;
        b=tB2VW0BLsl9eX7q6oteAJQD9JsoFit4ygjkbwiS+Lt6Ap1KvBaH2bhhSmJ6qqja0NB
         7tVOFD92IaoaDgZ6yDuh4uSmV9Q9n8Chlm4r3iWAC84MfQ+rFFUDHLpaAsIemDdFocVB
         q5l4ZKKHgPLY5ILVd0MkgNQxXSIvRRDy2BlOht5rOSXiPzwfOyYL1p884N/kVcjx57d7
         /G30d2EE28V8zfaIZeqbo4a+W8eyIkGhP8r2NOJcV/7QKEi1F5V60cKIzwzx1P2RCREi
         636TfPDgfFxxsWQ2hqxwY1B3dqitQ4LydhNYVCqzwfsCwy5ULwjB8eF6euMDvDw/yMxn
         5Y4A==
X-Gm-Message-State: AOJu0YzaPatPPimbeC+9BSWbVdtjjphHeqsIy/ucZ+HAsM/bRikqqLKP
	0gYBLIvBqP3LyTAcRcrumAV67wBOYthurpKR2qxxTQE2yQq4Gvv6jNCx8kTv2gwX0/Lxpaf1Dhn
	AjoLZl134YA==
X-Gm-Gg: ASbGncs6wLqmeMZtmihFS1Vew7UBP8O9k8eZFdhf9O7UVt+WrAlPvwJiyHOoot8vOfb
	lYFCgbqgNbLQlEGxwPOeMbcFFKjEEU8ZJ0AvH6gB5+bIBmUx0pYwxUYCSGnux5vdZ2SOMz+S+dQ
	VGSDgSQRHKFwKIg+zbKVhUXtEOcaxMy9er+uYncT0q87Lsi3zT8zrt1PFlyutVU7Fpw5uZA7CLr
	S91QsJouq4UJXxWkefYfhQlvBremY+CI6ePBpESTS3P5ERe9e7O7iZUrT8NMIZNgfRPvU2RnNDN
	JSnw0LsVp0gNKxrm5xs18V1aWGLaMp19xJHJicOOBcUTT0FHQ/kYvjqyk7DtF50baeV308ONQV0
	R8HK4/Iir1X0rfQz90lFcirM=
X-Google-Smtp-Source: AGHT+IGsOoO9XwRJnb7TOQT5f7AoP3eowHrm/P02Pc2o4FKGZs0lX1tgrDxhv06bry0MTPsnvn3YoA==
X-Received: by 2002:a5d:5f52:0:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-40e429c98f2mr5848361f8f.5.1758866081549;
        Thu, 25 Sep 2025 22:54:41 -0700 (PDT)
Received: from [10.10.156.189] ([213.174.118.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603161sm5576013f8f.35.2025.09.25.22.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 22:54:41 -0700 (PDT)
Message-ID: <c993fdf7-df9a-4689-a547-313b4cfde4b8@kernel.dk>
Date: Thu, 25 Sep 2025 23:54:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.17 final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A regression fix for this series where an attempt to silence an EOD
error got messed up a bit, and then a change of git trees for the block
and io_uring trees. Switching those to kernel.org now, as I've just
about had it trying to battle AI bots that bring the box to its knees,
continually. At least I don't have to maintain the kernel.org side!

Please pull!


The following changes since commit 027a7a9c07d0d759ab496a7509990aa33a4b689c:

  drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter (2025-09-17 08:20:49 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.17-20250925

for you to fetch changes up to 285213a65e91d0295751d740e2320d8fcd75d56e:

  MAINTAINERS: update io_uring and block tree git trees (2025-09-23 05:19:16 -0600)

----------------------------------------------------------------
block-6.17-20250925

----------------------------------------------------------------
Jens Axboe (2):
      block: fix EOD return for device with nr_sectors == 0
      MAINTAINERS: update io_uring and block tree git trees

 MAINTAINERS      | 6 +++---
 block/blk-core.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
Jens Axboe

