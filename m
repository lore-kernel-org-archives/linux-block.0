Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59563CA4AD
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717153; cv=pass; b=GXL1duqHoxa01Ad6+VqZp65SNZRDBigxMqrNkgfA4XgP41YHpq8UAcTmr/medmOw1yi/QIy5bSN5vD375RqT98FLbi3d87oGG72uXy/TW7DFCFqFVtBD2fVAwyeBWM8jkRu2wUZ2I1gwHZ/ixwkyyxKL+bGq1g4QE2tWfHwagsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717153; c=relaxed/simple;
	bh=UVEa6PU9n93zKwW/HuBL9n0f5PNRt8vXIcOzqE0SBho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxuquZ+RVGF4xvLeljlsNENFZppqf7hf+VPd7Lp23MCw7r78m0y6MK/36LQFQGEXkIUy/SBoOuV/yY5hj19uS1NGzE9/kBgtAqHJ3MVS7zMzeouAsr90+iF8hQZiuIyXxkg7BMYwEeFRcwAVM5GuB19xAvaE3ahPN7v5PEniDYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBOeKH62; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ht+rBn8r; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBOeKH62";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ht+rBn8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786717131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
	b=TBOeKH62RpdkVtiOmi2Fc0LjEuiXgzYbZhwVk3rjxTT7XjoOmHIyTieZcSNatNHI/+kxW+
	1Fzr1x9D4MdDWB5VgttnSCVjcFnAX81hiL8mXckMMUQZaRBq2U5TARn82G+CbuFCXSZ3wT
	bs1/DRAVpRj8RYoDEF++p2xyck7DybY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-M60YUMDfMiqV2tJTnhKKIA-1; Fri, 14 Aug 2026 10:18:43 -0400
X-MC-Unique: M60YUMDfMiqV2tJTnhKKIA-1
X-Mimecast-MFC-AGG-ID: M60YUMDfMiqV2tJTnhKKIA_1786717122
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso8552255e9.0
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 07:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786717122; cv=none;
        d=google.com; s=arc-20260327;
        b=W3OOhkICczhEQIPK31BhkT+/PTcddm5gml8phUv26iK7kjlpwI0hhf1CxdtA/0cwvW
         juiYaLxfsyoqu9azOpRqBZbxRiypcuqfA6bG8RlzZCRVoD9IEgsDxFLk4wb0uMbFLKtK
         C8hAJwkf5UgvNziHBMC1rDbTiHpTsC+YpbZ4BDIXwlkGwQV/H9aMQIJYWTaJLrQiApqP
         GYaH478K7McnWzVVR+o9XGTFhIekxn13l/XhYFPW7PuNof6E7p9qTrxOL0FXcTaRqzLo
         hsq4gV1hyqMVhq37l0dr6b/Q39zjd7+cZNcW/5hDPikG81HMjZtoAes4G8NzgKwyRMcQ
         luHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
        fh=Pw/ychRNAooBzKui/Jk9ssFo29jUtMBp3hgqp66ulHw=;
        b=hu1J/BknSNNmNqmxlbn6zQZwqzKyDMoT/0UnEi5P0E+M0HuYTyLFXZXCNu2haUIfPs
         CGp6qMGC5ohdhD+gQAZpXRIe74ETgcUlE1HASYM9X3OFIJA14awbtBWVtI98ThzwLwG4
         UXsqGU/Z1Mh+FgqV7+bi1JRXGCClhxbCKHbt3F+PrgOT1Q8Vr570ysDDHn/m+8Zk3jM4
         nyUwnJox088vNQyLeHSoBY81pdZ39oDm59q9etCbMPWD6+jhMGXBjc+d19z3RqNNqLoU
         a2zRxONkQLn+aQwq96AWqxwbwO/VWi+QJU8gCCSX2YScF8YqLOQz2AcwcdeaYkCmZGzB
         DHaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786717122; x=1787321922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
        b=Ht+rBn8rGtOVbyj5J6hdItozsZU20SoIfjehz2EM/p/oIpESONB7au8hnfPT/bbzB3
         rAe8NKj5AFiCtW3Plrnr5RgmJLdhZBFG4/sbsWKk3DuABhH0z3jfcuBVCLNyOdu+9dXQ
         4nWW/cgp2xevKL0vg4t9Ombp+VhsMCG6Z0Hm05cyO50PAhNe9e/H3Fo96y7D7pNW5Z6H
         11JlMeuikYaRbn2D1k0Ox+2Pgtb1sbuzGxYRrWbkwpDgvO7CKW5wJKszsLtXLx0k5hFV
         Q4O8lbON2KCZMfadPWbVEsQgx3OLdg9MmH1KvJoWDAML8kdoMWbjcOrucXzU0wB85w9r
         if5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717122; x=1787321922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmU7z6OC249KBM2h0aoOKXqrafvecetknhvjJZj4jUg=;
        b=fyPy53vctonlfgm5VpD/L2cC89xm2lqWtW409dBbBz9AidVv12Ko49yS9EEtW0WvQI
         2rAj8siPY94KiBbvTegig1EkK2iKUk6XXA9NmspkT9PrPRVDDjobYNzJ3D7z83AIFARY
         kW4w4cosYLIwhHCAsk1HbA+942wmGUAji5DUG0yqLA1Fj0TB053unbcW1sy4L7qrqdfG
         4OPTWb1hNNf5jAz+sW7HZo0erU3A79kadhsekusIrEkN70M5DM2sNwcQi/72thziUotd
         HUBouAO6pG71h9yRJ6W7f7ZvMTHMG7sNFVAgMM6KdY4K4yT2guNiVe9BNav8AMgUoZIe
         95RQ==
