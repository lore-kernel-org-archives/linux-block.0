Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9151AA3FF;
	Tue, 30 Jul 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374908; cv=none; b=dObrXnE/M4mku+fMRgGMaawA0V34vu6OrQq8sTqLFbxnr4BYLlaKe5viMwpvkJPwq3bxEyJGasvbE4had8o2U4F7XOSoJEf7Nezl02Nw8OVyOdWV5mTPEDC9tvTbJlMcELsHA2CBvlUBzyk/6mLQVGJlA6FJLVoesZQVO8oovbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374908; c=relaxed/simple;
	bh=tohvFFcsA+kMrDpqQwvEya1ZxVR68qd1fyh4J321LRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnBYutsMHjInnWJn1wV4ChXfQphlbimXDPbpdYObTruCF4+ZUxPnggbAqSMSG97xpvX4zQbBk2DS5ad21p9NwbylkH+nma2H9/kngwWApQalxca+pbYpBA1LHc4Q7kJeGav0k39vcITgcyhnDUsjAr/0LkbsQvKHFKmRqTeZQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYuO5-000000003kq-49Se;
	Tue, 30 Jul 2024 21:28:06 +0000
Date: Tue, 30 Jul 2024 22:28:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tianling Shen <cnsztl@immortalwrt.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 3/4] block: add support for notifications
Message-ID: <Zqla4Tw7YSi1pv7h@makrotopia.org>
References: <cover.1722365899.git.daniel@makrotopia.org>
 <ca0022886e8f211a323a716653a1396a3bc91653.1722365899.git.daniel@makrotopia.org>
 <ZqlA21iolCpnu4wn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqlA21iolCpnu4wn@infradead.org>

On Tue, Jul 30, 2024 at 12:36:59PM -0700, Christoph Hellwig wrote:
> Same NAK as last time.  Random modules should not be able to hook
> directly into block device / partition probing.

Would using delayed_work be indirect enough for your taste?
If so, that would of course be rather easy to implement.

> 
> What you want to do can be done trivially in userspace in initramfs,
> please do that as recommended multiple times before.
> 

While the average desktop or server **general purpose** Linux
distribution uses an initramfs, often generated dynamically on the
target system during installation or kernel updates, this is NOT how
things are working in the embedded Linux world and for OpenWrt
specifically.

For the OpenWrt community, the great thing is that the Linux Kernel, and
even an identical userland can run on embedded devices with as little as
8 megabytes of NOR flash as well as on much more resourceful systems
with large a eMMC or even NVMe disks, but almost always just exactly one
single non-volatile storage device. All of those devices come without
complex boot firmware, so no ACPI, no UEFI, ... just U-Boot and a DT
blob which gets glued to the kernel in one way or another. And it would
of course be nice if they would all wake up with correct MAC addresses
and working WiFi, even if they come with larger (typically
block-oriented) storage. In terms of hardware such boards are often just
two or three IC packages: SoC (sometimes including RAM) and some sort
of non-volatile memory big enough to store a Linux-based firmware,
factory data (MAC addresses, WiFI calibration, serial number) and
user settings.

The same Linux Kernel source tree is also used to build kernels running
on countless large servers (and comparingly small number of desktop
systems) with complex (proprietary) boot firmware and typically a hand
full of flashes and EEPROMs on the motherboard alone. On such systems,
Ethernet NICs are dedicated chips or even PCIe cards with sometimes
even dedicated EEPROMs storing their MAC addresses. Or virtual machines
having the host taking care of all of that.

Coexistance of all those different scales, without forcing the ways of
large systems onto the small ones (and vice versa) has been a huge
strength in my opinion.

When it comes to the small (sub $100, often much less) boards for
plastic-case network appliances such as routers and access points, often
times the exact same board can be bought either with on-board SPI-NAND
(used with UBI) or an eMMC. Of course, the vendors keep things as
similar as possible, so the layout used for the NVMEM bits is often
identical, just that in one case those (typically less than a memory
page full of) bits are stored on an MTD partition or directly inside a
UBI volume, and in the other case they are stored either at a fixed
offset on the mmcblk0boot[01] device or inside a GPT partition. This is
just how reality for this class of devices already looks like today.
In previous iterations of the series I've provided multiple examples of
mainstream device vendors (Adtran, ASUS, GL.iNet, ...) to illustrate
that.

Hence I fail to understand why different rules should apply for block
devices than for EEPROMs, e-fuses, raw or SPI-connected NOR or NAND
flashes, or UBI. Especially as this is about something completely
optional, and disabled by default.

Effectively, if an interface to reference and access block-oriented
storage devices as NVMEM providers in the same way as MTD, UBI, ... is
rejected by the Linux kernel, it just means we will have to carry that
as a downstream patch in OpenWrt in order to support those devices in a
decent way. Generating a device-specific initramfs for each and every
device would not be decent imho. Carrying information about all devices
in the filesystem used on every device is also not decent. Our goal is
exactly to get rid of the board-specific switch-case Shell script
madness in userspace instead of having more of it...

Traversing DT in userspace (via /sys/firmware/) would of course be
possible, but it's often simply too late (ie. after rootfs has been
mounted, and that includes initramfs) for many use-cases (eg. nfsroot),
and it would be a redundant implementation of things which are already
implemented in the kernel. We don't like to repeat ourselves, nor do we
like to deal with board-specific details in userland.

Having a complex do-it-all initramfs like on the common x86-centric
desktop or server distribution is also not an option, it would never fit
into the storage of lower-end devices with only a few megabytes of NOR
flash. You'd need two copies of libc and busybox (one in initramfs and
one in the actual rootfs), and even the extreme case of a single static
ELF binary used as initrd would still occupy hundreds of kilobytes of
storage, and be a hell to maintain. If that sounds like very little to
you, that means you haven't been dealing with that class of devices.


Thank you for your consideration


Daniel
