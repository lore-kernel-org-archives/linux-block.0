Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352B1EA7F7
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897732; cv=none; b=evRLdxqAkL3LAu+JHRLta0eLOfrs/SFUlOcDOv3vLE5LywIEv8o48sSo6Etfw3DSCY6FRhHkbR7GftKra+VkhHE6qOMKtc3sorqBrbdkxBNaibT0B1RQNEGRb2lI6tzb+fO4tLIxor/A9u3OgbzN2/5J1I4fHrdk06vNtWJ872Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897732; c=relaxed/simple;
	bh=Ef4HGfhFH2O5B+2fOUPuazpKm+OfKzc+RqhjPOtADx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kID7xmfXTfwr/sep6bXj+ivDbxNPbDiQ5YTwmBVYrpVN0CS67Ls3u7Wk7snWrmT7sbPmP/1NIVuLv86L6MnPyspp6aawyo3eXbCBoiBNZuqH98X2NSA9SbNDCP/QZqkEvmIstaOgSJ+EJW2CyAAXYeXb37KJYmnn4LO3886JdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oRdac0lw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oRdac0lw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2260c915749so70554325ad.3
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742897730; x=1743502530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOl85kkn8EDad0L2ymXY6WKpnUIUcFZbIKv6caJf9qs=;
        b=oRdac0lwMHoLY2V2nvORNbtoPjkNkOC6xmfpd+36Bpm5rWZ2prgOSvqfT8i760aIsn
         iNBVDR7PZpM7v8y0i727giaNmFjAyESgFHg8kNvjRmhDS059+9G0j2ZYP1ZxM8Iv6phP
         hSCoNoCilYwRth8A0PscgguLNER8o7CWJwX3TXJ2B3f7zd/UMw9vZQx72HiWKQ8dHAi5
         mzXWxuB9fZeVL910QIATuxOJjGqiwmw5qlEtTrW4FI772lo4e756ChV1DV+Un474r+pt
         xF/SMN6d3x2Xt8njzapFDI4O+x9VjBzvB9LhS1cZ/AZXj9wR84JiBGyOkOgiy1Xnjvpr
         ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897730; x=1743502530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOl85kkn8EDad0L2ymXY6WKpnUIUcFZbIKv6caJf9qs=;
        b=EVSXA8iCqatl+pqkKjdr9DrmQNxP8thfZeaEEz+9L38vLqTG8ECt2lS0xCDHFu3dlq
         NjNrFtAppq4ooyTJitERn/cbdbsRIGSZXKPJOTpODu29DdEl3tpqPTPLSeGEWcj8yx/o
         YEPkuTFu43JpnZuoAxeBNKN6cP96Jy3jWZxVJpAOK4KoVAZXdTcZzN4/JHDQrnd+wUO6
         2A4ShV9ogVMNJ1xkyyvx2a1gCAYtXwcbM0SJC0rD74371/j8rTyc83LIze+TnT9l0NPL
         +piE4zKhS+E2U148Vs4HjGbMlNjvq5ZhusgBPOveZJzSA3eq/icbIcaHrtiEd+tSSgHg
         +D6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtUvQnxMmssTCXyLNO2ib3mD6tsXWZ4hN4xH5qXKl2EiMjUK/q0ZcxEy5TlAIVWqyv/9efsN0ZQ4wygQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6n192rfizHFSI4gjmU7KXDoveoIbWfeiea63bbpZhQrJFkKz5
	hviBk8UHyCkWrGWJm5f7rg5na5028OpRZi/+3pSiSVQL7Gr4YNO9az/TP5FxAs0=
X-Gm-Gg: ASbGnctuB8p+zXmqdyVLBMd4h+8y4G/Z+HC9LiWeKvOTBVfLxUj8MIoN0rreRG6a7oW
	Dz5XNCY+n+9VselNotDa3HYdzdhWLarELlZ1J2J5EvTU9NSvy78PJXDpeotH1LMsXmatCbSggo8
	u5yZeMUp4KwIA+SE6ptdt5Hm6FPV8LhXQFEW6He18n2FlTaGyWPe0pBFfCvieWmKX+WpO47D1d7
	n5j2tsK7QCJHWUs3mpNJeRbFbPU2BRkuliAyey9qF6DyVWMyZzVz1jVX0TGXl/OuzUQltsjpRe2
	gVtaIwarMNpgw4JccLVuQcCCGPYdlCdwbg4VG+Zt/5wvQ0Ykqha/JkfvN+cn1EFrfzt8CsSiCca
	BAnrjHtwKtp0kXf9vT/ae
