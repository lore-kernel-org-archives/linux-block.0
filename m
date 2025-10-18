Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6632857F0
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809557; cv=none; b=YDolsyV1atWjBDhLfiq2UQtMkjw5P8XzG5kI0HbB0ow5NQvFJz7EBIyy0INUl3rtLRT+VA+E5MPzDvZ0u6g97yfEY80nhga9gEL8uJ8Y9NX96SfaPboydsT/aqdILShdrdMOPdgx2ynLed+iw3yp/TuxZV9M/vjkpEthh9vCRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809557; c=relaxed/simple;
	bh=VZx3xyzuE8sdJWwvMWeYLSbsWBC7U7VUNVHO5x1zs/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHaAEepYoGBY6BT0Q1ttuWzL79yaHDolRyWUsREtqIyWQegvfrtu0uK8VsrQvy6haAAVpRTWbs75O+XBDvuluDpZrqosqigIS+dD306/BPlQwJVFQwyMjj2er3YuY+fE1pnAgSYnxKVo+ALgRVbqpEavi8O0s5lQovhWWIMyug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee/C91C5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee/C91C5"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87c217f4aaaso32419946d6.0
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809553; x=1761414353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhXSu5jvbOALYGh18N5SGleu51uu827FBi1PfdDv9uw=;
        b=Ee/C91C5ZEhh8jLb3zo2XMwP99BhgrNtp+YaYXxaDKNCdTGMxNX7K9o4GOwIvEJQOn
         VPYJxGP9amVyvDXMcXa7QG/gVv2xjsWuDQc4SAcAV1UoosJxBQ+mD10T2+raWIFkryWQ
         DBkRdCXnMIXqSnHTrE2TOLMDVmXT03J1IHmZsON9STI6iJomwUctRDGmsPtDPMeklUmQ
         epikSbEVtz8xB61QSeluzDShCvZ04knfJVX0TWeCnPukUu+LVad0ITlzRppvZDA/A1m/
         CsmqaCemw4ZTA8kVrPWZiSROyL0AtGlLY9B/h4AczgSl/PezRYEjgJ7q1/+sNyqkS7/7
         0s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809553; x=1761414353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhXSu5jvbOALYGh18N5SGleu51uu827FBi1PfdDv9uw=;
        b=Ww8Z5n+VtwqTZ4NRTiG+vDJbNgnYaXjfjaHkPQOzaEb7ByUVynoceYgAYGjU0XD7PY
         ANJq+bC79ZJuB5iWv1/wzlE4pNP41Y0rf07+8/VM3ESCSC5Db3mA/ZpF7dLPl0CdcdGa
         RK1VqSAqqi+2juUB3tLoI3o5lDIdeaJCARik4sj9IkxGesnooQo8iiBB7YEPtybYYMdK
         5DAZPcC90e7lHdeoJnzR8ixAJVha31TAQj8cGghhVD0tNNpvJKJDmskF+LYyIYbXLVO6
         fdb3BAF1yhEj0ihphWVNMPVQDHr0soTDXwRoXP1KdvSNrzbu1fWw86i0J5N/ks/dyJyQ
         2cwg==
X-Forwarded-Encrypted: i=1; AJvYcCXpnNHgxQfS0xOpMJ7GJKlbdU2UYwjLYTNxzeXlA+tZnmgcpx3AIwdwusu4C8D5CrTCsdlVNv2YKO9EjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoaKUIQvvx2+9uwWLok2CXkhatTo+7r+svv+0PayV6fOQzLrT
	x8gvp7IljIPUn7tyKsmCeWA724CRCog3b8m25pIVI1EZTWbH+CejjXwT
X-Gm-Gg: ASbGncuwU77KD9k+FtKjoNKUcERO0vkH0PJR/ppgyhQLRyN8ozTg18t4g/yWsBFfSXx
	ZNF5iQIsCJhxaeassnUhfXm/MqsTXiST4miGzd2KAK5VULMYQySSKIIF4WZgTcNWdHFTAMF4eMg
	k8HrW1SG5vluvJ/rSOsHdWj05qrdp58CNODJEvA0fI/PcsCDh2Sv9Mpodweaitd2e6m4Uq4V2la
	pjll85Y3Cjy3sLKKP9wK+yfk6wcPW4lD7JfFCJT9pZne4taNTKfjjh6tvJ4IL4WrG1FdAXY5GqJ
	ywH0sPTyDNProDg8OE2LYXNkogfLc5Td2xcGwiqfp0kHx5WdcR+wjUXuYjcNgP89tnrF4bBIjCS
	loOhhYUuNnjcVXe7u5XnIUBg6KumKysIJElm0EXLw3LUxd2b4CFDUNAxrmlb9c0hBakfDJqzGF1
	5+xyfDZKg7J7bcJqy8EqYcb65c4yQ4LZlFgCCwsahP2clAw6zjuCBOEGF2RS4UebJ2Zg1EfX4dO
	Y4ZxwaVzUL/GykguMcgk2hUMy91OTnx0AEefghXUbODaMGY7qAT
X-Google-Smtp-Source: AGHT+IHwmbCilEbE3X/epDbrG5LC82vpTK8X6AnN2QSsDBY9zv0L0DqM69lN1FMFmljkUNXxkq4AOQ==
X-Received: by 2002:ac8:7dd4:0:b0:4e8:96ab:da8b with SMTP id d75a77b69052e-4e89d283014mr129620021cf.23.1760809553435;
        Sat, 18 Oct 2025 10:45:53 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:17 -0400
Subject: [PATCH v18 06/16] rust: alloc: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-6-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=2039;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=VZx3xyzuE8sdJWwvMWeYLSbsWBC7U7VUNVHO5x1zs/Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPuKAuVf9GfET2NKL0q4bp4Tc3Ay6O1rJo/qozL6xioRoXG7kz7tkE7k1hDE/ytV5U50M81wQNc
 BkpwRYc3KSAs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 9def0d0a2a1c ("rust: alloc: add
Vec::push_within_capacity").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec/errors.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index 21a920a4b09b..e7de5049ee47 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -2,14 +2,14 @@
 
 //! Errors for the [`Vec`] type.
 
-use kernel::fmt::{self, Debug, Formatter};
+use kernel::fmt;
 use kernel::prelude::*;
 
 /// Error type for [`Vec::push_within_capacity`].
 pub struct PushError<T>(pub T);
 
-impl<T> Debug for PushError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for PushError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Not enough capacity")
     }
 }
@@ -25,8 +25,8 @@ fn from(_: PushError<T>) -> Error {
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 
-impl Debug for RemoveError {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl fmt::Debug for RemoveError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Index out of bounds")
     }
 }
@@ -45,8 +45,8 @@ pub enum InsertError<T> {
     OutOfCapacity(T),
 }
 
-impl<T> Debug for InsertError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for InsertError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             InsertError::IndexOutOfBounds(_) => write!(f, "Index out of bounds"),
             InsertError::OutOfCapacity(_) => write!(f, "Not enough capacity"),

-- 
2.51.1

