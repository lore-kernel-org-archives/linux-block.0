Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4E238C26;
	Fri, 13 Jun 2025 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782350; cv=none; b=a0uO754L65C/oJkt/UTJTXxj2wYdqZzJPBsPoLHOB9LhgcA0kP1uCmGMh5PY8KR1f7+GKeiLOISLv7U5Ccan/lgyv0w02CCANqed65ut7U4+Db0N12iQyKy4VU06AbNnEaq0kJ7jaBdtzRdyuGoeVslULiqyH9ehKbfbGNzjVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782350; c=relaxed/simple;
	bh=33fE4qM3TNcAYqTzrr/Jfqt+YCnE9SPassKdwYIkyCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZ0NgaECX8V6X5aY/VSaJBcu7jeLw5I8GN7VxQCnTEbW0NQDVCEIb45jdS4+cygmtZ3KzR5daCLjaMHAX5Cqiz9UsOy8XSeZvyvbZzJflE94m+TqoWFozyCVlvTebm5GPZI8/I+dBM5vVXqnpo+yBgs/Fj4xIML9sozBcD02JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgdN+X2k; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgdN+X2k"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1570929b3a.3;
        Thu, 12 Jun 2025 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749782348; x=1750387148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+trFmWQdd5NKDjPst/9tr7cgjEOjUmMLk9lwPDh7fA=;
        b=OgdN+X2k3I8E1TXYNFaEFmt0Z+c9gTxJ5dCw+Tc63C8bx2Ocmot0+K2jK245vXWRy/
         UVIqWfLA7POf4uHOXglBzO3GyzXZiPpggrR7LxOJJ2ysUF7EY78Im4f9UzxHUBXBCycC
         nkAvXYUwlRy3cXDZ0BPltsLJXbdZ1b7VL//j1vCuFvV/aGss9e5vQBRic4r+3CkQijGH
         JXFOhV4TPKTDahkiit59UD6mxoqiXis0D5SxHAm+vAkmIf0jXnjrH8l/jF7yLehGh8XC
         eHFPH3tzfrNs7b2RRSIaoABaz2G0Jqqel/N4lFMgQ+Q1jURt31tWqveOWs9hUigXprKR
         /TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749782349; x=1750387149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+trFmWQdd5NKDjPst/9tr7cgjEOjUmMLk9lwPDh7fA=;
        b=anH8HbrkTM7rHigTDV0ezUMzcpQUgmjKiIrYU766XkWIaTgm9Il9HhQ/pn2vmiww9H
         otWfxzX+sEuTygtuuNyy8eYF8WoxGIlBhpr/YnuUlTwwILu5cNnoRJrX31lLq+HjGC4W
         suXkzIpoi1gmXD6c0L/3WyK7vjLiFXVkCNhYWI9J3MgA94ATbVll0Nybi4tpMr31PiKH
         yw8ClyRIi8zxKyBlmVpfK4Q3mrzb0ZvVlrZl+ndQaduWGxpu0+lUTsEB3qgeAAAEmSmH
         1anAHPMUFWE3KNBHeuEFz/lev8Fo/0woZvNVzb0ML4oJ6wQoZN4lqnIMAXgOaMIWLYYY
         cPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhdKuOK87YiYAaidGohqkxaKQz9+7lsqo4DO9G/CRW065jAPc1UoXv0qKz5SCSc7u0iamB/rU6wH2I@vger.kernel.org, AJvYcCXtT20wm2dz1BBUl0YJl4lLPdnEi67NQQqzf6IqIQ44aHiO9QZ4WGbeRXNPxJJnBH100xwZVtd1qMIxhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1kMaBY+dW7ymzaM2aTjEPKiBU4VTmSEC7pjxH+tLTYq6W3GP
	q3hydt0Ev81QGfqCHYr4gNCkxGsUHUAHttqM0ItURxeJ848KjytHrTy3
X-Gm-Gg: ASbGncu61vVBY5g0Nbppio+xY6B/ddmcSGAK5jdC0ORi3eBJzxcL9d7NVImwj0iw5nV
	DhRWoEuqXIj+g5sU0aRCl3onKFobwIguQ6J6amVk823OkUJcGPoRzXsPtv4GWH2Ed/ZSH73/6SN
	BAKyjTy+NVoGI//0DiHT3Mp8kp8dyYTtiUVpcGTR0NE2J/a3ExeXuq8sDcTblcYIv/NP49ncxPY
	fq5H2w1ZTXpUs6z4pcJKr3YjpdjbzBzZy7V8RuRtef2KSKfst75DRHSrTTIjjxK0d7dyCwTXN30
	Z3Rc8E/sRApq9QPdliXi9vcIUBhvZlf77F1cgodlwJ0ydbrqEXPR/YIHy7FCoQ==
X-Google-Smtp-Source: AGHT+IEbubMI4RmYSUIGqk47Q5mLBabSCGqHgDmP/0ShfWK12ZGZtXtevJ+X3QRTX3ppWikFOiOliw==
X-Received: by 2002:aa7:930c:0:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-7488f716f1amr2192369b3a.19.1749782348532;
        Thu, 12 Jun 2025 19:39:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d0becsm479785b3a.154.2025.06.12.19.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:39:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D675A4209E8D; Fri, 13 Jun 2025 09:39:05 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: ublk: Separate UBLK_F_AUTO_BUF_REG fallback behavior sublists
Date: Fri, 13 Jun 2025 09:38:57 +0700
Message-ID: <20250613023857.15971-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=bagasdotme@gmail.com; h=from:subject; bh=33fE4qM3TNcAYqTzrr/Jfqt+YCnE9SPassKdwYIkyCg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnefadmbHx3keWlxVVerpD9ap++2k+bGr20bq6ncEz4u qniKX4nOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARZReGvxIWqYsSJuffLl3G LdvBp7r+8WK+lvOG/7hZ0xVePyrfeZ/hn7WWxJLHD5MbVp/2uX31xKFL7JJ6f1uZvvktqdNVKgx cyQgA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warning on ublk docs:

Documentation/block/ublk.rst:414: ERROR: Unexpected indentation. [docutils]

Fix the warning by separating sublists of auto buffer registration
fallback behavior from their appropriate parent list item.

Fixes: ff20c516485e ("ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250612132638.193de386@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/block/ublk.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index abec524a04edfd..8c4030bcabb634 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -408,6 +408,7 @@ Fallback Behavior
 If auto buffer registration fails:
 
 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
+
    - The uring_cmd is completed
    - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
    - The ublk server must manually deal with the failure, such as, register
@@ -415,6 +416,7 @@ If auto buffer registration fails:
      for handling ublk IO
 
 2. If fallback is not enabled:
+
    - The ublk I/O request fails silently
    - The uring_cmd won't be completed
 

base-commit: c73e4b8bde5f2defecef6a3df792971f83841bd8
-- 
An old man doll... just what I always wanted! - Clara

