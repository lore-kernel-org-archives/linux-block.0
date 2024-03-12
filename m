Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23225B641
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203140; cv=none; b=MQz1/l1daHafkqbN66zd2b+HCdsfCnX/XWBKf6zOD1vFfcRc78gX/+9vkD/jcQsZuJk8OOM8tB5GsFq7HV/BaU5BkEax65qhJRyN4xZkGC7JWqLBC/Ujg/VazNICeKvUKvaHlbH8NdN3lTLdbzj0KnNMzSMTSkGJPr1E0uIl+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203140; c=relaxed/simple;
	bh=a1JPt5MPV9vb0aoh2TSF6H4MmIK13xmkFooc3rMTkD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m35K/W3DlRLGHmQuA1hA1MVh0DxKo4HebO+Zn7N9gVEL9XCF6zVcmpvGvAiQHdA/dqxCuT9so1UorRUQ5sZ0tjtpz9usCiw5azm8Au16bCug9bx4JreUAU+n55lP8jH2lyunYjaXwv9/lcxOYRXUcZiZv6U9V6MuZ0xgyNgFOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd9568fc51so15279745ad.2
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 17:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203138; x=1710807938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc8jaFttvMELkVCnFYf4PsBR4ovRqWuiCwF0QTUWaxI=;
        b=xFxTB5S9mSjV6JdOESbOOKofFoF5arFQBc/v6DENA0GMVK2cHelmxpGuIaEFoZxsI0
         L4I7h9eLhW8GLKswW4Sae6YgdeEssjXhPrpgNud6BOqwd3h+5drE2xUPZIC4fyAsHW00
         /UFsz31zESw2BDdvUyz5mSnBCtobCUOzRKIve1Km/ybyGFg19FBKQqX232hvigAUs5T+
         uYZ7BgNulzwOkntr7z7/oABMw9k8TOfW0vYoolcN1Um/HRJRCR+OdxebHAPygHzKCS4T
         HXd85XgMsfSOYBC5fUcqywLtEQ37MOuaZzLuUtA5JiStyAjca6JydUgOCLQgywRZjyts
         HNmw==
X-Forwarded-Encrypted: i=1; AJvYcCUOePZnGPjZq2/w08Y0/3a10hD8U4p6L0W1Zo8rpYwpRzzZ3jpEcXpvbOT67Ta27Yn62Pj6yX+oKsg1CJqZs7wggOFYA/uudM/xcLk=
X-Gm-Message-State: AOJu0YyLd+udAyKcugbMq3aPbCj2Dni5pQ2+NvJ+F42SA1bgQE3g1fyH
	DtEm+lC9+Qj6uk/wldzD7NFgWT2OQF90aDSPiBHTVn77FlkhKplqiiU2KcYd4Q==
X-Google-Smtp-Source: AGHT+IGuJMeqmY2lPQbObWzrprM8COoXlsXzWrNEG49xZZodG1nmtBzwBgBFApReSPxe80wMnaaXrg==
X-Received: by 2002:a17:903:22c5:b0:1dc:ffb7:e857 with SMTP id y5-20020a17090322c500b001dcffb7e857mr11139703plg.57.1710203138397;
        Mon, 11 Mar 2024 17:25:38 -0700 (PDT)
Received: from localhost ([194.195.89.21])
        by smtp.gmail.com with ESMTPSA id kk11-20020a170903070b00b001d8f81ecebesm5306962plb.192.2024.03.11.17.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 17:25:38 -0700 (PDT)
Date: Mon, 11 Mar 2024 20:25:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <Ze-g_P4oPOHLqDGZ@redhat.com>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>

On Mon, Mar 11 2024 at  8:02P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 3/11/24 5:58 PM, Linus Torvalds wrote:
> > On Mon, 11 Mar 2024 at 16:50, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>
> >> My desktop fails to decrypt /home on boot with this:
> > 
> > Yup. Same here. I'm actually in the middle of bisect, just got to the
> > block pull, and was going to report that the pull was broken.
> > 
> > I don't have a full bisect done yet.
> 
> Just revert that commit it for now. Christoph has a pending fix, but it
> wasn't reported against this pretty standard use case.

That fix is specific to discards being larger than supported (and FYI,
I did include it in the dm-6.9 pull request).

But Hannes' backtrace points to block/blk-settings.c:192 which is:

                if (WARN_ON_ONCE(lim->max_segment_size &&
                                 lim->max_segment_size != UINT_MAX))
                        return -EINVAL;
                lim->max_segment_size = UINT_MAX;

> Very odd that we haven't seen that yet.

It is odd.  dm-6.9 is based on the block tree for 6.9, which included
8e0ef412869 ("dm: use queue_limits_set").  And I ran the full
cryptsetup testsuite against my for-next branch to validate dm-crypt
and dm-verity working with Tejun's BH workqueue changes.

I agree with reverting commit 8e0ef412869 -- but again hch's fix was
for something else and really can stand on its own even independent of
commit 8e0ef412869

Mike
