Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07A219A7D
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238954; cv=none; b=BKe1wX6cV2qb50+5UeSn7An9OwIlEtAtyH599n60uzIMChvrGLuWC8RKlRZIggnB0fTGI4GASgxaUqdInkmOdJtjvtRtSkUr04nuDeD/QA8nObCLWmpsOKsrGrhZ+g5v6PGBigGCBjTigpx8hnFiAIpfw6fdr9w5WfcAiucB/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238954; c=relaxed/simple;
	bh=ra3g0WSTHGlONWh4dVaSP8Ga7ymiMHvVu5Uub8yg9PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdVmMa/BtR+Wap9gYEpIClMC7tVOnQrKIDjHnV3ZPDu39L8eo5cdtmZHa+DGn/tPupbS5ov2gNmMhCAMiu63sbjeVIs2wiK2TaFD0m9Up1klFVtDtm4kYXEjfDYiU/UGSbN6hbPJ/Nt+HYUO2pGXnQ55sJDkbKwSRh4JW0VdV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TB0GYylp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TB0GYylp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22a976f3131so1657885ad.3
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744238952; x=1744843752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZvDkyQnbebY09h0oUEJJQU6pkyHBZyFHnTgbadKnrA=;
        b=TB0GYylpD61oQAjoYujCTPG0AekLJaOji4HDSxlkoe5py0JcjebZuMjSr0BuBYE55C
         8cMQUApFTM49Z1kVJLXWMP6mOBqfU7noKGCvPO/ALVFDbVy6VDf0W7Y53gQ2cl7Vemap
         5CxLEA3OK/E9LvwQfdiLukXirqRmgBJW1bauVrVmhIrmNZtQBktTczNj/FHAkS3b2JlT
         rc/U9FNyWK5/pEJhXhqnnGpsamf/mgQ3UeruJV5bPDiTancYsXWMlJfhMV21pCCQ4iX4
         I+AtDQpG8P+QAcica3H9BYVWNJJ5Lt8hmUEXvKgBcNuc+YLs1j6G5nCRtPl/zZt2Iq/I
         tvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744238952; x=1744843752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZvDkyQnbebY09h0oUEJJQU6pkyHBZyFHnTgbadKnrA=;
        b=S5ii/gxVa0TGpKXMbenB91TsJKlKZhEDnMn5StNzY6ustp0Xm0DdefEA5B5cdzG/IL
         2Ko9rAMoa/VcSMm1GGvul4tiCnBa8yYJ67uzev6xlrORuHO4OZg4XPwBdIZRcxbCZUEn
         3cMnKij8wpBgj7r3svLfW8j1DecqeInYk/iszqNGZZfXK3cZwsgonV48JErM4zBsmdsk
         mm8rrSRsQlVTL6j3E3QYb7ycqGSwUK1pQKvB/UOHLhVGa3VFfj1bvwpTI593D03INkhb
         BPy/1fARIRanXKXUfqNaaaPpNg3Qxm3NS5hY1d8f1lLio8tdKNU39870/A3zB/kbDGNo
         8RTA==
X-Forwarded-Encrypted: i=1; AJvYcCWy9ahasx3PFvogyNTI0j2r/JMtIK5q89mkPJss28kk/MuREiiMjxGrIdo13Hp0q6abEsX+9lPQzhChpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywin9SOKD1M8dKVriMmHXBOY+VveLfOedDugmZClkAF5sm+xCk+
	Tg5YFQWsNfQBFmtC/9ZWTqaortPVftvexQYBTHYwWiYB93itxVjTFB/bUT7KH7A=
X-Gm-Gg: ASbGncvm7nDI6bEYZBGxnkJhlCJO6ADPYnaQ3/3IDl9xWGjLP45GOpbfuAsnq4b0F1V
	Muq2AILWsvKyxKWnZ9DB9OQ4SP6+IYEg6pEqAgqQSvFUj4ypCP+D01qTTCcXVSUAIamBYlEl0xQ
	1Pqq4v0avT/+LPC0GHhbN31pAEZKrBoROHL/y20I3kxh/Gd4WEJ/IDn9C781VuOcnmZ1qQetNCS
	e70ttNF+EphLWg1kB7e/cr6ULI/uLHFG8A1Q4JYAGdWVBXoenOHrVq7MRsb3Pz/RLMQF73jbJJI
	m3rJT4o2zhpkVdrjSH4yR+I0F/N7pyoySeVrjE/0lOFXnoPiax6I35rCq77BREhJVf3ORA5OKdz
	3sWyZfD6+i23LQbqBKqiB2o07
