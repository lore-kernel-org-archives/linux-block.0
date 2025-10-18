Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94C2F9DAB
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809566; cv=none; b=TVYf86I40PxXYT0qWs/bBX7MvwSDFlo+3oSB7zD1Z0LPKMzbFTtX7t4yB15/Q5y172npYz4Hu4Xrswuq8FzN41cZK+S1Zd1ztDFlHQoHNCiJ2T/WrfdcnjLjY85TQU0RA9JpYrNg1Wuh4ffbwOa5FPnS3EVktuTmIYCO7H3JhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809566; c=relaxed/simple;
	bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaPMZiKnzvW69b9xHU8eQ7D39Z9Pz2yu6u8oXK8X5F4iYpS60lOkogIiBr+UOVRfWfuxpUsgugTGNrs6w+AfJym62OHl7xvv9oF1NfXUTAPjnXRMC2G9yHlfRQQemoc3hughdoohSpBdtd7ErC50zSijjAVNn0SMPeIyAXFDI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHG+AFkM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHG+AFkM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-891208f6185so224980585a.1
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809563; x=1761414363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=lHG+AFkMbyufoj+SWOxxS4Jlzvye3+ZRVR3Wqpp8AfEOyxhL6mE+AOcVUJ4AiDmGLo
         1zhxrXq0n/n7BN0pZHr2D/IT0qYPM6Xs7IMW4VddAkyMUlyWQru1bVTzds4jFXGiH4OE
         vEe737BsPF3vXZF9wUdFgnj92fXmR16e/txtYSxdRajM+5jwe0cKQD9f2N/zenHtA/g3
         YPHhTMxWPUB90rIEpcevr0hUWrU37oC7li/e+I0Xi1MvMy43keNy36zeW2JTJ+X/1wMv
         skmkD+LA555N1oOfWNasqygss72HyIrUfzboyc6cYQkeAS/qMqMyT6p8eUyi8TlQbY5K
         YC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809563; x=1761414363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=H8mnyJAjonuscOlLUVXotAvVKtiXCt4SxLtFRUIld/COXAUBwlHeK/vrjXfBYEv33v
         1sQAL4+ociMBfIIWoKtRVnvY93F9DWbYxJpIiRwHv+23b2ZoeQmc51Lmbrko+SpOCMT/
         eDxlmizFcNHObOqks60kZXlkkgXdBDNU9QxdFlSNcm2aodc8/sVzsD3sW0TeqR0gukpC
         JDGM4BkVRbLRAj0LWxrz7/k3zXtphFCjp2TxRubsLViapApEhSpadt5VJdGgSVuYFGos
         N2Gp2KpYiu91WQ2oOqL4Oq1maPM0q9RZIqb1xKO9Pbq9LngUBjWWRfbArZxtnXamq3h/
         fsQA==
X-Forwarded-Encrypted: i=1; AJvYcCUP/bMHlF4KJeV+avaNSzd5vRwiYGaHst5kA6QvMOTbVEJEVOifzMatzpsd6yI/bSTlhja3hY6FkeX2eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZ2gAfo4Bt8CpYXB/wH+90tst0vML6Aaqs3uuyAv2CClAaNv4
	QuRFXbLxlXOxZQwbZGh/bClNEwMIPr8skjRSB+bec/ByzSO1ADhNN7mq
X-Gm-Gg: ASbGnctCHLkdgiO2Ceatj1P9AAYtiz7bQLv4/aOHvhmn9ULOFXRkeuwR3LXGQCudECq
	Rmnv7QgdhEHG4AGmRY+7VH+qTXKl9oYKLBCVEmAJL4Ocw59sosm5DKppXKmhAc6zZQ5vqThMsmt
	d/gNv9jev50RNLUOD+suFSY3fdy+DHKhFp+tXDzizEwuZRAqBXOXY7x3fglRwQ5nPH2SEB6Vx8n
	LUzUnj1kv6GJdWL2EN6wdVNb2lp37j1udTE8YTogIwydy2UJFggVU934TD7SP6IBQ25MYTk68I0
	1n6KhB75G5dUHLPPGKA++tLu2TkTu+X5yPIMtLhzEOwqjgsaPW4IJ2XBeCHIvJs/6a7Xhndi977
	U859B4AlWTfb+UGBCXETEjaaGcYwJTXnX6xhfbsx6zXpeCX94iEuvtnPptiVVhfXUDkaBbYmZik
	VBER8BZ3MyEr6MahZWtAk8/dpvAuP9XpOPDpsEq8mkrVqkgNQBgibAxj4V0eCxLIkFhMp1gaE50
	nXtmoAnOn8ShqCQsnRdW5wVTdABQ9L7F3d8F2fUfCy550yB4dCsFZV258474mhor4oJ6cGzBA==
X-Google-Smtp-Source: AGHT+IGG7z7f3MNU21/Rti4PmtrZca4GFxKfblibRIkboUBwmpGvzYHP42u9XCSh6vTqFJ+cvotYfQ==
X-Received: by 2002:ac8:5910:0:b0:4e8:9596:ee77 with SMTP id d75a77b69052e-4e89d1eca83mr102709391cf.10.1760809563421;
        Sat, 18 Oct 2025 10:46:03 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:20 -0400
Subject: [PATCH v18 09/16] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-9-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=668;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGXXqQt9RHGxpoBFZLlXeLUPAugoqd/q2N96Ig7iFhgm9rnqX6mshM+HDXmtIVBN7F9GI6CbJIb
 k7xYI3LBrrwQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/ptr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 2e5e2a090480..e3893ed04049 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -2,7 +2,6 @@
 
 //! Types and functions to work with pointers and addresses.
 
-use core::fmt::Debug;
 use core::mem::align_of;
 use core::num::NonZero;
 

-- 
2.51.1

