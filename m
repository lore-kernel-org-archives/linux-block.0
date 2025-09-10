Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C329ACE5
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526336; cv=none; b=TJ3d3a01E7CU+oxjxMQ0dhKfjfgHOWZdCWl7PwsibzhTCgi6X7Ws+QHFgXDltdMZhtTG9OgPHPySWZ6UKQY/IZJOgIqI1P028O+cdOXQsX9ZueN5+Relt9rC7y7uBlGD8BeR7WZw1D7Sr4QfqNA5Ek1qCVoSWlM+1UbN/QLzuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526336; c=relaxed/simple;
	bh=dNOWI7gSBAR/8CDRKSX9BtwfzV+PfFdf0Quy3tkARWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7JHGe1p9sjxyJNn7krypQXHgI4Y8J4Ksxz+62FoS+oZbnGYq0qZmaRWslovRAnhGSCwzdVOb4MUT51yNF/FY+beOmn9EODU35qm718Fbmml0t+xx5MpFDIGf5QfNTCQA6Tdkc4TFQ6CjmIVDfvDKUy7fCbu4TIO8hVXwyaBwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTwJ2DOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTwJ2DOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757526333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WlcFe5oCmvjN1h1Es6PI20V1rT7RlTmmj6wUjzqcp7M=;
	b=jTwJ2DOzYqOwz4IhU3sO8Z/4mmb6el50DzR8ptdhSG5Z33V/33rNOs/7Vh6wfCLKoWg3Az
	3TuXvKB3mZV/Usn5y+dLViHnyr92z9nZ+GksaRUBIwLDPOJXPe7k20mcyeoIgD77h977mQ
	1VrNI3ffXJnJRK6izGCZdspv5QC8/oo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-StHxun1SNO2lwtKLC2N6UQ-1; Wed, 10 Sep 2025 13:45:31 -0400
X-MC-Unique: StHxun1SNO2lwtKLC2N6UQ-1
X-Mimecast-MFC-AGG-ID: StHxun1SNO2lwtKLC2N6UQ_1757526331
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd62a0dd2so4021795e9.1
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 10:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757526330; x=1758131130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlcFe5oCmvjN1h1Es6PI20V1rT7RlTmmj6wUjzqcp7M=;
        b=vS6nUxVLmKMxb2ME7c6qG9mbEVbqP9YQ8d7BMuXqjzk2tijMFBF0d9CSuOEMQnT/ge
         ytqw6QFAV6ODSzjixvJ5312gOAw11f9og0w6PMz7hW6ZHtWFs9/d1Ho1EtmWckDnaifP
         VWLdRR84SnUU7KOHUCt9U4crUFFwCpouiAULGHXezqoqLCMc9L2uDqz/gn6QTOooM2hH
         zNQn7VTcBrVxp8uVi9f2dUqwXjfobCgbm0pFAihSYlD78JrunK8nSrJrHMrJ4NTQ+1JA
         qwatW2V8ArrLqw6mhaQs6crv6ZS/WH1AARU/5Zp03qflUhj5Q+Fp+FReezAPBpnMFzWD
         3zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9LUH3oJaC0JzG3Qq8MoLqWLxgIdA9EN9w0b778n6MDCaDdu13OoZCuNDb3VXZ2+ckluZmkUmWBiNYLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SebkoN/JFiGCHxQ/72lR+MUmlYrwzYT6Ox9PUSrqR3ADJs2A
	Hg8tLj/BT/PJ2++0q648gGGLpyIgDlHJ3LQWCGcXyxBCCUMEcAC+Xyekih+9yM6yFrPak845snn
	4TNi7LDqZ2HOi8OpqgDVskThTVz3DDlsf8PXOgwjEi5n4eDIv5NOavkpTyMHYRUgp
