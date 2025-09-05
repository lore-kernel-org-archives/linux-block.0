Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BC3594B
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071230; cv=none; b=VThqW7R9s6M+XQlDp2QTZSQC33v5GbG+RabU/liJvSkZXeyjr27KGKkDMEoc5lhIxLnTSq4ZZLZJPRSNZQWiz1oS7dk/lWAKXi8g2XZnSRdvc5LSKEkbMKChutG8wEn9UwSIqmN8wWAqr2xdMWE2eyPU8zbTEX0yCML6tM7cOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071230; c=relaxed/simple;
	bh=WTUEAuaEC938WdQc/fThO0qI0BJvhIM5ibgPcne/EWQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cHZ3Oo6aNgCzoN4sPl5nTjzSap48b/jNfJjeJcWVYRlGs/6ZJAR1fUqbblvY2zMuj8o+bHpRJBQSxDGZHLsUVLNS0nmLbyGS83tHGiNw43B2NtL072sIBneMGl6DNwntfC76KjY5WFBTZDW9SWSbMlhEj9LVQMC91EuYHTnOH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T8J6AHSG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T8J6AHSG"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e9d923fd113so1051622276.2
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757071227; x=1757676027; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0obPffwyoUjRLmBWZSNECzWosU5uvWiFYS7ygRpodg=;
        b=T8J6AHSGSZTQUJLzY/fG+3wq8MskvfDcgpamT/sAWea6rcfUZCZiQml3hcT7rr+wNA
         Uj8cVvyooYqsRMTK1TRM1VFDynmLxXyjVatIulWg7JHF3liMux533uilIsf9shKJ1uic
         SV6cW12COAl32KtCdHPowOV0GSCl1G1d0IyMB6q/9VTPLyaS29qs+hh5WAEKabmz2dPA
         K4pf+eLfjnGiyEuZxkBD/ce8SS5tvdoKFkA3HSm8g+acOgHbqwuHY3EuoboC5PIfmYT8
         7q4ErIKNquMP2LXv6jo4Sw+X2Bd2jT5JBPYjNh6+kkTHEQsiGfrkfqPkQGbqX99/8O3w
         mEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757071227; x=1757676027;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0obPffwyoUjRLmBWZSNECzWosU5uvWiFYS7ygRpodg=;
        b=Aa9rqMtgUtQsVVxOc0GbR4b50jNIcFK4tAWEG4oAycfFS4lNchKAWwqjsKkdqBsDrP
         Jqqa1PqwjQLv9TCD82NAE9mIuruAma2n7cbhJpLnHcHAfFBrvT7P+aH8Wm8Y/BOFSm23
         eoweTgzm30dB7lcpaEEzIoVTB5IboMLchDq0F57EmjTHsP8n/ewwSJjsUWu5Tf4bIVD0
         Eo2pdkmw7Gap59rbl6s08+4GcZICAEsZJm78dinOzhoFF43uU+Y7ixhpuc5f+ZDHaAFP
         +F1F7TAAy2zG9DgEirFMJdan7c+t2Hy9n8Wkc+M48pvbxMXEH9JI1dVUi4pVSweY/aH+
         hu7w==
X-Gm-Message-State: AOJu0Ywzi3lwYS7oOOnTOsDXrtBD1Vjy6Jl90S6IT1YN2ulYs1fVX1SW
	U0G2UcTi0hZOAhT4p7AmmQu4pQ6DrzyO08tt9m+HudmNgkd6QagNzwpItXp6a79eMjF19iLKGIe
	3K79C
X-Gm-Gg: ASbGncvJ4KrZj/Jvk7svcoAT0oIUfiYqkymRmHaeOKZNGvenHNxMyLesHLDRxPoD7jH
	jxAWfGe+fEcj/+AXXwOTMIKIi1MBAwVfOe3LNIuC7nGldHo/DILG76PZrBPoysQWEZY/3rqVPep
	ciaIWHtfxg7zIF4YWggNHdLHbUGGa9Da33iQQl+BCafo+/l+LV6Pq1v8JrpK3l/0yXMLkSF/HvR
	Bpq+1QxaXZ+NOLygTiJDXD1aVsRVqn2ed27W+q3WYw5D1AxarPuJwRa3lmeIpVSLqscriUvu8Wp
	Mk6fbC8DDDdkjo4hjtAHLBvnqIu/Tu1GGhGiP5xeTayb9HyuZsRxOufsC7CaM+7hAO9wZ0wKaKF
	5+F6ClBM0VBEjlpCuSQ==
X-Google-Smtp-Source: AGHT+IHcYnWtaLyP+1p3Rscdcg9fE5Xi8UKUqmmp5rvzlIxeUYNW56JKrJdHuxdXOF4kzKZMgCiOMQ==
X-Received: by 2002:a05:690c:3511:b0:724:bd2d:ac97 with SMTP id 00721157ae682-724bd2dbf18mr53908497b3.32.1757071227581;
        Fri, 05 Sep 2025 04:20:27 -0700 (PDT)
Received: from [10.0.3.24] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a855a89csm28124487b3.55.2025.09.05.04.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:20:26 -0700 (PDT)
Message-ID: <fc773af0-d2c2-4394-b286-9e7be415fd74@kernel.dk>
Date: Fri, 5 Sep 2025 05:20:26 -0600
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
Subject: [GIT PULL] Block fixes for 6.17-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Small set of fixes for block that should go into the -rc5 kernel
release. This pull request contains:

- NVMe pull request via Keith
	- Fix protection information ref tag for device side gen/strip
	  (Christoph)

- MD pull request via Yu
	- fix data loss for writemostly in raid1 (Yu Kuai)
	- fix potentional data loss by skipping recovery (Li Nan)

Please pull!


The following changes since commit 95a7c5000956f939b86d8b00b8e6b8345f4a9b65:

  bcache: change maintainer's email address (2025-08-28 10:05:37 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250905

for you to fetch changes up to 743bf030947169c413a711f60cebe73f837e649f:

  Merge tag 'md-6.17-20250905' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.17 (2025-09-05 05:08:27 -0600)

----------------------------------------------------------------
block-6.17-20250905

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix PI insert on write

Jens Axboe (2):
      Merge tag 'nvme-6.17-2025-09-04' of git://git.infradead.org/nvme into block-6.17
      Merge tag 'md-6.17-20250905' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.17

Li Nan (1):
      md: prevent incorrect update of resync/recovery offset

Yu Kuai (1):
      md/raid1: fix data lost for writemostly rdev

 drivers/md/md.c          |  5 +++++
 drivers/md/raid1.c       |  2 +-
 drivers/nvme/host/core.c | 18 +++++++++++-------
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
Jens Axboe

