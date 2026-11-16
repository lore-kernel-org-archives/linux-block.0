Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794843159;
	b=cfuQ1mBOK4bkd4J0mP5liVf9PIHe6zUbmVCMqwE15lO1iTZJCID47cIRijYab0mzWErI
	 8jpo3AH3wnyqpohFvYJNxEHWbewlQ79zg9+HEdd0e2/4t4p++l42JdiR0lqqyYHLXpY1m
	 C1RGv2YcTk3X0Z1+/kP6oX85ulPTWh2PXLwWXXyJ/paWOkfQ3k9vM+gn88ZAAVskgB1/U
	 dfGd6QCnqYE1b/SgOUPLoSZr2EiOkxUB0TDuGmXSGcBA0zbi5oEl95YXKlSRd1o6llviW
	 X2lfhuJU9UhCGOO9oK3GS70T0J682nilUwbG2gbGnUpdWH4301IPXJz/U1gRiRXr57A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UZfjUUdOGV4n+muBluIHHduUrTQ0oRHWELrphw0Vc24=;
	b=YQFJO/MdrbrTKvlwogXO72GM3Ojf2uqlIT+a/TTr6GHLQAKFG1VHgW4U3orMIc3O3a6n
	 9WQI/uxwWD/6LbtuSaBL/WjWFcFK5OvSKey1Yfy+ERfufP6hAf79JHUQvnO2ww0v/p2W8
	 bDcPCo4nzOJ326HppFOc1R7Xhg3TfHeEtdrlQZXckDousJnMO9x/nmh2ci7Yv+1+N6ssr
	 rQyBpxSM3AF5YSUZcEtotUIHpPmAsrYE6EkTT+urxj6T6VoQzQiSvgIK9s22VkDEnJKRl
	 F8koVLuj8AHyDTXcsTQ9CmyXWf3QPgm6og1q0a/R1r+EfTp72fKudr4ZtIbKUeHCqQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJiYISSE;
	arc=fail smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CB606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 15:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJiYISSE
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ea0c05c92so51039586d6.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 07:32:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794843158; cv=none;
        d=google.com; s=arc-20260327;
        b=XQauuzPhSiJsfb+EF8y9u8ttafXRD+itOej1zZyDWDiGJzLvswvbbi54rK0U56UdIN
         guUcBx5opK9Vj6drlF8hFhcumYsV/EgUJi8insNgJhzseXHPzYZX0ubWXPiACn+fNzph
         DBIgxMmcDSUH0j9OS8OaLreP7XvjeSufZaifJAZl/yj+AjxO+yO+uBTCpCavMiFbhYFj
         gwYF5AKu/WDzsQJ2e1wAybTHJ2mXxHDiSKkI+8JE/7MeeKdcX2Q5HdYfYefL8QNeswqj
         3dSt3Tzu9X3+tWsEVs3Oii6SxbpXf53/pmdke5cyukitXQKLvXTYAWB6JTecwA1X8K4d
         Xihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UZfjUUdOGV4n+muBluIHHduUrTQ0oRHWELrphw0Vc24=;
        fh=a2eciKvubi64cDRtq+Cr2umtNxDZR7TgbL4uzisuGsQ=;
        b=ORdM4OOvFcdyu1Gl5q0GJzVG77aOzk0N8ubDqAVAjd8rztWUCoqA3n0JdKqZx5uLcx
         K/lI3KmQ5n1DdFYr4sZG4aARQuQPLkiiUc+TKxel1QbogeMT+3mb+1JpoqQiklUpa9a4
         MRbof3s4F+sgteNkX2uGrvtvvU+Ep6vl3R1ZKb/ZE7yJV8uKZW5dkuzIWmgbsH2u5Kl7
         4pDFJvG1ct0ubb5drhME1KjOlxt440bX/nRg+RQsd86tn5D1E/eH5KGRoinyQjyLX0bH
         iAjAQWWpaSktsbwG74X2qKUftGUkXajbdyXsdDNSnLvB37Ekz00kpCD3uZal2xPB5LIx
         YeUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794843158; x=1795447958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZfjUUdOGV4n+muBluIHHduUrTQ0oRHWELrphw0Vc24=;
        b=vJiYISSEW85hJMCPpfsyCN3ZkSJKg0MWSYEXXGl1KGF8rw9JNmPK3TazqOtdRKHN5o
         LVaxVKgv8fFDR6iFvvanbAkKpFTnsG/f17IrYDvhp0N3oOsyOAj1D0EII5U1fMwXWvw+
         cFO2hOKT6kOyZ/buLAbuFZBU5eAHCZd4Pnk8mGb2QXHKBjXX4osgIvYSLSoq3HHBYKQU
         q2LSf2rGBAgADwC6pg/0gLDdyHv37OZ285IfJ7soH8NiE6Ij5SThvWgN91odFNR6dr9J
         Z7T8RJ+4EsCLA1Il9n85LOTVDE7kgahkDvvJ66NAUujuut7iVbpynvNz5r/zT8hXmbYp
         hjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843158; x=1795447958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UZfjUUdOGV4n+muBluIHHduUrTQ0oRHWELrphw0Vc24=;
        b=sV7AlMKgaUein8KjSF35T8R5OrQ5VR7OAyzu2akvQ15UXrP/yZIb1N3/6sJCQY8SFj
         Mi9NS/rZAhXMtn9I1SPA+jZjmvPEOZKwWUV/+Mxsp3TTvlq/14/8xPSJNYF3whLWXupH
         zWdoY2l6TAWhF2YOJfJsE+MOz7xZDuBCyWY16C9AexUb9jABio+gFn8u0fG746fXJAEQ
         XLCm8LnetFGbTwaPv/qxxPwsxHBRs7xXAVzGstKS6tzW6zP++UnDGFfACtwgj4yKNO0h
         AScYaBN5ohOvB6LslPr1BFEWavJrpCAWmYCfp+UvSWdeIWtIEl5Fxruy+eNY2KaOk0Rj
         16xA==
