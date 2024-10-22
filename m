Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2914A08E
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627169; cv=none; b=P7adGPn5xK0WC/vTxg/veJ1NvW7sZ3oO8KJzQE1zIsyzJEw+RuCeyY0P7UsaD62asDxGOOgGWlHSvCc9Eo+Lj7HqC56Ap79C/ean4AuYxkKjIpf8R/iqUks3gcjY+xUxKPEXr9LzqnUcuA+SkZZIC8ulvf5d73q5qM0C3YvaQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627169; c=relaxed/simple;
	bh=r6otyKA3WLyak03vklmEbpRTCqjFb4oYyFuxi1qJRDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKtAsWjz7MmPCkK9mDkQsqDEES/1qmGd1kT/7nj3P1YiDXoC9FEsdQAVrf+gnXp8MOFmYf5bc0YniTRQP+4ezFsB43sEeoTTlaZsfc13LEfwUquWr1bqqXpI0uM3uEiNohDX1YBhg/vTbegyqXJqKm624NTKSW4CWPNuYCiKl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=jp/XSFjP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="jp/XSFjP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso1162172a91.2
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1729627167; x=1730231967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjczLJzU846pgk/Nf+gEz1IGPCfQMK9BEKbQgAkTrs8=;
        b=jp/XSFjP9WLmJBFfYEF1nsnMxiwUse7qfMSpUMRTHQKkP0839i6JsEhe7ULlm99PV+
         o2+ZG4Hc1uYBHBWQZShzP+qjz7mBNww9MBVIrXb/Gl748CtfMT5hZWUKaRXY51oIX8m5
         ADFGdPhW5J3E4V8EBrf781aRFczWmugl4HITXt/Q+yo6kfqGJ4J7W1k0rOHwJLid/ub7
         ZyT4GFws3h0QVMDzUfXTRtqpdbAULmoG9Bjy9vCdGAJoc9rwYMatVGscpxYlSKVREJsI
         TxHBeJy1OQncF9jgL4LSC+aZotvm9ZiS5XXYAXF22xrAz6+16jfydDVIXbpxFsG5Rd8O
         7UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627167; x=1730231967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjczLJzU846pgk/Nf+gEz1IGPCfQMK9BEKbQgAkTrs8=;
        b=ZmCaJNVRy589VZHh+02oxjFvpWEbHzqsrvwXrAnTVhr12Ebi5tCxJG2wQj9dD/cEuX
         Ivj8C4MpfOioFTsKAWh5vcz2or1AcRBqFa+2h50phB28HU+7lz3nGt5iFYWS3+3qXIDU
         RXRs4LcoFAY1WuKV0S2PVnG2wJ4jurfJhZYkIht8X8JZ9SO8PrrV+uq52B7wdnETRcTN
         aLggRqs3yMW0zGUDbaGQXn/MxUXr3eF76lhtFvNaseIm5hZJTx16GdO4EEms4j9mzYvf
         3XWipLE/gC45OxcsAs2Uk+SMeQoQPEbxmjoS1j/LxasgCf7f5o+VCqnFDJZfWLanXAgB
         rGAA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmznsVGnnBfWXL3ZSU706FtkL5Hrdkm1crz6JZjuzH0GyuhrTmN1R7a3BlyTxI4/LcgjriFBwhysFiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyi7zTrentFMUUDXb0tR3OxdUSHOG2VLfkqmR48i892cySOw4j
	IYltxDuB74kzsT1ofCcl2VNSFyj66Uj9Z/hH508G7qnaiNesACIMgsU7zgkpswJ3K1fU4i2bKSE
	J
X-Google-Smtp-Source: AGHT+IG0PhGSKJ1IxiGqheB7b0O4ycpWVH5TGjBsj3+UTjIsqfm7JYVK9+WbQbe3Sw1ZlC5jd7OckQ==
X-Received: by 2002:a17:90b:1081:b0:2e2:abab:c458 with SMTP id 98e67ed59e1d1-2e76b72f825mr36709a91.8.1729627167317;
        Tue, 22 Oct 2024 12:59:27 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:9251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad3892bdsm6653800a91.31.2024.10.22.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:59:26 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:59:25 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Muchun Song <songmuchun@bytedance.com>,
	josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
Message-ID: <ZxgEHW0UuuLcSY7_@telecaster.dhcp.thefacebook.com>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
 <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
 <7C429559-E91C-4732-901B-0D49C2D083F7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C429559-E91C-4732-901B-0D49C2D083F7@linux.dev>

On Tue, Oct 22, 2024 at 02:31:53PM +0800, Muchun Song wrote:
> 
> 
> > On Oct 21, 2024, at 21:45, Jens Axboe <axboe@kernel.dk> wrote:
> > 
> > On 10/21/24 2:52 AM, Muchun Song wrote:
> >> The memory barriers in list_del_init_careful() and list_empty_careful()
> >> in pairs already handle the proper ordering between data.got_token
> >> and data.wq.entry. So remove the redundant explicit barriers. And also
> >> change a "break" statement to "return" to avoid redundant calling of
> >> finish_wait().
> > 
> > Not sure why you didn't CC Omar on this one, as he literally just last
> > week fixed an issue related to this.
> 
> Hi Jens,
> 
> Yes. I only CC the author of patch of adding the barriers, I thought
> they should be more confident about this. Thanks for your reminder.
> I saw Omar's great fix. And thanks for you help me CC Omar. I think
> he'll be also suitable for commenting on this patch.
> 
> Muchun,
> Thanks.

Well there goes my streak of not reading memory-barriers.txt for a few
months...

This looks fine to me. wake_up_process() also implies a full memory
barrier, so I that smp_wmb() was extra redundant.

Reviewed-by: Omar Sandoval <osandov@fb.com>
