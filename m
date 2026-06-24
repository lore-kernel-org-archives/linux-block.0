Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F63C1084;
	Wed, 24 Jun 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312657; cv=none; b=msVaGVP3EVmQk694Hs8iihxVaxPLoxWy7wRpFsI9uzt1tMH9AF3LVxDmSR+7uTHXX/E0ZxnSzkB51ZHh0FH12lnRgCzLpBDaLtUDgoBoPrUaxHO4/GXbiaFSrfCe2hOtRdq33HovsR6aOGNxHOSFdPLsapDeKusOIzw7qiJRysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312657; c=relaxed/simple;
	bh=sxx4jcfqifuLsse/09Zxvfs7xYRJegnI9jN3UhlAT5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iuzWrMXEEpGPr8cOSrvbXhKyWYbJDhuk+lEK9UIRc6YuFrxSs3GrgJxkl/dWJH+IAP+KfebD23lr8OEvQgL3voMiKAhhEbY02GvKbsxFhndp93cP4ozGk+YwTBJCDb/TnwUXlUisMPEgm+qj073HG05UQwFwbB9KXswfc2vQKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRvzuIXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRvzuIXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292281F000E9;
	Wed, 24 Jun 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312655;
	bh=RhE7XAYwFGAxOusv3m7rjZ+ngd7AFo0axuxmFrVituk=;
	h=From:Date:Subject:To:Cc;
	b=oRvzuIXi8ZVCKl/P8o0YWgUcS3JGxQr4HFP6J0foPVth9XuRyD8ERQTvASityYIl6
	 d5L8viiMpFOoQO1BZU/9SRhOXF5Ee3s/NCUF6k7lFioIWrz99ox5nJwy6dHj+XR6k0
	 Y33xEeywGtDxd+Tc+k3EEWHbkddv0jPewIP3mojQR2FS2gfL9BL1ZrHtUXkGMkqFb5
	 Ne54vHqTwwKZhInPQu+CSCUemXuLTLQkgwrX/ru7hHmVPOr86DJ7hE66exmFTz/XYD
	 4SThKB9klqt2QV/dJRiKG1KbQEmh6bza0XBvp1S/eJl/Q1X4YlZrAQ2+7Jk4t2rNt+
	 q9JXpj5+Eg6iQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Jun 2026 10:50:34 -0400
Subject: [PATCH] blkcg: update iocost_coef_gen.py to use io_uring
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-iocost-v1-1-2d53f3c026a2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMT3cz85PziEt1EQ0szCyOD5GQDE0sloOKCotS0zAqwQdGxtbUAc1e
 XIVgAAAA=
X-Change-ID: 20260624-iocost-a196820cc049
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
 linux-block@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sxx4jcfqifuLsse/09Zxvfs7xYRJegnI9jN3UhlAT5Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqO+7IQBpnJNjXqOJgu2/E8aKIpK5vnSEBDEEe3
 jKh+pR99IqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajvuyAAKCRAADmhBGVaC
 FT2REACrUljSpTvaaImwhGWQAP56QO5dySpOYz+SisD9yDMmCLLIvbnBOnQEioce/5N81EtuLow
 swzlryslxEeJuW9+bSl7K2SACO95uG5lCro3HBrtvyAsEB6yRlLiklvPGfF6iTvMU/XynTy9bFm
 BwqSBaFkJTvP8BlKnfENlGrSVhZEn4gPJalux4JFWMqNsfLlIqTI0Om9gS8yOPHhaYoXxWtQehg
 BDpIfwHBM7ZO1jTUsT+H/FA1KoblOUVsnVhIvbE551OVKg5mWA/bnW1D3qDMubPZVSsiQbTmWm9
 xzLnMm0EhnOkAFXn3kEPqpETO0qWZXR2P9dMc0aRY1W3Ig7kn/KgTNcg47zVFYKSWPORF2A/5q5
 jjdo9c4M8EA+tV2WQOa9la0xHSoM1iEQ8JR/Yg1ai6S3t+ois3USLN9Op5wCHnuv8jwq+UGEs2P
 YSTy0+ZY3A0ejt3boHovZRQUGrmO9jtB6O3qa6G5aAUz8dpMvDFjgX4CgysoLBPp/1Ejs1Fj/yO
 TUtySV0CAmki8+bD0+PWe+bcaU0kFIW5+gJ1IoBGdBg4f+xxzBw4cZdWPQUru7V+ppz+CMlOACj
 eL6NwYw9YmBiQGFpLqlJpkK92Q5ZVcSsEu/hEND2qXrbYkPSk4Es28ucLFIeo8oQcK6Nf008vpa
 T/eaAEUfznmWxcg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Recently I found myself having to benchmark some rather fast disks for
iocost, but the old iocost_coef_gen.py script couldn't generate enough
throughput to saturate it. Make it use io_uring instead.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tools/cgroup/iocost_coef_gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/cgroup/iocost_coef_gen.py b/tools/cgroup/iocost_coef_gen.py
index df17a2ae80e5..41f93f4536cc 100644
--- a/tools/cgroup/iocost_coef_gen.py
+++ b/tools/cgroup/iocost_coef_gen.py
@@ -91,7 +91,7 @@ def run_fio(testfile, duration, iotype, iodepth, blocksize, jobs):
 
     eta = 'never' if args.quiet else 'always'
     outfile = tempfile.NamedTemporaryFile()
-    cmd = (f'fio --direct=1 --ioengine=libaio --name=coef '
+    cmd = (f'fio --direct=1 --ioengine=io_uring --name=coef '
            f'--filename={testfile} --runtime={round(duration)} '
            f'--readwrite={iotype} --iodepth={iodepth} --blocksize={blocksize} '
            f'--eta={eta} --output-format json --output={outfile.name} '

---
base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
change-id: 20260624-iocost-a196820cc049

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

