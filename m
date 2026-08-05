Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1330C156
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950465; cv=pass; b=tAUn1AzY0/vbylXQSXmGiCNDpPPYfNzcocE1hH/sYAvjhyMogQo8BRQs/etvv/6ad1qPO80wlU9LDGiuMuasGjd35B4mFg3xd4BPsuidJBg8DlX97iMKEWqDkFTCsM14BBxqwpPaoHE7YsZJqEs2WDJ5DOX+7kV2A11H3MX0qxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950465; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUIxs0ifErgOorFbPL6NJWwlqKvHG/5hTjVNLVl2XPtGs9tfKtoqJNUIr9/o/8vGkB0+BcNWKhvHaSExEExzwBbbYW1u/HoDI4DEGCCQjBwG9jN+DYLKm4W7vT3lsjcM1ZI2A3Gjht7UGoc8t7ekCSdNsuKAUcGDuZD3sdIPUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbe437a530dso119842a12.1
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 10:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=a6Xql1N6nKaeduX0oV+WtnbhVXnOAB/mG/Xhxh5fWKO0o4m7sidgTO13nD9cSzrBHz
         Ox1FmhaKVWI9xBwqdGKpXwQ5VU8w4g4br5ru2roqoKvpC7ptx/41FcTSzvaxWwHivjsz
         NW/bDBCBWpRucIDvwbMNKP6KaL/OGjROpQTLHX8aIX1GNqcI/y4/Z9YROKx1ZALSxzCk
         bg2QT80/YDCrGlTW89uWx/i3LtAGcAtPWjl9LirDMEUHBmUfnQDPHlvI2vOw5hR0XZjj
         vEEFJ41ZziK5Yz/muSFyUHtkFXkeaINCjzKEHbJGU0jy+DKt9+ypeaO8aNCXhHxjpp4B
         zIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=bXbdhbjIvL4OzebZdGLwDxmFSMz3Y5UpPV4QgnK92d4=;
        b=rl9YhvSLAM/Igmg6qr24JbqriHOHY5vLIrPNR8Soo1JhiwEzbwMzDS0xc1aW9NftI7
         MvuERetj6FC3LFRnVvRSrrvox7aVCWr3RZmR8C1VVas0L9AL0ns73jzgvXy0FS+ONbFe
         /SFB6H0PHZch58b3JrKl2n1paxucs4jxzK6Q9zgaG+MUYqvI/ARMIqpYYsYHSa/HqNJK
         9984fcnTwD3lB52OXZJ5sX1jJkLTMse5rysyHKVvwEj9RJ+CIw0LNiqQRlhW9liLLrLV
         zf12ad/HSXEWcbnEILJXTjdahjc6wNcaA8p0rUiv7F7eS12hn3e54eYtiXz6yQ7FSKOL
         IS5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=bbG/uJoNpdHoYAUKaUAvYGHx/DgJZJaWdVu/D4OrvM1OjX5a8KXXHH5cW1rY19jVvR
         C3vNqeQrBt3ugYr+m+ZkkqI7gtdHqQdlFejpTYPdXFC67QuY3VHo1Qpf0hsU9JZmyaVW
         u1YqQXACgWX5LAXX6jXUwsYIwXxJ5IAbfMMI28MwLp3f+ubZjCRWiODubAWlJ/+/+MqR
         uuPuYjGBe0XpyrqE4ewiTpLYifeeW6/510OGo5x8Ca4OzhbD7pLxhjUWKiQEEvZy6sb7
         dt2tDj4bLY24FfkBsvVMq8k55+7dZlq9fDFDnGo+lH4mWiSqoPnARj72j9OQQ/XXowAr
         5vDA==
X-Forwarded-Encrypted: i=1; AHgh+RqbdeWW/PKHqV0hQTUtHswG4nwvsuV0IkRM/Tvr05jSoFZeMozWKzEi7ZO4h/ZxX4KZSGUsxOOutVsp2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLn5cWGCmkm5SXt+F/gn8+Ysg21rc1FCAJOhd2mBerFk4Ll9g
	42SErkZk2/RM/wa85MGNvY74GlTmrZllLPLNKlCvvwLPmNLzUxo/v1l6BrC7mb13d1rEIIUiAw1
	ftcbUzW54f4OxXv/+f25OcRREFDyEjAc=
X-Gm-Gg: AR+sD11HGGY1QG5rSk241VR7E5m2TiAV/pkpgAniqK7OQJxz0pcM/iPvlVY3z9jFgKd
	Dbqc4a0hnTpsp+7w3oKy/aHxUGf72Afjc8rA8dQHByuIF5xlrzcqmBCpy8xX+ON3lBvPruSbmxI
	wO3lsBGTqMTpsBMNacE58MGwYB5uLeDFOFDlmOXv54QSPBk6WxkoeUyGexnAzHFKT9skUTf4/F6
	0tgDH8zFAOOBptnDxmvv0HEV8noeePGHtEF5nfMELVKQASR+j47Zywzm1V268KTrKNPet/O9v+K
	w+DiqOO2ysFZOm1b+sdlppb4MxFngPQ5ld4Y0/BAeo7jY66SmRrUBNxQfq2J6UPVA3otDLCqO4F
	0J1ArnKCmvBKgJLn68hLfZt7W/CCs9HIpvTsxez90rLKTkS3ObqwqzPrhnJzC
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
