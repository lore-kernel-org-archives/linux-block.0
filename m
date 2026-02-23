Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42E30BF68
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864949; cv=pass; b=WdvORT1XOgM10cKdxUNfT+/AfGv2JV4urgQE+34Oi2IwGMY6KDuvrPeXc54vVGd0nhNf9ODr9UFUkHkussAyZN3y4/Z2DrekumFVxp1mFM1MQ5A9/MYRnJzLlxNlVNK8VBLVRa69pw3p4TGMgTR9AbYTfXy/wS6Mfz4RDrs1AJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864949; c=relaxed/simple;
	bh=yEgogbxdpEiqMpzP98EetmT1KLhxxN+nc2beoGOHgAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYeMX5xPi5NSIWZk7vJwtzeaDi82AlxYBW6YndbdpOyTe+llGSXQsLfzmCBvgc6UbJYE9fKtKb1brCkGPjq3TyRVrwqwo4CSo/iLC5WmmTAWG0/OqiYiQ4fnTWVdy1YUotBsA0mgBeWZEexnA5xwBTJwV4H1kACMBqPOj/Y68OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JTGOYh5H; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JTGOYh5H"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a1faf828bso220456a12.2
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 08:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771864943; cv=none;
        d=google.com; s=arc-20240605;
        b=PtjGhIonpcX9LPKSVvuf88k5/z1KCI9zX8sh0NZRlN39Rg9qHcGrOWvHPH6TlcQd0Y
         iJfO/qu+FBeiL8UItd2zW7L/Hn7f6FRtqQXzTeSzR+FsB4LL+2/SfOrG7KIb5NsrsrCm
         7XagcWOBbzhs7b8s134o9uNb30ma3zV9+ZKWWv6PanBe0T8ZOILm851p09z3ZrjH8jg4
         cgCM3ZXjosxaw/+dkr/3oglo2OwhxW783Fi7pmBsShqAUffpeF6IqN15Kc/A4l4K2rpA
         4Lmrdfk05soCz5V2y6dyOj/VhEmFztFtNdWK21FDwW6FIfAR+Fun85kELki0u9Kutv4V
         JVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDWSQURJv5trZ1dQDtLNi7ca62o3TpYDmqefD3Oq55M=;
        fh=BbW6CDiBH8eZZ5MG6g12prrXlC+9ZMGeoKs3o3GzoMM=;
        b=eiPkBJjTrd/tCjf6frVRXJkCwjoPd9Pfi/Xv3ZWIIJ6HtKXCaP8e1SztYFTClAzZOO
         UWf6kyYEmVWopCFtiiekZmDxm+yHD9sz3Q6xnvtqJMRgB8L6i5gisev7l7+HVLvpASjj
         jj8vE+tmQ3GYuxMcxyJvb1FWNY8Pxr65Ddzyuk+gnkURfPJF06E39EV0IDcgJddZ3CuT
         vhUkqIREDVXMa7vxzVu8JQJij6pC0cmuSenY7pQi0OT3uBPhwsxk8WO61GnCspWCv0K6
         BPBt2e0WnKuTgahOcxDzTuevQATBFVf7/YeHc4jZApvBo+MsSUCEpOx58rl4KQz6k4gk
         J5kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771864943; x=1772469743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDWSQURJv5trZ1dQDtLNi7ca62o3TpYDmqefD3Oq55M=;
        b=JTGOYh5HJaujCcschE8gl+UFgI4qvEIAFHTgHjA6bagnC2IBvlFgCqAgFaFTk00zCn
         9V01R27k2G0ohUEAa15F8cMabkMlPosxy87lt0MIPg3lYrPDMqqwiCGROBra3vm+xtlK
         fKCn14bvBrwEgt9ZucM1GHy4O2I4tT8dwJ3Gb3Ijea+8RjeKmZ5CSPhdYJgBOY1mV1Tu
         Plf/wcGovm1UoD6ADWzRZPtK8qg1wNLvPJPZ9YRgqs92snqoTXV7EpzI2tReQQhjij4f
         bHdpSd4JpPR0QVnMXh4QriKEv3ga7abQDATb/DxbjQlLinu/p1Fbg1lztjZ9mHr6aR5t
         ml7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864943; x=1772469743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDWSQURJv5trZ1dQDtLNi7ca62o3TpYDmqefD3Oq55M=;
        b=U3mScZ8NJJgR8DKEjnOId6OWFWxJJB5DYThiuK+kUa/I3Q1Wx8qXuSd1M6BIhPs78/
         R0qgUx2p2dYfTRL+qOLGlUJ4lq3gY6yFCa/v1khuKgFve1yMjtjZgZ7K4w3Hq66OUBpK
         S+RlyEXb3eqyx0G2yElIIBQOtXxP9lXooOLuftr4Ao55iwdfyVrPEJEwfB1SSPwtkDyu
         NKts6QzRkvCyTM8kPt50U56z32W9Haqq8hpWg0t7Zj8tTme9PHxZCBlBfoP6kv69gM+D
         P0xbuzYJr2x/5A9MW75/3rs2wQfWBZLhhKnbN/oyM7LQiXft4MsEclfBQIkPD9rkhXah
         R2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW9zTLr4UNuHLIohuqJk9V+ed1juCZG1rF1qtjdPwZwRcufv5PDlZMMIG7VuUUQFmEJvjdoglg49iaGqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9KFu1bpUK11Nk3kuLGE6jHzD0tuVIkHrHwHlbYuN+Rgsf/Yj
	tGUaUDMNa5wVLWP3skjaKOv+tbHJzwe9kZ8+ilAQ+qrYePGBPrzopU0LF5mA3ebZQp7HgwQ66G9
	eCRWR/qjVSumuOJxCm5jdvURd9K5PHFS5CgDopUF2qQ==
