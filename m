Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E81DB124;
	Tue, 20 May 2025 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721411; cv=none; b=uoh1Zw4SHIfRKMOP2mA6622PZMUP5KdyKdB1A12/DNtULLCQ1xGNqYPKN3TFtnxaX7fyTBYPeekjuW0ofcgv2Q96mCiOpl5Nj/jHHnisM5tiLA4z7Beffg212DArCaMqDGDo9uO2+zp2gaqq1/aCPrnEDHdcG+YkqSNox6U06DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721411; c=relaxed/simple;
	bh=3inkbt8TL1lFoRCu53H4E/rxKOPuy4Fw9iBX9yfI1EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uryXOx+GTEr4IhThQkt9u3Cr+8csa1QPZOxjp2vPeRPvfdKV8ZVsgzwXJmjvAbmI39T+cJ36Rjy1rVU+qJxitE8ZkJh8po05p/wHVNEAvvrSfZaKfQAnzvk5lAIX5BV+ukV9GFYw6hThm3hxZW4eg6NtqhXq8Dn+68Wfzmjrtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IuofMIoD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IuofMIoD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G7Kx0ZtWsfXqw30Vxg8hLBL8MP5DK1Zph4yxRDD3jAc=; b=IuofMIoDA6/GxCoqUO+bj/xGM9
	/YzUYj2Dm9Xkdu92t6jcUkeX/gyoGdKcpsmBoTttu+WEzuF7rr4eoBQLA5CopLnsVG4gUd3epTFN2
	iT0q5MDt5QKDnxp3HEZShGLpOiR1oVvAflWmSYT+/5QzFzaHxiWcfnpifZUOivkWzcVVKHeU7FSqi
	Ve2jA6iXN888dRQcH0RvE2bfMR1a31gCX6FZekP6gPjAACpTzpg+5MHhA+MQLQxdYz/fnK3C1FsGs
	0CazuZXoc/hOBGvOpkeL4g71qsRkOdXII0wLvEtu9VnqhFhnNFNAKyJYMiHB5Umpyy2ikl/zfdZHA
	9eNdLXwg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uHGAv-00GASm-Et; Tue, 20 May 2025 06:10:06 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 929F3BE2DE0; Tue, 20 May 2025 08:10:04 +0200 (CEST)
Date: Tue, 20 May 2025 08:10:04 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: 1106070@bugs.debian.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
Message-ID: <aCwcvC4KBu6j4Dqz@eldamar.lan>
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
 <aCwZy6leWNvr7EMd@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCwZy6leWNvr7EMd@eldamar.lan>
X-Debian-User: carnil

On Tue, May 20, 2025 at 07:57:31AM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> In Debian Roland Clobus reported a regression with setting up loop
> devices from a backing squashfs file lying on read-only mounted target
> directory from a iso.
> 
> The original report is at:
> https://bugs.debian.org/1106070
> 
> Quoting the report:
> 
> On Mon, May 19, 2025 at 12:15:10PM +0200, Roland Clobus wrote:
> > Package: linux-image-6.12.29-amd64
> > Version: 6.12.29-1
> > Severity: important
> > X-Debbugs-Cc: debian-amd64@lists.debian.org
> > User: debian-amd64@lists.debian.org
> > Usertags: amd64
> > X-Debbugs-Cc: phil@hands.com
> > User: debian-qa@lists.debian.org
> > Usertags: openqa
> > X-Debbugs-Cc: debian-boot
> > 
> > Hello maintainers of the kernel,
> > 
> > The new kernel (6.12.29) has a modified behaviour (compared to 6.12.27) for
> > the loop device.
> > 
> > This causes the Debian live images (for sid) to fail to boot.
> > 
> > The change happened between 20250518T201633Z and 20250519T021902Z, which
> > matches the upload of 6.12.29 (https://tracker.debian.org/news/1646619/accepted-linux-signed-amd64-612291-source-into-unstable/)
> > at 20250518T230426Z.
> > 
> > To reproduce:
> > * Download the daily live image from https://openqa.debian.net/tests/396941/asset/iso/smallest-build_sid_20250519T021902Z.iso
> > * Boot into the live image (the first boot option)
> > * Result: an initramfs shell (instead of a live system) -> FAIL
> > * Try: `losetup -r /dev/loop1 /run/live/medium/live/filesystem.squashfs`
> > * Result: `failed to set up loop device: invalid argument` -> FAIL
> > * Try: `cp /run/live/medium/live/filesystem.squashfs /`
> > * Try: `losetup -r /dev/loop2 /filesystem.squashfs`
> > * Result: `loop2: detected capacity change from 0 to 1460312` -> PASS
> > 
> > It appears that the loopback device cannot be used any more with the mount
> > /run/live/medium (which is on /dev/sr0).
> > 
> > I've verified: the md5sum of the squashfs file is OK.
> > 
> > The newer kernel is not in trixie yet.
> > 
> > With kind regards,
> > Roland Clobus
> 
> A short reproducer is as follows:
> 
> iso="netinst.iso"
> url="https://openqa.debian.net/tests/396941/asset/iso/smallest-build_sid_20250519T021902Z.iso"
> if [ ! -e "${iso}" ]; then
>         wget "${url}" -O "${iso}"
> fi
> mountdir="$(mktemp -d)"
> mount -v "./${iso}" "${mountdir}"
> losetup -v -r -f "${mountdir}/live/filesystem.squashfs"
> loosetup -l
> 
> resulting in:
> 
> mount: /tmp/tmp.HgbNe7ek3h: WARNING: source write-protected, mounted read-only.
> mount: /dev/loop0 mounted on /tmp/tmp.HgbNe7ek3h.
> losetup: /tmp/tmp.HgbNe7ek3h/live/filesystem.squashfs: failed to set up loop device: Invalid argument
> NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE         DIO LOG-SEC
> /dev/loop0         0      0         1  0 /root/netinst.iso   0     512
> 
> Reverting 184b147b9f7f ("loop: Add sanity check for read/write_iter")
> on top of 6.12.29 fixes the issue:
> 
> mount: /tmp/tmp.ACkkdCdYvB: WARNING: source write-protected, mounted read-only.
> mount: /dev/loop0 mounted on /tmp/tmp.ACkkdCdYvB.
> NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                                    DIO LOG-SEC
> /dev/loop1         0      0         0  1 /tmp/tmp.ACkkdCdYvB/live/filesystem.squashfs   0     512
> /dev/loop0         0      0         1  0 /root/netinst.iso                              0     512
> 
> For completeness, netinst.iso is a iso9660 fstype with mount options
> "ro,relatime,nojoliet,check=s,map=n,blocksize=2048,iocharset=utf8".
> 
> #regzbot introduced: 184b147b9f7f
> #regzbot link: https://bugs.debian.org/1106070

Just tested: The regression exists as well in 6.15-rc7 so it is not
specific to the stable 6.12.y update.

Regards,
Salvatore