X-Forwarded-Encrypted: i=1; AL+hErGqIAZYehk1gMwxrbqp4xQMRmuM/Z6tQlUzGC06js1I7fwGbRCtTPzZ8OcGXzA89wweGfWs9DP1C6sDzw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/m0YSx1vf6rC7CHfQT7yORYqzUcwVEaZgKF30b/mQRMerbcO+f
	NwJG0bEjcKk1jyliHa7+a4YAJ8NILQ2JSyo313M8mv1Qpt7YKc4vufzhL3l/fj9f4uHFJElygfO
	HnQ4aw8dZ0vl4PYQBq+pnwB+WvLkcHV0=
X-Gm-Gg: AZFdTZc2gYK6PcNXYwM8sjx1+wNLCS5ackTwmcsdUGzYrH5dPzZh1amysPsccEBRSR9
	N+Jk7Ar5JB22ENF2iY7sv4wDhR9za2C94VrBMlKOSJIQkZA8l3TVlKwDwQQZIHx5aPPqGW7DzuQ
	9q4Ezv1QB/bi1cR53XseFaXJQ6LLdJdCbl1M1m4kwBEP+LdxHiXCBApFud74Ft4nFVaBqjLz8Uw
	fjgkIoIGmRokNGEGFSHHj4yNuQraVGZxv81VKly5I8hx/rZe9sfke1nUcNWKWyZ9gecEx4vfw2V
	ZTcPRcf7u136WP7hHYGaRJjCceVqpZP9Lu5AoWXwaMY4Zcvxyd8B8kZY3w8RekZw1svn1E7N9sG
	WULwOvqmqHh05Zo7IlN6W3vSl+9yq2578i4hjewtzL+Lv8pgxUhYnTwaRRW1numFWBqt/j7BPED
	YaPaQ=
X-Received: by 2002:a05:6214:c6f:b0:91c:133d:4916 with SMTP id
 6a1803df08f44-91f24258d3bmr175963246d6.57.1794843157790; Mon, 16 Nov 2026
 07:32:37 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112134703.38510-1-nondet@yandex.ru> <20261112134703.38510-2-nondet@yandex.ru>
 <avmLAy52vfyJ5qze@hungrycats.org>