X-Gm-Gg: ATEYQzyw97OBp+uMWVcPlJew6RsF1i0j7tKi0YhgFac0pCD2z3uXuEFIhvD+AIT2c0h
	hL2lozNHDOAKMmuEhlk6Dro4cwDTSjb06llePdZ1lRowk6tulv5Y5XsTeEqAyiu0+qke2g5/+jJ
	IXjy/8njJChvoFlqmGlIsB/poBy0DWG9JQwPH7W+WoGTXuAl1f1r3nyA3XOZurfV9hP8yls8MS1
	kFn7UWKJgFYFttJ/iCh4/fqdnvtXV1KBB1WUeolaMKGugu5+sY7So17wz4347y3PHcbo3pdNGm/
	nyijKx63
X-Received: by 2002:aa7:c14a:0:b0:65b:a4f8:5d58 with SMTP id
 4fb4d7f45d1cf-65ea53fa916mr1887697a12.7.1771864942974; Mon, 23 Feb 2026
 08:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223121515.3296983-1-alex@zazolabs.com> <20260223121515.3296983-2-alex@zazolabs.com>
 <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com> <A21C344C-709D-4E28-B0C4-62946391D560@zazolabs.com>
In-Reply-To: <A21C344C-709D-4E28-B0C4-62946391D560@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Feb 2026 08:42:11 -0800
X-Gm-Features: AaiRm52jMaHl4prVbGkHKAHMT_5y0JxxxucB97s_xeWTQUE1MVHgvEBUet_bmso
Message-ID: <CADUfDZqy-wrUDW=Ka+v0sKA0MGrMyVjPNQwU0V0hwA0yMxUbKA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix UBLK_F_NO_AUTO_PART_SCAN
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:23=E2=80=AFAM Alexander Atanasov <alex@zazolabs.c=
om> wrote:
>
>
>
> > On 23 Feb 2026, at 17:59, Caleb Sander Mateos <csander@purestorage.com>=
 wrote:
> >
> > On Mon, Feb 23, 2026 at 4:17=E2=80=AFAM Alexander Atanasov <alex@zazola=
bs.com> wrote:
> >>
> >> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> >> as it tries to use it as a switch for the auto partition scan.
> >> To fully disable creation of partitions GENHD_FL_NO_PART must
> >> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
> >>
> >> Using the new flags rules for partitions become:
> >> - Unprivileged daemons - never scan partitions, they have
> >> GENHD_FL_NO_PART always set - they are devices without partitions.
> >>
> >> - Trusted daemons - by default have partitions disabled.
> >> Partitions can be enabled via UBLK_F_PARTITIONS flag and
> >> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag=
.
> >>
>
> [snip]
>
> >> Rework the code to work as described above:
> >> - remove checks in ublk_partition_scan_work and rely on
> >> the caller to schedule the work only if it has to be done.
> >> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_c=
md.h
> >> index a88876756805..467ecaa20ac1 100644
> >> --- a/include/uapi/linux/ublk_cmd.h
> >> +++ b/include/uapi/linux/ublk_cmd.h
> >> @@ -367,8 +367,11 @@
> >>  */
> >> #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> >>
> >> -/* Disable automatic partition scanning when device is started */
> >> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> >> +/* Enable partitions on the device */
> >> +#define UBLK_F_PARTITIONS (1ULL << 18)
> >
> > This is not backwards compatible. Existing ublk servers expect their
> > devices to support partitioning. If you want to introduce a feature
> > flag to control this, it needs to be opt-out rather than opt-in.
> > UBLK_F_AUTO_PART_SCAN probably also needs to remain as
> > UBLK_F_NO_AUTO_PART_SCAN.
>
> It is easy to turn both to opt-out - it will just get double negatives he=
re and there,
> which I tried to avoid. I got the impression that the API can be changed =
in current stage
> and people in general do not want to have partitions at all, so not havin=
g them by default
> is better. But looks like I am wrong here.

I agree it's probably more typical to use ublk devices without
partitions. If we were designing the ublk UAPI from scratch, it might
make sense to require a feature flag to opt in to partitioning. But
ublk has been around since kernel 6.0 and has always implicitly
allowed ublk devices to be partitioned. So we can't change that now
without breaking existing ublk servers. UBLK_F_NO_AUTO_PART_SCAN, on
the other hand, was just merged in the 7.0 merge window, so there
likely aren't many ublk servers using it yet. It's reasonable to
change its behavior before 7.0 is released.

>
> UBLK_F_NO_AUTO_PART_SCAN(old) -> UBLK_F_NO_PARTITIONS on by default
> UBLK_F_NO_AUTO_PART_SCAN(new) -> disable auto scan on by default
>
> Also for backward compatibility moving to GENHD_FL_NO_PART can also break
> users who did a user space partition scan.  But I have no idea what to do=
 here (yet),
> especially with regard to unprivileged devices.

I'm not familiar enough with how partition scanning works, but if a
userspace-initiated partition scan can block any kernel threads, I
think it would be reasonable to prevent it for ublk devices with
unprivileged daemons. I agree it's a behavior change, but it could be
considered a bug fix.

Best,
Caleb