X-Google-Smtp-Source: AGHT+IGjJAjcitAQAv4Chk4T0tkE8kfKdHQ/aWkSJyTOTVip/fuhtkcZ66iizlmv+Slne03pX68yaw==
X-Received: by 2002:a17:903:440d:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22be0388787mr34105ad.40.1744238952293;
        Wed, 09 Apr 2025 15:49:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5463sm17613765ad.195.2025.04.09.15.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 15:49:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2eEG-00000006eLH-2B66;
	Thu, 10 Apr 2025 08:49:08 +1000
Date: Thu, 10 Apr 2025 08:49:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <Z_b5ZK8H0pK0Saga@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
 <20250409004156.GL6307@frogsfrogsfrogs>
 <Z_YF9HpdbkJDLeuR@dread.disaster.area>
 <ed53dc33-c811-4c20-8713-8d2d32cb81d7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed53dc33-c811-4c20-8713-8d2d32cb81d7@oracle.com>

On Wed, Apr 09, 2025 at 09:15:23AM +0100, John Garry wrote:
> On 09/04/2025 06:30, Dave Chinner wrote:
> > > This is why I don't agree with adding a static 16MB limit -- we clearly
> > > don't need it to emulate current hardware, which can commit up to 64k
> > > atomically.  Future hardware can increase that by 64x and we'll still be
> > > ok with using the existing tr_write transaction type.
> > > 
> > > By contrast, adding a 16MB limit would result in a much larger minimum
> > > log size.  If we add that to struct xfs_trans_resv for all filesystems
> > > then we run the risk of some ancient filesystem with a 12M log failing
> > > suddenly failing to mount on a new kernel.
> > > 
> > > I don't see the point.
> > You've got stuck on ithe example size of 16MB I gave, not
> > the actual reason I gave that example.
> 
> You did provide a relatively large value in 16MB. When I say relative, I
> mean relative to what can be achieved with HW offload today.
> 
> The target user we see for this feature is DBs, and they want to do writes
> in the 16/32/64KB size range. Indeed, these are the sort of sizes we see
> supported in terms of disk atomic write support today.

The target user I see for RWF_ATOMIC write is applications
overwriting files safely (e.g. config files, documents, etc).

This requires an atomic write operation that is large enough to
overwrite the file entirely in one go.

i.e. we need to think about how RWF_ATOMIC is applicable to the
entire userspace ecosystem, not just a narrow database specific
niche. Databases really want atomic writes to avoid the need for
WAL, whereas application developers that keep asking us for safe
file overwrite without fsync() for arbitrary sized files and IO.

> Furthermore, they (DBs) want fast and predictable performance which HW
> offload provides. They do not want to use a slow software-based solution.
> Such a software-based solution will always be slower, as we need to deal
> with block alloc/de-alloc and extent remapping for every write.

"slow" is relative to the use case for atomic writes.

> So are there people who really want very large atomic write support and will
> tolerate slow performance, i.e. slower than what can be achieved with
> double-write buffer or some other application logging?

Large atomic write support solves the O_PONIES problem, which is
fundamentally a performance problem w.r.t. ensuring data integrity.
I'll quote myself when you asked this exact same question back about
4 months ago:

| "At this point we actually provide app developers with what they've
| been repeatedly asking kernel filesystem engineers to provide them
| for the past 20 years: a way of overwriting arbitrary file data
| safely without needing an expensive fdatasync operation on every
| file that gets modified.
| 
| Put simply: atomic writes have a huge potential to fundamentally
| change the way applications interact with Linux filesystems and to
| make it *much* simpler for applications to safely overwrite user
| data.  Hence there is an imperitive here to make the foundational
| support for this technology solid and robust because atomic writes
| are going to be with us for the next few decades..."

https://lwn.net/Articles/1001770/

-Dave.
-- 
Dave Chinner
david@fromorbit.com
