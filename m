Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7D310631
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556321; cv=none; b=q9a2jb2WkvESr259S96e1acqaLcyLyG87QlUgtw/JGvxEULawtYb+utMZlkO9rqm6X1hL6PbhSoE+y3DRRzkFdNi8gQ/dnmkUvjuZyrdVGH8psX+UCyM4POdLnOSUmyAcan619vE6YrWtzBEvZMi4NJnmKk9thwP6wA/XGNRuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556321; c=relaxed/simple;
	bh=Kd0EzPTdfyblnmo1RxE7jLLbIDYVUJvE5DzKX0nK5ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf0Zyfzg98Z8jorSnZ68dUS79EpYFlpgR270GoIT3VAzx1bP3NsmP49TsNKHiLT4lwPFP1qNF+SDfRd3obR1v5Qxg8KEFLmiZr2PnPFxHxVVsGlrZ7/KefJ2MrM7wO+9nPhtRHBMC9lpK80Wh1dQ7RopTl75WrhSinN2Vff0PSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMrVogHc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMrVogHc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso47867906d6.3
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556318; x=1761161118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfKLoaIE6m6YAqIlpySfZ0ebyLDDrsoOWfky8dWsuu8=;
        b=LMrVogHcGeDeNnUmoDhp1Krga++idOt61PfnQ8nq+3PdvwKyUiws7bhrvpk0b7CDP/
         PHSIjY1iJksa2BhauBRnYMKCa/I280ce7stALHOIvdRk7qWx2SRUowDi73acVUB79S57
         jXzRMkCYivEYnL4oIcVDkJQCHs6urxlAPDI6XW5+axPqan+BaSEWETFfUi6H3qhRt1yL
         nFIUNQsOGG6H5jScPpkkE8gsB7aa9iMYt48RqBk61JvTtRMKlmjyAMjOADtOdURgh/Jb
         MEdxYcMfUMLIsqE690ypLxJYdc0KzEHJO3mwynr6D55fwU/gMyPjgnwHZrslFLR05mIP
         InnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556318; x=1761161118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfKLoaIE6m6YAqIlpySfZ0ebyLDDrsoOWfky8dWsuu8=;
        b=W3R32DFhRbgtJImZWow1riPg8p2eOrc19LOYW+zCPlPFTqPSevpExkR35nHbFB63Pt
         udsZtVTDIVzuVY7Sh/314eK5LvPrDneHhxKXsLsZw6butaSSI+HKZE/sAyKGoDrAN4Dp
         k7pTLY8m/xPsEb+IhSXeJDGX8sBiC+Dq0QbGVF9Vv1w8X1kLGRYEkA7j7ULBZ8rR1S9v
         QKc9lS6sKFvvx7EXcXvZjKNK9N4e4ykJ10GlEErDspnLhHXqUOn0c9VjCxzcrkxyeyun
         vCtJkHrC4XC8YTEjy4rZjjS3b9BlifshlUg2O7JHg3rW2vaIzT9SDdx+9Yc8xLui6jSy
         NjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAwydta4Br2aMszAxR7gak30dbkKg+Kos2Kdw8IuY28S0G63kqud1LD0aAgLwzOqtFKvfkqEVqTqcWlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYTivmWxEjfn89U/wG1SH2Q9FVEtG3y7lADM4ZvMs/M2B1JBV
	wH3Z9NgElGdPbptoBPq1xk0/n3OT9Q9SjXO5sTep6UT73Nbl/v5n8G4Z
X-Gm-Gg: ASbGncuRq6jjWMpLjm5qS7dfCqdRI1TkeR0TMHpPM4d/8UZyR5/5ogIVpIyAfqluAit
	wwCgYLi7XHjCwbNxrYAkH9nY67ez6Hy1vBJaE4LIsYPqVBtgf3ntVw8REX4/RqSp7EmiQ3eua5T
	tsVJ/+P0zvqX4oLS24B5AHfsWRg8mtnr5+C75k8hjwIMxiYO7II7j0AtZ0+ah8qOEP6F9tlOaNe
	UcKlWz6RDG5mL9e314dkg+dpzXx+75l4dnFEp7rIOOax8ZGsLJsNZs5ylkLE0fkw78oaRqFZRWi
	VH05vkdkw6sHqHboOOSs2t8Y7P1e0IFDASNvQ73PuytyMbvKPuSp8A/RLWZdubt6gYyzMZj9hnF
	jXKtRtfttIX/gJ2G01+rn1qTWu+vjDG5ZKpLLSJjN3I1SBvTyXju46UCdC11NTN/PtUUkX25sPG
	9n9qFh+o6aaUP/c+i1V1HLa+QUigkXqL9Ahe/DE7YyfoUB9lE5FkgJ0pNejUVbJkpijggYSLAxx
	nv5u6QNwzB+yvuG0ANMEBcreSGHGXnm45uuUVbqYzGhyGwd8M5N
X-Google-Smtp-Source: AGHT+IEyJ4wXPRNVHomX6M4YCh9mUoGoZWRpoOJh8NtSqhKRuXmvyAnybqGcRN9E15RRAuo/qFdyWw==
X-Received: by 2002:a05:622a:5809:b0:4dd:8dcc:17f5 with SMTP id d75a77b69052e-4e6ead15d7dmr389497071cf.28.1760556317628;
        Wed, 15 Oct 2025 12:25:17 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:38 -0400
Subject: [PATCH v17 08/11] rust: pci: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-8-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=872;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Kd0EzPTdfyblnmo1RxE7jLLbIDYVUJvE5DzKX0nK5ME=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEhfQevpl/RzFxxXnpbY5oPfpzKL1+vKftdtwGLN29QKlCkDGEX76xd9UdrJV0rHFhQ062F1yi6
 DHt74TqCP1g4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit ed78a01887e2 ("rust: pci: provide access to PCI
Class and Class-related items").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/pci/id.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 7f2a7f57507f..5f5d59ff49fc 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -4,8 +4,7 @@
 //!
 //! This module contains PCI class codes, Vendor IDs, and supporting types.
 
-use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
-use core::fmt;
+use crate::{bindings, error::code::EINVAL, error::Error, fmt, prelude::*};
 
 /// PCI device class codes.
 ///

-- 
2.51.0

