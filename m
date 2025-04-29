Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C625F7B2
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966639; cv=none; b=rP0Vdnx7wAlVRahZFPshFTmwVq2quXpiJWHJ4Cst0Ub4hbcPSY16bVG/Y9R17kTznsU/LdxzNN10cyRFwhnSIop9/KtC2qKy0+KVyuRbnILv0Zje/x7LqLw19VHrKtgux9a5UElzu/HTUxZV7aACO8k+veIo2Z7W1w9DQvgdUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966639; c=relaxed/simple;
	bh=8krmq6gGLWICnf0RDzJsoQ7XVrbV+7ACHvk9dokG9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocEMN8/tCHY8WsFcQgNnoOvAH8+mke39JXFqisC2zpn1Hg7Csz5ldlNBU1/H7HC29tNd+yVd72ekf6LrUw0+UrOBcIeHdcvOfv5vz9IoCgx29eaI5u23T7buuF8ffjKB7jGz+MipIw/5Aw1xxXL44GmLtlp9xGuN3kOVeTLI7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B+FClEFX; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B+FClEFX"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-6fda22908d9so50391417b3.1
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966637; x=1746571437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heVSgyVKUb+FAm8sFJ+MihlxtPVid7pXn+732rMtMEE=;
        b=B+FClEFXj13MZ/uaJ/1kesJVtP2DjvqxSY3YJdVL6sZsj8H60S6lE5WbfdjmSPBrKK
         G+F0uNhYMuruOa8WgFsV6nx8BuIZSHlhndfukzY7NbRYTMEmThMaq7uoePKPcsYqzNTU
         3WTaMaoJZ5A06LoItiViTWxli0ClUyzfQYSm4+c4HZh/tWBNCz6kWWS81J6wbURM2Fsx
         FgfXK91s/t5mo8/MBOHkHLOnhhDNBDJF8InSw3m3luc6KwvoHmT/p/5s7ZM5MMrH6rcl
         R2uIVSW5na7mzOytugz28DVQp7qiLA89n66J1O/hDQ4DbsoCouyN/0pW+2RFRmtjj9GM
         NXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966637; x=1746571437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heVSgyVKUb+FAm8sFJ+MihlxtPVid7pXn+732rMtMEE=;
        b=hQMDJCATldvgTihOvHUflpIeUobJDAayxWR4ao/C8jQYuIv9P6hv+0wx8XN7RAl1Bm
         LsyjT94H4a5eVy/BUo36X1EkvNXrlEfwnxZnRlgrhctTsNtONyKEQ4UFhZRT1y4cLwXa
         w1Ohk2kGUKICBxddKwsLu3rjvBvsPLiX4WJcEDwCqkaZ2ss2uynl+Jo+hBx6VC2gFXbw
         7h3M7Gl+6YudVYecKmfzhTyic0DFixe8WWInnSOgF4EpEt2rDU3KJcXk3HITG8fFzgYl
         wqaC+7NlKxtdGhqIoHOyxApu9ODoHIv4JQauYozm5jc394Z+vbbvhRoJFloDNaHvaxxc
         bo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUIGbY3GuguvdG0EIWuYHqt4JeZA4KVSaDUI0Ep8Q8nqJG80hzNilvxq/MwaSEOISuZJUSLJ8vYR0kzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+eTTBPqWvAlNvfe+KmVLIq71eygeWIj9PQSMF/4u7/MwXf2R
	/IeQs19GqAnuLX6H1L/bgjzep4lclq0q3wkkQp6MmLMKX9Pa7cT7nBAyTFhq/b9Rsadc/Hj/tu0
	/+r0ibpjy05H+zcbYLRZY536v/TlicOV3YdulKYDINMk4YdV5
X-Gm-Gg: ASbGncu5se30ctI3ywaJGPlFoQtpa7KM9/c2SKNltvR+IBs6uRZ5CVc9madIjsz4+Ps
	MPnlx+11feSeNQdlVaL6pJs/iucCIXw6jzHM7UMbxoFQ3kFbwbAEhhuIf4TNZTHG7Sllpah4x9I
	SdXOKP64S4ChbQLtH1bETUeea9jc8KeW+ELrsQ54LiWWASLJp2mquaJtdA9QJ8lfxNBjjaYLjIu
	Hs+WkThVCrIhncjxRunRBK4d45ZA6KVf0nPjBIHC64Ad1gMkh8YF5KuUe00sHcRaiLt/r0Dzqad
	o9HqW6cZ3pkUxpUkAZAyNHCU+1UwzeE=
X-Google-Smtp-Source: AGHT+IEz4rx1/5caK68tQaO9b1jaWJL9Vugr0d/32zWvxjD52I6FEeimg97KRMlrDUksPPYZMyAW7+pUA3Es
X-Received: by 2002:a05:690c:6210:b0:6fb:9495:1650 with SMTP id 00721157ae682-708abd7d841mr21149987b3.11.1745966636991;
        Tue, 29 Apr 2025 15:43:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708ae00cce9sm75537b3.17.2025.04.29.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:43:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 650BE3400C9;
	Tue, 29 Apr 2025 16:43:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 59D8AE404E6; Tue, 29 Apr 2025 16:43:56 -0600 (MDT)
Date: Tue, 29 Apr 2025 16:43:56 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: kublk: fix include path
Message-ID: <aBFWLGhuRO+Rlzon@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
 <CADUfDZoKictpMvAgu9FPbHRLVns4HvBgwddsCBgHsH9nhiK4AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoKictpMvAgu9FPbHRLVns4HvBgwddsCBgHsH9nhiK4AQ@mail.gmail.com>

On Mon, Apr 28, 2025 at 06:14:18PM -0700, Caleb Sander Mateos wrote:
> On Mon, Apr 28, 2025 at 4:11 PM Uday Shankar <ushankar@purestorage.com> wrote:
> >
> > Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
> > error message) if kernel headers are not installed in a system-global
> > location (i.e. somewhere in the compiler's default include search path).
> > This failure is unnecessary, as make kselftest installs kernel headers
> > in the build tree - kublk's build just isn't looking for them properly.
> > There is an include path in kublk's CFLAGS which is probably intended to
> > find the kernel headers installed in the build tree; fix it so that it
> > can actually find them.
> >
> > This introduces some macro redefinition issues between glibc-provided
> > headers and kernel headers; fix those by eliminating one include in
> > kublk.
> 
> I'm curious what symbol was redefined. struct iovec? Anyways,

The RWF_* flags. Here's an example error:

In file included from /root/linux/tools/testing/selftests/../../../usr/include/linux/io_uring.h:11,
                 from kublk.h:25,
                 from kublk.c:6:
/root/linux/tools/testing/selftests/../../../usr/include/linux/fs.h:318: error: "RWF_HIPRI" redefined [-Werror]
  318 | #define RWF_HIPRI       ((__kernel_rwf_t)0x00000001)
      |
In file included from /usr/include/sys/uio.h:179,
                 from kublk.h:22,
                 from kublk.c:6:
/usr/include/bits/uio-ext.h:45: note: this is the location of the previous definition
   45 | #define RWF_HIPRI       0x00000001 /* High priority request.  */
      |
