Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF774A0C
	for <linux-block@vger.kernel.org>; Sat, 25 Apr 2026 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777092015; cv=pass; b=lpH+DCBPhFom48aU+sb8jd0ETnJa8WtWqsoznk8Ca3R6/m4SyCGQm+B+2g1ZAnapPp47+qagCEPRpPKfYb1fg85CMvFJvclf3MyISYTcwom481rFjZlfxi/Dleoc5+h1gSifG4pdOPKlvmrly1KsPt6aLx1Ydwrm3ts0xSIsi8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777092015; c=relaxed/simple;
	bh=xLtuymJMWON2mBGcQHzjTwCH1UYQTKN92zrKCsT+iCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4Zu/J9QAyL5OFSFLG/z+g6Lv0jElocs+NH2UPLKgHn4ZScKFG+C8fq8Izrevy/T1/Oz1r3scSVI86gt6F3pJxSAd+nYMma1Ipqorex6OV5/7e5+EmfFVtnFtWqAVvPKsNrOLNFZwOEWzzE14ZPqYuGpdUpeRSU/KosDezfGMxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hruCMQI2; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hruCMQI2"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-404254ffe8aso6033094fac.0
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 21:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777092013; cv=none;
        d=google.com; s=arc-20240605;
        b=Rd8DNdXykzvwKo+NjQfyt/CLF1pdH3+yzCYaigDWw2kcnDS6saWwx7pjl+QggIq40D
         nP0GW+7qbC682v6RA9jIwmZRTuAebMHKy4IBnDjds8l0l2aFnGYjOtN1BWLyfqOeYX8K
         YhOoRx7f+ERwGCXpzGnKcW84ld/c007OL2J5gy8fvt+p5Gdar4xypciMNp95Tymy6+8G
         4JgIAJZQf7EM3UhFsmF+n05F0xXyplOVpRc7swbh/WpUHhBqEsP7DdKU0eozqbxhSSx8
         rNY2aiYG5wUTLQaEVNskTSc9qSdMajLUcerebYkRThFXLKwgk5vBxP1GEMNF8/NqUEdD
         kH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xLtuymJMWON2mBGcQHzjTwCH1UYQTKN92zrKCsT+iCE=;
        fh=vROiz7qELQk6nZOdSyLB0MazAQeXuZrqySqSrxXWLrA=;
        b=FvMGMgiEjgJ0Ca2j9yopfhqohirn5sRoBAAis4YtasDJMmHHLmhGjKxy/Nht1BqXxt
         FkxjBUFh7zRbXAm6YXJmDxRifkx1QxdCeZNDHZ2UQvuHWON5kueVnSgACsCLIzZ9lXQQ
         lBVAGBPBH2tRpk3k386dxevXlYVtoLPWQthBX51m2aMnNRBXHL+9OxQ5klcUu7wvyTfX
         /Vk68q/iXBO3K0005HMR8M6KNeD4CiNhw9hd0zaWZNt44VM1u/OSho7qoZKaBLfcG5DR
         nyM/R8yXZwCWyVwaDIXUndRYxWm5LbFPFa/cqX5ntxEU+1k84g+K0oA1yITbxFTBKsMT
         ic0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777092013; x=1777696813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLtuymJMWON2mBGcQHzjTwCH1UYQTKN92zrKCsT+iCE=;
        b=hruCMQI239/x9n8ofZLGLp8rca8xPAji/J1BTZuGo3xrX3to6bdD2GXKphucjXgnzO
         aOdx7w5vl0pg7fyIx5cA80R1/2srBTcui0GwoZPeWTXacUaiQnimG+tzxSHrjCa8nLCQ
         tjHKb6+7iXXSou61ggoYU/y3w+lPgCMNUpLZRPE/6QWmFa8yaD/6EuSGFkL1alEx0hPO
         mBMrBWnubbzKLQIoGKrqHmRATWOwDiMErbwo+nYZKa3uDo1bXliYP4pQt7ko/EsxSZLv
         9MBCXpvf3I9fxpfIsiYGUzcWZTJOdrtl/1alWTWMpnagZi2RCc7X9VQJUZ+DkjsEnEJ2
         bsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777092013; x=1777696813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLtuymJMWON2mBGcQHzjTwCH1UYQTKN92zrKCsT+iCE=;
        b=TfhaDqgacPfzR7xbPBxyQqlz6K3d7PmGmgltgmq+kIUT8rchmVuuIYnt7YCKnl5AEO
         8r6ptnFHX4Xb6l6QUXQErBl2e7OAS2O5Wd7sT0QnQfjy4FJR9IGG/PrmhXaUqc8W9tsr
         Md19CCMLKkbcrshNJZXwUlMIb+skFPIZ3dQiwFYhrZYpeLw6MX2686w+3ozQTE9P4o+t
         kzT3N9HeGNUfseOt79wT/4SHsERU0XIPhcZYif7KCDSSMlRSIKmMn1LZXk9d7oO4grsI
         RFFjpllLU4h80Y4a5PVFXtWA27LoEzwuttUX5vnSVHPMDrBREzP0vkeIAakrHlFyGnO1
         Gx4A==
