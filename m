Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C613112B8
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556323; cv=none; b=SD97tgAixb+cbVt1EDQdjBUPyhdVomeKBR0twkp3HUGcfJcn6FgYOGSz1Ww9HiyzJXw1Wwhq9LD/2eNAt8NH8+VpReZvCw/rpl4Tvzh5HHJxqt0my1wn9zSey4eIFCBweLKzQ2J0d/lT6/FpkvuD9PJGrQvDLgQPVGT9BGpLL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556323; c=relaxed/simple;
	bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ak18Zzly5hFzUKSs0yk9q6QcPbQVF8wQzhE1/gMllGJRsa8A1vPtbd1OamGBTR6MMOOaIYNnJnn7cmDZZzhSVXDB0dUukH1i3DEqQU9hyS1ye/iEbhLxBIUTyKn015XSXlOAm3/T/W3HV8lY5GKD9e7PD5hZ0yG6ZtcPdXetRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAWmy3km; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAWmy3km"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so22082696d6.1
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556320; x=1761161120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=EAWmy3kml5F4+VbSFVMMwmSbTG1JPrXc25HIJ7wTREx+dvdcv925LAr+3H/MK2yo8J
         3b9T0AX5Ziu4paKrSgcqxGTenO1PwPrhrzkoNEbyIxoWWF+Aq3cWbc+5V2kh4UQ7AA8E
         VQsfzcDkX92HSyd5p5oao9KAr6R1RVTKp7/itf1AdXmq07NlGuakb3PvyX35cHUwmxC2
         6fjYPFDV97+fr4if6sLN4cmCN0hWUKM1L9CBEYXRKwNeu9kOCNzsg2+6Ek2mJsUJ0RPP
         OkPwUg+mIY2Pch+B8q08Kn7Z3MuD/FVy14virXSGtKUv+g0ES3E3mh0HVDExPtD2Wfh/
         SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556320; x=1761161120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=fu5fGLLvDZZQ0Au7lSsC8oCi07usN4Tjo5A40674uKRPjdW2RmiIHQ6PGAohuXaimE
         F1v5DQ7tTzadg7GhoTJCrVAMeTPArL1S9iDpB3bD+3kRu95yunpYHvVPCUZdKqV4E6eP
         YNVtIUcHGfPERJdCNgB+MsHbFkLsmiRTPReeoDnUBfnnoe6l/OtEcEYoi19tZoD6qQH7
         VLj+KdH1CcIFFMop3kY73xycNUOzLzIqcTwX6o7RuT27TkZHSacRFxe3ojXhJtkRD1Q7
         r4i2wopm5Mnhx4cGYyYxJB/C41ATHWcIKjJ313JnNK+6w6svUKmTfaCswn1rQmt+SU+5
         hD3A==
X-Forwarded-Encrypted: i=1; AJvYcCXH/5WB+GzhNFfkhdJlsb73R4PPrQ27PkW3V6r1nrQTt87eU3mEZ6kMrfWDWxvbHWrR08PXfbp2h3cknQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HmLk+3Ja37dpGEU57HL8dcOGYKbcTC1o70smiHiU2Cz4ABrD
	r3bhR97FCDShkDrhLIgE/t3jWzcKyqnlPfcABe0S8lymRw+YZUVdnBEd7+gYKlSy
X-Gm-Gg: ASbGncuI8PhpiinRLiUlgv93IoWm/DJ30Q3W3SZ0uvLBhcZlKhlBtS8FGQ7mrOBI4cF
	9QIcHZgYCTKlPiGkB10lTjYfF50D6KuwKMo6QsusRKY4A3EHzRISYymkdWnJeFm3ZdYZ8anbWRU
	g144PsSgMdE2vOxbF4IvgMFvSKc8NgCDDLccIGolboXNol1hLxHCA+L74+kR/CfkCi0gZS879YK
	9xzFXdUWi/KiHWhrGBSmoMxbA8cBg88OHb7ALlPzZFPoj4gqvEeFMGqlRwyhsW8S250m+8CxFM8
	mNcFQBRxk+wFZriX35EIewxZgjKfhcmFd8bvsrR61M1uTtr0RB+yTsf96UEbO3AHtweKwGvYKL7
	AOmPIgEkqxMGfruy07H4ia7mQvfH5mT1E5pyqGgMer8kPXyfJx5/1AHabpldQYQbuATnpN671/b
	16+Qk4iuLGZp842SBdPE/SL95hxJmKlDDb20f+v8V5H9xll5U8k/ZTRQDQ+NFQwIUOuQ8hbmVpK
	IaChDwAIjj2vXJLF7m03lW/EMIub//PzqfmST+25/wS7w7DIYQ9E5Exntiw/0Y=
X-Google-Smtp-Source: AGHT+IEDOgFM0nazGEEfzHtKDS647mvDkfCfJSWTYyfnR0K2d3p2LPiGQli6GsrPQ32Cigz0HxquCQ==
X-Received: by 2002:ad4:5fc5:0:b0:787:f736:bc66 with SMTP id 6a1803df08f44-87c0c5cb92fmr20009666d6.1.1760556320049;
        Wed, 15 Oct 2025 12:25:20 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:39 -0400
Subject: [PATCH v17 09/11] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=620;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA49f7ifUr2XwLcazgyI6X2saN5gtmXaaA6IvRCW2zqJXH2aWsvrcTeWwyt5IimaZuePXX9+Xm5
 hOtGKK/bcVgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

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
2.51.0

