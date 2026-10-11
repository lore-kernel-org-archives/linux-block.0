Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB230282F1E
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733227; cv=none; b=jPG0MUsqIcS/lzHnfXkFxzzQOvOnqq0IO35yOBC3WpvMwoB4W+KrOjrKlGgQ/jXTFbBRHmUpo83yjf7SJTlnAPtTpnZZ4hf9oyUzXteSt2FP5fX4W5LAnbqS2yYFMd+uhwyVaxtNt/cm+zJVgqXQmd2W0mN5MjGkiRPlTL/NRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733227; c=relaxed/simple;
	bh=8v2ggXzUD3gHQZSpbkrI7r2xnny7T8N9JpArw/Uh008=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcEZPhchG7uHbVRIuOSum+Vl98oD9MgI1/393ghbYVr5YNVCxSPWqCSCTv/pNK+PzUjHOMd29Ky77o77LfwfAMOlWOHCOh2UgCkXZFc4bGGDn6EraJnPepMuw2D+2D7o3VHlW3QyR77W+s5qa8cIHla7G0D9Dy/loC7MfPHtnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESuGnzQx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESuGnzQx"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1419d3416ceso1507916c88.0
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791733226; x=1792338026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yJqSVfn48yTsL/59J4SIahE071FOQoaX2gq57TLxImY=;
        b=ESuGnzQxVtd1sCMqmm2mFuAkHDaRK8Y3XxiKzUZzMnOpw6KuGfokusR49XRY7pLupr
         +MNaBtsO4sslSGG9Wam8Hh3tsX15VMV50dHrlmTXCRX8VUZRc2neiTnC72iW055TOF45
         eqhqJmhU+V5N+EelMhW+uNSHnBNZthjR3DG1Mbo0+zuZhWgrym1sN0hoW6qGixsmxUsI
         4ATg4lsHa3tN5ntz7cmxlouaVGBGnzVKf/YzikvKnVZzWGvdDhBylAvPAaalt7gKGFx4
         d9zJtgbxmTSXZkx0ntn/QkfNv8igl90/WJMPqm1Nx7XuRnZto/FfiZPBkgvJnMSvbB5N
         Jytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733226; x=1792338026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJqSVfn48yTsL/59J4SIahE071FOQoaX2gq57TLxImY=;
        b=knDxSVeqtmD3QPyKB4ce9h1TjUs+LH67uxUSoUO9UPvkyo7g0+ZZ9pTC9eCXDsiwMt
         0L7Q8F1ljZhCSlkY0++BH+64BXauD0gpXH+c1CHjOJpYdJFIQMWVil6aetLoPpokKrxZ
         kiKPqn0OdLpB3UIVMaxtnn3p0DzsuwIVypCW0PhXggMvyKMlk+492oRw69P3Qt6/i7p8
         rxKJKgfTzciueSKd/AsE/zVsnurELICT4vWHTUGNnYeZAfszWxE1hnJC7Twh+Ba2dOmO
         rChCnwaRKxzINiDEoeXEcUDg7mUnN7BZtdf4Ifl0ZfCUU1IdpXQo3PyZq/OGVD5vB7mf
         gHZQ==
X-Forwarded-Encrypted: i=1; AKwUvByn28cAmwgdE+dpDxvdrkT66raHfvvrBKUA5h/O8nuhjBeNuXdbyr3iwVWwYZYA54FUJznUF3r4WSG9XQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJJguWO0XIDmgLxdQ4g3IqrgbPa4mtj3ogN7DwO2ciyCYWgg/SA
	3jByMYlCeTyTFazGM9vNwPVVQtfOcnGMrM4MVTGuC83s8x+V0BlN2D9g
