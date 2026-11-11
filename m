Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432987;
	b=ALkkiL44JXZ7F4jwDel7ULng0FCxhfGPGztObrb/Edq+orYYa9eG1C1ejxfKAVuwkVBi
	 J4WptScJQrZ9Mv82iYOwh0sluw1JpjB26a/xb/DtF+9Tvp/Gx+x8+PfZQvUk0w8e7kVuu
	 3D2+ItCqhvvQ9BFdHlSWr0gZ02xq3QBE86DNy48nLYYEjHqmvHbEpk/ji1nbHCddDPkbO
	 citYx5E1SCYOhDaO2xW2WJ+e8BUaheKzuB3k0YnOnk+vLN1oi19UuXq9gSLwe/gp5h9QF
	 eOJlQ3ZAin84bUwZc4DL05wKW/EQQZdzyT23t8Y0jmwIMYoqKSnrPWTGJTzH5XxDQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IpkLNmGIFXERWPmUEoHogDFCZKFpd1SbfnTThFLywHE=;
	b=tWeEHCOh/AdJlT0O6g006SQvjbX7tTLEqgE09ccUL/W3zSsV3kjyfsYL3eSaals2y39Q
	 ebboA10XEu0g9HXqDGrMhLMG6MONmu9ctCxyLkZQASs6RMG+eZ4QA8i0o+vzgBen0Wlc3
	 XrDZLmuz4/LjTFojwyGpLOgVnQOFgQXsQfZrf1lnVS//ZXbm2x0hNJoWCH8ti707lMWOJ
	 eyRnyvjSufxbqCvP3laLI5uOa33qUcmTW0nCSLZ/UAdYXhYXYXES6O44VDuwQiI1qZzsf
	 EgRs59ci9X2xNSWjRX5fYsoN5R/10Yoi6qxkHHvninBichIzy23aNEqRuVRhz4S0gGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GnBpcmMs;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E236606A324
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E236606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20260707.gappssmtp.com header.i=@philpotter-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GnBpcmMs
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2458127f8f.3
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20260707.gappssmtp.com; s=20260707; t=1794432985; x=1795037785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IpkLNmGIFXERWPmUEoHogDFCZKFpd1SbfnTThFLywHE=;
        b=GnBpcmMskGd9l/IxsKoy32ItXSvzyoIpyWiJVmW8inYtHzSYTrGZJmWEoxItUBaa/x
         /Zd00UAOp4CNtbPaN0hLyvvKyPEWZNHCg8IEGECAHqekCUgoRDCu5HHjgt4lxKECr6py
         YE6rUj8WQpEE3sRpBqPtNwAQqOORGX/UJPmOYJuJ5NK25RuqZziPGW0EXbRf8KksjW4b
         ou+aKC+BCUpNxahr8uozmdSGkg8Zz7TYByVphBX3SVN6q0seggrp7NKKQbCqVjOsoV4q
         mvnuS8ON5BznGdKvdEPfN8TpuwDgtiks6x3btQ2GP2uScDTaUi5Z7l49e15/taJGikul
         LnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794432985; x=1795037785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpkLNmGIFXERWPmUEoHogDFCZKFpd1SbfnTThFLywHE=;
        b=CRvfdvoDkDrNZFqj1mgC6e7r/T4iAyQd0AaivE02U4lnxKJMxYM4zZNVGhkUTOFNx0
         SHjBOmT3FmpsRAMV1GJLgFDHv6/6K8xW1LKwo1TG8W7zdodLDpe5iVyPzl6Q6DYTu6qb
         9Au51EEvHMYRdbYgq5GXYMzPbyw117OgRSSRretGbq91I93SkhyBmotMgd/2edqpSeBn
         Sb+oeLvb2MMmmhvcXqUAj3I4rycjbV+A+nFXcl3MAaVYqtt8s3rfuyeXajSzamZ0DlsK
         0tQWohaZqDzT1dN3xzABWje4CQdXvoCIi8eRWUfxu6Uk6dGMwQmGITU5P5vLIRhVQW6B
         WLYQ==
