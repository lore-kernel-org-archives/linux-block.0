Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89622211C
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966780; cv=none; b=mDYn41fNqYadi861vz+wehn7DbbjgOW8FDQ5sjz6U0eLGdlXpmiQsfvzbyNbfH9sM9WKL91tomhnMMAY8REBtFTenN5RHU79V5Jp3wQrpD/isLIszo1CIiyz6Lgdl993qUdfFMBa+9nzNQCSuizAQHeNSMuNcxQJf0iF+a/j79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966780; c=relaxed/simple;
	bh=YQGldYYZN+M+lMKEvXamPZpN40rNMsoWh5qt4/JT0LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEienMj0T9Ev7ZvJCoKw9JMK8MdvEDriuJqoND7CK6ujsE9wbfbLeoCStnMvajbkfH+yvFx6WR77J8wk/frxLOjus1NyeIf1pEoGigI3QAV/xJj6YkSxZIBTCQMV+puMxP+3Vy9tu52G03eButOR90/4qfXkSL/4Fj/aOEppe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eEnYViyt; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eEnYViyt"
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so32074565ab.3
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966776; x=1746571576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCGCCKXBocwMhtCNRTkeUsgiaS7jZ1hs+w86svHkyjs=;
        b=eEnYViytMzkG/tKt//nQPEIKIurRr5yfH+7MFcgmbfjzoaZRjAksLm+vk2PI0yNJ0a
         cpZ+6rWpHJh02LBCjd8HJCDfmIUeipzDmXPar1rLxb0wIgDYFFsltEo8Y1GTFkaZx23n
         /oS0o4vNO1Pf8w2Ouid91DFpI7rE6GO3zLCpUH9YtALvWQeKFYylKLBXpXrAX3w4Z85T
         q8DcY4dx7/N0urlsiQ/MlBXk2oJ94xqa9kiBFTaAtQba7IDfW2N6fU+xMQhlqTdTWwIo
         JedC+UIeBH0944n8c+1f06T2rXdgW8yKQ3LUWOwrZYxXa/nmczxJ5hpNjJ9QW1jIqLa8
         6VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966776; x=1746571576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCGCCKXBocwMhtCNRTkeUsgiaS7jZ1hs+w86svHkyjs=;
        b=I6M4ViRTNUWdzXRGkr6jvYhXdiCGfI/qTBvuJ8rf5J2VQ1eiFHyQbTKcOkJy9NacEo
         d1USgSeBzYAWe3tHgmUYFZci9MmMuARc5GNtMwrkWqzrdznb+pMXbkzcOPEl352Ceoaf
         sBRsNlPhS5r6eD2u+3kPNkE3GW9Yj6XGTZUo90O1eYrPVyfzSo9qNzxn8ooWfCTLqIQG
         428n5TdtH1UF557wsX+lBmwZcF5fqHXL2/H7zlyCVCnflAWLDdgefo4jwQheOe9tdiTU
         P8SEwq7biQo1ZFVCTb48lg5ouUc5AlVaunWXoITubgpNuIWF1rkvTomF6z4rCS3bq3bi
         6aDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFNqL3ciVoaYSaPqFSaYI8Pc2fzVpDrPaGRVBFomi7n50/ZRbVj8poFnO4N406Mc4ELJC4Dh3gWSUdtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SIUGwwx3IIccgmh98nwm/U4KqUlldODT55EHMRSX8ic+JhDB
	c40bTRm0Mk1tEwqlXgcLmY4bpZEFp3BUWNdzEXNUop3EQ4CoLgi+0yEtwvfsdgEZrv/Q2L8kzb3
	Q/u6X2ebE87vyjCkihsOHihR8tND3aHnx
X-Gm-Gg: ASbGnctHJrYtm4HRUDie5ov6NfqYEhWPC97sPnRtABbskXOWBapvmzhMNcHAE9xLrte
	y45qXj5vAEyO8iZ+QOno4v+b31/foo0SEmrPFbUiFMtrrUVADnnRbp+M6wtMyHj15jpL3D1HXgY
	oK2JgbGUNg1rzx92iaWHTkaj97EK3S6/beqIgZYdKPlJM5bq9c/EbU93PKrZ3whfvAWSTcxQyPc
	fWw7xQz0NKMdBHPnEXoPOy6W6UpJsfI9Ovqxb5JqXmqJp6nuPQ5itoRmjZenW6KMEzHd5NDTPmh
	+CcDAKir7nk268WuS26C4GI5gEBbiCrlxuIkx1P5eQ93Fg==
X-Google-Smtp-Source: AGHT+IE+G/JgBSc4QPhJO/JMssnCs47xAcdzkMDhhI6dkdMavoR9/32QK0KRcpc8my2GqlxfzQ2mMpfpLE2Y
X-Received: by 2002:a05:6e02:b42:b0:3d9:644c:e3b7 with SMTP id e9e14a558f8ab-3d967ffec1dmr3337395ab.15.1745966776636;
        Tue, 29 Apr 2025 15:46:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d967d2b553sm155645ab.25.2025.04.29.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:46:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BCFD3400C9;
	Tue, 29 Apr 2025 16:46:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A4D78E404E6; Tue, 29 Apr 2025 16:46:14 -0600 (MDT)
Date: Tue, 29 Apr 2025 16:46:14 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: ublk: kublk: build with -Werror iff
 CONFIG_WERROR=y
Message-ID: <aBFWtvHv84aPTMvi@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
 <aBAnKZCUZWyEJhfS@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAnKZCUZWyEJhfS@fedora>

On Tue, Apr 29, 2025 at 09:11:05AM +0800, Ming Lei wrote:
> On Mon, Apr 28, 2025 at 05:10:20PM -0600, Uday Shankar wrote:
> > Compiler warnings can catch bugs at compile time. They can also produce
> > annoying false positives. Due to this duality, the kernel provides
> > CONFIG_WERROR so that the developer can choose whether or not they want
> > compiler warnings to fail the build. Use this same config options to
> > control whether or not warnings in building kublk fail its build.
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > index ec4624a283bce2ebeed80509be6573c1b7a3623d..86474cfe8d03b2df3f8c9bc1a5902701a0f72f58 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -1,6 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
> > +CONFIG = $(top_srcdir)/include/config/auto.conf
> > +WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
> > +CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
> >  LDLIBS += -lpthread -lm -luring
> 
> I think it isn't good to reuse kernel CONFIG_WERROR for test code.
> 
> But it can be done in the following way by passing 'WERROR=1' to make
> command line:
> 
> +ifneq ($(WERROR),0)
> +       CFLAGS += -Werror
> +endif

I've taken this approach in [1]. It actually passes -Werror by default,
but it gives the developer a way to disable it with

make WERROR=0 TARGETS=ublk kselftest

[1] https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-1-e970b6d9e4f4@purestorage.com/

