Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAA33B6D9
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014823; cv=pass; b=Lcu4K02i3dxtHOsZkCrPu9LhNtSmZW3Vg6IAIqJq0qZoddaroF+VHGWysKU47R0Y7u5gH2igdBrDOo+d+GcEZapOlO56a5orfgEeBLDt2t5cQLm6mXRJolMxkjhLaa33CAyl51DphJRe/o0nJOFVIgRm862cgZzPUKpqkHqxGjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014823; c=relaxed/simple;
	bh=TOm9y+/mhaIt+WJ3XhAryBy1CJ5N7kLgO3K/VS3uHKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz5f2aXw5GXZOhZLKOAiRlUH0Ll27jmU/GLqnsfA6+rb8MFNz6ZOKrfycZQRK/0X29N7faGHEnX4U7zCP6kacIF1POVhrokg/xYYyQ4nlMjxaAT3miII/rNMQilqXOhPAGAqSLxu0qm2INCQvAxATO1dP+m7ZhXBE9afEXFGJJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtDGkl7M; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtDGkl7M"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304dc707c7eso514077eec.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 07:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014822; cv=none;
        d=google.com; s=arc-20240605;
        b=h/Zwrel0xNrU3sEtfwmijVvLi/8eEil6L80vWWjRwcMvOlhqS2IoE0O+Y7aU9qWIX/
         EzP4/ZxUZxuF7aTwqg/FYHn3rPxgz+5eec/t7CcgGrsJJKLLfHam7SEy9F02ZXNaXCm6
         hveGutkfGOQijoWr7QTp0esnxjyAwaiTTw5lvTvYFGym9z3v2GqWI4TBKPTsDBUZzm6D
         xB6Njx5YaCJ1EZXMvk3Clh6DTJWJieiY/5wsVjkCYE1q0hHkhWSJ7zVQtIMnURsbwlhk
         NvnBSsb4fvrtND5x/08x3uOgJL666B0GyMuFWt3W+8MfwZpyS0fm/J0Ory/hOUT+buI9
         +5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TOm9y+/mhaIt+WJ3XhAryBy1CJ5N7kLgO3K/VS3uHKY=;
        fh=9T8cOrue29FIH+3esNwfKF31nQuFFSU7qiuyXBTsPnc=;
        b=UBon53sa8QNV8zpszLmoEf46Gz2LNyNnWImuAkyQeFaNwtxksudinNugWRQmCRnMMk
         lsvR0Yd34aY9Mz2Y0glst6VGGdz0Kr9DPPwpE7Thqsmvza/XXAfbGZghVTwTJqcIv9yu
         93MlDqtb6vFXixD4BzLMjNTNNgsy7WXC5R2SXr7MUfdtYqDchWsbkMODLDwSeTNWW7s4
         1iFf4YzEURpSE8hIUEYbdQ9VtoMpMHPVe2jVHClvElK1mzdEv0u6NpsDKajZfuI3BEkN
         bSPqb4SfJwG2bq2fYb6EZ9gtj6cvk1HEW2REZSkymmXf6OEMI0nCR2nKd0d8z9Sv/mv4
         dmjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014822; x=1781619622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOm9y+/mhaIt+WJ3XhAryBy1CJ5N7kLgO3K/VS3uHKY=;
        b=EtDGkl7MgIIn85UzF7NjNMBjQfc+byHqHECOSyAQcMhqOZR21u5CvLku+rl9uGWuC1
         eSq+Pl6c6vI73EO3RGJvSyfyH0nmRRWZeTl4YZUhJA/u8pQDopxDvf8oB4dz5A/Ip/6z
         JV8kh56dyt9LkU05PIQq8yEljZ6ZFG4HUv9/Eyy/o/B9EBEtvyiL7sE++vEpFN1tT/rB
         QMbSK+xKhhNtIBX4EcURxj2BbkR3mSCamZKlhR4e9qF4aORhqHjGuxDhRoM+QVpiKV0W
         vjwVHjL5IWSyRAwKndQYUE7O83pDn9QycFkDKcMgqsGc6e5Gzb9SHkQBlfqFTkACxaSX
         MnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014822; x=1781619622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOm9y+/mhaIt+WJ3XhAryBy1CJ5N7kLgO3K/VS3uHKY=;
        b=ARhGJmADtxdtghm6TOzveaiN8RoMI6MaAr4zeYXOgXitWS82w0ot1SArj96lQaItM5
         IukOMyDbpYtPmKPSzBWnxnuAJXfbN38qE+agxVbtIY9sssCE/6cviW0ecagX1cc8kXXx
         BICkkgugQ5HNnZJO+Q2aDhSnfn2CSZIk7YFz9foN26oaY7Fx1iZERoAAEFUx5h4fQYIG
         vAqd1XaH+FOaYI6netiYG2kXhSXFVmQsNtvz00uBynndM0IJtEo+NNR4fJ3fDyBivo5R
         m/faWX8vIOA0MelWJDGtq9k2S/VGcWvpfq+QaaFzKC4i9dwR+p3qg4GRsetcVFn5elUZ
         DWmw==
X-Forwarded-Encrypted: i=1; AFNElJ9O6vxrw26ZIX8xDxzDJo2tyfhaeyFEsGnxUdgBnlIa9iPt1S662G0visuUYeoHTm6wAHfwtqWxuNuH2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rvZYLEVp2oQ7jXbmUKaUzHxEPmNyyqYmkg2wFCsXaPdfZdjm
	K8mbx7yGfTY/9TgEIy1Gm+2NItjwKN6Blyb8gQN5TRxBB/a9xVRcOrNxIcCqjtvOchrvh4Xdc/n
	K2no2tCx7goHahTdS21JEtvZ0qCDTn9o=
X-Gm-Gg: Acq92OHgzgFsJdxSdmlqv1LCezocEKG9hy3J98PIUiYK8XsT03GBDW3je1m/D8tEXBi
	BUOzXlUjtRinbfDsQUKQmpEWvCzlJPTVYKFM/YdeS5EZCyVWHqQg4cGqtfFdVuOo+rElhLbDZra
	9TyFUDRh05jmhJYv7GvaKXn4FayYHvHb6iW9RPDPui2JqhMENUjHt/XRmlfwwDlsgIp7HsTGTsW
	eNtlZzRvb7AxZJJwDs4drPCt8rvuUo86DOBmPgdlpkpD1SpsFCDYJuDWvwPlfC0urBhnKm1/MlM
	DPVzju3DOuK4ak6QM2FwdlchKDEemZroGjs1BmBcfmkaHsbDD7m9/1RzMesqAf70szez6RqyDz0
	EclOd5+Gxcp3mD5wqBGkbQSPpBUD4YIMwyw==
X-Received: by 2002:a05:7300:320e:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-3077b76ab86mr6029176eec.6.1781014821449; Tue, 09 Jun 2026
 07:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
In-Reply-To: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:20:08 +0200
X-Gm-Features: AVVi8Cdwuvw2Lhq2Nlb7NyGOFSjHIC5QLy-H5VBQV6Qi0GBVUV_8tPxmh6vs6C8
Message-ID: <CANiq72mGmRTfauU-HUOyBVSG0GM7q39=6aP8p1djN2cHr5C_Kw@mail.gmail.com>
Subject: Re: [PATCH] rust: block: require `Sync` for `Operations::QueueData`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 10:25=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")

Should this be Cc: stable given the hash is old? i.e. 6.18.y+

Cheers,
Miguel