X-Forwarded-Encrypted: i=1; AFNElJ8gjUF3Gc4sHRYdmFVDQs6+GT1WhYQu0aGQC1m1KOMielNQuzRkS9wZHlIHgTHY1KNOfZmUTLz8Kr1ODQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzviVVrXXEMLgxU253qu/rWQsvSmENLRKGPTKf2RY9G0ycszrbD
	ZfRaSaNyk46y950Qhkv8YVrm+gLb9Lbt9vOVb8QLgdBwcp1lIAQwVLE0yNA9PxRVdmrpUDdOWVO
	JOEowVuqWM4/J/Kzoq2YpGZccF2PBhPM=
X-Gm-Gg: AeBDiesbEbmQB+SWFRnBd06TFoqSUOPZgLPrbt2FGi44dAwZnQmRY0ATPEoGEfe6h9X
	GySziwYz2Js2bjZGioWApoESVLpNMLQDgxekmtcuzuq2JsSWMZnr3KXMKI8qHoPqLp7EvLTv0mq
	Rku343ZEV8EMtTjTgd3uJ6VKFYDZZKcr7LbV62Ar+7sfV00m7K03jefGrp1dz2R2R+mJqV+dFtn
	+emiWW6bkzlPZMquenhdIEreLjK6TzB3h9ze7gieDwhWip/QTmX5WBGNhKaF7VUgbYwYhuX2CFd
	ALpESHqfkUsNQzkbsBqAsCCK2dwmmHWrdQPfM8bPVrGsrAZqSQ==
X-Received: by 2002:a05:6871:6c0f:b0:423:5641:3d7f with SMTP id
 586e51a60fabf-42aa2afd185mr19075478fac.25.1777092012812; Fri, 24 Apr 2026
 21:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423121739.7694-1-hare@kernel.org>
In-Reply-To: <20260423121739.7694-1-hare@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 25 Apr 2026 12:40:01 +0800
X-Gm-Features: AQROBzA1tQm34p0f-v5wJoovdMueA5nlOszKJTma1_MZWwK1WEg8dr9HC_fNcMM
Message-ID: <CACVXFVOwgw3GA0x83_r1rA0mqbEN+x1oNL2zupBXRLU2+V8qdw@mail.gmail.com>
Subject: Re: [PATCHv3] ublk: persistent device links
To: Hannes Reinecke <hare@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:17=E2=80=AFPM Hannes Reinecke <hare@kernel.org> w=
rote:
>
> Implement a 'uuid' parameter to export a device UUID in a sysfs
> attribute 'uuid'. The ublk server is required to set the uuid
> parameter when creating the device.
> This allows udev to create persistent device links for ublk devices
> eg with this rule:
>
> KERNEL=3D=3D"ublk*", ATTRS{uuid}=3D=3D"?*", SYMLINK+=3D"disk/by-id/ublk-$=
attr{uuid}"
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks
Ming Lei
