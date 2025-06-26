Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA32F1FCD
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899790; cv=pass; b=UzYcz2SEpIDdpAqFj15q5Mh8K9RIvPrWfpmqWnWDYNtOzGYrGRR7zVNk8h2Jh5P8UJyl5D63fDpoPOMcY4qqqmwKHR2MzsHbsSRZQ9qVNLpoZ766FlZPAcoO+JQUoJDy2VIJ/NjaFNrmRSxbTij6GLwul7VF/gQ2TDmfyuChSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899790; c=relaxed/simple;
	bh=0H9nOGIme6pYLphqj7jMGOnecf4BuEwDA9uIXqIPLp8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IOaJbH2U3++35e1HRuU4PdMa8USa8E3IK4r340qHg4z/hrXum3bWX2v8gi/C5FB1azN8a15q18dmjfBkGGx42HEZxc3DboeV7mt9WxX6eBvJYCZZSIYdx2FiKPeIcsvXnd5/bOcbborFhudTfoL0nIXDCK6LdbvBDKafvki68f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=oIX99bh/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="oIX99bh/"
ARC-Seal: i=1; a=rsa-sha256; t=1750899784; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=byGRdHo5hvuPrIzdt8hKJtJVHx2yH3Zk+OQ+aoj9f0j/0YTGJBBMPZeRqDUsK6XVoStaQAHdRBqqFt9QgHLF2amqAD3WvCVkX5cxBHQaW4x9/2UoborpXYwMig07zp2zi4wiBuw3yrvYTS1XN+WN8dF1IRPXunUIn+e9DvDUds0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750899784; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tJUV53lvraX6SB16OCk6aq2DiAFAVi4Je5MkbEUhP/U=; 
	b=eVtPN9T3fThl+mWNVpkvBPAgDV1zpaxpka6vhqAG5BimE+lGiQ/oWbXWOrBFvaBJXzF9ItN9mgLqJr3RFD2GoM6ITsNa+2489V6qQLzwil0pcxV804880KVY9uZB6kzwBmufmmrX2kEIMOIwf3Ey+gswJp2y7yARg7xZa2zT8/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750899784;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tJUV53lvraX6SB16OCk6aq2DiAFAVi4Je5MkbEUhP/U=;
	b=oIX99bh/brE/T4XSdLxGECqnZG7kH4/qqOSqX72zzwqAdXKmLA22XfVbLbuclgy0
	FFbY05VWlPqdlzA2gkDs6EpK0sG98F37CoxDCesGdJzDx7EDhU4uUUS1T55N047Vp5k
	f1quMukqKzmaba+ydaezKGKTJs2pttDrTFzjI0aY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 175089977996030.27910721233252; Wed, 25 Jun 2025 18:02:59 -0700 (PDT)
Date: Thu, 26 Jun 2025 09:02:59 +0800
From: Li Chen <me@linux.beauty>
To: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>
Message-ID: <197a9c26954.111bbb21f2606644.8376567975474145103@linux.beauty>
In-Reply-To: <qgon5pxnxccucafhgz76v5aqliypnbtki3kvvhu6o5l7f3l3vv@oqobbtx4gkma>
References: <20250624121057.85689-1-me@linux.beauty> <qgon5pxnxccucafhgz76v5aqliypnbtki3kvvhu6o5l7f3l3vv@oqobbtx4gkma>
Subject: Re: [PATCH blktests] block/005|008: double timeout on machines with
 more than 128 CPUs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Shinichiro,

 ---- On Wed, 25 Jun 2025 20:20:50 +0800  Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com> wrote --- 
 > Cc+: Johaness,
 > 
 > On Jun 24, 2025 / 20:10, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > > 
 > > The current hard-coded timeout for block/005 and 008 is 900 s.  On large systems
 > > (e.g. 256 C) the test spawns one fio job per CPU and therefore
 > > issues 1 GiB of random I/O per job.  Total workload scales linearly with
 > > the CPU-count, so the original 900 s window is often insufficient for
 > > high-core machines and causes false failures:
 > > 
 > >     fio did not finish after 900 seconds!
 > > 
 > > To keep the logic simple while avoiding unnecessary test flakiness, bump
 > > the timeout to 1800 s whenever the system has more than 128 online CPUs.
 > > Smaller systems continue to use the original 900 s limit.
 > 
 > Hello Li, thank you for the patch, and pointing out the problem. Your idea to
 > extend the timeout can be a solution. But I wonder we may need to extend the
 > timeout value again when we have more CPUs in the future.
 > 
 > On the other hand, I can think of another idea. How about to cap the number of
 > jobs with a specific number? According to the blktests commit 8fc7ca8300cd
 > ("tests: use nproc to get number of CPUs for fio jobs"), the fio option
 > --numjobs="${nproc}" in _run_fio_rand_io() was introduced for the workloads
 > which "just want some IO". So, I think it is allowed to cap the numjobs with
 > some number, such as 128. Based on this idea, I created the patch below. Could
 > you try out if this approach avoids the problem on your system?
 > 
 > 
 > diff --git a/common/fio b/common/fio
 > index 91f4b23..f4965db 100644
 > --- a/common/fio
 > +++ b/common/fio
 > @@ -204,10 +204,12 @@ _fio_opts_to_min_io() {
 >  # Wrapper around _run_fio used if you need some I/O but don't really care much
 >  # about the details
 >  _run_fio_rand_io() {
 > -    local bs
 > +    local bs nr_jobs
 >  
 >      bs=$(_fio_opts_to_min_io "$@") || return 1
 > -    _run_fio --bs="$bs" --rw=randread --norandommap --numjobs="$(nproc)" \
 > +    nr_jobs=$(nproc)
 > +    ((nr_jobs > 128)) && nr_jobs=128
 > +    _run_fio --bs="$bs" --rw=randread --norandommap --numjobs="$nr_jobs" \
 >          --name=reads --direct=1 "$@"

Yes, this looks better. I'll try this patch when the machine is available, likely next week.

Regards,
Li
