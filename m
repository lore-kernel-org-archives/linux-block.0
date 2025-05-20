Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71252580CB;
	Tue, 20 May 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722690; cv=none; b=qrFwxDsdFQyPYGBJrr8Nbp3J65bWFoPYOb0qgIBnY1YUPx920ysNzsyNIsoXCXaH36mlt90jX/LV/RjDDfWFz+v55cpGV3DdZe4NTXvZEB7coawBahiIE5OYlgB7PDX/RSOgJzcFz86IZ/cq4kq+slqS9U75E5BPR1X+kAWFj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722690; c=relaxed/simple;
	bh=Re+lidTtgn4qNd1zwUVxIaWwVsiZIZkKB59dSI0Tn3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhuDMLRSj4JAa/FVPeXDB8tvo1MaC8Q56md/q5Jf+eQPIkhM6mi/pEi0LspHk9z7AE9zIOlteVZ+bCdES2cJOs3uGajrOrs4Lo9j7yEzjbsCxCOnrBsiXFCKhjhtW3Ou+Ln2UXxQClVzFSq019Oy9XwL1BEat5K2cGp0UOd3X+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=J0HOUDM5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="J0HOUDM5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zOaRJ94Fm6w3ZOR6xqIqJ3OCL7WUo+919zCPbZH0zlw=; b=J0HOUDM5EP9FAFa1K3OyU4NgIL
	i4b2Rk5wITFjxQMu1VzjVNZDvLv+pOoaHadSgN9oIwcG7RfPgv0vr4LY2fbeMwADttJaiS0GKnz1d
	ej66NVBEe/XLYHjdSkLDG/iOCcBp6J1j6iHbojbQrVUBSo0Lz2QSIL03Xow9kgGS4EhkRaJL0WWBT
	uBvgYUg7X2kbkVxNIYYmtnDQj+TSk/5DEItjGRaWFmJVf/qesBHYPrcV+QXtqavjWTQ8iyH8Iic8b
	2AetF373Rh+Nha5peIV8j/EZZ7xvzXuugv9pF0p0zxh6OIuB03LFESJpwXPs5TbuaJu0ae3NhJ0im
	cbtjak7w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uHFym-00GA08-6O; Tue, 20 May 2025 05:57:32 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0B758BE2DE0; Tue, 20 May 2025 07:57:31 +0200 (CEST)
Date: Tue, 20 May 2025 07:57:31 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: 1106070@bugs.debian.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [6.12.y regression] loosetup: failed to set up loop device: Invalid
 argument after 184b147b9f7f ("loop: Add sanity check for read/write_iter")
Message-ID: <aCwZy6leWNvr7EMd@eldamar.lan>
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
X-Debian-User: carnil

Hi

In Debian Roland Clobus reported a regression with setting up loop
devices from a backing squashfs file lying on read-only mounted target
directory from a iso.

The original report is at:
https://bugs.debian.org/1106070

Quoting the report:

On Mon, May 19, 2025 at 12:15:10PM +0200, Roland Clobus wrote:
> Package: linux-image-6.12.29-amd64
> Version: 6.12.29-1
> Severity: important
> X-Debbugs-Cc: debian-amd64@lists.debian.org
> User: debian-amd64@lists.debian.org
> Usertags: amd64
> X-Debbugs-Cc: phil@hands.com
> User: debian-qa@lists.debian.org
> Usertags: openqa
> X-Debbugs-Cc: debian-boot
> 
> Hello maintainers of the kernel,
> 
> The new kernel (6.12.29) has a modified behaviour (compared to 6.12.27) for
> the loop device.
> 
> This causes the Debian live images (for sid) to fail to boot.
> 
> The change happened between 20250518T201633Z and 20250519T021902Z, which
> matches the upload of 6.12.29 (https://tracker.debian.org/news/1646619/accepted-linux-signed-amd64-612291-source-into-unstable/)
> at 20250518T230426Z.
> 
> To reproduce:
> * Download the daily live image from https://openqa.debian.net/tests/396941/asset/iso/smallest-build_sid_20250519T021902Z.iso
> * Boot into the live image (the first boot option)
> * Result: an initramfs shell (instead of a live system) -> FAIL
> * Try: `losetup -r /dev/loop1 /run/live/medium/live/filesystem.squashfs`
> * Result: `failed to set up loop device: invalid argument` -> FAIL
> * Try: `cp /run/live/medium/live/filesystem.squashfs /`
> * Try: `losetup -r /dev/loop2 /filesystem.squashfs`
> * Result: `loop2: detected capacity change from 0 to 1460312` -> PASS
> 
> It appears that the loopback device cannot be used any more with the mount
> /run/live/medium (which is on /dev/sr0).
> 
> I've verified: the md5sum of the squashfs file is OK.
> 
> The newer kernel is not in trixie yet.
> 
> With kind regards,
> Roland Clobus

A short reproducer is as follows:

iso="netinst.iso"
url="https://openqa.debian.net/tests/396941/asset/iso/smallest-build_sid_20250519T021902Z.iso"
if [ ! -e "${iso}" ]; then
        wget "${url}" -O "${iso}"
fi
mountdir="$(mktemp -d)"
mount -v "./${iso}" "${mountdir}"
losetup -v -r -f "${mountdir}/live/filesystem.squashfs"
loosetup -l

resulting in:

mount: /tmp/tmp.HgbNe7ek3h: WARNING: source write-protected, mounted read-only.
mount: /dev/loop0 mounted on /tmp/tmp.HgbNe7ek3h.
losetup: /tmp/tmp.HgbNe7ek3h/live/filesystem.squashfs: failed to set up loop device: Invalid argument
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE         DIO LOG-SEC
/dev/loop0         0      0         1  0 /root/netinst.iso   0     512

Reverting 184b147b9f7f ("loop: Add sanity check for read/write_iter")
on top of 6.12.29 fixes the issue:

mount: /tmp/tmp.ACkkdCdYvB: WARNING: source write-protected, mounted read-only.
mount: /dev/loop0 mounted on /tmp/tmp.ACkkdCdYvB.
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                                    DIO LOG-SEC
/dev/loop1         0      0         0  1 /tmp/tmp.ACkkdCdYvB/live/filesystem.squashfs   0     512
/dev/loop0         0      0         1  0 /root/netinst.iso                              0     512

For completeness, netinst.iso is a iso9660 fstype with mount options
"ro,relatime,nojoliet,check=s,map=n,blocksize=2048,iocharset=utf8".

#regzbot introduced: 184b147b9f7f
#regzbot link: https://bugs.debian.org/1106070

Regards,
Salvatore
