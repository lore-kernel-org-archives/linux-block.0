Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8198462;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022796; cv=none; b=WPy56bmiSV7/Og4KWOEqt3EXldzZFgdCfGzx3jXYj9xCLKs4Uuf1WA2K42nFYtwvDLZNjeYRWHKzdQkzqS8ID59rpeRCRIcC2Gyz6uT9pnOEtdf052OKo0CxmCZLdPUUT6V1aBRfteJIqcHVq5LTBrKjUAvfqyC/ubjttKX9LdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022796; c=relaxed/simple;
	bh=Qfw83Lsvw9YW81iRX0U1pEJiGDlKBK7ODRwFNFgYaqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/sTcyiIrU6RuPkAwA48I7z0HZ1QykoMExa9IUD7SnmwBF4vMFaOaf2W7q2NKmUhIUbU2KY0RsxiQ4UfgtUQkFmUHdxlWloMrgWfoDcYbkujHuLfeXg37sY6+mdnfRhXPo95tDfCnvtGpqZNfUsHWTzrhCv2JGRS3FIvTsnL0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCw3ncnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCw3ncnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD2C4CEEB;
	Tue, 28 Jan 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022795;
	bh=Qfw83Lsvw9YW81iRX0U1pEJiGDlKBK7ODRwFNFgYaqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCw3ncnMSwJFVXYin7ecw9sGmuVVEgSoun/Ci8tV7AZDndK0sk/ezkYQeuOL8Bybh
	 /benV6dn1rTZMgO5OcAncJ1Xr+5/ShybogpSaSirks9Ff7qNGQaUBefuNsqP4WRF06
	 pFGswKs51hT6T/iJvTsYUiv4AcUNg87OiQ+Hcor/64tVrg1SdWirZTWwtHqZdmdmQL
	 GX+v2TOwPZ+4hSVnqYZrjmtEMARaw46ajpon2hcouDom+G9ztQrE74oB9K0XEbdHGe
	 ksI2n7HFQKKWv5nySzAsHQUpcoCHDWjmpj4WgxYiZHSTYFXFwUxEiupH2PdFn/Gbi2
	 1FTpMUkv/teog==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7h-0000000DRKZ-2hj3;
	Tue, 28 Jan 2025 01:06:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 03/38] docs: block: ublk.rst: remove a reference from a dropped text
Date: Tue, 28 Jan 2025 01:05:52 +0100
Message-ID: <f892c3774c1f6f50a74b8e5f5d6c830a86c743ce.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Commit  4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
implemented support for unprivileged ublk devices. With that, the
text mentioning such issue was removed. However, the footnote
is still there.

Drop the footnote to remove a documentation build warning.

Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/block/ublk.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 51665a3e6a50..1e0e7358e14a 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -333,6 +333,4 @@ References
 
 .. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
 
-.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
-
 .. [#xiaoguang] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
-- 
2.48.1

