Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A013C873E
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874044; cv=pass; b=aWdyYOB8Syo/v87cJPYtTRC5kt2oCDNyUi2CKJjFiu6ffobJSTRo6AndF/c1z9HLeImDr6UVS5Y4t5JsCU8wXhljZ5V2Nrbu71mREGOs7+Ia3fq/N117iWOphrHeEkKXLdtkrIVTEVGH3kxhE+01jyYoUCbrWt+cqOb+7DnVA+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874044; c=relaxed/simple;
	bh=sLcNQjSC7i8H0jUM4KuanVuGfpY/m7dUY3XjEdUZjSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qObPvNSuQ5XiZPAMk12uXzeslrpZVpXgwcUqi3ZXNh5tWK6kQn6pVYTeh91IpCFDDK8K7OiWhbUsbjfyjKO5iEiE3TyR55fqXg6N71BU7Fy7F76etI5bdpjA+gy2M14qQak/tpIj8Ob9bJ4N0Fmh0LPyyLo7VshjHdK8HwW8ywM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Etq7jqla; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Etq7jqla"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732165d1eso6060655c88.1
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 05:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774874042; cv=none;
        d=google.com; s=arc-20240605;
        b=D/tsvaanNrG3BgdfVXcD6/YXUx4pgt7SxLxOpH5Z+QLtlJWxJ0UsfaHRBjMCgME9xX
         jELKrY3SQZnZCFbu1gj+aRoHm37rz1W2HfmjpuUM7Dahu6O3XdYUWXy+Bcgh4H6SGtph
         j1eqi6QvmxvubTr20jvp/aOZRKnQyLYsdMzEj4XU4lMtGj5bJA7wJKPCjDb0gtXZEOSa
         DsxYNyB6VDjfAUbGSV81E6BWsuv3FCx+Y2FKFjes9dRFN8fRyiUmA9nqdsNSiXJtk4H1
         tkUd4y8t0MILleHOewjG2igmFisFq5dG1zhTls3XCEJOSagIY2RlgEIOwIZswxZcOpv5
         9QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sLcNQjSC7i8H0jUM4KuanVuGfpY/m7dUY3XjEdUZjSU=;
        fh=bUvef1VU8UxRwwMvqN57zvLtdhIl1JUXiiipAJNB5d8=;
        b=Fo42pBrH+8L1+oOA7UsTqM8StqXYFEux2t/5HkgoCBKPHhXCwtsl72q4N/xphj92n4
         2gHO5/ZQcFLawHoM8eBdKUY3ZzBXEeSdS8/Igu4E26M6C98k6Exp/koJkdZEkCWHN4SL
         PVnmHjmhzpUWzSWPv2YPmoaGr37XfiC7B/h3/y/O5N3oM9UXNqu14OydW2f39UAIoOHb
         C4ELi1GRvtzV5R6iTGaIpVtxD4e2iHI8hvrNMtdnu/Rg7phWjIaPJz6MvlWN0ECTbP19
         1bgsaEk29ZL7zmkJw0GlzJAIA6KQ43HzibcfDo6yyHemDvaIBokDxd+7Xzg5lQZR51wk
         rpUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774874042; x=1775478842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sLcNQjSC7i8H0jUM4KuanVuGfpY/m7dUY3XjEdUZjSU=;
        b=Etq7jqlankV0tSByA3Pu93SQ/015iFchdwkXFOp3/MrgzsfMyb3pw5OR+yCOeDdITc
         EzkjMKsmbxHd51OxCpEzf2d5f5TVFDRf5TRGjUuQSLf/D38c7tabcBdEkvR+XItHOvqC
         t17WhUJZWuiDbjUrfDzf7QAX9oyocC2exCYZqExYUEQkK21kNDc1k1ENpMAbwD5Uy0ax
         vikCcEYC0aZ4HD2pUe3aJY0q0AdRjTMrjzRSlJ00yoa4EwcAk47kqV/QodQIW/InDczq
         M9Qy5ruZX2E6TbzUXUIq5O7pvuhDjoXXRLEMAOq8gFs6usjDKGuHFeapGare+OrASKRT
         OnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874042; x=1775478842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLcNQjSC7i8H0jUM4KuanVuGfpY/m7dUY3XjEdUZjSU=;
        b=VifyGEL/N+HZgvibktlOvzE5E6ral+NMY9c0gOYsvIINMcITi4zGgZYJ0ECIyEB3fb
         KuXZnPzmUcol7ZQaaDsa1FIajHeE44/Uu1QMXajZ6kGh1XwH4lhJJ3WApsbgdv85Zu63
         1hwT5GyfrefsQ/GSXGN/bA/D/iUikvUd8brE3dsdXxUju+FxdUzz65f2JKP7zVprkbSc
         nZBAro7EDqePM+9Mq/i8Yy0G8N1owIPcEb0m/BCr+D9CMOachOC20VAC6v6sZ3y6s5sq
         lbKqa87a+YpxeTehbra2XCpG7WbFTKMwdshScz70sLGbrR5cwQvn0hPVmW4J71N5wcxc
         19oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpgVAYHT8A7Y3TtiJsszgV8z5+WHRKq60TlV3397ejEiKKF56nc2zVsWvFBe6UNzQepVo9nV4E00RDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLDx2ob0P2LAGUNHE4hsBdfArxxntKVxX7crhopuj56Tunew+
	kx1/ihilWHxg7kdsFL10Y2qaoA+elwUzGBsF1i/B0TzRue251nXOZlm7PBBlbqYQwDZoFaSYFBI
	dEOdJEhcbou+ZX7T8kVYBrV7vxnrKmQUnkadwoPjr
