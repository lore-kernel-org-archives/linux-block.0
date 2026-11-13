Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570843;
	b=gzDI+9rawN4jzK3E2kmb56TLkjAG4AKhE6cmyqUrDC8/H8iM7sT9cN474nwS42iIIWmX
	 BgCDIm6X0SEdffjTvcWSvGYThe/xqhvolyJqUzSdOsliZBYqt857tSg8Y3bcjHEKjomT3
	 iQVKec/cAbzBU/lTAPYL5L7QLgSlxeZfYgeMebgWGToTsflgXV4pCW3mHZf2hmkOVADuA
	 u5If530wEkwWLCBc+SP3DNM+SQM1lc2BpX0IHbBJ3OgoMtFPn+kS77dU/AHckObXOJham
	 XZ+P915xh8+MVyI9Lg27uFx2XrhODUu7sNjN1uDDNrogJSXYCqw6q/htG7jKlx5QntQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570843;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=O3L1hntt+mGRgmPOsIU6DlCvda++WQq/ELFEBmtXqXI=;
	b=sHgG/m26nOXPgFZbucWmTC3f0SwqwkZhmGWtgoq8GI+5jOZLzp77pBshd2Cl+QI3tq96
	 HS9lNkEHVkQvvu9sh+nNDUiUlg/ru/2KfNLeWorqC+S6vr4EaGL9bZs7k89epwU9xUZ4E
	 nQZ6EqgXincpMKeraKwPYtYw08PtcZokzDIMXxhPWm662rU30cGplxJCGWzRJAnnFtRhx
	 9PtDAIHDlGIB9gWRquYCGX2BU03AOEBKDmeJHj1e/Bm7U5Niio0g/rfPUeFLPjZfwg09c
	 8Ow+JXt4cudHPP1RsJr+0nW1bM0JpBJt+VCSuZsEosZg2Mfr+fDM+mdEDHDZ/GdnYNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="VLTFp1/t";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B507606A323;
	Fri, 13 Nov 2026 11:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B507606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VLTFp1/t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=O3L1hntt+mGRgmPOsIU6DlCvda++WQq/ELFEBmtXqXI=; b=VLTFp1/t+zSzvxPCuf+S5kbz/T
	LaEUQQwQ6SlHA/7vohSSKGE1kW7Xkh4dtl/VwagRPDxoVl2YBlUbnmnd1WdTU6EuWuRVCOpGZb9kS
	fcLi5AJ8zmU0BP711wK6jwjlnjvhhAUYnYMfY2Q0KH8mVYbX8ox1kw8I3op+i2dcrr72vgANqJ/hm
	3teeuBOKO3NqIlfsxMfasgGcy7+Icsl4aucvOp+Z6Ik9CtamKXjepsKZn8juX38vRLOoY4uXZin1J
	zHAO5tXPxznAV3nB/NurFhmtVGm/lTukwi/p1wkk8F6YPbB22FzKN8319axOKEXYKhMovK3Xx/9nD
	a13BJgFg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRpqt-00EjRc-1e;
	Fri, 13 Nov 2026 11:53:56 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC 0/3] fs/pipe: copy a run of pipe buffers in one user
 access section
Date: Fri, 13 Nov 2026 03:51:43 -0800
Message-Id: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANT59moC/x3MQQrCQAwF0KsMf91AZypVZit4ALfSRZ3GGtBOS
 ECE0rsXPcB7K5xN2JHDCuOPuNQFOcQmoDzHZWaSCTkgtamPse1JRZm01hcZz8b+A+TvUSl2pRz
 L1N0Pp4QmQI0f8v3fN1wvZwzbtgN69g4RcAAAAA==
X-Change-ID: 20261106-pipe-pool-regression-smap-13cc7cd3b482
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=leitao@debian.org;
 h=from:subject:message-id; bh=4jLrtdhmOCVJiOwO0M+p6XVXhCeaTA7Xqo8KTLt9UZ0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9vpOoHE1ti6a8QEI4HSizzNtvk11ePEbcp9HT
 Wd1J2BK7hmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavb6TgAKCRA1o5Of/Hh3
 bdGcD/9h6zid4Vm6P3p9V9R9lWGlvOsHd/tM6446mryfwbyadcMlD4qM6fzDcUqICHbd5LVC+BE
 G0bDStfv3Q8J6Kreg9oVyFcBchw1ubdkfwVZ3kOHt4+DYanLFr+fyg3i+6LH3LsRWEQeH5rEpKu
 zbJGFJfq0z0770l+IfdNZib66HC6/YOQCI4LpjLkM3F7SXYQrzHurdM65tbMfupB5E2w9hNCc19
 4NMMWN8lwOLUqTfzzqtHiWysxYiItvxVJYJxzHZDClXzuE2ObJI/jCYkKTIQniMY3bCrnZRdRwo
 au3DBWrzuFVe7SH3/XodqKf/PAYroKa91xH1vEWXa0ENnGzHqyv5LO/FVVEOZOtK7H3LzA0UrCv
 Bc8meyIMuV6Jn0NoabKEKaARt6uI7wvd/NgfNR3Hc1zMgM0k3k4ZGoY1YJQ0Nt+xALvWkaSBXoy
 tO57BYu4ZyLnWC2khFIyjMmnacyWB3SqYTx2soRyFCiyNvPiTBg7x7clZ+uzCyOzn3PYXqhRhDR
 xt7UKueUokHdpCDHHei3XdkKgVg0kEpaeK+bTNVp2LKR97v3YpyLUG88NFuHz7dwdWirJOuiVic
 M/JoMu0BYXgNl50B/QzfGoMDYLojdEroD+hcHOUHgv2KGrOFvRkZJ3kHsuESZS1eBEpORl5CI6E
 Yp7J5ZrzlVCmM+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

anon_pipe_read() opens and closes a user access section for every pipe
buffer it copies, which on x86 is a STAC/CLAC pair per page. Mateusz
suggested [1] doing the copies under one section instead.

Patch 1 splits the STAC/CLAC out of copy_user_generic(), so that its
rep movs body can run inside a caller's user access section.

Patch 2 adds copy_bvecs_to_iter_full(), which copies an array of pages
to an iov_iter, all or nothing, in one section when the destination is
a plain user buffer.

Patch 3 uses it in anon_pipe_read() for up to 16 anonymous buffers that
the read consumes whole.

This is an RFC. A single patch PoC [2] behaved as Mateusz expected but
was "on the uglier side" [3], so the user access part moved out of
fs/pipe.c into lib/iov_iter.c. The main question is whether that helper
is welcome there, or, make the party a bit uglier.

Benchmark wise, see the numbers on the last patch.

[1] https://lore.kernel.org/all/CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com/
[2] https://lore.kernel.org/all/avMQxhpHhIPM_6HP@gmail.com/
[3] https://lore.kernel.org/all/CAGudoHFe8XgtKZohfn0Q=EH0EeXozTZq+UPJKN0BEmLnEG2s=Q@mail.gmail.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      x86/uaccess: Split the STAC/CLAC out of copy_user_generic()
      iov_iter: add copy_bvecs_to_iter_full()
      fs/pipe: copy a run of anonymous buffers in one user access section

 arch/x86/include/asm/uaccess_64.h | 20 +++++++++++--
 fs/pipe.c                         | 44 +++++++++++++++++++++++++++-
 include/linux/uio.h               |  2 ++
 lib/iov_iter.c                    | 61 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 3 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261106-pipe-pool-regression-smap-13cc7cd3b482

Best regards,
--  
Breno Leitao <leitao@debian.org>

