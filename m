Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=z+alGSBkC+HYLbmYn8uvBb0xRD0OrOOZs6j5qxmA0DfMakTzcr37I1fev7Yo+8o0mMxP
	 fgvpDgwd5waaODfnsrpdwc3/FQrWQKONb6AzhUD2vclW041g4MIPS/R3JDVVE0LbmvTwI
	 5PJDtbXFJ1ie1Ic3QYEXt9/6+wufH7NLYzG/91y1tUsplqBOomk4QTSzRn7SUOTTN9XeE
	 KsYee0s3G/CzFsGi9jX20+dYo3SQ4K4PzjOMFxAAC0tX4iV0p0HM+nfomtjoA1hRHWURr
	 uRELjtHnaradlEXnzdZiFxdSt+DPJLWafwzdB488+UrTfqGO7wBNmWbkXqCzXRTPrvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=aThotqWxygBXQ96A7exdWdwexk8TWPdQ1K10iRHRw60LNpAeiZjs4Kp7chTqFWHcvqeM
	 aRzygen1gRHTL2uxfpN/spE88n4MKHL34zvM2E06tL73U8OIc1EtzVm98e/aXBiAy5O5R
	 GAfDEq6zyZVlAUzUbKiehLGIVcyGQPcSikhzKLNmKww2B4czOin89VAlFc2lsgOFcICMA
	 20FyIDSwhQgP1JEx2bQPVWWddXsnnaXXmyYnkpDSBmp7JO+Gqr3+q3ryhxPWmjlBtCPeA
	 siBVOX24O964rjzGR/YiRAUBia7qDPBJOnqU14/iye+/V3Z+QmviMos3hclCgUwyW8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADB606A332
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8ADB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so3771027a12.0
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=aqtchPERRZjhrsaSMz7SMe0FBRVGkxPgOWZF5je+4v+xNBjhUTkYLVgrLwb2uqtY09
         946RfX2xdVQeVsKrYlo2GEB8J4W+RStOJ/8UmJL27TUXz/88A11D0roDmdzSio9pJJfj
         9Ocjng72IBmwpts/xaofwgvwt/Jz88NiZAkvkAhjMU8fWe+u9jYCSrf6eKJYS7Y6ZOUL
         zNOS3uGw7hZrSF5lia6ADXbqersCPCWYISGSkLEoCuGLjRELG7YQsvw4cQLhlFWXxGlF
         IrWzKd8MSRkA+WZgfsQdrOcrck3Y35MwmIUbIJFXXIbzSuLewCEgyyX+WecOXsCtQEKf
         mwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=4/QJPIZMsWrh8ww9olFshRCVNYb8GoDqVz/NBhqD9xI=;
        b=rcE5tadiRe5EStBr53Mm11qBfZDBDiBch1sVohdvXUI/6rxUOfQt6+FS1eUwtxoGkv
         iF3uORRZlc8gUx9lyrxIg7bESCH/uEfaD8R04dbgYG89Wd8W/cLA3b6/YKXojFAPsw6J
         YcWbNyX9ER3pXWiYeejlUHhgB/k74cyXVZNht9wsBr4fIDY/OeWxVl2xJZRbtyyRmYs7
         juvdCHOrN75oJNTX29AlJEE18e3n96dy8F8UGP6waeRH0UV452hnBIIsoo85Fa0iKH2d
         mhrfH0YR+DIr+IQ1LX0l6F8zxUeNVnUzPVKHI/DdcI6QhjLm6wcLZv1s/R2uIZM8UpPL
         BLIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=sFtf+83CITRRT6pimbQIgjZrvCBl3JRJ3ixuihR5VJdYAqOQ+2HbBBoWgobM6xrXCY
         lCro+tppvhqnQwGz6Tx1fCqgdbuhZaO9wCZi0flj/JiUKt4AN8SzNp9LK25ZZ4RiAnLs
         1M3RZSo7KKj0afIj49fG/RaHapQE4eYsB/7YonqJAtpW0mA1CT+1sy1SVgwRqNAsAOsd
         /rUGt+ce8phyD4kKzWCqU0lbH5pbHDGVbbGo+F2fu2ApaAKhCt/u/ni2yyhF+ifguHLE
         W1DpMeYsES2hiM10baZ+qyMy54SCZDKImfWPZuOLHGh4ggVD0Qhho2L5oCoVA+F1yiRf
         27bQ==
X-Forwarded-Encrypted: i=1; AL+hErEUxGYzxb4ASgfY04t401+3tntTistKf2s6/JLdiKyDY7fzUxLIhlnqfBGNVd1dDDzjMnAFpr/2GabYIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+F7V2NI+t5KcZ/tew1ybgonz9DFCKH1YWFEBySeDUKGHz6llFh
	uXECYxisrN1ZRvqqyFzI4qFqpfKjQLIR8XqM3gaydcY8Z2ynaMZofKnRIY6bvsUTEIMlVW7fD9j
	gVpXvhf49+z7+11WxE+n4JZ2pGW/NsaE=
X-Gm-Gg: AYBFou3mw4Vs3g0VRKWuagf4AikqAGcCqtNLk+RajhLuAup6ugYQl+7k9O8ykNuiut9
	xC2nJbMkVWzBe/nIazb8a/oJrZ6NJLFrFRMvgjiGvto2K7NSzUOjWyWWTBk3qiBJ2jA4bJWy6p3
	+lAQ0NnGqFVPlKcWVqY5IfN6pSnvbOllBRlpzySKD9uxn9W0gdefdypd3V26fSB2tNWfsleVOSS
	+2bTXF+XwEIBfLf/cv9xNKrExORVLcJ9h59TGUIXD1e6SV4SmMBm2VlrgZCXKKR61dmLjHux2i/
	YsVmGVTGe6bvC5Aeqy/TeZkxfZkeFNXaOoVcwyGiL0jNIpsZ39hnE9kANeCiQlX8jtCX9PDsNoV
	kD4PcyI+ekQiGX1mRyj/sZ9zHLkcYXprnZzRyooO/0SDxXPeaKHy/ynOAqCDweswTzdMn1g==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