X-Gm-Gg: ASbGncupNywxcIjUZJsP+dvIWY6rEQhId+mchTzOWoG/Ay9kjgeQIrFB9t4bcintn9A
	VCa/udg6sATbDMSGE/y8JoxoSnsn4bWLxD1nM99A81OqbeqGuJeBBi6Gi+mHimyOzeTl5ihdlt9
	sBcgYRYojN6u8UEb0ykzeLGXaoDCea1wa/XXgjB6nzPuK6aJLxf8iDpVWnhneeLBPMDpwg7IXxr
	E5iPdRLcis6L+e4OJOBtPMuJDVERAhXeuoKVxdf2tV27PItoWQMT2xMq5WJPzcpU4JGt5hWLnY4
	VqSLsKbFHcLYWZPVVeoKqhv4sNECH3FnhM4vEFK4vmrNY7fmYVJM4Iggag==
X-Received: by 2002:a05:600c:c098:b0:45c:b501:795c with SMTP id 5b1f17b1804b1-45dfd5e3da8mr3261855e9.10.1757526330525;
        Wed, 10 Sep 2025 10:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMyl7SOy3kBxxrDvaG0ZHwpCo+23n3nT2GR9WmBKsR0hHAuXPPpMwuMAjIh8YD03Q6O8LuqA==
X-Received: by 2002:a05:600c:c098:b0:45c:b501:795c with SMTP id 5b1f17b1804b1-45dfd5e3da8mr3261595e9.10.1757526329906;
        Wed, 10 Sep 2025 10:45:29 -0700 (PDT)
Received: from redhat.com (128.19.187.81.in-addr.arpa. [81.187.19.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d20d2sm35623175e9.8.2025.09.10.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:45:29 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:45:27 +0100
From: "Bryn M. Reeves" <bmr@redhat.com>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel <dm-devel@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	kernel <kernel@collabora.com>
Subject: Re: deadlock when swapping to encrypted swapfile
Message-ID: <aMG5N4nG58GHrE7K@redhat.com>
References: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com>
 <2d517844-b7bf-3930-e811-e073ec347d4a@redhat.com>
 <1992f628105.2bf0303b1373545.4844645742991812595@collabora.com>
 <a7872ca2-be14-0720-190c-c03d4ddf7a5d@redhat.com>
 <199343ab2a7.11b1e13e161813.4990067961195858029@collabora.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199343ab2a7.11b1e13e161813.4990067961195858029@collabora.com>

On Wed, Sep 10, 2025 at 04:24:46PM +0100, Robert Beckett wrote:
> I see that dm-loop is very old at this point. Do you know the rationale for rejection?
> was there any hope to get it included with more work?
> If the main objection was regarding file spans that they can't gurantee persist, maybe a new fallocate based
> contrace with the filesystems could aleviate the worries? 

Right: I first wrote it back in 2006. When it fimally made it onto a
mailing list in 2008 the concerns were basically threefold: "why is DM
reinventing everything?", the borrowing of the S_SWAPFILE flag to keep
the file mapping stable while dm-loop goes behind the filesystem's
back, and the greedy population of the extent table (lazily filling the
extent table reduces start up time and the amount of pinned memory, but
has the drawback that the target needs to allocate memory for unmapped
extents while it is running, reintroducing the possibility of deadlock
in low memory situations).

Most of the interesting discussions happened in this thread after Jens
posted an RFC patch taking a similar approach for /dev/loop:

  https://lkml.iu.edu/hypermail/linux/kernel/0801.1/0716.html

This used a prio tree instead of a simple table and binary search.

There have been various different approaches proposed down the years but
none have made it to mainline to date. I wrote one in 2011 that
refactored drivers/block/loop.c so that it could be reused by
device-mapper: that seemed like it might be more acceptable upstream but
we didn't pursue it at the time (it also removes the main benefit for
your case, since it uses the regular loop.c machinery for IO).

The version Mikulas posted is most closely related to a version I was
working on in 2008-9:

  https://www.sourceware.org/pub/dm/patches/2.6-unstable/editing/patches-2.6.31/dm-loop.patch

Which is the one discussed in the thread above - I think roughly the
same objections exist today.

(historical note - dmsetup still has code to generate dm-loop tables if
symlinked to the name 'dmlosetup' or 'losetup':

  # dmlosetup 
  dmlosetup: Please specify loop_device.
  Usage:
  
  dmlosetup [-d|-a] [-e encryption] [-o offset] [-f|loop_device] [file]
  
  Couldn't process command line)

Regards,
Bryn.

