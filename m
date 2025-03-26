Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784A1F560D
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009465; cv=none; b=sKRaHzTxGseVmG8UVPxKy+Ai3Q+G3F2n3mrJx1lzUgROD+9MtydN2mePnYu6fP92ejak3Pnbag1LQO+WuGDZm1MSZATQRsiMIEGUKRlJhos2Hg4VpXoEOJMK87Nm8av1hCUJsY86ESSKI/nZPsl7/1fHstgNkbI/zrQfkpz9kGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009465; c=relaxed/simple;
	bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REXh2irOTaDigdIYZMTJCf5Rss+vxqYEE+HPn3uIl0idOUASsKou+eh5Wg7MgNCCHbYTMTHG9Z9FKnFb9LezM86FCbz6QDIcLv+aKN8XIlVD3VkecwqVW/0n2m24QD+hGXeWNghkxDU+rvT/vIImgt4G1EpYR63RY+Uxdzx+K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fhVsjeVi; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fhVsjeVi"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-22403cbb47fso3489335ad.0
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743009463; x=1743614263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
        b=fhVsjeVibWxGja8i6E1jFRPaCSm4bGgFSNiUNeThA3L1bLPxDt80rWYj124SOQxXdE
         +ZPeLsz/6iE7/Q582xjwt15CSyFyVC2+mNN3nzn0w5e0qh36hDRM8sH+NEdrMg7/+IYL
         RuxmLAtfnfDc9c1TI9I5lap9ph4qnWSnloNypl/qcVPXrFH87Srx+ba7umPNF6TP+jv1
         ZSL8bhfdQ7KCcoKb3JO2o2KVY2alk8oB/QbU0M9VFezOUmk931gRRvfYY96x0C4vYKSw
         b4eoqOgNgTrwjkQ1Hj5c/O921TcarZjjQJZ+fmHK4oY7rKDxdba8gKFcKwphpBqxSHfm
         +vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009463; x=1743614263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+Y80Fl4D3XILmrZi78H6SULsEtuP/szZHrz0dbbl68=;
        b=EKsfrQFB5pzKXPh5p3/CeGv32n3ucGugRTzxz6OrdZmDhfHGKf2hyRAHqk8mzJL1UY
         RzfTtX+mHARm/gBh4Yipp2BLH+w6SdoDdrl+vl/UppIVHh6NnNZBxRpVCd5d8ZQdjJ4q
         VtZZDhrLUiJMlrLeBqYLqC7S4qUSnMsxESXoPwWrJvCbGleRCMxLAvAl9iq0v4B+qaA7
         qYX9tOTPEpTFcoVIIBpdL/nIRzevJCTHG0q+fpZtrhk1FePwfnEVAi7/adXf02347I+8
         FDrhDENf+85wgEIG+/nfVNy/Zgcjmt90Y63UvLmUyKXRSZiK8O0ah8GWLue0wze11TaN
         C3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVCXVa2R4MyW5x4iMDaS4j/CMii0tF9Thl+kXVWvCIVe/RJnnFwNVXaB/Xyl9FSE2aVuqJiTlgEqq+cLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuP1PRjB+4BzNk8W2FwfDcU93wxFGGu33Z1PHkxcDiapnYcIrO
	QSwaX6YOxKMPgA2U2M0BxWtLPqIC6pYkqK1vNaxcJTzV02tLIKKMZre9KnShuzteTTLlh9jPi8H
	ga/IvCUNx9mGC196YNvZPdtZVQin1KyAu
X-Gm-Gg: ASbGncvIVUT0PO304rY+StV37sETt9Y72z+wU1BUNoZmQwAT1nPBFbQn3iu2Uw7ufMW
	olv/nJN33v1cgt+sw6J12k83yejSeop+X2NRaDKQdsPKQRuMcCUh1zhlWBKYwnt4UwTPOvvv67/
	wwQBIz0SEofvVLzX9v4w+mJiMpJu3dHYH4MQiEEmowotF/jQTFzyk4b7+w3XAepldcb6bhpnGMS
	ViYidBrGuSK2z/3EeOGuwdXaXtZcZ7t5EPccsf0vGX9y5B9cIf+2I4KhbiZ3vAffKExL0311xjU
	D+LWKYpqw3Uq/UU4PNahH9vMTofHKUoTihNRAKt9iHNM8bi4cg==
X-Google-Smtp-Source: AGHT+IHLdUa435MD/UMv1YIUu9iHHEATcWU21t6cTQMIchpUDMRQTrioGjnCdfUWBnEqYE5PKTj4eW3k//Fg
X-Received: by 2002:a17:902:d54e:b0:216:7926:8d69 with SMTP id d9443c01a7336-2280491ddd1mr4238145ad.47.1743009463263;
        Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22780f16a79sm5510215ad.47.2025.03.26.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:17:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 925D3340199;
	Wed, 26 Mar 2025 11:17:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 85EBBE40158; Wed, 26 Mar 2025 11:17:42 -0600 (MDT)
Date: Wed, 26 Mar 2025 11:17:42 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, g@purestorage.com
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Message-ID: <Z+Q2tiQfZmh9+eSM@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
 <Z-NzLbW0nAIAUdIN@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-NzLbW0nAIAUdIN@fedora>

On Wed, Mar 26, 2025 at 11:23:25AM +0800, Ming Lei wrote:
> BTW, the SIGCHLD signal is ignored by default

You're right, that's a good point, this change is actually a noop. I
think I got confused during test development and the -EINTR probably
came from something else. I see no issues when reverting this change in
my tests now, so I will drop it.

