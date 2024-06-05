Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09E79CC
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717549504; cv=none; b=U2LlNx9PEuD9mWvpiinRQIdtNo6kZ+9oapC9FmRwJoC18TEL4wukap4vGPN2Xhvo7SGmUENhS0VphMNm80EELyLCRqJmre9OafLncMvtzRqTe90kL8OA2ZLequpN7u3Q+Qcwzlo51eT5e/TZa66xFzjj+Hxjc74r+0H5Scv1tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717549504; c=relaxed/simple;
	bh=u8pMyf8aDFfT4U6diLhkqyV9B3FF3U/i3+KeoZ6LaOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8Se3xknZ/tSdOc60uSNUtMNlHCCHcxclTkHHFdXYgWnDxaxaQGqVlZB0KAQZh1WaeJiIrvrjml6epGku5puLIdNCbG9+UXOdC19SGqoErxTWBJKdPAwu2lkpvkF7UtT04Je/vnBGGkB/uf3VsHALaAXMFn6GjwWLT+y3Ztj84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYwQAL9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYwQAL9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717549499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LwyLKCrfATHqH04I1Lt8iswat4E2T1A0VIN7qzb8z8=;
	b=IYwQAL9SRGL4X1BSVIfDlK09M5DRRSI4ZdMB83+KTXcCTv7i/OoS6QuIxgcjHI/pHZdPDR
	5GDzk2FyoM2tiEc0cF7AuPWWrgrnYqca2RmREFOXkC060rwfM97WYyomm0pyh6iyn6G0os
	PJ1malqYUIUWBpvjV4b8WW2kN6K7shk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-IcSFfD0MOqixlPag95N0JA-1; Tue, 04 Jun 2024 21:04:58 -0400
X-MC-Unique: IcSFfD0MOqixlPag95N0JA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c283f190c1so97806a91.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2024 18:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717549496; x=1718154296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LwyLKCrfATHqH04I1Lt8iswat4E2T1A0VIN7qzb8z8=;
        b=jQ2PfPMaktVYewSdowloiwhYImME5vJiHnn5EjhIIxYZbSqNZ4/Odrs5un9sTqjCzy
         pm58oDyKSoerJsFY7or4l75N7QBX1pNUlpW8Jih3Hsp1pzo44nSpZPUQft7mZGDW0FFe
         WBH7PC6nzr+UQgMzVuqrWo+WS8zaypGOyy7Y29Gt7NoUaKCCMu8nCexTCFCwSGPdZFhB
         X/VMauSaySWykn213b+pPTjRDhXNBg76qMdGdJLyfOm40vpiWanpVe3Zk7hcQWnqZajK
         PJF/MkrTRLtjl73kUerm+xm1AZNMZaaz0jw509fgIT+9/HLqGzELOBmKfMECkQsvwv/1
         aIeQ==
X-Gm-Message-State: AOJu0YxZ65QVvefn+O5ANeTD0D1R0kc+eWFzilF3DKsuNGK3FZ53Kj8N
	D7BC5i2aojMmW6hGOFDlvnWXWjXkFVGYAIl8zBs4/MIHLXqYwzcKadY6ljSBvSKsTZPezhlzGGX
	X4LaaxjxOs3kAnqQdTIKMh9Nvj2g4INDsexgssTPqfTPnp4x8ufOYDtccQcEJ2wTTze+rbGGGgd
	BPr1zAIuz3uZpZeKnUMBwDoyo6Iot53okuxkNyaceEtuKN1Q==
X-Received: by 2002:a17:90b:484e:b0:2c1:bb0c:9af4 with SMTP id 98e67ed59e1d1-2c27da301e5mr1407353a91.0.1717549495920;
        Tue, 04 Jun 2024 18:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu0NDxgzg49UMemfpZ1oUIa5FeSdXkF7LCL85RuiR089XdrWEnzlapScoEIECrqV0b6FM5r1fSNJr5MtsJWQA=
