Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329D20897E
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294356; cv=none; b=QhgcPy6L7jXkEDyKpVtwQRf3A47/IgaioqwRJzP6FfweuhcV7IP8UuvdAoWpuhnBDo3VsrVhsldwVxA1Vb6wlIxNpcyV2Q+YA0NSok4fXzFh7q0reCAf49F+VCfRu0BW2M36xWc2D4VU6BIEvQhGXtsQpIPIQX0QM8ooVeLwEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294356; c=relaxed/simple;
	bh=yJ9AodSuoT8ScnArcrtwSDAji+aAvxyic6VrdoyGPkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrbIFYkh94Rc93QfLxDvFvDrrl44OERcpSrqa8Sb08PpPbPM5OlKstI67Ya8ItuxmfeaIfvzGgn6UCHd3YwjLyAyom04lLmBxQVBCs6j4xxpgG0z+a+tDlN+v+TeyQDgd5VkwdjDj/Ikv5hCwE/JLILvoGNRBFwSPVWsV89deG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/X92fVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/X92fVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA04AC4CEDD;
	Tue, 18 Mar 2025 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294356;
	bh=yJ9AodSuoT8ScnArcrtwSDAji+aAvxyic6VrdoyGPkA=;
	h=From:Subject:Date:To:Cc:From;
	b=R/X92fVd5i2I1KRL1+XqtFQzP2rgRToNd/WbHSZumP+ULb89K7YTrn/vcHINuMVsH
	 Al6eohOV802ONH1zFyzBIl2BK/5lsLvBzuCqxKXlzFPVzsHoNOwL2y7IsYPU0Aq2aG
	 tsfj31Oi3J0cDBchImn15bzudzLvdWhuN8w0nM1ht5GRHMFnGlIDq8Uv4N162f8kig
	 VurclOFYH8EjLoxgNvPuqn/MSQav5Nu/flXzS3CJo2R2K7TvRtQQlozgyOZ9riCRpC
	 JQADkpmO9xBQgPRWGUi25EyU5R1oFX3pvak7JTf+QRxiNa4zrYNpFgMt6x6LK5gLih
	 9Kjenj1mNbNvg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH blktests 0/3] blktests: add target test cases
Date: Tue, 18 Mar 2025 11:38:58 +0100
Message-Id: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJN2WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ML3ZLU4hLdksSi9NQSXYMUM2NTS8sUS5MkAyWgjoKi1LTMCrBp0bG
 1tQBhkPVmXQAAAA==
X-Change-ID: 20250318-test-target-0d63599d94b0
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

For testing the nvmet-fcloop series I used these two test cases to
exercise the target setup/teardown code paths.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (3):
      common/nvme: add debug nvmet path variable
      nvme/060: add test nvme fabrics target resetting during I/O
      nvme/061: add test teardown and setup fabrics target during I/O

 common/nvme        |  1 +
 tests/nvme/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  2 ++
 tests/nvme/061     | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out | 21 ++++++++++++
 5 files changed, 211 insertions(+)
---
base-commit: 236edfd5d892f0abb0747f2668d1b9734349e2f6
change-id: 20250318-test-target-0d63599d94b0

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

