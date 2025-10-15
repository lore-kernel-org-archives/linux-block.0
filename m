Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F31302CDE
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556307; cv=none; b=O5x+vJ/ZJN/h8kuFbW7qijR9Sr45UPsGKLTqhB/pldhq9UOpmXMYMLy1FZEORjLf5Czs5hTTbCfF1r0V/5ZRVeVvz5K3bEogoNtFanT22xTt9O8NnGVEGKsER63N+shm6i443jRAWW7Cg3tJYdVYowiQD2sUC1aGPrldZX7qql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556307; c=relaxed/simple;
	bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XK20j7xmVd4YOCxK62VuQAmSGp0ijimljIyWkHK2x/ERqfVUhIFOOrHIjUrIs5IDEyntWm8slhSa7vcWFI1dPxNFaw3SdEUn8/9/bAfKQakxazkhFB1TI1sR97+Vh95kClNKoPVjactDwhuRamBzJCbkAiQMrKc+hmwVZnKrL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbCdb+fM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbCdb+fM"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78febbe521cso94967976d6.2
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556304; x=1761161104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=JbCdb+fM+OVabHRFA0Q4ek4JESF0QVGj+1Y+55BDVoMky/bZJokq4LiZQoOYNJo+6+
         7DXUahkxmMERzwdWQZZs0E3KcR3RoK9s/8h0Ro47K8vtrh75OjVFVQAJyl9PdUQBRLlj
         eYJ2bxdgv/4W8p/VXKBJS/lc8Yfrt4CAAWHvxgzjEGm1nCS36OGdoDXpkNW7EQmDMLbt
         r4kuh0925ie7RHRpBJJg+q9zIL+DH58iQIoxaZhmC9Ov7bIgBvUYv6/YoumwSZImbTjb
         cda9nCeWjILwA/5qrqhY/1Q/tGQs6JlncqJi0o0Y/N0marbQ/O0MGe9fiqmkEhmPQ1P7
         i9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556304; x=1761161104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+cfNHruMdPBuLxqLR3jBeCuq6DohSxciPX7+EKAG2M=;
        b=L/b6JWdptmZxXGkjS0V6G17xxngkqKbnOECGg9306tsual2n+/kX2uu9yQ0YE31qIm
         uwLhZ/TwvLEOs/F66RPNC4HIM5BPNpd5AUZs+JJdKtR2NEIHt+YiT/6sQUBSJHX/Ju5f
         4m6Eb90OdlHi3MIxoinU9a+KrdAgDpgTydcAN8C1xPvqRfSyAD0VTUOcU7KlNrfH4/Vs
         a9LeULPUvcLFiDZsRvmBAMQniER2SVeo9AfTlFtnUWhZhqRQ609gwj3MHacdA5aKXXZ3
         JXTKL49kly2HDkO1U15koHTmO6bT62OEhR/cG1kDWh62eLa/7bJgkx79b0CcuhTXOWEe
         YE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE+hbROHMP//VlmXFm3sBrqVIPv54fqa/wKSE9ZUkTaCUQIETMUY4VjDk0MNW5pPbu9FSNQmnr1QGKfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56kwStM/1t/4p/x0Rlf6yxB2gzhLQQzKYxZNwYiL0r4Ftpgpb
	0uiuo7ELj7PJ0c8b1d4LyinZsmQuKWZDsxwrOVb07RJpsVhPljHGCWIsescrZinA
X-Gm-Gg: ASbGncuou2Ijk7F1a/QKuJC60w5qpr0npbBv9+3JdkNQYHd6WPcvG2YaP+eoxrz7XUy
	/yM4cSP8C3kxEGoCkO7BT28GMJZsjgPJpFUYWnBTBd408ERoSBK4CeHC8VJ8BCp8Z4gHFVi4fWv
	YpkiOeuep76Xl7XSFEEPJ8wMD/Uzpne4m51pU9zZRteJ5lxLhnm3FGswjJav3r2h3Rnk8xrLFQH
	UB4PptBL2y+EYkzgPKrPd7vPpPuPMZ6rHRdZe00OdJCmBKS0FbG9h60a3tijRnZEll+L1LJUIwX
	8pNFjUwmBrSLgWR/F3Mai5Pv9dVAZsNz0IllyM/5AuOm74xggIFRf64q1FQjvcyYeiyoABuWGt5
	Wif3tIGBw51YW6K8AemCy/ABDPYcjZiCAmZctwXJ4bfk+5Gb9tqneHK2Pmtv+OwYnz0jxn8jhb7
	Namg/NWFioAvf0Ie0B16K53Khq/3ThAUxMBSNIoiL9hZj+14G8fdLdrsAb9ZrHBbhmDhHdJFxhw
	KcZzbR7Hefqm9WZAp3jx8I+uAtO
X-Google-Smtp-Source: AGHT+IEX9u1kD253LkrUXYqr3dEKSTO5L1DiyQsTG96pQUi26l2qBcGyddQYo91Es/OcoCoyz3pFyw==
X-Received: by 2002:a05:6214:2b0e:b0:87c:115e:47c6 with SMTP id 6a1803df08f44-87c115e4a3cmr1082086d6.60.1760556303575;
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:32 -0400
Subject: [PATCH v17 02/11] rust_binder: remove trailing comma
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=933;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/6FAAPliz9JMtIVhSN5WM1U6uwaxaWrmdWOweTW7QYA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH7AeKnZyD8ngl4+hPz+8Rz7zx2cNxYrkgP+Fzg1nzu/J1gZ5lAhrwaQqIaNPJOGnMwEnAQZVmN
 mf304LMVVag4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove this one.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/process.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c..d8111c990f21 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -596,7 +596,7 @@ pub(crate) fn debug_print(&self, m: &SeqFile, ctx: &Context, print_all: bool) ->
                     "  ref {}: desc {} {}node {debug_id} s {strong} w {weak}",
                     r.debug_id,
                     r.handle,
-                    if dead { "dead " } else { "" },
+                    if dead { "dead " } else { "" }
                 );
             }
         }

-- 
2.51.0

