Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B431CEAB2
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293430; cv=none; b=A6Sn3QCpOmqfz+hE6HEbvqWaUBgwlzCXn6M+g3y6moouaVHm1jyVobeD86Zw8VNpy+o+mryxfTD4hrqHHEitoGavBnueaoT+mr+QoaEtyfBSKxp7S7V1i9NFyOA/A+tskfO54A6xhWH1AzZLZoWs2wtwgc9E09e2oOV9+1L4tPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293430; c=relaxed/simple;
	bh=KBcsmp5at+jJviL3J+0mcROw+lr8j4mNJ+AGY+9OtGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX0i4aVrvWpZ1RLyBbbC0lYkcxYRZe0aN6rpTt/Dj6THd6jyLz2TAkfXH++0YyT0TUzHrQjXSfIe5jSNocmcAsmo6l3O/vTTcThqpK7Sc23gBjT3+1kot88De6AHeWVhweC9yJIJUqhvycx31yKG08N0xHsPSXmEmwMUtthm0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrW0c073; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrW0c073"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edaf8773c4so16567051cf.1
        for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 17:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293428; x=1764898228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=PrW0c073q25bN1iavUUz4yt2Lb7EDAaUNYuID8JvdL4Xqrpty3F94+Ub+MRj0sIpmp
         7Nmg1jzeK9v+6Kc4BEAiYFTKakDhLljigRRz7UoUMWB6OdCKU6IrpVAsnLJV+qcZuZ0K
         AQOogidI4CxP3264iBMSLFJRZK3azTv1tSdqVs4vCLmM+5V01xSCHiUKoJRx4/qDyeyO
         ou86edpciL0JbHCvXrJT7szrI9evagYdm8cVZel9ce1nudjrAB7LgZrc19a6Sraa5V77
         s3JKZxI9slhgWAGGYoLoDC/6s2dZ02JcvdJ0jLTnEXhJyWYtTkIodODXxsVBw3p5t+CB
         lWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293428; x=1764898228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=NgjVYcwhiHy8U641hcu5+H0Sa5kiQwh9FPHwXYlOYBxq6LsBosweNhTXAAEhd8ZqpR
         I8E7vDlzZmPqu71gE3lvDS+j++rQB7e6Q/+pZTcP+yV4i2JFZPKWhreZYGI5xJ7QCWq8
         GPi7zw6+wIgcukiqfr6OaYFzlKodDrb9axl0+ahHdnushsAvIdSsJoDjeU9UHhJQ3x3a
         lDz/puuI/N2hedR3w6pMFAAb0DzzMfaSLsEYt+ZQRN2Hvtg6C1Dli5DeW9rQHb5ki6gk
         8FWk+qBZwdKfgGJEhqrvOlWRsD6PJD0Z0IzC9NfsuyrNuG9qCtEJHNcUt7CqT4ksWhnE
         SjiA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Mt9ytj5yzHxESSvzOUC2zbaAZ7r5wJ7mcP2T1AiXP15NIvsU9UJcvHSuHWhbenUncy1rCO6NPiSxKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQpEN69MPtJbk6VydKPmo6K1gf0TTAqHY8f+rRZE2tO+BV2H7
	6WFW6SlhgVDpG5dVtziTxd4lr3XMlidhEBtkBEVJfBOUp5uxrSwg6IpkC9dKyY8KRh1OALzvv8b
	zwFSTb/TqqSfASgTOTgrNgFHOZhVYUIo=
X-Gm-Gg: ASbGnctitVhOpzg4lgc7+y3IHGmRFYAuFVCTwCUSgUjftZ1hHs//cFChExg1nYdqJ4Y
	qkgVhO/Nds5dPXkj72Bw2tONkMrcC8WdBjEGuAJ9OS086+y7CKDvfz2MaG0WwAlAqFOxUDxNLHI
	13jnXfkybJPRPGWzGUgxjAnIKKjajsBu+ld/syXVWHq80mKD/+PZh1Pfi6BZq7IeCPboxiFyNVV
	BFbTPcyXVLDlUbNBZoWVpqfuLFaevSJOCXapuIcYPVDmpsO7BlPOtHIIdlg8p7cOzB7K6s=
X-Google-Smtp-Source: AGHT+IHLwC+N+hhLqdlufghZ5fhnM4rSYysjvUV/1fIoNRweHCYWM0pQrvWGMYNUf8igtQ6F3vcEMbZAHieS7voSeP4=
X-Received: by 2002:ac8:57d0:0:b0:4ee:827:7e62 with SMTP id
 d75a77b69052e-4ee58b05b62mr339066531cf.82.1764293427985; Thu, 27 Nov 2025
 17:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
In-Reply-To: <aSf6T6z6f2YqQRPH@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:29:52 +0800
X-Gm-Features: AWmQ_bnZka8N-6d6tnub2wv_mKK_srvt07g0FExU0PMtOqpsh3yITqQM0jweo2c
Message-ID: <CANubcdVhDZ+G5brj6g+mBBOHLyeyM9gWaLJ+EKwyWXJjSoi1SQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
> > No, they are not using bcache.
>
> Then please figure out how bio_chain_endio even gets called in this
> setup.  I think for mainline the approach should be to fix bcache
> and eorfs to not call into ->bi_end_io and add a BUG_ON() to
> bio_chain_endio to ensure no new callers appear.  I
>

Okay, thanks for the suggestion.

> > If there are no further objections or other insights regarding this iss=
ue,
> > I will proceed with creating a v2 of this series.
>
> Not sure how that is helpful.  You have a problem on a kernel from stone
> age, can't explain what actually happens and propose something that is
> mostly a no-op in mainline, with the callers that could even reach the
> area being clear API misuse.
>

Analysis of the 4.19 kernel bug confirmed it was not caused by the
->bi_end_io call. Instead, this investigation led us to discover a differen=
t bug
in the upstream kernel. The v2 patch series is dedicated to fixing this new=
ly
found upstream issue.

Thanks,
shida
>
