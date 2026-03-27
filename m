Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D93FBEAD
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635491; cv=pass; b=i7OqIfMLH47LLykGN9Knkg4FbNQMQpoHXyjKRGnANEVAfYgsaniY4bdqGCepKmfBvr6QJ38OHr4t8h16x8WYBSBEaOov9+gvSKwexvLbflNoQ55oRiQoucD1rg4pljEHeM7kTE/TCC+LUyeh8WgjAKIau8ZShkQWWJjvwmk8jpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635491; c=relaxed/simple;
	bh=WRjVNnS/2keoCkK5cx7mfnTH01uLNE9si03wjdpdknU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVZXxTKdNBIEXQd56HShgKbSG42K6RJCsPQ9ws+tLLTj9S+guwG1xWw6Bi8leRpy1dr/E0jFR533kBMYF/TlZeS3V/2fJB5h7YDoJWD2iw0tL9UGdUAxv1+ey2zylUHH/AcpZGa0JWLO7MlPlx5N4E/R59+lsD9HP3KDG8jVy0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kpZBuHjM; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpZBuHjM"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2726118eec.0
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 11:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774635485; cv=none;
        d=google.com; s=arc-20240605;
        b=JMkkQoJTsBf4iVdivA9VMkfHqMXt9XgWoX7WYd4aGLGGy7C7QQkhhVC26BmbYJ3D80
         usCmAduz5DiEFHiZhFnXYeQPPrvyjIBBD8lTpVLAPCU4futqRCB7H2+gTRlgLgMir5kV
         RcTZn684WKk7/Ychvgazx3Y34VFZys60OpziOjvrDQBsiDxu79qvs6dq1BCOgHw0lRIT
         4d89H2a5YKN6ZoNBANZa5L8aqFRnM2Wq/+sCkeDUP66bTy9Z24G/t0jRcEqw5Op2cWKP
         wKpP66n/srzNLz0x1P7bc4O5b8xeX60UoRz9beL1kgPAj7TqzL7BsU1H5IOz0Xbx2Eps
         tBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f8q3vMVf2Ii98ZOQhSJlERdZZnD7QFduR3TM7RIEBlA=;
        fh=BWosWk783YjrK79qa5sM8AJuQMWMk0PdtgE/eeXN67E=;
        b=AAOYc+07gPfLZ5YC65NU0Rb7RBIGe4lPijzyaUIkwzLtpdMucrTKhhLGm656SwZzUJ
         fvmVCfeI1rrB54CfMQFQCVWE7FgqgmjCHRwpfiDRuE7Ou8YBudNXCAmjd30ISCUjPQn4
         yIBZrNOmpEBt0TXIIIebdB4O1tzeEVVH6RYL2LExkZOF+2ebQI3c/QYUwrZp1eh1glar
         7CU5lc8kUhPrqVZb3uaVIFTvUUBtv5hJTM4aDqGQk1JbTTAH/jQy/y2p4n7VwLAe7ztE
         44JHtAzF8pTg6MWE5Lzyvfp7OIwNSUg/4a5fWufon+sEM6qLA3cbreXlYsnWEAsJzEph
         yrWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774635485; x=1775240285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8q3vMVf2Ii98ZOQhSJlERdZZnD7QFduR3TM7RIEBlA=;
        b=kpZBuHjMl+zdZe+L4Lg+7xS5ExqAJj4eQokRwuPlL0RdOUr/huP9E81193L5d52qPb
         EwurWRXuzfnhkOmR4RwyUawpmzXC52IGhX82cO8UnCUAMPi0htVbYLvS+i5OppuJas6r
         vDEG7PhU9439WLYAwjPXDKoodNND25k344TMoOFBMnyBRq4DFlxDmtqLlqqJ5z9+0aaK
         N2ES7bs4iQdhPzqQbpeQpQphAYKpGoziGsvkSLxOp0FF5ywtArLfKFQRoULX7Ep8uoz7
         AC6HAJCdGOp85c7hgbazXCb1nNj8AcyH/wwpJhFHRENz19U9vtStCSYMZxoo70YZhbQV
         1s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635485; x=1775240285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8q3vMVf2Ii98ZOQhSJlERdZZnD7QFduR3TM7RIEBlA=;
        b=WYZgTUdOaF76a4iAQztjpsqNo3bbg6wqFMAkq4EpTQHtfQPoRAlpZv/JR3pHxRM0GA
         ta2vBHw+hyDC9ORa7QjKly0NpVZdHheBjowxVhtkGHUaMdgpLwLp2hqCUPhF0kI0c89h
         atodw2vDPHM5ylZVu3AdlyC64wxgQIHJoRShntZzkQCTT8hApq4QQ87wlCy3RpLCR5Yn
         //EMik1ZwBgHogF4nQ8WPmXHzObP0p7SkgxGt65c/2MHifFn8b3lmVhBAB/txosN4P7I
         C2Dkd39ppCGN+TZqSW8yg4r5yZeBFWhB2rHrVQQwXaZYBygWlJOOLFL6TAR3sL6L4zEC
         WM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPZ2fGD8JKE22ghhgXmzhT7Gq3yeaM3LTPu5dz0Lz33MNSWoK4gsx4hg/+36Z6e7UTxE4bfBnLClUrvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUkDEm9WSIkoQs6kJ9MJV3HHoIiiT9p+inS5vwiG7Xb+iUVGj
	/DNd/zEHnNoiUoJZ6XW9WKC+VeMq7EHkHEbcUIGVQ86e/10JziMtymW9pwenFkocfLn4OPx/Ita
	FwuWdxH1pjEIft8iFLN1hoj04bERNBOPSRIHugjh0