X-Gm-Message-State: AOJu0YwVkIuGI8tunx6ZB+yHN/CYq/LuLLW/o6039Uxsr0INzAMX3KBT
	xKcmKVq6zq60V30Ylx0pXkk2J5hn0yDiO51poaBeBuSPBVcrKSlAFpJ3JNLJPYN8a1/cDmYfS1n
	XFns1RwDNf47n+PFCM7eOhbf31XImA5Ynd+lGV488hA+JlUclXWYEM9YP5rM1oQI+9/t/38Yakz
	/MA37kMMa6pLGdCqv+HEGMFSMbSUNwIOUzIRDIHoaky6JmILU=
X-Gm-Gg: AR+sD13wM/ab3l1zLY+YxFoHbIBQFVjvWcs5vFl7Tkvz0FtUOR4j845Def1lRT+H7PK
	5KDyuPw51qOdj+YxFKre2Qo3WUL385OONwfYHHG6syblC4Hjw5b7kzbLUD6hWAZ94oK7sZK22qT
	bzS2xWnZLnimn8EiC4nYgYXQz00X7j4neWH26RML66+3PbpvurYB25b9aa9KSyfqYAZ80wo+5SW
	GWIRcQZYAfWb/lW3g==
X-Received: by 2002:a5d:588b:0:b0:47f:9568:ebf0 with SMTP id ffacd0b85a97d-4816076e5d6mr8567194f8f.23.1786717122031;
        Fri, 14 Aug 2026 07:18:42 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:47f:9568:ebf0 with SMTP id
 ffacd0b85a97d-4816076e5d6mr8567119f8f.23.1786717121682; Fri, 14 Aug 2026
 07:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
In-Reply-To: <an75bRJc8J6NexeH@shinmob>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Fri, 14 Aug 2026 10:18:29 -0400
X-Gm-Features: AcwNN1W-_eBVIwPeU4L2Msiij6dBncE2vb0x-B7AGUvsZOMgUKDIjjcSxeVZJZI
Message-ID: <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:25=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Hi Jesse, thanks for the patches.
>
> On Aug 12, 2026 / 13:45, Jesse Taube wrote:
> > Tests for the upcoming nvme-fc: FPIN link integrity handling set.
>
> I assume that above refers to this kernel patch series.
>
>   https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@re=
dhat.com/

Yes it does

>
> I applied the series on top of v7.2-rc7 kernel. Then I ran the test case =
added
> by this blktests series and observed the failurea below:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  33.581s  ...  33.028s
>     --- tests/nvme/070.out      2026-08-14 12:03:21.338000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-14 20:17:04.731000000 +0900
>     @@ -2,7 +2,8 @@
>      Starting background I/O
>      Testing iopolicy: numa
>      Changing FC links to online
>     -Set all online: pass
>     +No FC ports are being used, expected atleast one in use when all are=
 online in numa mode.
>     +Set all online: fail
>      One host marginal: pass
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
> Is this failure expected?

No. I can't reproduce the issue either.
Does this happen consistently?
Maybe the links are still connecting?

Thanks for you review I will implement the changes you recomend.

Thanks,
Jesse Taube

>
> I will comment on each patch in line.
>