In-Reply-To: <avmLAy52vfyJ5qze@hungrycats.org>
From: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
Date: Mon, 16 Nov 2026 15:31:59 +0000
X-Gm-Features: Aa3M54oeRpvY83d0nLazjOVqW7eXFFClTJV0uMrGDZK8xguOz0qojD8xIBRH0QU
Message-ID: <CAO1Zr+q5hhK5oPJtQu8v3oh=-AfB9FuPF2VQA=zpSGA0afB-FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] btrfs: track physical bad extents, fast-fail,
 persist, and relocate
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Zygo,

Thanks for the detailed review. It changed the design, not just the patch.

I agree with the core point: physical bad-sector handling belongs below the
filesystem. A drive with spare sectors already does the useful part in
firmware: the filesystem sees EIO or a checksum mismatch, retries another
copy, and rewrites the good data to the failed LBA. That rewrite is what makes
the drive move the sector to a spare. We only need a block-layer replacement
when the drive can no longer remap, because the spares are exhausted or the
firmware refuses.

I also accept the consequences you spelled out: the remap unit has to be the
lower device's logical block size; reserve allocations must never move; and
the table has to be crash-consistent with the data, with FLUSH/FUA committing
table changes and two copies protecting the metadata. btrfs should not
intercept physical I/O for this.

Verified defects
----------------

I checked each point against 6.12 and I am not disputing any of them:

- the write redirect used the chunk/map length, not the bio length;
- repair writes went through the redirect as well;
- fast-fail after a split dropped the remainder;
- fast-fail inflated read_io_errs without doing I/O;
- device replace reused the old devid, so persisted ranges followed it;
- the incompat bit was cleared when one device's list emptied, not when the
  filesystem had no ranges left;
- the mirror-collapse test could pass from the page cache;
- dmq renumbered reserve offsets on every rebuild;
- dmq reloaded the table and only then installed the ranges, leaving a window
  with no remaps.

The last two are already fixed in the userspace side. The map schema now
stores a per-range reserve_start and the allocator cursor; reconciliation
keeps existing offsets and only allocates new gaps. Live updates diff the
target's range list and send incremental add_bad/remove_bad messages, so a
range-only change does not reload the table at all. Geometry changes are
refused while the mapped device is mounted. The userspace suite covers
add-below, remove-middle, idempotent re-apply, split boundaries,
poison-to-redirect, and reserve exhaustion.

Status of the btrfs patch
-------------------------

The btrfs patch is withdrawn from upstream consideration and kept as an
experiment in the branch. I will not resend it and I am not preparing a
btrfs v2. Scrub reporting and targeted relocation may still be useful, but as
filesystem features that feed the block layer, not as I/O interception.

Proposed dm-first staging
-------------------------

I am not claiming crash-safe redirect yet. For a first submission I would
like the target to do detection, keep a pending list, and poison confirmed
ranges (return EIO, never stale or zero data). The volatile table would be
restored by userspace before mount, but nothing would move data to a reserve,
so no acknowledged write can outlive a lost mapping. Redirect would arrive
with the persistent log: a small self-checksummed area at the end of the
device, two copies, a generation number, and the mapping committed before the
remapped write is reported durable.

Does that split make sense as a first submission, or would you rather see
redirect and the persistent table in one series?

Two smaller decisions:

- Geometry. I plan to require the lower device to be a partition by default.
  Whole-disk ownership, including LBA 0, becomes an explicit mode with a
  documented recovery path (initramfs or rescue media), because the target
  has to own the partition table and the boot loader's sectors too. Is the
  partition requirement reasonable, or is whole-disk the more useful default?
- Reserve. User-specified size with a documented default, not a hardcoded
  constant; new defects take the next free block and existing mappings never
  move. Any preference on the default or on whether the pool may grow?

I am rejecting zoned-device support for v1.

I will post the dm design and the on-disk format as a separate RFC once the
format and crash-ordering rules are written down. If you are willing to look
at the format before there is code, that is the review that would save the
most time.

Thanks again,
Alexey
