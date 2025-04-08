Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77D22C35B
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129566; cv=none; b=cooTVMEIWRlPaHi60F/Y8qE0ti7v2IfliUp96XOC/Q1sGz8dr0fMS3GA0SsgLS2vl3o3ol1+n5pGPhGK0R51LGhtZyzR2y5BvZAZFB8xQzZefuUvpRguodr8dRGmJHcczs8rMoM7Hh7rkugYhZIi/k8JuOdgXavIy9gNXcYGtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129566; c=relaxed/simple;
	bh=toGjZDZt8cAv9qt9C+SZiDq+5TPiiUKa5RyaaG12imc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bp9aSAr9NwxQApYoSQwQnUnP7UhoGKWObvfoag/pEf1Kk1VibXAMgRietuEyzbbt9fHkazAvAWIMKifzpKf78bxxjZoii8aqLzKJzICp7HylpYU5YTtgX14HKOdtB+o6tanc1QGic8/IIMf2h74zqYLoGTLSEcv9ZrFnH565yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4RKI5ZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4RKI5ZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33830C4CEED;
	Tue,  8 Apr 2025 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129565;
	bh=toGjZDZt8cAv9qt9C+SZiDq+5TPiiUKa5RyaaG12imc=;
	h=From:Subject:Date:To:Cc:From;
	b=Y4RKI5ZWV76XBNB/0IZWWkkA3LUzgs9y5i5df5XbH5Fhk+AnJJHTd2sMVOhzjD3BE
	 wx4K2YGigBvYA4NVuRkaL9G0LNbNbGuWlQUpCUW67Nc/TX96cBh7hZk3bEPSSo6U7Q
	 RqR2AFKY+4/QsVejC8raDnSJ79e08Y8ttIdT6U3IZ6pcCOfaUgg76hlrRtoUEbKqTM
	 y94MOXlzop5VQrw+RqGnrpmt84ulb7KzZBBXsduk0l+V0q9D4goFumz8ytCStvHnRG
	 E05KnVFbumz1ettrXmPUZwMSQxdGfguyBjBOfIpFzZaePDRteoqa/HR/RJHrZL77KN
	 InHvvKahkAz/g==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH blktests v2 0/4] blktests: add target test cases
Date: Tue, 08 Apr 2025 18:25:56 +0200
Message-Id: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRO9WcC/23MQQ7CIBCF4as0sxYz0NaIK+9humjLlBINNAMhm
 oa7i127/F/yvh0isaMIt2YHpuyiC76GOjUwr6O3JJypDQpVj628ikQxiTSypSTQXNpea6O7CaE
 +NqbFvQ/tMdReXUyBPwee5W/972QpUKAklLJT86Km+5PY0+sc2MJQSvkCc11sPKcAAAA=
X-Change-ID: 20250318-test-target-0d63599d94b0
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

For testing the nvmet-fcloop series I used these two test cases to
exercise the target setup/teardown code paths.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- fixes shellcheck warnings
- removed dead code
- reworded comments
- updated requires section
- moved nvmf_wait_for_state to common code
- collected tags
- Link to v1: https://lore.kernel.org/r/20250318-test-target-v1-0-01e01142cf2b@kernel.org

---
Daniel Wagner (4):
      common/nvme: add debug nvmet path variable
      common/nvme: move nvmf_wait_for_state to common code
      nvme/060: add test nvme fabrics target resetting during I/O
      nvme/061: add test teardown and setup fabrics target during I/O

 common/nvme        | 29 ++++++++++++++++++++++++
 tests/nvme/048     | 31 ++-----------------------
 tests/nvme/060     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  2 ++
 tests/nvme/061     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out | 21 +++++++++++++++++
 6 files changed, 182 insertions(+), 29 deletions(-)
---
base-commit: 236edfd5d892f0abb0747f2668d1b9734349e2f6
change-id: 20250318-test-target-0d63599d94b0

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

