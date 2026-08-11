Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35255400DE8
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480206; cv=pass; b=JqS4qD+RRR7IociCyZGI1cCDLVAvWAdaXyDLXFpubyME8ivFP/sGvrDK5ELnD7vpbIo4Yni7zEYn5Lbid6NaXiziixoXbUCKWtfjdrhX5c5i8WmgIDlpk4eHY2190ke0i7bNQIxppsevCd0z3Og93ndFmHZkJKy5QKq7s3WSpq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480206; c=relaxed/simple;
	bh=X8QNUXB/Uq4WmIU/R0XnTWunz3D+Qk5IHhscFew5Vys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8REkYGnrGAKiddFF6FvBUFk0SGCqNQ6MTbx0mBCEXcefnJZUDzkphqiHaUXfqTKO8dvJ/dH7+uJH3Ss6c6/Hk72Mci741m7rjP8/i43oTgECIOWTAa0cV3YSuWKUiKEm+3zWRQvWshzlSZAgNv/K5lY6LJnGRgRFcVdiRfMlx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJVWDF29; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJVWDF29"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so376247a12.2
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 13:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786480203; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHFXQz8kG7K5gya6OM7a3yTqE/AQ/TitON/ZX45M/Pgni4Be5ycV/+0btZFSbktB60
         y/IAcaSMW+WI2xN8EJs4QT0s4UB0XvEhV4NuVs1/FBVfR7wkmMjcgQF4cuQw/vCdRdFN
         Gjl/xBTf2KXmxpV/33jUvgeFAIkW+oclx7H5xBiMcM0VYygjU6PYkhTaXqMYo3IP4mw2
         MgmvBUiozrYnDgjVXD6hlj++jhcxy/Thr27NMQpzyt0bQMDeW6e44GXYlWcrTo8T+3r+
         uO18JbuV3yVinAPqWaJ/kN9TLUr7Fq9L3pt5ec3zkVIgEW8vaFb7R6s1TBWQ5UiIamwW
         8X3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        fh=9+XWoSh9zFHBA597SsawPi5SNFxR0kT5BUNHiiqmhkE=;
        b=jF7Bf5X+Smns5D566Knukr5KdEIa2o6xFRVPv0hpnG5gOKDirp1bzbYR+RMEkVwoe+
         wUoDx8/uRqFmSYFYN9nRB55kOAfQxLmiuSajdeTo9ro826jEEKTtsVEH9DGEBCy489zb
         eB/vwItibm+P2ApdjKyKiynZumceYZsbRyDyRfzO5mAf34yFemQaeTgcqpyrSeeIfZj+
         etcLqyAb2NT2b3qMsgADrY0YGJI43jdff4KddH+THv7LXg1Dht85oI4EqrQq03JGG5fu
         /gVpwqqJmTqdXR4Hx+kUSbz6PQWfjjHQbIxmOY0GZrriWA6PLTwFAli/DU7lFLLUbwns
         mq9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786480203; x=1787085003; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        b=rJVWDF29pSdWUeVe3NCTLhVb3EHYo2Xiv0fGlD9QCl2habiVaNCkcbUW1x+JYOcRqk
         uiicaKqHoVLXZHUJCMIs4eANMJH1HHuMLs9IthJsNWKmnrZMPQQ8MLdsWZ9oxScmtjlw
         FZRecc/f60r0OFqWuR2Eanue5ZrpmrZ81ShVldVJZkhIuUaSA0PmXJW9cp/Y/DFih19X
         StH1KqQYIwTA/Af+i03PmJZZKe9EckVH6A+q9n5MZKp/c2B2Kc1BlsU12/+t1edbNK01
         DaAt69BPMXutC6DZndHc2gYxi4HV/77zqluJEc2JwNeUZkzzoSOTi3Uos039J4kjXiVt
         4VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480203; x=1787085003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Od64kOXlsBw7l33MxioNZlnpLtczMNN+mPBlqshAfSg=;
        b=sNIclNlI7YZgSUTHWBzr41HqSq5+vL4glOPXvOn8b5j1Zawv9bDUGrnTFJI4KzKoOo
         Indtf7xYMOSbU2Q36w8W6unZv9E8Dt0nUfPUTb680R3Zp00dsTmYQzBrrFTV4P7xuahG
         L6N9FkeGIGV3emkp8XBHP8Wza16eh4D1kN8pua5nBhTJC9/PdKe2+G0+pxy4BoSs520H
         VCX7ac6x46ZkJNj8L3nRZMFqowJlmVfeVzR+jmO4H6C269EPms2TBjWUZKuuQmiTHIgS
         SDCK+GsHC/4q2eWXy5KZAeMLuKAJQoMksrU5PxqAsun/dZk01+qdlg6sqJQ9kZjZbebn
         jOww==
X-Forwarded-Encrypted: i=1; AHgh+Rr97FUUGwAh5L74QuFsikO6fw/mM+nJQJSrbFnjLJsFD5OWD/jnC/d8z3vvJWUyGZuododSvI31aBgJMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxfnzaSDhD6R6sa0r/+aXuR0QXw5/INKCOKIQIMl+d1mTXCOH
	fX3M57AYna7p0Y3FRoXqPmzieWVp6dRas40ecNk9tUXbpUhhtaHwjT5GjiOnz1j/gLcSoROs/sX
	Psf8JOBwAn3gqxiw/UaGjE2F5fgXu3y8=
X-Gm-Gg: AR+sD11736WIqlwraztzvwEFjU6Bb8QCOw0O4JuWT3C66AfNf+XYJ1wpr0Eb/2cE9qb
	wGDw6cqoCkWwgbeBwP/408kQbz6ToDZlMA6JBcq7bxSgh41ThLgXnDAZmeKoYy+/6E+oilOiHlH
	s+XGF8Mh/7JVu/Xm/HNiSkozmne/NGIXF06Doehs1dPVV+1GSKRvLuk6SfUXLCixu1gS+VCbG8G
	qe2oPZw4uu2UhXmr92PL4FzpxEJiP+ASbcO9CLs5eqPFyq+GxmOKSKVP3fKvkPB7GxiCLzbPmGA
	dbMGOSU/6xWk2kSTSw4QfbXQK0pEmO8fp6XXKKtzW7N1
X-Received: by 2002:a05:6402:c43:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a36448b12emr3342728a12.5.1786480203030; Tue, 11 Aug 2026
 13:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811192111.2058140-1-coshi036@gmail.com> <ant4bioGLl4B35n_@kbusch-mbp>
In-Reply-To: <ant4bioGLl4B35n_@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Tue, 11 Aug 2026 16:29:51 -0400
X-Gm-Features: AUfX_mx5rnEmlFvuiMPBF-UBljjUMrJ0w3-4yrHSeb9aLUfcWEhgJ5oe1jx6xO8
Message-ID: <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2026 at 01:30:54PM -0600, Keith Busch wrote:
> Refusing to acknowledge the new format doesn't mean you get to continue
> using the old format. You're going to corrupt memory and data this way.

You're right - the teardown is the problem, not the refusal.

nvme_ns_remove() never sets GD_DEAD, so del_gendisk() takes the
non-surprise path and asks the filesystem to write back.  Those bios
go through nvme_setup_rw() with the stale lba_shift.  set_capacity(0)
doesn't catch them on a partition, which keeps its own bd_nr_sectors.

So it should mark the disk dead first and drop the cache instead:

        blk_mark_disk_dead(ns->disk);
        ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;

Multipath needs more than that - the openers are on head->disk, and
only the path gets removed.

Is that the direction, or is refuse-and-remove wrong here to begin
with?

Best,
Chao
