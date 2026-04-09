Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE377280329
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741280; cv=pass; b=no/aGkSCXtctZ4HWYaqlRwyjoy8o6PxfmO09QjAJc9W0V38iReoc2Rdf4te+k1Aj6UxrjN+ef8YcFTmQDUyW5pw/CiqmUIxNSq/mEJsy93Q3lo7Fj2kfV4OK+l1bOgbjfkcTEvIqWYDAcYdxEHPL9YinYG9SV6gy7PX50vfF4+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741280; c=relaxed/simple;
	bh=rZwffi93ybAcdJMXADnHeGlJeegQbY9s3aIm7/3ybko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDMDuHeoPo6eVm67M4jrNbJzqfLcFRoiVWhKo04glkaUdFZ6AO5jhXQs+mB3EJjo7BEAHjC9pvvaiQ2SwiBF89Ad/WxVSa7reSlMWBiKyTj0BXAvvF/bHpnvMaLVgBc/AL0QD166ka0gOnNZMw0dbeKXe6HJx8LxmBJucRxOom0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbonDWss; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbonDWss"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c2575ff49so1353847c88.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775741278; cv=none;
        d=google.com; s=arc-20240605;
        b=W/lMhL0SZ+btnRMeJKJ+8sKCBhhXDZ7jYtH+7OqZY3AkHrRm8H2Wl+pHmY9vzJcsHl
         /Vl/Lt7BGfBuCL4yMlwKEY73k7OzIgi7y7YNr5sVVmLbZrRpLFoL4QiDbE2HezrigJQR
         90ReSdxRc3fDPBYBX8ZnXoFIBScogOfLeQzukVEh3h9miPf9xWa8xQo0dEvuGO5YMnyB
         0d0owKUK7Rf6U5U0rahYRefcrTSxY+Lksqz3lH+EmIyWWiLg1ipCDfm8QpDkkSiw+Z2i
         bd/tozRoXx70SkCSjmGrKZFH4pWoIaKOWTyV2womuE0mDXd47lKvh9c7L4Lr2YpWthAm
         eWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SSgLW2lGUww1w+mEtWcbH0xv9N4lRbgVUVcrlafpCQQ=;
        fh=TVVy2tk6eF6G7o4W9NKa8Z0SUxmRHBBaI2pwdggEn2Q=;
        b=HXi1iyRW/WLEf4Fbsj+F3IsvEHQtQ26v2jqy2KOXLzu4oCUKCnRkFY8fcmd/HIhhlU
         ZNce99vs4ZR+K9Mdv1rlSBKk0kf61uASwdiv2RqlKXkrr373Ox92larJo+PHg0Gw2hBr
         NSoiZDGRphJVniJaz1fGB1cAl20LQMR/Y2idJPDjskvEV4D9imW0oJg+0SrUdjZPN2ad
         un+uWKBXgHp/qlEUxLJxXSvUDne+OOAJKuIAS1s9FLCYE+fk4C/F+H0XZOD+Gaj4RGH5
         cIgwxi1rERQCXVgL9hkcVtvgctlD8Hydv5c5QjwB45qKG8sdUb428ZtgVfUD5aB+1YPS
         TdpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775741278; x=1776346078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SSgLW2lGUww1w+mEtWcbH0xv9N4lRbgVUVcrlafpCQQ=;
        b=lbonDWss5TEhfKN70nucFOzFAAUKPbHZssCwvi52g4FA399K7IMS0kcHRAE67MWgpR
         S/RuwwXQAyZH1Fu1WJW7c87imbbDNuGstbrzOTXbxhB0Ri7y07DfxxmVYTdi8urNIVg7
         U7YIteUui/mRb8cRywrZCleniqeu3LwoDULl+uvfkUTCIYGKo/K0jnaJNs7FXzQCuh8z
         fZ3F22WL8vc4j80fdgXnBt++lHq32P/pio6YZtgSg4jGdA3jv2KBbFd7yn/vFkLgyFq/
         ixHqPaow62KE66g66or26Wglx5POGR5UFBy+DbbebjFcCAknX3F/jvhLz/8zwWoxPveM
         c9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741278; x=1776346078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSgLW2lGUww1w+mEtWcbH0xv9N4lRbgVUVcrlafpCQQ=;
        b=Ps8DPIznTfJ/QxTa/HFlFR0N1JZ42RM1J/iqVtNuJrVNJpucHA2c5RQNGhcc1T4qVy
         wTnyJsbQwuOys19vO+TAdC3o9kV+/4mKUX2pgB7FvHD+kW6wc+f9x0Pi43Of/Ct3ImiK
         t97UNaE9B4hCDlFhfyx+kPBdKtVv6QZTgfsudtX1zVr1WSbdxRym+Gn21xM/IrKmpFYp
         RRBSapC8VOx7pGlMSr/ioLd31xczUMyUDykm1suuaYZM1nAA9n1HHcTh6rfNSxow6Wom
         7Q2Hpd/B7BZf/L9Th6jLxetL4r146w80GkT8f9eQGPPoV1rdeScCFZAcCaZgbtJf+g0o
         ZYKg==
