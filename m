Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390E3FFAB0
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587109; cv=none; b=Z6WPWWJXvzcT6sruiX/063PqzfDQbFQX4bLH7CLHCqz2jZlH3inPHRoU5I/kPH1oeMOR9sl3GBdP/e7hmBPCuiktZZVUYa087KsQWSqaAHTk0dr2vZzoJ8da4NlvKvtWxXO71NhDXqcMMgQ7T0/Ml8QMyOCVNZNU1nn7wdtJHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587109; c=relaxed/simple;
	bh=znq26plhwxInEG6rMm+26AmDR8mHesOo4g2XGqxnm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSbsG5Rjeuaa2AVDLThKpUTWkUprRcJ99LNtWEqlTD5ZAq1EKVDVK7pcrah2wIfbxzNk8ccQuteSIq1+/beoC5vxjUrJYKPdYlDXo9qw4v02BEhYsWrInX4kydfqup+xmHj1JALnSqT4shel2ZmVuUDzdm6Kf2WWgSUTtB3lDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iza834L5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJZyI6bX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iza834L5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJZyI6bX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783587106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
	b=iza834L5VL4ghd3uS/qwfK26v06iCDCHiZ2z7zsaJ0ylLcpa1eWADTc9i9X/fWm19bl264
	QgI4N5jNYKNxZTzfat48yOmrhvb4Ppip5zPTruRZhbA8nwMVjFxHxJrVCipqrgHMlrH0Qy
	8cA6E9aJVUxYbReHXlmNFov4FiM2kHE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-9vpncJ_COM2B2irMb6Ze1w-1; Thu, 09 Jul 2026 04:51:44 -0400
X-MC-Unique: 9vpncJ_COM2B2irMb6Ze1w-1
X-Mimecast-MFC-AGG-ID: 9vpncJ_COM2B2irMb6Ze1w_1783587104
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c55d5ce5so9840975e9.0
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783587103; x=1784191903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
        b=WJZyI6bXBH2/vvILVynx+GtNbmR3khzYZB4phm3GjRrJbvpTiHoouRN8+2DCzLMxC6
         PdRkuIGVEeX0C6AhiWrPW6FkQC9tlPf/e2VfMQD8UW1s1O6/kuK6V4WWdcepQxyLpLqw
         kx9HskoNwbR56G3kbwQqug2O8Z9YhaUB/5Dm7ggZfCNbYulWDUJsy0hIdbrH42Pwd3m/
         ++AWF9jw9zLOuCiZO+0mWyi+LKsd7Nak6+gm/LqlJfCHfiF1rwEOG/6ydqHTcjJE46Kf
         iLLF7aZbq5azY742cVWimJkQxtYoTfCbP00sNNkHxLSGX/YCPOMYE9z3TdPo2qjtm61Y
         YZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587103; x=1784191903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eb5jDTkXBTPOE342mmNfwm5lDoBFxjZ2KPIK/Aydl/0=;
        b=G6CJHknvn3Mvyz5TBucSh61Kkf6TC+TPdAZ2WWuBb/WZC3ZojYcX0e+Nmjbz4j9PfW
         HH8GbfSqgSN/d7nlpXr8Njg82Q9MTAgouQX1Sv4Gz2jHbOTknXrEY/xXnGbboOpi6Kqu
         INdoaPz/uy5iSeQ7Bc8AUjJ+E3G1oTmzGxPCGiLyojC6AfRdjnKjyDJ3tHP/t4fWWV+Y
         9xB09NXn89I/j0TeQl3n/3b1fgBllGFivP4OlmiFFXYCztAT3rj7Lxsua2ZPAsacLcy1
         3P3RSesHNLW/pDgJYM1iJIoVbpvz+p/2CGfY+8Cnj4ezxThRocR0zmW7s9xSpA6c4xlk
         JbJg==
X-Forwarded-Encrypted: i=1; AHgh+RpJjKonD4D7iRJkaCB56GnN5GMzZQsIQ5uz6PUR9EbtkQu5AQz5/4Eaqb/CF1cJK9XLFB0e378SfAzNuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8zf9QZIcjpV3dRlPdpkzrFJZ06v1SccYKVypXMwptPnyQtG4
	YbceGSTuDKJNMml8fGpiMSEqCr3/pEBApIkEten2pVNCngaKWbLW48694772F326z+iYtGSNAJ9
	8e1+HoMrIfuMT62GITqu0ogBh2dK65wymLAo5XTwm4VZldCZC7gMYKWal8k81mFM=
X-Gm-Gg: AfdE7cmEeISJ13F/Lk24j5Dxe2GX9mH/wHgOKERRKomk0RSWJUz4ODSSTBwsvOGh5jI
	2W/wq8K/A8mNK35vrt9lC/iTG1Ulf1BKCtD0Sy1QFIb/GCE6bcp/4B8wnGri1CMlWcCfHDK2KDC
	GnsD7v45cByR2Mzey8HCunuMAamhQ50wihHUSk1jiO/R7ULCW9V/ZUYMeqOISWrdYD3oKTf9CEK
	s8YcbfKSa2YlELk8Jn9uKZX5qQjgZ4evHFgFQMWdum7QJl+/kzBRw1adyPO2lNG76+xCY20qAR/
	gm+W4yKgfr8vZ17opcQhh4sRakGG/8d6ZOv2r8rXmlGN9uTk9mqx9SXZwiGuwH5o93mvOjj0YAj
	F1lqU04KfUt5rz2fJToOAC759kfqgjha8bufukYQ+294oog==
X-Received: by 2002:a05:600c:628d:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493e6862b68mr57369625e9.12.1783587103526;
        Thu, 09 Jul 2026 01:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493e6862b68mr57369285e9.12.1783587102989;
        Thu, 09 Jul 2026 01:51:42 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm144100205e9.2.2026.07.09.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:51:41 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:51:39 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, axboe@kernel.dk, jack@suse.cz, 
	brauner@kernel.org, cem@kernel.org, jaegeuk@kernel.org, aalbersh@kernel.org, 
	tytso@mit.edu, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] fs: report direct io constraints through file_getattr
Message-ID: <ak9f0CXSegLq8l5w@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260708011843.1036846-1-kbusch@meta.com>
 <20260709071352.GA20180@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709071352.GA20180@lst.de>

On 2026-07-09 09:13:52, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 06:18:43PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Memory alignment constraints for direct io can vary depending on the
> > backing storage hardware. Provide support through file_getattr to report
> > the attributes necessary for applications to know how to construct valid
> > read and write requests.
> 
> This probably wants to be split in one patch for the new UAPI,
> one for the helper and one for each user.
> 
> And especially the UAPI one needs a much more detailed commit log
> explaining it, including why this duplicates some of the informastion
> already in statx and documenting the semantics for all the fields.
> 
> Andrey, is there a man page or other official documentation for
> file_setattr/file_getattr?

No, I had a draft in cover letter but haven't got to sending it to
man-pages. I will prepare a man page.

-- 
- Andrey