X-Google-Smtp-Source: AGHT+IFYqGWlzR8VFFYDQinF38dCfjE8ZCvm9Px3j5zTOBDRVJpAJEvMsURXg6g0GEroKGOZlrSeAw==
X-Received: by 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id d9443c01a7336-22780e2a37fmr236154395ad.49.1742897729510;
        Tue, 25 Mar 2025 03:15:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f397cesm85648665ad.52.2025.03.25.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tx1Je-0000000049n-0EgB;
	Tue, 25 Mar 2025 21:15:26 +1100
Date: Tue, 25 Mar 2025 21:15:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z-KCPvmBO3AeuiDf@dread.disaster.area>
References: <Z8-ReyFRoTN4G7UU@dread.disaster.area>
 <Z9ATyhq6PzOh7onx@fedora>
 <Z9DymjGRW3mTPJTt@dread.disaster.area>
 <Z9FFTiuMC8WD6qMH@fedora>
 <7b8b8a24-f36b-d213-cca1-d8857b6aca02@redhat.com>
 <Z9j2RJBark15LQQ1@dread.disaster.area>
 <Z9knXQixQhs90j5F@infradead.org>
 <Z9k-JE8FmWKe0fm0@fedora>
 <Z9u-489C_PVu8Se1@infradead.org>
 <Z9vGxrPzJ6oswWrS@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vGxrPzJ6oswWrS@fedora>

On Thu, Mar 20, 2025 at 03:41:58PM +0800, Ming Lei wrote:
> On Thu, Mar 20, 2025 at 12:08:19AM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 18, 2025 at 05:34:28PM +0800, Ming Lei wrote:
> > > On Tue, Mar 18, 2025 at 12:57:17AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Mar 18, 2025 at 03:27:48PM +1100, Dave Chinner wrote:
> > > > > Yes, NOWAIT may then add an incremental performance improvement on
> > > > > top for optimal layout cases, but I'm still not yet convinced that
> > > > > it is a generally applicable loop device optimisation that everyone
> > > > > wants to always enable due to the potential for 100% NOWAIT
> > > > > submission failure on any given loop device.....
> > > 
> > > NOWAIT failure can be avoided actually:
> > > 
> > > https://lore.kernel.org/linux-block/20250314021148.3081954-6-ming.lei@redhat.com/
> > 
> > That's a very complex set of heuristics which doesn't match up
> > with other uses of it.
> 
> I'd suggest you to point them out in the patch review.

Until you pointed them out here, I didn't know these patches
existed.

Please cc linux-fsdevel on any loop device changes you are
proposing, Ming. It is as much a filesystem driver as it is a block
device, and it changes need review from both sides of the fence.

> > > > Yes, I think this is a really good first step:
> > > > 
> > > > 1) switch loop to use a per-command work_item unconditionally, which also
> > > >    has the nice effect that it cleans up the horrible mess of the
> > > >    per-blkcg workers.  (note that this is what the nvmet file backend has
> > > 
> > > It could be worse to take per-command work, because IO handling crosses
> > > all system wq worker contexts.
> > 
> > So do other workloads with pretty good success.
> > 
> > > 
> > > >    always done with good result)
> > > 
> > > per-command work does burn lots of CPU unnecessarily, it isn't good for
> > > use case of container
> > 
> > That does not match my observations in say nvmet.  But if you have
> > numbers please share them.
> 
> Please see the result I posted:
> 
> https://lore.kernel.org/linux-block/Z9FFTiuMC8WD6qMH@fedora/

You are arguing in circles about how we need to optimise for static
file layouts.

Please listen to the filesystem people when they tell you that
static file layouts are a -secondary- optimisation target for loop
devices.

The primary optimisation target is the modification that makes all
types of IO perform better in production, not just the one use case
that overwrite-specific IO benchmarks exercise.

If you want me to test your changes, I have a very loop device heavy
workload here - it currently creates about 300 *sparse* loop devices
totalling about 1.2TB of capacity, then does all sorts of IO to them
through both the loop devices themselves and filesystems created on
top of the loop devices. It typically generates 4-5GB/s of IO
through the loop devices to the backing filesystem and it's physical
storage.

Speeding up or slowing down IO submission through the loop devices
has direct impact on the speed of the workload. Using buffered IO
through the loop device right now is about 25% faster than using
aio+dio for the loop because there is some amount of re-read and
re-write in the filesystem IO patterns. That said, AIO+DIO should be
much faster than it is, hence my interest in making all the AIO+DIO
IO submission independent of potential blocking operations.

Hence if you have patch sets that improve loop device performance,
then you need to make sure filesystem people like myself see those
patch series so they can be tested and reviewed in a timely manner.
That means you need to cc loop device patches to linux-fsdevel....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
