Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8D27584A
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639554; cv=none; b=gpLK+dV/8yT1xF7SntqCkF6M1AjKi5qBu2+elh38B5Pgy6jhS0eksa0bBOAAA/RP9nSVVN09jy9hcPgu8zZJG1t2/MMcA8PirGI0zEu61MGK1PdGrQEFe3XuUenejAmehjhhR7bEjC3Y0qrYAU0Vbhq2SX0W4zsdwYgS+/ciChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639554; c=relaxed/simple;
	bh=5YoW4N3GuesqbEjvxAuHHN/zt2GQ9v5eBYT/u9piu4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u63qy1ZxOytPVqSczR5r667ySjyEy3HG7HMb4MkKjSWa+xOep20Rs1dCas1dQrxwvFyhNJe+rhErZz5d7iw+iDaKeCNgy3JA/550r9IApM3peYwbrxPshNo9n5q0tHFboQJaBWVDsMlQylsXPmCqGQSbjCTQPUpI+RgvxqJTsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvSyYcET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvSyYcET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C4C4CEE2;
	Mon, 14 Apr 2025 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639553;
	bh=5YoW4N3GuesqbEjvxAuHHN/zt2GQ9v5eBYT/u9piu4I=;
	h=From:Subject:Date:To:Cc:From;
	b=uvSyYcET5UYh2LbLl8MFAF/ikJkr3CU7++G8EMt/V56APPzRZInE8I0ZPB6L4OzS1
	 ugoMB5WNdQFlHl0NBIzICrm6Hku4N8Zx9We2Nw6XgRso+I1Lj9GET3omWj/S/o3xct
	 p1dRME0Z7LhPRYmi55HhZokZFgMCftTwG/KrKULt5k0hu6wfOe9mJLVrXW/yHIii07
	 OrVP/F5UZ+EYvskz1vSLXz2AnW6JIQZu5G+g0mwg435fVRdsDtOZXDj79FETR35snD
	 LEJMLUXGl41GbG8E2NtWdkL/TaVsMWLNC+/8XNHAJZwTTs6sJ2yl3nLIhyzJmUsqCB
	 B59wRedp+5c8Q==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH blktests v3 0/4] blktests: add target test cases
Date: Mon, 14 Apr 2025 16:05:49 +0200
Message-Id: <20250414-test-target-v3-0-024575fcec06@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0W/WcC/23Myw6CMBCF4Vchs7ZmOlBCXfkexgWXARoNmGnTa
 AjvbmFjNC7PSb5/Ac/i2MMpW0A4Ou/mKY38kEE71tPAynVpAyEZzHWlAvugQi0DB4VdmRtrO1s
 0CEk8hHv33GuXa9qj82GW1x6Penv/d6JWqFAzal1Q21NzvrFMfD/OMsAWivTBBf5gSpgtk9Fkq
 rKvvvC6rm/NDg0s5AAAAA==
X-Change-ID: 20250318-test-target-0d63599d94b0
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

As discussed in v2, the tests are only valid for tcp, rdma and fc
transport. Thus I updated the requires section accordingly. Also
addressed the typo and missing quotes.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v3:
- Fixed typo in requires section
- limit tests to tcp, rdma and fc transport
- added missing quotes
- Link to v2: https://patch.msgid.link/20250408-test-target-v2-0-e9e2512586f8@kernel.org

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

