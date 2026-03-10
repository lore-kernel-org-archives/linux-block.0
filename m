Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943D34404A
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162741; cv=pass; b=K1ThDrOGJpE+ZCnnSlO98irFmrWN12ueGubVEAJu1GMpXSDmeDbSA3NgJMchSgLsXOfdCZgoZ8iVegwv3CVPjofIu9d8WUiVlraqZe3eG9PdXftJINNtlYt3do2AFfTnkWKgfiUKAxkk69Tb64cerzf87DzNG91FNuAW5bcvCag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162741; c=relaxed/simple;
	bh=p+2VWtAfEqnbV6BjTW/bbvyRS5EdJraErOLfFzFtBRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f706vzsC6Gzi6SLq57ax5eB80SrOpPyuruDUvP9cDKYa5t4QiXJqdrDLXjVN04tj+oVbMJFnolYPqAEvT0xdpRdMJsqEFZv6G3k7eZURSw/9FM2YupD8rhQtwDCduZs96EgvA6ueO7FrdvDRHeEfxR8faQCVBPOuGeBzF58wUy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDQMOyUz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaX/z0hR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDQMOyUz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaX/z0hR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773162739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
	b=HDQMOyUzOorETsN9Xpxey+yrGx+OaeH+oiY7l0d2V5+vsfMegi0F3aXNDnzWWxCuhOqzq9
	2ddgr8D4QwZ08ZQ5KrNO6m3FgcmOj1CrRVNQ9+UHSi2lqML6PtLxS3CbL6jnZDvWSk8nLB
	UZwUV8EQwxXEf13ebwgFYTNlrzg61Cw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-y3mqMxTlORyACHRc1EwM-w-1; Tue, 10 Mar 2026 13:12:18 -0400
X-MC-Unique: y3mqMxTlORyACHRc1EwM-w-1
X-Mimecast-MFC-AGG-ID: y3mqMxTlORyACHRc1EwM-w_1773162737
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79904eb0d1bso47334217b3.2
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 10:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162737; cv=none;
        d=google.com; s=arc-20240605;
        b=i8wcYkH1PZdhQriuDy+1euJgdVoya6QYvrF2Ex+YBDW0kEtttECgnU8bcIFcGP9+sg
         UtHk8ib0wFZennmmBJZEvzncNFeIH2oheaaos6M7uPGcjYauOy/BuQGh0/2+qg3RCLf7
         js/SZoCkdEzs4RR9BAsmVxC71nRtEYukTZcls9IEXmiz6iaG9uY/anrurKZeryFMh9eU
         i7NBPRgfMu3A9MtHh5Q5qIjdQCxlFlAXqf036T/a12VnLYJjeUxqodLHo/h8fbb2z4r/
         9Da5TmGFIxpyObSR3zcLwE57G0ELpI4TBechntdrCLRaluKlirG/WB1UT8YP5xJP46zx
         DnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
        fh=o/+LNtRQosdHAxiKcuPlwgvNF3dpnRA1rdbKYkfautI=;
        b=Yh5iYKqtxCC3xpgNaWKrloWFqN8VBlXXddnJzB+Ivj4POnbLGSFUw5Jd2D+wvvIOLY
         D7pQmiXZr6mg8sHqMKoyjHRvgub9pYqO4H/OzZSWwMnsmrHykCnEn/PvoH1JGZLTyonA
         UbPEAb5fN/1Tnmy3hK8iHDV9o4Ox87ylGxjTEMBH7i9H8UOhMNsVsjOQ8vpDep+01SnL
         xqOl7o2FYfFADacnOZ7UkCryBCekHHk0Ufww9d1GsNp3mtfi9rncY02MwbkFAQHXY789
         Ks56K0fMxar6CZiruswipLOnnF4fNeHkcbh81tLjfTKCiVJZ7K2YasRaZ+VHBh3mBV6f
         w+HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773162737; x=1773767537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
        b=GaX/z0hRH9Uzl4V7Y2+yfpqk4aXzDasQAQzMjCd8OKFRvyNJ7Ft3GUJq5ZkGFEdrdU
         1qpr51h7kk4Weuj9yb9i7LYKD3aI5GVfuHEHmxebQep8XoTL25BMx5ETHAuDt8YraQuW
         EvW6P1pEagMi4CgnhnaChNac2NVF0QC7wRUsz7sckYQfk++yWj7m9q4YKOs4y29mApqM
         BUOMvyGnLhub0jYbiIop6jcH+AGJcWvRau1qLXpahZM+iJbT4YDubc9P300hC4THaAYI
         em0rRkTx6yufVwzDJP2yhIaYWdSRFZHqYLrHGU2mVglqI2QRF3i2hYgSyMGOkJLWb2Ru
         VolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162737; x=1773767537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BI3+yo6UUBZ3ZK+Qz66GzbgSeWE4IqJN0CQI+lHktj8=;
        b=Uvhwg6QvmhZf4GdDK9lkw0rvJwBmuFUuJDQedBO+vd7VtWBYSop/OlGgY8pFX9/HWS
         IBgZYxqsel37Iw5ibTIJVuwt057mFhwADsk19CuKO/IMAkr6ojdmzS5t9+VwwI3dsiD7
         lITxtM4Xb7OzxLEgGLLHkYi4DmD55h6zJCzTLF+YtFSlSqyRi26GpwYsSnm+CaaKguUP
         CMi0jiZ1qyeGUcOr1WprWQ81ZXgVOu0SDCLJI1LP2PKtkXdRwiJigyLClk/LW39vNp+2
         JQ2BDAvwRLG4Tg63dLCNfnJxkJWuBpN8FY9GPfX+wNM3o1TrbrDPk/n6NEXNY1RTB9nF
         VCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmC9ukSrL6BLYL5K9tqQb2h/FfZvzpqucNi8I/gnGpusMbcuci3wxkLFYotDSPoXtJ4KPQkL2I1SC8wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9kwAzv0gGoxg0D+14dvEgVONlxpohBZcverG8Xw5w/ERxl5b
	+0Bg9ZQyxDyQOQHFGb2W+rGRS22md3vijXnuQb7ifTbCIn9iitz+Zf7X2puNRBqsPMy1OvnyQ7f
	EsRThXAj4PA5sT1xgAK5KLM3t/kY4kq+qba5d8/cP+E6DFCru+AFU9fGlIrEq4ZMUtkCz1j/P5L
	4uSoXnNewdYxkh+NFctAkidfqhKFkbF58h82eWTy0=