X-Forwarded-Encrypted: i=1; AL+hErHlVwd4qdZ3DUYdMssyZzeC5qyuVvXH76By4JCnSK20XJr/fbbnwNuZAHctDIINwiwY9HmFubnx+AVPxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7pBlpADfdLd+zlhuZzhoHn9pnl69Pc2yFoQQCuJkD/4QjZTnc
	clAzl3hkOHsos4c+UC4Xw4rwqljKKyKU0ISKuoGxrpH3PICZA5mRmYcoPY+yBHIuVNk=
X-Gm-Gg: AYBFou36UZS8GHwBpTrAhUNxTrzgPmaeNq+tPo6qrqPlVc5DLWwhbqhCOHmCn8en+Ms
	USANlfc5aANSst6uD/zGNIgJ1eDSC5lm1b0HP8r0c3s9ys7m38oL9WbTa4tnQIsIZ2J1cskbOFI
	nvn7sTCNBVmKS7mTiL/CSyxJq7WnWsLQRtBVn4YLA+dh+3xYzcz8i8L7adZJSuD9rkA1d+QZL2B
	IZt+PH94mxaPo5rh0712E5+v+17nCa6CFE9Fs0pvnQNKJXv3m/PkTwvjT/Du398WXAMt4ebLoge
	oohteCw18OsDe6DDa3tpC+hmZ6R/i6BemyZaN7lljPCg6rvC59zJl5fnIwBOr1zQSdyZw0Isx1h
	203w6bsCtRbDyw6QUZAnRFLf+nCd8FzbXBPeAN273lZjbFt6qRvsRikjs+Gc3Br45oGM/9Pphlo
	59AS0EFMU5pQ1QIX8m9LycxV7tgFhXj+g0AP+abwZiMdmaybnawHIzxv4p5zB0wjxk4LYxEdMu5
	9jt9+AOcUoXeizOfwOpC1n+e1ezqIihNxxifdm8lbbNBDHUBmKFU/KLqtahxdKvlgy1crr1m4O6
	dGeSvJUjLifMTWXRAfYl
X-Received: by 2002:a5d:588a:0:b0:48d:f7f9:6a29 with SMTP id ffacd0b85a97d-499c75526a8mr6569706f8f.20.1794432984795;
        Wed, 11 Nov 2026 13:36:24 -0800 (PST)
Received: from equinox ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a495csm13114191f8f.55.2026.11.11.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:36:24 -0800 (PST)
Date: Wed, 11 Nov 2026 21:36:22 +0000
From: Phillip Potter <phil@philpotter.co.uk>
To: Jay Vadayath <jay@artiphishell.com>
Cc: phil@philpotter.co.uk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: bound the device-supplied offset in
 cdrom_mrw_set_lba_space
Message-ID: <avTf1rFy2Ks8Gm3Z@equinox>
References: <20261022181955.35758-1-jay@artiphishell.com>
 <avOQ66kCxOghtFp4@equinox>
 <CACd3oYMZ+umLbeK3q8oaJUwZHC4zbbFOe1YVEAq3s2v4B+d5Dw@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd3oYMZ+umLbeK3q8oaJUwZHC4zbbFOe1YVEAq3s2v4B+d5Dw@mail.gmail.com>

On Tue, Nov 10, 2026 at 03:08:05PM -0700, Jay Vadayath wrote:
> Hi Phillip,
> 
> Thank you for your response and for taking a look at this.
> I am happy to make the changes you requested.
> However, I wanted to clarify if you would like me to start a new email
> thread with the updated format ?
> 
> Or was the idea to just follow up on this thread and repost the same
> email with the updated format ?
> 
> Please let me know how you would like to proceed.
> 
> Thank you.
> 
>

Hi Jay,

So generally, I would submit a new patch, with the subject of:
[PATCH v2] cdrom: bound the device-supplied offset in cdrom_mrw_set_lba_space

And in that patch, mention the changes after the ---, i.e.
Signed-off-by: ...
---
Changes since v1: Updated commit message


Then include the rest of the patch as-is. Please run the completed patch
through scripts/checkpatch.pl as well, and make sure there are no
warnings.

Few more things:
- I seem to be getting duplicate e-mails from you, one in plain text and
  one not. Please send only plain text to the mailing lists.
- Please put your reply underneath the original e-mail/portion of the
  e-mail to which you're responding. Makes it easier to follow then and
  is standard for kernel patch threads/commentaries etc.

I hope that helps.

Regards,
Phil Potter
