Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550EB1DE2C8
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323426; cv=none; b=cA41ehiU8lOcK1Ne0QkznHZQ5mCn3rhfDHLYnwLcIozVMViXUgccebtsVCQWMCgK9Zt+5ZWQNXNvmun3e1OswTnzJ2ljoBKgoaC4edcf/YnOJgAYmTiyeN1+ydiYpaz8t3Iz1Dn0u2Y0CJ8b3X+IgK5hzDRCFLUknaG7VBmzLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323426; c=relaxed/simple;
	bh=UwaP24eoj7BAO8Lak2j51EcNk4KY03aM+kQNAApp+2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqK9eynCf28Sp2WpPXHBNuTMcENTjgH2VWVZ8UfxdpBR+cUHV8COJehHXss0WNgxSJ/E2qbD+K9z58aq024ny1/4bx3uXsI5PGQ1HWqOCcDioBgeAPtGJqiRVVNXE8m4OgWWQTsNa4Rm1aAhUv8RGx/uGmzTxCW7grK4g9lGehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gnb3AEZn; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gnb3AEZn"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso6160730a91.2
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742323423; x=1742928223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TsMwNq6dS1d3ieUrbOI/pA+aTYiJTlgfP0K+Ojk0RDc=;
        b=gnb3AEZncd6fbKF7mJfq/jXKUoJck0nos13CCoBrhyOPv/McfWG0zlh81qkobpt1Lk
         BSDlYbXjbLt+1hwS68CI/NmZQXVEGvUyCz/b5NSmqXF/TSgPmO06oKw1DwkVUNSRPRXA
         WzOlm30MB6OqVjXIFEbXgq4rF+7W2y2Z8+aq/zAS/UZrflXVdyvcCohFNPGd2xfgCWgp
         FLa70uf4TtI+4vL9SsF/LJX/Xz/g9Vnw8c2Najmp+P2U9OxExCirEtphiBa4gcLpcsNS
         mTQVgVbu+OTPPg2eadkkMVIM4DH2IeNUtmLCCf0Kl/l24stMGNwz/joLWtKKTV24FrrK
         dPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323423; x=1742928223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsMwNq6dS1d3ieUrbOI/pA+aTYiJTlgfP0K+Ojk0RDc=;
        b=lAlydoqzm9HaR4lhfk8n6zO0op+0FFzCgVMVfhpDKjN3xGGBOhLgoYJ9mcGBKzqq4Y
         NvQPUaeA/8ODedHvx+42ZiZTbBDh3y+mpiwT+wJacLGu1MrAHAuRmnC6kNdeNb//Pn5E
         8XfKrsRh3P7AIMyklSQpXQLqYEIUYMA5W9/bqXCNxnP0k+m2I7u67wa5qtAPReFaJkAm
         Emh1ceWSD1ITThpN5IKwaggxT2w1aFPwbEXxIpo4JNM4NXJPftDAEFNaQfP1Zl7qI5WV
         JrKtDEsqh25IlHMZFPjsTYIXtQztsVHbU/06R6hD3jujc/TyHZF5ZkGQVIDto0IdHnIg
         qfTg==
X-Forwarded-Encrypted: i=1; AJvYcCWU0Rqor0iRueAJmPxSdKSOb5SmPuxcKsylvG8Yjs6fSJ+bw+5w4uyLdirb/IBmJG+sILOTLgj+uO284Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YywJOXIdTFzQD/I+k2RzIGZfdqilKM2zRc/Rx5s7y6Fs6xkCU6e
	tu2AS/0D69y1oZZcmZePlJZvK68PfAO562aeH/zhLpCB/cQsJgIEQgWEIf2j6zYa8WB2kc3pI9N
	EnZtDn99x3RktZBWZzjq9YRkT0f4b1Jht
X-Gm-Gg: ASbGncsA+vJmKC3GtDih/Nz0fuUN6scd2e8lswhGtpiGTOB852ikiAz/KuYwpmfye6J
	q7GBDgMd/C/ACg/0OH8Opu4lPF6pvy5OT3J02bwS/t5FHxZqHlYpsc7zMPAXpORmmulXT1sLMCL
	+msAP2q6VkkusPNQSgYPFK2I1zcnRNgTJrZj9kjRLVhTF/c/IlJ4piJBzQNtfMJvky+yXfnWMnZ
	URId79LA87r3zuA+PIJM/H/D5Of+XWmTWhOnlbf5k+3e6p85vVgXa385PsdMWlGhG3rx0cZRAP7
	hv/vMVm2c8K4LcEVgD8LAD+i8U80WDezemLp9YZTfzh9/4/HLA==
X-Google-Smtp-Source: AGHT+IFWTk06yMJSEhTtZps4nH0pFGVLFfy6gG/Estl8Ef6TsMtY6Cf1VyHXIYrxQl1YrKtf7FtRTkEzgHAZ
X-Received: by 2002:a17:90b:388b:b0:2ff:4e90:3c55 with SMTP id 98e67ed59e1d1-301a5b87b52mr4252334a91.27.1742323423509;
        Tue, 18 Mar 2025 11:43:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3015374e6f6sm752584a91.15.2025.03.18.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:43:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BE5923404BD;
	Tue, 18 Mar 2025 12:43:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B2B86E4020B; Tue, 18 Mar 2025 12:43:42 -0600 (MDT)
Date: Tue, 18 Mar 2025 12:43:42 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
Message-ID: <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>

On Tue, Mar 18, 2025 at 12:22:57PM -0600, Jens Axboe wrote:
> >  struct ublk_rq_data {
> > -	struct llist_node node;
> > -
> >  	struct kref ref;
> >  };
> 
> Can we get rid of ublk_rq_data then? If it's just a ref thing, I'm sure
> we can find an atomic_t of space in struct request and avoid it. Not a
> pressing thing, just tossing it out there...

Yeah probably - we do need a ref since one could complete a request
concurrently with another code path which references it (user copy and
zero copy). I see that struct request has a refcount in it already,
though I don't see any examples of drivers using it. Would it be a bad
idea to try and reuse that?

