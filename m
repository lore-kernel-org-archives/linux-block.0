Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364C3CA491
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813449; cv=none; b=D4+P06KjPhz/l/cfK4lSrZR40klq15ikQo7RIDbEPeXv8eHuhy4ahDUyQ5f9bR0ZL/AESlg/ORGjpZuBdZAmkxHBzZ13DEJE3mwXAO9gyJvtoqisNsQGnGMFaU0+Kg0Eqdrm7BZ6uOTuhj1/dVOMFho/lFAsmTbxlclJAUluw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813449; c=relaxed/simple;
	bh=wPbiL3tdI/BIIx2e1JWAGJkK2ZZp7TiXD7EE9S7Nf4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oQKEWp52zLlBIMJpBvJ2Mi2+7uNVHwFj95ydP2wqq7KRLsTZtD6fcNLUXxgD4np68WWz+iKRiCU5EkqsPUspgOUPPMhwvlzVZBUXIw2jrKWjxymXD2JTrtZ+HhQd8HtK25pKpkZIL9tj+Y1sTicvME29pe7BymVLjjHmo2AkAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GzzSUQDE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GzzSUQDE"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bfe055ffbso709594fac.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813447; x=1780418247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azootos90mDhLNr0xGgJIJN+KeILdcujsZY+11LjFE4=;
        b=GzzSUQDEwhM1O31ViCKM6Ww+oTALx2LQLj84W8oSLVpHCNL3moCoC93Af1ZFATwLmA
         1V5f1vGX+WHziRTSwZh8YtuNpGxknLPNJ4YUvx7ko6REjLVp4ZK7Jeft5KfSnFnYtOaa
         CcyTREFjf9u8t8ILNwzSeyU66Z3ZsRuR1Y62at8arCRV/ChAtg5h4GlB9xrsPMAgRhml
         TsJSrpo4axeKiQldnVgRSCh0KRN4idDmzQ9PlSeodNSrRpORN6XHNES7CdCpl7jKiE/Z
         fczlQtLVLmNlZW0Rbdl5G/U9VzHx2c5ZrV9DPIV5bVDa60jRNO8m9w/3a6Q0/urQbS42
         bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813447; x=1780418247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azootos90mDhLNr0xGgJIJN+KeILdcujsZY+11LjFE4=;
        b=QmrsOh48cWiqb0fHAmpEZIk8FT3Ptlt6+guwEl687X2NXC8vD+bgNFQx35GK+gYcU2
         6GMNMXlhLAsTC+4P9+RWQq/i4AX/0+CarOiblGmJ/IVOm7XspbctzmKwvlllOTZ9E0Tj
         pQDmYbbPtot7jsh0pp0r4MXCLkvOVGRAaVn1Spv1gNNs6ER2qCoRDY1/5tIkMtPKKJzX
         cd75CKJ+5Vc7W8vcoEGwOJc5WLY6N5cPsEThLMLAhULlagWcgDn0wFKBOTyH5qdBEY7/
         CaS35I4ti8ozQjarYAm1Ond2Cvu2FymZqDXAFVmyP46WFfa9JuglKc1w7HI9wbT2+TnB
         JWZQ==
X-Gm-Message-State: AOJu0YyiFvbchlZdbY5AnMceOgYtX9AYq5ZAGaSoiZLKU3NeUbqVJNIu
	i7QX0OcnTi6MSPsr6s6Poj3BorySfNVTnGbVuoa97xdJWtd2Vd4uPHqSANOBr0Ph4s4=
X-Gm-Gg: Acq92OFlV3jyU02n7lvXoHtG8p1Jd9hS+1unBC76zt0zrGroa5cJnc4NSRsznnEmH3/
	5o8k1W4mo+rdfTW1c4roWS+VZHAYY5hFKUwQY4prLIQZChifEnVrR6uHNcXGIcJ3FRbfEneik9n
	0tkpBJ4xpa0iWoL1rg9c9QlAJpieCg6oqNu1kFw1qAWMNjPzhN/A29ai3kiZWQq2Ln64tdUxtr9
	bZc6g77rpgRFFtvJcSbiXVdOAGij8rkWo4P2XkXW7C8KZu+h1t7S0+A+K0zFoM4bt1Fqv42pq4n
	lvU1P6SXaIn0BeyfzLgjd8fWF0N7eYUjsEx7SiOxyV2A8+6clzbfPLLAgBeQYXsRE6qNbanDLiL
	Yivojg+dfWQWkyBXuku53+q7uH37KAVeb58IVwavnJOWBN1iXqBcWE2j88SvnplmOdPuyLmzqKb
	Ff1F9PIw3OXHh4iGXHbAzI2fOJo6uSpZoW+hVmWz2YIul/K9jT0h/i+BzjtoJPPz1waUOnrz5e1
	yM=
X-Received: by 2002:a05:6871:60ca:b0:42c:f89:755f with SMTP id 586e51a60fabf-43b5aa7e063mr11931015fac.9.1779813446741;
        Tue, 26 May 2026 09:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Arefev <arefev@swemel.ru>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20260521072857.5078-1-arefev@swemel.ru>
References: <20260521072857.5078-1-arefev@swemel.ru>
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-Id: <177981344495.464267.5969625320718476596.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 21 May 2026 10:28:56 +0300, Denis Arefev wrote:
> The bdev pseudo-filesystem is an internal kernel filesystem with which
> userspace should not interfere. Unregister it so that userspace cannot
> even attempt to mount it.
> 
> This fixes a bug [1] that occurs when attempting to access files,
> because the system call move_mount() uses pointers declared in the
> inode_operations structure, which for the bdev pseudo-filesystem
> are always equal to 0. `inode->i_op = &empty_iops;`
> 
> [...]

Applied, thanks!

[1/1] block: Avoid mounting the bdev pseudo-filesystem in userspace
      commit: b518ae170f6c411cac2d5f320278c27d902bc628

Best regards,
-- 
Jens Axboe