X-Gm-Gg: AYBFou2ogemRLcsHwNCP5C8qL/GMQJ5sgYXrrEgzoqCcH7EcKJG8rHIK+uf4E8q4C/a
	3zeYgTx52dCHj0sDVpJW9i3Y4DFN3DKbb4mgvhqV/QqXQW+E6us6n9YuNYb8VhGrvZMDomrZ3IO
	VTr4evEX6QIiRzmGik2Rni0V3JmUqGn6ZfR+ASEWM6LyKFjUcf0/aslIQeeD78YaS3LwqLdPSCA
	XvMJLZhKI5qhBcSzPLMSNl8MkiafVeXxUkdT05f20+Xy8p5CF5N/Fj2H6idM+miBTb2Ck38ncph
	baijtxv3NHP44ja8fswJJjtV6oKeVfW+SAtWjWoF8D9mtrXt6mbmRcCBdXEAFefNCwLMtSjamIf
	lKSnL8mmf4mudsD/pvbw9LBiZlwkBHoo+0SDHqryzzAktlGspyUuBgGGvCA00LQAdqVsW4q9wcH
	++EtqjeIdfudwyKdkTDfBU7XWZbCHbl31B/Dwd8rsR8IgZAQp+0cKCMgqxGyjFxHEzx6loPZJ0F
	gl9NDG0xivPRhTL0ZyVOclH3KkN9xItJvRtAd1QZ5zwa9XR0W1WvfqfxZlvfgJU6QcnmMkAlpw6
	5Br7pR4gVFPWe4oNedFC41r/YyuQFr5yNXF3NyrkvBuTBnkDACed0ka90ILRrnNvpGCZ4xByW5s
	nRC3tcsO3hc4HOYxYpy08CrTF3WBacKZlTSwDzdMNfBc76HGypR2srhLbDE/EAFsdVeU=
X-Received: by 2002:a05:701b:2705:b0:144:fd7c:84fe with SMTP id a92af1059eb24-16a6203dc1emr10890274c88.35.1791733225641;
        Sun, 11 Oct 2026 08:40:25 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm26252154c88.12.2026.10.11.08.40.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 08:40:25 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] block: two fixes for the zone report ioctls
Date: Sun, 11 Oct 2026 21:10:16 +0530
Message-ID: <20261011154018.48913-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two problems in the zone report code added in v6.19:

 - BLKREPORTZONEV2 does not look at BLK_ZONE_REP_CACHED and returns the
   cached report also when the flag is not set (patch 1).

 - blkdev_get_zone_info() gives a smaller last zone the length of a
   full zone, so the cached report describes a zone that ends behind
   the end of the device (patch 2).

Both were found by reading the code and then confirmed with zoned
null_blk devices in qemu (x86_64). The test program opens one zone
explicitly, writes to a second zone and closes it, and compares the
reports of BLKREPORTZONE, BLKREPORTZONEV2 with flags 0 and
BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED. On mainline it finds both
problems. With both patches BLKREPORTZONEV2 with flags 0 returns the
same device report as BLKREPORTZONE, and the cached report describes
the smaller last zone with its real length.

For patch 1 there is a choice between the code and the documentation.
The changelog of b30ffcdc0c15 and the comments in the uapi header both
say that without BLK_ZONE_REP_CACHED the report comes from the device,
and BLKREPORTZONE is marked as deprecated in favour of the new ioctl,
so I changed the code. If the cached report is meant to be the only
mode of BLKREPORTZONEV2, the header needs to say so instead.

Changes since v1:
 - patch 1: rewrite the BLKREPORTZONEV2 case to the positive form
   suggested by Damien Le Moal: take the cached report only when
   BLK_ZONE_REP_CACHED is set and blkdev_has_cached_report_zones() is
   true, and call blkdev_report_zones() in every other case. This drops
   the redundant blkdev_report_zones_cached() call for the no-cache
   case, where it would only fall back to a device report anyway, so
   the observable behaviour is unchanged.
 - patch 1: blkdev_has_cached_report_zones() is now used from
   blkdev_report_zones_ioctl(), so move it, with its comment, above
   that function rather than add a forward declaration.
 - patch 1: adjust the changelog to describe the new form.
 - patch 2 is unchanged; it keeps Damien Le Moal's Reviewed-by from v1.
 - retested on zoned null_blk in qemu (see below).

The series is based on mainline (a5ebb76233b7, v7.3-rc6+), where both
patches apply. Patch 1 also applies to linux-next (next-20261009).
Patch 2 needs its context adjusted on linux-next / for-7.4/block,
because blkdev_get_zone_info() there tests the zone type instead of
the zone condition; I can rebase it onto that tree if you prefer to
take the series there.

Shashank Mohan Jain (2):
  block: only use the cached zone report if BLK_ZONE_REP_CACHED is set
  block: fix the length of a smaller last zone in blkdev_get_zone_info()

 block/blk-zoned.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
--
2.43.0
