Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214192233A
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465757; cv=none; b=Ac5ZHTXfWAHN4ZWJ8Cr6aW3L2td2c+CO2QIeunPSgyOmJqO9CVfQnQsUzqDazi3fKnkQLYT2OeK71g9yADN7l+z0GnMJ7+P3UcilBjhVQS5mNMAvus+E66l/jE0cQ7d56uo2mzwS1pEmFYkunuUKZm+vmY6omtRfC5Mvenv5p/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465757; c=relaxed/simple;
	bh=lYAIK9TUQhTdUWvoyfe8nkpGFBTS0UkDrYL/F3RU5ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0I8CKSrTzhdkdg3w+rjOP53evNxJ9TFs3rlf9D+XXM8mR/Cq3I5noTX4YcVw5nQeDsOHZ1o9I9sOKN0aS3m1ADwaYWw0e8vdeD4AR+Xcj+Bug7ioSVNmdr7Z1xou4pmoznEYSrWfsxk7cZ07Tlhe2O2YFFlLQdXMOQoWOThoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq82kMKS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq82kMKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711465754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqFPSBjiFPMVeG85c+Q/gaConfoMRa6RcAAdKjLZdF0=;
	b=fq82kMKSTHXjh+UjZ1D6Cb2uUYjRgsVdDMtsimtj/QaTHFmNzHj8xfEV74Mypvj4/tjuGp
	ci2+opPwHC5pN8P78A+srJJ4Zh8Nzl6nMwWYEzkHu0IsI6dDRxtUpEHkp2Z9GtOrzNydt7
	AOTkw/qfSP4ea0cHlDSfmnfPdM/dXrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-hJbeDm6GMbCCt60WDJtT0A-1; Tue, 26 Mar 2024 11:09:11 -0400
X-MC-Unique: hJbeDm6GMbCCt60WDJtT0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D2EC185A789;
	Tue, 26 Mar 2024 15:09:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 325E62166B31;
	Tue, 26 Mar 2024 15:09:11 +0000 (UTC)
Date: Tue, 26 Mar 2024 11:11:05 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org
Subject: Re: pktcdvd ->open_mutex lockdep splat
Message-ID: <ZgLliVcood71SFNE@bfoster>
References: <Zf20dfwIdayItxsO@bfoster>
 <Zf27X6ZNOwkXjc6A@bfoster>
 <ZgC5ydajy7i0f8e8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgC5ydajy7i0f8e8@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sun, Mar 24, 2024 at 04:39:53PM -0700, Christoph Hellwig wrote:
> On Fri, Mar 22, 2024 at 01:09:51PM -0400, Brian Foster wrote:
> > Ok, I guess the reason I was only seeing this in one particular VM is
> > that for whatever reason, something happens to invoke pktsetup during
> > boot on that guest. If I boot up a separate VM/distro and run 'pktsetup
> > 0 /dev/sr0,' I see the same splat..
> 
> pktcdvd is completely unmaintained and in horrible shape unfortunately,
> and no one is interested in caring for it.
> 
> I can only recommend to not build it into any kernel you can care about.
> 

Heh, Ok thanks. I was poking around the code a bit just to try and
figure if there was some easy/incremental improvement to be made here,
but if so, I'm not familiar enough with the code to see it. I was
particularly wondering why the multi-open occurs across the setup and
pktcdvd device open and if that can be avoided. It looks like the main
difference is the nonblock flag. From digging down into cdrom_open(),
that is what controls whether or not the drive is opened for data or
control purposes (i.e., so dictates whether media is read or not), and
so that seems to explain why a blocking open would be deferred to
pktcdvd device open.

Anyways, it does seem like the warning itself is benign because the
pktcdvd and backing device will be separate disks.

Brian

