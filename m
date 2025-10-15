Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D143081B7
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556304; cv=none; b=uqyln72EygazgFyifIdCrCoy3dQC81XMxedn/DEJ1EXAvxLCAbLorUUcCpk8OyzHwxIkH8hvsHN5wezRIrUKJOa1zNaD84m3a38g2dIS+vlfRLk/7gxicNueZe3ht2w+OUF2/Y1lsUjCvL3gPguQD4u2MtLBlAqTtyIPLN7fShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556304; c=relaxed/simple;
	bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrYXRbSrJEMzZKmmgCZsMDBRdKUt4uwTZKhaR3ywf8+KBBfTae4NDJxtkOa32AIpzbn0P7R0y+x8oMRiVdXIHBhhfXVz86ELX9pzZS46DLl0JVh74+6rZqYzQTl/pAeghrkK/n1MsfyhEhy9i0zNz8H58uSbmvtv87wcVkFbZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCXrNsQg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCXrNsQg"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87a092251eeso23819576d6.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556301; x=1761161101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=eCXrNsQgdp8f7K3ebgai0Hc+oVtG7Ooih1CjwjDKKEEyyZRL04k1+buVHsLdrDdZFv
         obRzzMetWY20CiOmgFh7z8jJDzH7T+zw5ad6hPUzi20sx6uv2ldeQpYGde6OGOnWOJtp
         DzdooGEYRpumj3IjZjDj5FLmJiQIgw/lO/4Zja9+GSN4nT+5DkaGtfbovJl4LG7Uj+b3
         TspXozl6ahSRXhsy06RgZaVmFezunO2qz+23kqlR9f7/KhkU4nmjfwvir8p4s81peDQG
         DFQHwm9TE+r82eNAPhd1D6oKZey75NeQZMRi6ScRstLl4TZXS7A5VpedXZCDRUJPBnAG
         pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556301; x=1761161101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=FHDNPsRcYXonGNrhA8WAco4m9b31HhNdE0kjbei+oCUOYCRfV8MeLMqPG+Ied3VKl0
         qT1GIE6ZtsCcOMIAuOfmFd7igD+In0n2JtAC9jJj0qVV15nWEPKg8n4O/eQtMTJgbod1
         pOlkvVu+NLBClaJuB3F+JCTxmdLX6uXYKCUx+0O/E3FPkHDpXurBBWyqQCbkjn7l2BPx
         MkG6PGJZuaG4KSezNwjSZJRX3FUJx5INCDbDmsTXJ6suRy8DAGLFr87CdMr/5LdXXhz+
         ubX9bgmfax71gaLuH3+9Tw1PXoFUIlM4zk0vwE5UYZjIQmNeD5PcA4hyQJ1F6OvwHR9Z
         yraA==
X-Forwarded-Encrypted: i=1; AJvYcCVIB+PyKMdIFWcKzqP3nbMSMi2QNJw8+bicN/3kY5/lDc8P1y/uuybeHQ4HyjTVeUECWR6LdidRLTdqSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzWQb6/6ptYva06+uctro+IDm/QQHOWYTsam2QSx/daYcf+hJ
	aNcJuNyWCP+ErxW9lrxYrFvz66q4ohttJ2MKze6Mbja8S8sw7fz+eYl+
X-Gm-Gg: ASbGncuXfyEWLFHlt4f2Di58cF2wb9a4ICWpf4ffhL46TjT02VM/QZ8rcNSsO/MZ9kq
	wI9P55Ie3DSTPnWeD2TgxRluw3ZeS9mPqzyU5zzhQs/CRIlIvucpMMaGnZoafFFLhWgWVUU2MiV
	9czyFwIPbpmEIuamXAkPcDpWjqvAvWhNX52WaCZzyN8JzPVAv8pvlM44kxaMWvyl8lCaB27KKzC
	1ABBqEKx609xDtY/l2mPo5pcKW6IGE+x94IX3HyHkCE5LtkOx85dnp7OsKY0757qSYZhyRJNf69
	yBvSt5XifZcsUsJ2ZmsfpZOT/5/XwgJAWcpme7417FN0Tsrxz92+5r6OX8LtfTQoIwHcvN/Nx/Y
	dstnl/6HXIe0Y3WxyHvG/z1wXhv921O/oCwsF4nRbJzNWZi6jm+hrAL3L7CxfjmGeYyvptFGSYs
	FDa1yp3Rf5LKCkfRwcEdEoX2pL54I3Fkgqs7FUSr1i33sBwxclbLvnow7V7DosWLfOJRisepzib
	wX48cotakhsAwKdoJMI6zQ/RvcThkF+I5aatw5meatZHcSVfcG5+dRFgRwtTEs=
X-Google-Smtp-Source: AGHT+IE/6/93cmzALh4Jmouh/MLI95PCde1EljHLkZKlJY4iPwz/j8r/4JCLGlbGVcRLXtlHwQc0sw==
X-Received: by 2002:ad4:596f:0:b0:783:f54f:418a with SMTP id 6a1803df08f44-87c0c8131a5mr22292536d6.15.1760556301319;
        Wed, 15 Oct 2025 12:25:01 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:31 -0400
Subject: [PATCH v17 01/11] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-1-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1642;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKJ1BUAmPVQjuKlRlHXyE7o0qpMUW2qdVnOqngFN6VFfXZIKKvKAJg9piKZPdbhI25H2DhoqGoP
 iQgwB+DS24Aw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove them.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6473baf4f120..8a82e251820f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -146,7 +146,7 @@ fn properties_parse(dev: &device::Device) -> Result {
 
         let name = c_str!("test,u32-optional-prop");
         let prop = fwnode.property_read::<u32>(name).or(0x12);
-        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n",);
+        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
@@ -161,7 +161,7 @@ fn properties_parse(dev: &device::Device) -> Result {
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
-        dev_info!(dev, "'{name}' length is {len}\n",);
+        dev_info!(dev, "'{name}' length is {len}\n");
 
         let name = c_str!("test,i16-array");
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;

-- 
2.51.0