X-Gm-Gg: ATEYQzysyj5e96V/5uh/iLCcp7HPi6ZYa19P4A4OGrAdfkQf4f9GZr5VGXgc8Smk9/Q
	WcHd1fyjI82vfsBINFi5Xamx2hFKe5ZRFVgtTkXeqVHQvVq2qxhBHm0U2dZeTkiTwuJbCS+yA2j
	iE62fiT/iG6in5fKhsWAV5NpPJnIGuaaYe1HpZWjBNsaoQiDVj259RAysgGsl0g7Q/S0Eh0TQbr
	mhoooxpGoDMTYygofrJjU7M9lAXjITVw0ZC+ZIfeX5Tb/6bTDxgNDO5IuGwYnJ9uHrbRIroMkz1
	ULLcV2LqoSUws9W/Xg2Zp7ws+TPabAyq/8boAA==
X-Received: by 2002:a05:7022:2387:b0:12a:6c4b:9d1b with SMTP id
 a92af1059eb24-12ab28ec9aamr5905693c88.31.1774874041678; Mon, 30 Mar 2026
 05:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-3-bvanassche@acm.org>
 <20260326062507.GC24071@lst.de> <16074463-9242-4c62-877c-54b0939ab892@acm.org>
 <CANpmjNMiR2_s7iyXAT_nOdy+EhxR-oSf_KR089L_66d13JidCQ@mail.gmail.com> <37e0a051-8bc9-4af7-8ad2-8b52784897d9@acm.org>
In-Reply-To: <37e0a051-8bc9-4af7-8ad2-8b52784897d9@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 30 Mar 2026 14:33:25 +0200
X-Gm-Features: AQROBzB85Xf7IGSfMWv7Os_BBJgtcPfVlTZqPlf9OK3cWDs9YZucSj0lK1Edkvk
Message-ID: <CANpmjNPEdPm8me3KMpe+KFTWnzSivOE=vo47VRsbNx6byuZ9kg@mail.gmail.com>
Subject: Re: [PATCH v2 02/26] block: Annotate the block device functions
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 19:28, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/27/26 11:17 AM, Marco Elver wrote:
> > No that's not supported (yet). There are various design options, each
> > with their own pros/cons: the one question is if attributes should
> > behave more like type qualifiers in this case (enforces functions to
> > match), or just be a best-effort thing (functions may not match
> > function pointer).
>
> It would be great if lock context annotations would be integrated in the
> function pointer type because today these annotations are lost if one
> function pointer is assigned to a function pointer variable.
>
> Maybe there is something that I'm overlooking?

The system was designed with attributes (for optionality).
Changing it to treat attributes more like type qualifiers will beg the
question: "why not make it a real type qualifier?" from the Clang
maintainers. And getting that right is very tricky, as it's a
fundamental and rather intrusive change.
I can explore the attribute based design, but if that's rejected, I
think we'll have to leave it at that for now.
