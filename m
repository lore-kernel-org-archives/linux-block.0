Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E022D8391
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235288; cv=none; b=J6n3WvrtqNA4BllKZgsCtQ+B4EhvzYgFx3w/cfDM/gSofYtfpi0e1kUwD2oXgJfpzPU4QWi9iINfkNNBS0/wi3WnwSCEHlt7108CEIBxUkHTBI2I0RG80yeFWYSuZb/y92EEBEvso0puFTcEZgTZ6deYhS1JoYh+RZa2b8bdGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235288; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEiTtQH/lSyeSSsLJ6jfr3cc1Z4BoQX1CTa/4lHWK20b7np8DlwTIAQmslcXjDhdpdsOus4ua3TMuxLmgrc+rTbG8tVxGpdmC6yOJFCxWPXqEDxu1wYBaYOFkUbMagLtcjeMst7vtVQUiTGGXM8EEWLI7ZZvwljIaPeGtqn6eFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5675d609621so11790674e0c.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 06:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235286; x=1773840086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=reOTzc2i0+Qb3OVSqrLwT2fc4YPW3jb7RHcYw+bPDP+sromK5Klf6P5S6e10abTkeZ
         ICE17TT35/fu4kSb3TCzmt6XDlI7o3/gCGZUqt+NFi01j66n9+o73N1TgE8FOxYrrNmY
         eCNVTq9KVFfMTSmFynXePh4TjUEpDpPc/Jit0FmJ1vWdOVJgSMFDIOyVIWXQy3loetHx
         vU1VuR3c5lnF50KAfjvrH+9y+o6RxUXNuHnh+75ijJEnBA6H1EonYNQqwwLeOvzlgH0y
         YzIIJLYID+7w2DC8jcjMdwdo//Dy3d7nPwGJDJonjXFBNO1deDsXSmp284yCOxbXiYf/
         E9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXeeYisuLn3sY9MmByv+WvDoOMhuaO2/TypDUJA6Y/QAEOVKcWwtFTcgOTjwO9PUwhxQHn1y9cNL/9IVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysgA4lFUg9TSQH6V5SdgwYvRwCmnZNSsBt66UQ0fnF1+ly4RAb
	ra1lPcXdz+FSkYp3EeSbfxKcet/gzWauakjKeDwyLq0Qt7ISJFRhy0FLcKUmb58qTQ4=
X-Gm-Gg: ATEYQzyr9rby6jDLkqXtoGcXq2w2/vDqZ1ancE8EMutJpSCilEunLwS+rX7VknBd2Hd
	jbnTbjdg60Fb7bGZZ+AmMJHCAZvN0ZXacBMJywK5HySwttR32h9mnn8r3NYhsxjsZeFJ0S5E7So
	+4MpTKa3gkgLnm4bnCQrkzlD9X5oT4Zd9cJYqD59co4hYFA2JiTcsI8xrclLqv0Vs6HQiFNvjtu
	lo5XaDkQOtBbr/3zLFW3myvN4w8qIIMisBebGBn2mChRBL1XiOUEM6ccAA6+fdCuFGS4Va+0gl/
	3s+OYLWhoXxkPTg/T2YZCa3iC3Qukx90RwZFM8o5oBlwJCEjE187W6HN7B8OrfgW82xERYSFDMV
	aH0+/7K07itG7vlVMGrv3svg4j0lipcBzNH0Lu0LK/hOEQexm1vDneXvxuuCub8rBSoURcah/1s
	88+s+TYE7eJPrJzna2aT9lrB1qheXwmUaZLBTMjwHWkc/lB1wQr+Ovb5Qbt2NM
X-Received: by 2002:a05:6122:6090:b0:566:354d:9f4a with SMTP id 71dfb90a1353d-56b47448dfdmr920514e0c.1.1773235286258;
        Wed, 11 Mar 2026 06:21:26 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecff71a40sm529187241.13.2026.03.11.06.21.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:21:26 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffa277c115so4957519137.3
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 06:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyRqnpUhocJY6+4zQWEO7klDSwfLqKW3te4I025qwl54twUonsrKR40YDEG6Nim2WsuHwMPNmPdrOe5A==@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
