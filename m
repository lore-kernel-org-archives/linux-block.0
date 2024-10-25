Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F31DD0D5
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850556; cv=none; b=IANyIwQpoUf1OC2a0VNr2CJn9iTH2gK6sW3Hl0ajuM1+jiJoNmcIES8Q/IkIl8ubtrrjQXu+H1N9kWYE32uRKy6KmXAOrC4PdGdPuIcqUtpuPyv8OYXBPk6fA2uk9CiMcGqKCPTnZ/ZISttX0n1L85qxTYVDFhqsIQEhY8npvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850556; c=relaxed/simple;
	bh=VA9wJnIriGtYqDsQsF1p+nJJ6hiivfGLmhtbHqf/IW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti2ZHRVAvjzeDJolcnku3Bw7qqx5NarE3+3DBNqed4d+9i6Tb/EsAIC5Oyt3kjUL3GUGp8MXSUIYT79mtmDWzLv3p4tsW+Ql4P1avuMjrShAeICNqdruOJpufJH2x1Lhz7yzaGigRFYNbvFy1CqdI/TiqieCA9Ro165JFrLoVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FleDxAXV; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FleDxAXV"
Date: Fri, 25 Oct 2024 06:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729850547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPeMmDy9NpxeAMEK1cYt2qu+mg0HpoHS8zlh/+R0WxA=;
	b=FleDxAXVM3wfxxMySY0lxYtJsSd8Q4dNQzaHTrUevqd+ikp6th43pyrR+ws+jaCkVt5J5d
	80uiZ6qF1BbMmu6TlMelhh80u/ZWcsw6525H1Uj8ZSe7FO3uDDDoT1r+AzPcMrEEDE6wfp
	03AbWsHY0KlMee3xSs1J4LZrR5Berls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Lai, Yi" <yi1.lai@linux.intel.com>, axboe@kernel.dk, 
	linux-block@vger.kernel.org
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [Syzkaller & bisect] There is INFO: task hung in
 __rq_qos_throttle
Message-ID: <66emkxxuzcge3kdd5iwiqexyeqzm3msradf5bhgnxc7zdy3qys@bm5luwh65lgo>
References: <ZxYsjXDsvsIt4wcR@ly-workstation>
 <kuvbuekbzs6saggfxleiaqtl5mleozqozpamivz2zo6pd4istq@c6hfl6govn44>
 <ZxtqeYRHz3hQrR0f@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxtqeYRHz3hQrR0f@ly-workstation>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 05:52:57PM +0800, Lai, Yi wrote:
> On Wed, Oct 23, 2024 at 09:57:53PM -0400, Kent Overstreet wrote:
> > On Mon, Oct 21, 2024 at 06:27:25PM +0800, Lai, Yi wrote:
> > > Hi Kent Overstreet,
> > > 
> > > Greetings!
> > > 
> > > I used Syzkaller and found that there is INFO: task hung in __rq_qos_throttle in v6.12-rc2
> > > 
> > > After bisection and the first bad commit is:
> > > "
> > > 63332394c7e1 bcachefs: Move snapshot table size to struct snapshot_table
> > 
> > You sure...?
> > 
> > Look at the patch, that's a pretty unlikely culprit; we would've seen
> > something from kasan, and anyways there's guards on the new memory
> > accesses/array derefs.
> > 
> > I've been seeing that bug too, but it's very intermittent. How did you
> > get it to trigger reliably enough for a bisect?
> 
> Look into my local bisection log. You are right, that the bug is intermittent
> and takes a very long time to reproduce the issue.
> 
> I didn't observe similar issues during following v6.12-rcx kernel
> fuzzing. I will keep monitoring.

yeah, this is one for Jens...