X-Forwarded-Encrypted: i=1; AJvYcCWLPOpjwTJOWIUTmEW24ENVMjLawBOzeMVl6X55kONyekdqop7dPWPZ+iUtkOPLoXuyD93+OpYPEWo0ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gzpuz5qSfis0NI10Kl163eVqUuIQhhslTRwRQ9NZJhqivYVw
	pV8TLnxMJiUlTf/SSjfTjGpFCcvCDqxHd9OZnvirQwKQH8+3ex/DKTYVMeTQQZ8PnFrNFmgHX/I
	NHRAX2+/Hk/7wzcZzINFNmj7OeJrZAj24us59oreW
X-Gm-Gg: AeBDiesDStuVKlsveeem281SHwIPfNCLeWQyUEXwpa5Ct499cnfEJcFx3oRVo2naK4J
	dIiRtFgiYtCG8Rv/TrMJexLWAloDjiZKunGNyFyB0CnLXF3rvoL69TqlvgiOJrc3/1hZKGMVanl
	OgMYtkUWnnzNwJNFxQh407lPMHD28H4EYBx8uRG0Z2b754nk/w43+cxNyQUS7VMCEbsJrJiRtTK
	MemOknxLFOzdkE8c2kYccJ8XDGXI1KjJz1lMhc/L0u2pR98TH7cyLB3k4UMTwbBY0D+JTxCBHGC
	IN/3slav9p9q+wnQI40vSVmpE0+23NZ/pdTmGg==
X-Received: by 2002:a05:7022:45a6:b0:12b:ebb9:1c18 with SMTP id
 a92af1059eb24-12bfb7677e7mr14255895c88.31.1775741277160; Thu, 09 Apr 2026
 06:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
 <20260409064221.GA8378@lst.de>
In-Reply-To: <20260409064221.GA8378@lst.de>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Apr 2026 15:27:20 +0200
X-Gm-Features: AQROBzABld37YFX7b1ocgf4VIYf4LZECmv8yyuXU4xOdXbNQfERVT-WwGPBep-w
Message-ID: <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 08:42, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Apr 02, 2026 at 11:39:34AM -0700, Bart Van Assche wrote:
> > The four callback functions in blk_holder_ops all release the
> > bd_holder_lock. Add __release() annotations where appropriate to prepare
> > for enabling thread-safety analysis. Explicit __release() annotations have
> > been added since Clang does not support adding a __releases() annotation
> > to a function pointer.
>
> I have to say I still hate this with passion.  If we can't propagate
> the lock context over function pointers it isn't ready for prime time
> unfortunately, as much as I'm looking forward to it.

Let's see if we can land this: https://github.com/llvm/llvm-project/pull/191187

I think we'll be bumping min Clang version to 23 for context analysis,
so hopefully it'll be included in Clang 23 and should solve the
function pointer false positives.
