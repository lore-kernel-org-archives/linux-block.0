Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE844D014
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071503; cv=none; b=J2NRUaE2seOoUhyvyT/YyNpBC1c++N72bppipc8KZQRA6kltBUS3KuXhMCYA7cjoJAQFAwDywzFgdratQLCaB+sxslkSK2EppPmJugBPo4pqfqYSk9gPdmKWP2OAUht6MnjvU5hcNQJoZ1AL69eAGPlhNbwIOhio0GM6LUt568Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071503; c=relaxed/simple;
	bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNjkR5KYezcUN8G8gOosKgJEvzIXhg880E1dils+sB7bfgtbKgiPk8xVW1k6a6O1cLDElgLAM5FIH+CCtj/2wAMq05NLt5hbH6JzRwEfgnicUnc+QhUw0jpOFvUPqK9l/Eg9q3VOtyBX19MiV2gtkU3vnOVH/14L9I2VAONDeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=0iVYiCHw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="0iVYiCHw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891f625344so9775885e9.0
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071500; x=1778676300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
        b=0iVYiCHwdtgZrSMtRulgUDqBDfr4zNjI7HC5CH6oG5NG4z/EO1E9jcW63XTVnPN6BM
         GVKOJghGl/DLC/4Z7y2wivLgF9IJIE1OIyWnPXt4vkrRoPYtA3RrBEKFK14mD9zEkW/P
         TuMki2KdXR4i6nN7lVYSBEIo7uBUDLuh9fkTqqvrUBeYD6nSwU8dn3U6n4Qu0abhbMCy
         gZovGas2YAl5C/RnbnZk3wlWK3uyCQVTBoudkLF/3H37BMtTWelb+IXglFlVEbygyI//
         rWh4VAovOuQGQmElcn5B+jCL4IWAkylJE4L8vREc+/Hq1nYBI5QDplSjx1X+ZeBY+iaN
         cR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071500; x=1778676300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
        b=L7KoxkXM9pXDoF5xDVkMEYMLWXmWMdDK6maXD9JWdl9UbpolcJd5aTZHU5sP1rHKQs
         0u6jRZpd4IMLpwGMdiLX+IblXKNPprVAOHusZj1D0g9r9mKgRMYVPok53x1Puhlx9fBC
         imFCZlycRUZHFJ6xYIdYcsk++WaIjppLpeXWHdtYxa9RxwQoptCHH54aJNHnVPZuS/DV
         9QnAvhrumyzW2TpjXWAHSwp8XeO4CmosNTEGN35Hm943IxPtgTBUd51qAVhvtxG68UQt
         +9Z5mEsN720CdXGNsQARSfm1Vb3m435kXEhrzR2pl+yzNaFwynh4p3412zsXgiJjC3yr
         FJ5w==
X-Forwarded-Encrypted: i=1; AFNElJ+DTFAL8EX9eWfraUFH16EYGusFK5VtMAsHtL8623VwpWUl4+T0ZLbDtkpp5TJ1njoH0KZgsEJJlgpNpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBMabq8+b3n1XFafWTXfaVQ2WDXkPf9J7sGa3xJ6CwC5Go+bM
	WOf+k7t6tDa9s4iKXPiaGmEe46ND81+YiMTnT2nm+9/8wwyotu48Jpukk6Yys5Jc7Ms=
X-Gm-Gg: AeBDiesG1wcT/25G2etX/ShBvH0mp+XXA5pGXylA/RMOhAijUqNtSWNY4nY6pPvWV4y
	625fqXWs1LB1ro6Y8r61pOTLsXMXy65GwGTmtb0YSzLdIjd0WqFi2va5yOWX85oEXpBUTbIrEDy
	WBF5dZkKzbQQbZQnQE78xhA2nz6zeI8otRZjDN19vcyfwKUmekp3+4PsvDv/hcI02iXGSmgJ55I
	DQTuJkuIUaUaYJvYct8prLTBCuNJROtUmj28zk1CSmCRhd4Jkj4jazYszK8MnHPkCsL9lwcDaeX
	5O8AbgUSIy6dARHbRqmpcdIjsBSMnRzw3cJOLRS6QxXyxZXQ7yVQuyzWx9/NtYqiNpbf/hGPumE
	feRRO2jIFD3jwZw4RHgkdl7BrB/yQamX+lKUAH7+tRv4iwyrR9joj/LErWDm58aNZOKFgpHqfLi
	4D95EjWkrRIlgqSp7gsCwflnA0dwiXlrVzFWUCUzx2Ni5vI1eo5mkyEG+kD5zmwlGBKEsZz8o2z
	CFlcqrje/wTryp6
X-Received: by 2002:a05:600c:6612:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48e522b71f2mr47915505e9.10.1778071500107;
        Wed, 06 May 2026 05:45:00 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53108c4csm23047995e9.6.2026.05.06.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:44:58 -0700 (PDT)
Date: Wed, 6 May 2026 14:44:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drbd: switch from genl_magic to YNL
Message-ID: <afs3cyhtAbsr6T1D@localhost.localdomain>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>

On Wed, May 06, 2026 at 02:39:24PM +0200, Christoph Böhmwalder wrote:
>DRBD's genetlink interface was defined using a custom multi-include
>macro system, genl_magic_{func,struct}.h. This system generated struct
>definitions, netlink policies, serialization functions and more
>from a single "magic" header.
>It never really caught on; DRBD is its only user, its internal macro
>jungle is next to impossible to understand, and even harder to debug.
>
>This series replaces it with the standard solution, YNL.
>The *_gen.[ch] files were created with a modified YNL generator, but
>these modifications are not shipped because the current DRBD family is
>effectively frozen.
>
>Note: this family primarily aims for compatibility with existing
>userspace. The next planned step is a new (also YNL-based) family,
>"drbd2", which will implement all the actual modern recommendations for
>new netlink families.
>
>Changes from v1:
>- Remove YNL generator patches, ship just the generated code

Sorry everyone, this series was based on an old commit and does not
compile. Please disregard and look at v3 instead.