X-Received: by 2002:a17:90b:484e:b0:2c1:bb0c:9af4 with SMTP id
 98e67ed59e1d1-2c27da301e5mr1407325a91.0.1717549495417; Tue, 04 Jun 2024
 18:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605005612.216263-1-yi.zhang@redhat.com>
In-Reply-To: <20240605005612.216263-1-yi.zhang@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 5 Jun 2024 09:04:42 +0800
Message-ID: <CAHj4cs97JNhQNJ9LzUy6GnSH8fk8v6PnoyzZkC7DGPZOEqLgDQ@mail.gmail.com>
Subject: Re: [PATCH blktests] block: add regression test for null-blk
 concurrently power/submit_queues test
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

oops, please ignore this one, will update with V2.

On Wed, Jun 5, 2024 at 9:00=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> null-blk currently power/submit_queues operations which will lead kernel
> null-ptr-dereference[1], add one regression test for it and the fix has
> been merged to v6.10-rc1 by [2].
> [1]
> https://lore.kernel.org/linux-block/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7=
AP7TPnEjStuwZA@mail.gmail.com/
> https://lore.kernel.org/linux-block/20240523153934.1937851-1-yukuai1@huaw=
eicloud.com/
> [2]
> commit a2db328b0839 ("null_blk: fix null-ptr-dereference while configurin=
g 'power' and 'submit_queues'")
>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/038     | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/038.out |  2 ++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/block/038
>  create mode 100644 tests/block/038.out
>
> diff --git a/tests/block/038 b/tests/block/038
> new file mode 100755
> index 0000000..2122e10
> --- /dev/null
> +++ b/tests/block/038
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Yi Zhang <yi.zhang@redhat.com>
> +#
> +# Regression test for commit a2db328b0839 ("null_blk: fix null-ptr-deref=
erence
> +# while configuring 'power' and 'submit_queues'").
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION=3D"Test null-blk concurrent power/submit_queues operations"
> +QUICK=3D1
> +
> +requires() {
> +       _have_module null_blk
> +       _have_module_param null_blk nr_devices
> +       _have_module_param null_blk submit_queues
> +}
> +
> +null_blk_power_loop() {
> +       local nullb=3D"$1"
> +       for ((i =3D 1; i <=3D 200; i++)); do
> +               echo 1 > "/sys/kernel/config/nullb/${nullb}/power"
> +               echo 0 > "/sys/kernel/config/nullb/${nullb}/power"
> +               echo $i >>/root/power.log
> +       done
> +}
> +
> +null_blk_submit_queues_loop() {
> +       local nullb=3D"$1"
> +       for ((i =3D 1; i <=3D 200; i++)); do
> +               echo 1 > "/sys/kernel/config/nullb/${nullb}/submit_queues=
"
> +               echo 4 > "/sys/kernel/config/nullb/${nullb}/submit_queues=
"
> +               echo $i >>/root/submit_uqeues.log
> +       done
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       local nullb_params=3D(
> +               nr_devices=3D0
> +       )
> +       if ! _init_null_blk "${nullb_params[@]}"; then
> +               echo "Loading null_blk failed"
> +               return 1
> +       fi
> +
> +       if ! _configure_null_blk nullb0; then
> +               echo "Configuring null_blk nullb0 failed"
> +               return 1
> +       fi
> +
> +       # fire off two null-blk power/submit_queues concurrently and wait
> +       # for them to complete...
> +       null_blk_power_loop nullb0 &
> +       null_blk_submit_queues_loop nullb0 &
> +       wait
> +
> +       _exit_null_blk
> +
> +       echo "Test complete"
> +}
> diff --git a/tests/block/038.out b/tests/block/038.out
> new file mode 100644
> index 0000000..aebde64
> --- /dev/null
> +++ b/tests/block/038.out
> @@ -0,0 +1,2 @@
> +Running block/038
> +Test complete
> --
> 2.44.0
>
>


--=20
Best Regards,
  Yi Zhang