X-Gm-Gg: ATEYQzwPk4xQz8zUgFXNIfnxXT2OH0zblWVTBrQIoMJqhFVOWgaVjD5FFblQIoyw32Y
	NjO8ZN2cXj5BwYSCF/VUXUCRcKtm2JtzY1552uicli1OOCNh+NCVkAi39t7JCk7gSy+7xOywe4g
	MGcpBXwP0HVSyViZ/3J1cfk+hJEmXqw6OkRF2l6B4WN6c0jiR/8gFo4jY9yUrItpyTBFjoq1tCT
	Jr27Znz+lzRD5MBpnXq9FA6wZ5cjMQjtbtITwuPi5m9m3ETB/wg/ofcn7j2hnK7VoD7YRB2bhj+
	a+Fcp0V0kFVG8JYyyJufUkrPqug9vwp/YGMz
X-Received: by 2002:a05:7022:4393:b0:128:d39a:b141 with SMTP id
 a92af1059eb24-12ab286de1emr1868401c88.17.1774635484135; Fri, 27 Mar 2026
 11:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-3-bvanassche@acm.org>
 <20260326062507.GC24071@lst.de> <16074463-9242-4c62-877c-54b0939ab892@acm.org>
In-Reply-To: <16074463-9242-4c62-877c-54b0939ab892@acm.org>
From: Marco Elver <elver@google.com>
Date: Fri, 27 Mar 2026 19:17:27 +0100
X-Gm-Features: AQROBzBTfasUmzCHQvGf20HkMEsyWk1UkesA8T3DAxQSleG1s3JWc2Gw9DgqWCM
Message-ID: <CANpmjNMiR2_s7iyXAT_nOdy+EhxR-oSf_KR089L_66d13JidCQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/26] block: Annotate the block device functions
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 16:55, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/25/26 11:25 PM, Christoph Hellwig wrote:
> > On Wed, Mar 25, 2026 at 02:44:43PM -0700, Bart Van Assche wrote:
> >>      mutex_lock(&bdev->bd_holder_lock);
> >> -    if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
> >> +    if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
> >>              bdev->bd_holder_ops->mark_dead(bdev, surprise);
> >> -    else {
> >> +            /* bdev->bd_holder_ops->mark_dead() released bd_holder_lock */
> >> +            __release(&bdev->bd_holder_lock);
> >
> > This sounds like ->mark_dead also needs matching annotations.  Or
> > can we have a way to annotate the expexcted lock context changes on
> > indirect function calls, as that would be very useful in general.
>
> (+Marco)
>
> Agreed that this would be useful.
>
> Marco, is my understanding correct that Clang does not yet support
> adding lock context annotations to function pointers and hence that
> adding this support would require modifying the Clang compiler?

No that's not supported (yet). There are various design options, each
with their own pros/cons: the one question is if attributes should
behave more like type qualifiers in this case (enforces functions to
match), or just be a best-effort thing (functions may not match
function pointer).
