Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334D2FC874
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809570; cv=none; b=VKlDdFWIKmUK9Qt6IetCp8d/J2K4X8yQfJdsu3xrUeL21ZhruE1Zv5GV5LjC7z0XQuUymGrJMtpmEXtIuCI1Xx6wXbgllKvc/RQLt8Lr27dQZA5jhgM32oNToPenZ8ImT3hyTMXcLDax84cA3dU0G/Q5vNoyt6nGBS968VmRU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809570; c=relaxed/simple;
	bh=W0kd+lIKrES9E6f3i/NvYS4ZToF7HAzoNGFG8gcpmao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5Xo6FhLfzL9HBMQBS9mFBYsIVY3oP8Gy9lLLUBP4/pOM5cBUviFCCFYc3zRpbi9vqpA2owrxsXrvWRGOfpoDn4LJBv0qjGwyc+7NC/iDBpm9TA37+cjhXlR+G2M1sV7YyBNPxDvz4YgTFJoSxBTsrlUzFPaX7OUTKGvs6sHKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJUsxV4m; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJUsxV4m"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c1cc5a75bso34443206d6.3
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809567; x=1761414367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKB2rh6EiQ7umDMD4HQ+ERdIpZM9C4N3KJVnDXEYlQU=;
        b=RJUsxV4mLUwfi6sZRhT1okEl38/H3LXxoSzmGRUT8wFxkDIqT6KLaOpXzDvKaFhKki
         O2GIKqKwV3f4hEubO2CcSR+6MfxlGoaecVmHqLXPifSwQFexHUsxFxjjH7YwlKyEOqqL
         q6zqZ85exfd3JY9hjeLRew1p9yCG7Z4vZQgBhRZi0RL6eLvGo11lHtBfPOour/xqaHgM
         wLs4NcTvki4J7cOMmt+guqWZQkVJuSaupB7fqaIkjq2E1aF7ylBaVAMoUvBtbVKeV0VP
         S8XkX0pta1l4dnNQkpid7fvULY07Fyr5PyHy78oZWxTBnWYmQwUhaMPeH/xQt3FYY217
         kMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809567; x=1761414367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKB2rh6EiQ7umDMD4HQ+ERdIpZM9C4N3KJVnDXEYlQU=;
        b=R1yUSCrDtEbpd0dqz2UODmfsw49h2d7I2sfSLw6YWqhd8G0BuOe+zzlKb1RVID02U4
         tbPXnoVp8MT3Q2QjczaEPM9cH8ujyMTEZU3yjk30OBkUjLBgt1vtc+yNNxq4LJje/WxK
         YttFJPzNiQPGIdLRMrIb2MonzDgJy5Uqr2I4v5TEQV1/6RgZAwDUYTmi7wD1L14auolU
         AIHdnRZcYho+UPFtRe0KiCRjIDjsEkcGUod6rpHRI+cGL3fBfLLWIVMiNmbpixAkEcVQ
         fHtQM2Pn5dRuth5NGak7AEvdPeqXq/WMmUN6yO2BoPdabWyIjhCy+jhpCRDA/YZhqtAi
         DMOw==
X-Forwarded-Encrypted: i=1; AJvYcCU4NAuaaPHpdWXWGBV5k1CyQ/+S7Wsb35O66aMMzi86He3yC/iUPm3554YOpWJM6kCL8uVsD8ZUp6CV/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7l3+TKa+qiuLyrVRFhqFwRAp6Qr2tABa8D3CqTlRSBkaWf5k5
	O8OZu0hUcuNMnYSV8tQeN0UOD0pxegqK3ZqOIIr65LZwcdbqB/VX9lOD
X-Gm-Gg: ASbGncu/E4FLVqMQsKesV/rxazYW35Ont9A7uQHQlC10hpP38L00lNO4FxO2T3Zwvhe
	qEuzADEB7wMbRZdFXTUkz11SRga0etqaGCWq0xniue1lEQA3bFx3pkaX+BFP5xv68fj2o/UO3rI
	WIB/UCceeM9lYyoumBAeA/A/PXfFQJPB8GwVL6JOF+VpKS7xfiuw4UX2bAWQiQQBZzwL7OAaVuM
	uxW7kNxy5ZyR0QxSmitVAHHH3gojS3qzyVgYBVypZwwSq3ZHZJqNaQyuruXDOlfzPuKKaAD3s5V
	PTmcqqr+qW1QxYgr2aEV73tSMVvu0Rrsnw1E7+juf+YToYn9E1SKyl9rCnO3JaqJK8aHVptx31p
	m+tn14dFAWA/zkk+9ZMZeV45W7ThHhkMioWgNDePK+PXg8J3+AmbQm2rzbZPBQPv1Rjfrc4V7bl
	3mdExTRSHLVKATeeGrGfK1NWZi+xQmMUc2chGcgmhd3w/0eHJU9Y2DBHnX4zBdOYheG7+XM7ysW
	ZI3tWLH8ZnQHzgh+KB/udIiUX/r5w+u8QYUKzCWP4sQPzCCXL8OIxvik93uqcQ=
X-Google-Smtp-Source: AGHT+IEi+T9/sjZ3+qvtuzBCO8Ryg37IjVdgJ7+/CPsrCZub5GHtmSQZv61we6wEcfm1jaszdnCtzA==
X-Received: by 2002:ac8:5908:0:b0:4e8:8e75:1875 with SMTP id d75a77b69052e-4e89d283973mr96538081cf.23.1760809566774;
        Sat, 18 Oct 2025 10:46:06 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:21 -0400
Subject: [PATCH v18 10/16] rust: opp: use `CStr::as_char_ptr`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-10-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=1431;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=W0kd+lIKrES9E6f3i/NvYS4ZToF7HAzoNGFG8gcpmao=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEAqWyd54iXxQf1W7agZsuXCPqrg/zEyTWXe5pjUlem4d91+xriJLoSF0e5Up8mkLDTG1Mc0sF9
 CNvCQrLokrQ8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/opp.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 2c763fa9276d..9d6c58178a6f 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -13,7 +13,7 @@
     cpumask::{Cpumask, CpumaskVar},
     device::Device,
     error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
-    ffi::c_ulong,
+    ffi::{c_char, c_ulong},
     prelude::*,
     str::CString,
     sync::aref::{ARef, AlwaysRefCounted},
@@ -88,12 +88,12 @@ fn drop(&mut self) {
 use macros::vtable;
 
 /// Creates a null-terminated slice of pointers to [`Cstring`]s.
-fn to_c_str_array(names: &[CString]) -> Result<KVec<*const u8>> {
+fn to_c_str_array(names: &[CString]) -> Result<KVec<*const c_char>> {
     // Allocated a null-terminated vector of pointers.
     let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
 
     for name in names.iter() {
-        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
+        list.push(name.as_char_ptr(), GFP_KERNEL)?;
     }
 
     list.push(ptr::null(), GFP_KERNEL)?;

-- 
2.51.1

