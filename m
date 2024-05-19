Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A42EAEB
	for <linux-block@vger.kernel.org>; Sun, 19 May 2024 05:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716097324; cv=none; b=lNmx0MIQT7cT8YKttbZxuO2eVm4dgnYHBFRZpjSatLNJtH7VLNsalgoXlbL1zmBxhNOJ/7NgnpJ1TySNcJaF6qbMwnduLcbvJrfeaPQHTlnNdcmPeyC+aPRK7u7o3pkVtw6ZPSggbZVqVzjAc9upT4Epjv/TeIwzaxWQtUwi43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716097324; c=relaxed/simple;
	bh=/SIEvilEuGxNx6YsbUqINfipy5NHVf7qeI1zkT+rWh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEfhcGpnOHX9jZHFMb/nmmd6QicOmHRFL4O+KW2edtsGMqtvyA3IxpOAmC0I8t8kUM6tIIZq9ENWHfLYSLAKP2alzakYJ3WxXkrawFCjxNrtx9uD0E0kuU9RNyeT/VqCGsgdcR+BJCdKMkja5R6itCaDnCEVE6XDrVr+MWXYi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f0fbd2d9ebso1574183a34.2
        for <linux-block@vger.kernel.org>; Sat, 18 May 2024 22:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716097322; x=1716702122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4AwhCy5t0HDmb4oWwsifG/akPKwpEP/0M3vb18IjHU=;
        b=xG7vlwlYyQO7QBJRIvhgat/cM9Rly1F37lUhabgRy9wKcWaxhgiI/FCajJIiq1KeBU
         oj5xIDrDUdhRKMCYrOcKvPcfRq7rDCuq1nr3esibmb2/7okydGkeCDmpeAqESr/qGkcE
         VVgVx0G4NfDd/vxurKVE19zkjr9C/o+n0mlydGGijBMDZ/AIuDpRcnsybdtdgkReRHkj
         CuZTB1GJ52pSgjVrSyH6HNn7aBeKDGsu096X5Am2ZFuhjm4Xuj6xTvLvLPEG8KGtXr+k
         g85SWbciN5M2F+5pKQ/dY8egFJIBUDWHaaSGxY5EgG4W6QsrsY4lQWNDhKvwjOZSJIwa
         /dwg==
X-Forwarded-Encrypted: i=1; AJvYcCVffwPrDbBCZaykpOCgF0x4gVvj+Rzq+mhIUBP7R51PDB2nA6bib/+MAL7xfpAcZgsYr4yUQkvIraL16oRoBvItBE8Ij7uDon3MhqM=
X-Gm-Message-State: AOJu0Yzh7zNYgxHZVD+jYzksJuxhruunkXFB7EWJGf7bPVxWcHqt9yMH
	ZJJmhNlr8MZqRyPilottbG02utotAuUn8o1IqghGCN/avTIIPQYB9CuIDtEYEfs=
X-Google-Smtp-Source: AGHT+IEjPAD6MgCxL+L20MoLBfYzCdWwrbQEAwIGqlJinj5kSkPWA1UbpuE7ezuYyYiP7+b0i1WkdA==
X-Received: by 2002:a05:6830:3295:b0:6f1:3d32:5906 with SMTP id 46e09a7af769-6f13d325b7bmr4334249a34.1.1716097322353;
        Sat, 18 May 2024 22:42:02 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a3cadsm1058972985a.67.2024.05.18.22.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 22:42:01 -0700 (PDT)
Date: Sun, 19 May 2024 01:42:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkmRKPfPeX3c138f@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkmIpCRaZE0237OH@kernel.org>

On Sun, May 19, 2024 at 01:05:40AM -0400, Mike Snitzer wrote:
> Hi Ted,
> 
> On Fri, May 17, 2024 at 10:26:46PM -0400, Theodore Ts'o wrote:
> > #regzbot introduced: 1c0e720228ad
> > 
> > While doing final regression testing before sending a pull request for
> > the ext4 tree, I found a regression which was triggered by generic/347
> > and generic/405 on on multiple fstests configurations, including
> > both ext4/4k and xfs/4k.
> > 
> > It bisects cleanly to commit 1c0e720228ad ("dm: use
> > queue_limits_set"), and the resulting WARNING is attached below.  This
> > stack trace can be seen for both generic/347 and generic/405.  And if
> > I revert this commit on top of linux-next, the failure goes away, so
> > it pretty clearly root causes to 1c0e720228ad.
> > 
> > For now, I'll add generic/347 and generic/405 to my global exclude
> > file, but maybe we should consider reverting the commit if it can't be
> > fixed quickly?
> 
> Commit 1c0e720228ad is a red herring, it switches DM over to using
> queue_limits_set() which I now see is clearly disregarding DM's desire
> to disable discards (in blk_validate_limits).
> 
> It looks like the combo of commit d690cb8ae14bd ("block: add an API to
> atomically update queue limits") and 4f563a64732da ("block: add a
> max_user_discard_sectors queue limit") needs fixing.
> 
> This being one potential fix from code inspection I've done to this
> point, please see if it resolves your fstests failures (but I haven't
> actually looked at those fstests yet _and_ I still need to review
> commits d690cb8ae14bd and 4f563a64732da further -- will do on Monday,
> sorry for the trouble):

I looked early, this is needed (max_user_discard_sectors makes discard
limits stacking suck more than it already did -- imho 4f563a64732da is
worthy of revert.  Short of that, dm-cache-target.c and possibly other
DM targets will need fixes too -- I'll go over it all Monday):

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 4793ad2aa1f7..c196f39579af 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -4099,8 +4099,10 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	if (pt->adjusted_pf.discard_enabled) {
 		disable_discard_passdown_if_not_supported(pt);
-		if (!pt->adjusted_pf.discard_passdown)
-			limits->max_discard_sectors = 0;
+		if (!pt->adjusted_pf.discard_passdown) {
+			limits->max_hw_discard_sectors = 0;
+			limits->max_user_discard_sectors = 0;
+		}
 		/*
 		 * The pool uses the same discard limits as the underlying data
 		 * device.  DM core has already set this up.
@@ -4497,7 +4499,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	if (pool->pf.discard_enabled) {
 		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
-		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
+		limits->max_hw_discard_sectors = limits->max_user_discard_sectors =
+			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
 	}
 }
 