X-Gm-Gg: ATEYQzzhfNmTx73czf3JWp28K7auX+ndE901RS32+mV+Slq5AIO9UJGYhj+38+ef0rb
	0xpijcEr0HzB9s+Q5QvrF2l3qhsA5c/BDIWq4clGpl31Yr2uWkWnET2v/fAGBU2zkBWo1GTEWEr
	4erSeKKNjrscjRe+rN8oaVt6Sk6N5Tsdia/7k3Q9oAcz4aCqW/wUSG8o6Edi5od6pH9aEb1h8Pj
	LOSHX4jrXgULpMFa7HiA4RzAdbgkUWgfSvHUbluqr/s3lig765gETczfv8xCM4=
X-Received: by 2002:a05:690e:b8c:b0:64c:9f87:ffc8 with SMTP id 956f58d0204a3-64d14113af0mr15223663d50.27.1773162737145;
        Tue, 10 Mar 2026 10:12:17 -0700 (PDT)
X-Received: by 2002:a05:690e:b8c:b0:64c:9f87:ffc8 with SMTP id
 956f58d0204a3-64d14113af0mr15223605d50.27.1773162736479; Tue, 10 Mar 2026
 10:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <aZnuSC0qYfw0hiwM@kernel.org> <aZ5GbVxDT3gcS6WE@redhat.com>
 <0a6ec8d3-7623-4809-b275-3eccb94419d4@suse.de> <a1e5c1ac-fb5f-46f7-ad7c-e21a545e128d@oracle.com>
In-Reply-To: <a1e5c1ac-fb5f-46f7-ad7c-e21a545e128d@oracle.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 10 Mar 2026 13:12:04 -0400
X-Gm-Features: AaiRm51xvGgBZM7WloiUzJR7AfTdxoMiAkW59yuvLN8gxk-OMb2WC5hFQKpQwAY
Message-ID: <CAGtn9rnreF=AjejdZ_66Wicc6dhQjbjkK3BY4wdaRm3_bgC8tw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: John Garry <john.g.garry@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, Benjamin Marzinski <bmarzins@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John-

Sorry, I was out for a couple of weeks and have been catching up...

Re: sg support, there were issues in the past with people attempting
to do SG_IO through dm-mp
assuming that DM would handle retry on other paths, which it didn't.
You also have to be aware
that non-idempotent commands don't work right if retried.  My
recommendation would be to avoid
implementing it, although there has been interest in a better way to
do multipathed "generic"
commands (e.g. virt pass-through) I think that is a more involved
project than you want to do here.

I see the discussion has progressed re: ALUA support in your later
patch postings, which is good.
As Hannes said, a Native SCSI MP would be useless without it.  You
don't have to support the
older non-ALUA mechanisms though, those arrays are way, way old.

SCSI does not have the equivalent of NVMe's AEN, so you need a way to
ensure that your
ALUA info is up-to-date.  DM-MP's path checker normally does this by
sending commands on
which the Unit Attention can be reported so that the code can fetch
up-to-date ALUA info.
Hannes made some optimizations years ago to avoid excessive RTPG
commands with large
numbers of LUNs which we would need also.

It will be necessary for the functionality to be enabled via a module
option, at least initially.
Introducing this in general use will be a big change for people who
have Enterprise SAN
configurations with their own custom path monitoring tools.  I believe
we put some functionality
into usespace multipath tools so e.g. Native NVMe devices can still be
monitored/observed
which made things a bit easier for people.

Unfortunately I will not be able to attend LSF/MM this year.  I am
sure it will be a good discussion.

-Ewan

On Wed, Feb 25, 2026 at 4:27=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 25/02/2026 08:11, Hannes Reinecke wrote:
> > And I _still_ want to have a blktests for persistent reservations ...
> nvme/054 supports resv testing.
>
> For scsi PR, we could use util-linux, which has blkpr.
>
>
>

