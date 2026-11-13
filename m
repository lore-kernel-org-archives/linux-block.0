Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=T7e6T9AhHTzFDjGmCsyeaQ3rIJSFE6lqYESyqsOZwG5egoPspj5OTMRoDeiaJChkGbxR
	 5D9vxUtI0SPeBYasmDP1PmXv1Nc8qS9dwaesZh4uwLetN2KF5CnJM3mah0csy0a+/zL1N
	 bXm9xx4BVSNjSBG/jpnQvUsC0jUopuCwyppsvCyRSaFn7LoAPqCNpmWqC/BzljIhH2/2/
	 nA6vDNfX3NuQdH22yVmGSvfhbU8H0kqOO35UkFIFepeI4PboclKA1+7IduTRnLAuvPkzW
	 u817B9TDyRzsgYzYGRnjyXQELax7pVqPGqj8W6ekvsH5AD7a6GFgDDwEYDJlSilvLGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=AmeST6Nl9KD5xXKJsmXMRBsq7hQaz0/HVwk+Bebw5vMkReNkf7EJsidiDZm3WgYMMEJQ
	 wK0uRS6JH5eOzY5wuffr/aTMjeuf1jZBIwlIvkvckzGlubHl9ShuOto7jB5dqb+/0DDqz
	 pb2LtBifpOrZXloHX7wFXIStkYwSfWIktHmEbhPUsB1SRK+7XMOx72v3il1fNipAm90GN
	 8bBrTKeyfCRqVDS9TnZw5b+wN9RKuzJVc0MOJHPVyyiIh9VtGAkpNtYmCjThQ3VABB4Lb
	 T3wTZtTEEm9Fc6m5/HSQ9B4M3sx+1hbJ4Yrp2WgT4Kjyts9et1FB5cnNsIbVavesVIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F7606A890
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8F7606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso1170645e9.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=rRZaoaqthOShPtTJoLtJszxxhBVcwuFOv7Py1lh6wAFXkZv4d/r8YfDFPAxILQfAEa
         FGYVM3SEi8an3nDwirkGg6vIZ1kiF2wO1ykf97r5EV5Sn1lOY0+cNRntBEHwIKSsVPu2
         JENBy3/kmnUTUo0fJO8nzfdwrxChxPUAite+F9pistgHFCFpHjFdF6GS4Sslr5UOXbBb
         dTMrPXlV4VtxVon/sVZC5EFYwcRVsoGN69OYxwdRSnM3F8j59i9VtSRnJuhbF2ug/Ze6
         XlRdvwvctH54WS4gpEtm0jmJxA3Z1lhXnk8VJKyGGd1WFiOGuDFIQCdJUlWOA1fw9uFG
         DiNw==
X-Forwarded-Encrypted: i=1; AL+hErGSKjr8KdZ11UlXwcY36Sbxclx9t9/j0HO1Nv0BFiSUN5p8EFaBW2aieJqhwznYkTCPkJpAK2FcWyGX2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+49Qoqco1HhD9DrL4R3zzdFRyxouVesfdpqcbv7Ue3A63CtgP3
	UgrLZRPVdfAfU6bWL16uqOxrPsihNbI/BxAFq26bsINHYHL5fIZRBzewMb+L3R/W0VgY
X-Gm-Gg: AYBFou0ertiKpGpcTYDIiGKfqPFrVhjbGrExaNTBmYHflaqCBGfTHcJw1p6fq6DHAN9
	Vw7qFQfmLVLw9kiQiot6W6RDy6IAzRL6HZ9rYf6Mrno9IcRQDPRjYx3SBdt2jUrbLbtOfajJEDs
	4z/13JVrSm1MDSLDG7tqyOk7U1imJzFaqi5nXnVPuHrOX2jnRMJAsBwiQ1DAYQ/vBSrRYvefAjI
	/RGcjM/Cq/g/rJvbxVXcmCgPi4gk4RekW47KmCAvT260JN7oJyHq6k2zM64FhkJEWgK6OiAGsfa
	dzCK1Fi6PlWMv80E0p73ZqsmKAIQZcaolBFbFMCVx+AAX9kWAyKxYRj4ftSpww7C4bMtvp8SPD6
	um2wi9/w3JrsCN6lMJsdLdstiuu7M0jUiB+UsMU3nJqegzQ8CICo8C1O4XbUp8zG92d3TNAWQwx
	nBB7N4QHL5+9Qt1W9ho+3RI+SZ+KkSXaYuvJvx+XCTYkH1gTJ3Ttogx/1JjF5P6znZRf1ly121N
	asr2QteYiSYtLNV/Ofgvk5QlQ/2+IThViYatMVugr1N3TgocZ9aNyyjCgyXYuGz6OrZ1enly5eR
	J6KYf/XT2E5IXhPO9U3v9t9guY7tpgPnC/tnzcroSw7kla5DnSWa3Zz5FApE6Rg=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
