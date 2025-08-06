Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33727EEA6;
	Wed,  6 Aug 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501373; cv=pass; b=UGDk3ljtRnWZg3Fmr/B+F0qy03AzAkb3ua8VtM3zx6LhYpq17+eqWxXYf2HJ2G0Bz3VONhsMuujkLOIxhdwDWxsNcwGA0cUmNKdgNHo09qJf/7IuafpJEMrirw0Tsk7DpjtT9YacGHtsJcxZoU8JxWzVIAmcWrpByIDvMQp2dCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501373; c=relaxed/simple;
	bh=P5HumY1f5pqcbsSiGen3zHpVU5FyFzi7IXD83orIJ5k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A1YPT6QrjVzQEB4va66v9TwH2rPWDWConsr5XB5EOsfdXV8r8+caZY5DtXoFPrtcTnsdX9x4bXECiN3VmDmpxFXGOMWLxhgj0v63OH08AgrjwSRjhL+VS/4+iu9szT/rGXpmN1L7nsoV0D3ipXF8vi0KPTakpNHAICLV5GBSStY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gr4dpVoI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gr4dpVoI"
ARC-Seal: i=1; a=rsa-sha256; t=1754501355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nRVlUP23EhAIa3nkqn3aarUxylgokKXzhvKKc+aKnJOif3UKp2m8RKJ01tqW0ONJCJegsztMAQWCQkjon/u07MIeMUqgW/Y0jhMYOLQJ6dMAv7cNUyYnjhOuZ5eOPb9Mrjr1TgY9Cbpyi3IuxLzuEQjs6Ie+gJW0lTY/M7VnlCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754501355; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5qQS3haJplQW3XCKKDMXBKL3UdZ6MJ+OjwYNOoSXYx0=; 
	b=G/FjokbrZGt8dL2s82kyfDIU2Uma7Tq2/K6AZPV0X+mRX8SE6b22WrcmbBAwMiWWQvB6u1bumzPUoZ+0ApnYcMZlouhEnFYNR9KgZiCm6pRYBiUxkwNKFmlgTdzRcaBSrFxz86UUV2bbRyB/0e8KVmxGhz8P7N7X2VQn+wRJQFA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754501355;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=5qQS3haJplQW3XCKKDMXBKL3UdZ6MJ+OjwYNOoSXYx0=;
	b=gr4dpVoISdQmYfQDNxHsQvL59FeRRsiZ5wheNd8x00aWNDCnyYtOfFNgbQxMaHln
	FxMi0nT0I5KPViMneohQziJRtqiOyt3GzbVkj2ReViy6ykUZbkyBDutIKSZ3xzUyaxJ
	7LQ12jm7aGvQ41h7WerET7zdPXaz9OOPcEDFI5VI=
Received: by mx.zohomail.com with SMTPS id 175450135331155.256780099241155;
	Wed, 6 Aug 2025 10:29:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 11/16] rnull: move driver to separate directory
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 14:28:58 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B09EC7C1-1CE0-406A-9856-9FBADA662AFE@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> The rust null block driver is about to gain some additional modules. Rather
> than pollute the current directory, move the driver to a subdirectory.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> MAINTAINERS                        |  2 +-
> drivers/block/Kconfig              | 10 +---------
> drivers/block/Makefile             |  4 +---
> drivers/block/rnull/Kconfig        | 13 +++++++++++++
> drivers/block/rnull/Makefile       |  3 +++
> drivers/block/{ => rnull}/rnull.rs |  0
> 6 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b8..29b14aec3559 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4246,7 +4246,7 @@ W: https://rust-for-linux.com
> B: https://github.com/Rust-for-Linux/linux/issues
> C: https://rust-for-linux.zulipchat.com/#narrow/stream/Block
> T: git https://github.com/Rust-for-Linux/linux.git rust-block-next
> -F: drivers/block/rnull.rs
> +F: drivers/block/rnull/
> F: rust/kernel/block.rs
> F: rust/kernel/block/
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 0f70e2374e7f..6b50dbc0495b 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -17,6 +17,7 @@ menuconfig BLK_DEV
> if BLK_DEV
> 
> source "drivers/block/null_blk/Kconfig"
> +source "drivers/block/rnull/Kconfig"
> 
> config BLK_DEV_FD
> tristate "Normal floppy disk support"
> @@ -354,15 +355,6 @@ config VIRTIO_BLK
>  This is the virtual block driver for virtio.  It can be used with
>           QEMU based VMMs (like KVM or Xen).  Say Y or M.
> 
> -config BLK_DEV_RUST_NULL
> - tristate "Rust null block driver (Experimental)"
> - depends on RUST
> - help
> -  This is the Rust implementation of the null block driver. For now it
> -  is only a minimal stub.
> -
> -  If unsure, say N.
> -
> config BLK_DEV_RBD
> tristate "Rados block device (RBD)"
> depends on INET && BLOCK
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 097707aca725..aba3e93d5014 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -9,9 +9,6 @@
> # needed for trace events
> ccflags-y += -I$(src)
> 
> -obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
> -rnull_mod-y := rnull.o
> -
> obj-$(CONFIG_MAC_FLOPPY) += swim3.o
> obj-$(CONFIG_BLK_DEV_SWIM) += swim_mod.o
> obj-$(CONFIG_BLK_DEV_FD) += floppy.o
> @@ -39,6 +36,7 @@ obj-$(CONFIG_ZRAM) += zram/
> obj-$(CONFIG_BLK_DEV_RNBD) += rnbd/
> 
> obj-$(CONFIG_BLK_DEV_NULL_BLK) += null_blk/
> +obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
> 
> obj-$(CONFIG_BLK_DEV_UBLK) += ublk_drv.o
> obj-$(CONFIG_BLK_DEV_ZONED_LOOP) += zloop.o
> diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
> new file mode 100644
> index 000000000000..6dc5aff96bf4
> --- /dev/null
> +++ b/drivers/block/rnull/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Rust null block device driver configuration
> +
> +config BLK_DEV_RUST_NULL
> + tristate "Rust null block driver (Experimental)"
> + depends on RUST
> + help
> +  This is the Rust implementation of the null block driver. Like
> +  the C version, the driver allows the user to create virutal block
> +  devices that can be configured via various configuration options.
> +
> +  If unsure, say N.
> diff --git a/drivers/block/rnull/Makefile b/drivers/block/rnull/Makefile
> new file mode 100644
> index 000000000000..11cfa5e615dc
> --- /dev/null
> +++ b/drivers/block/rnull/Makefile
> @@ -0,0 +1,3 @@
> +
> +obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
> +rnull_mod-y := rnull.o
> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull/rnull.rs
> similarity index 100%
> rename from drivers/block/rnull.rs
> rename to drivers/block/rnull/rnull.rs
> 
> -- 
> 2.47.2
> 
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

