Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF622A4F9
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619369; cv=none; b=BI2ZmQJ1gUXzE7DnWSpG4B5RhDceO/AjW3bKZY4ZHfgVH05GaE3fxVclcv7Ny1XfKEL1/rSTRlodmCDl7gkN+PsEbwGoIW/SFlAaz0m7wu7cRIrLfZJKJY879H/locAhqstipG5z+tyRpoYzuthWM3iKuvEp37WonMxqjO/nREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619369; c=relaxed/simple;
	bh=JGpkeFJIzLVEXwQqSPpkT4SOMyDYcklm+l1A6nBBUqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugRQi6SFLuuAgyOU2JRNJwYF6ALEwx4KZc3ae3EP0zuwHYylmqQBp58CdERVN+zi1NYD+QLFsO5VZfRkTqPuP1+Zg6UmpMrxgV+bOeQ6RP8BTT4CqhpZ6ZN+FyAEOKpMR8bhHcMqczNyMWEzG0dD+K3BYbM0KO2kluiS6Jx2NMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzlZAbr/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzlZAbr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741619366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66Tnycb2VJ1AuTJOexw6mcJcSUNl2GwzWt74sY3xBWk=;
	b=WzlZAbr/Tf6aquBPZbX5DXfUpMctTfsQbthc6W3vlKnDfX2oGkvsd8JCDBaqyR4pm8UI5K
	JqOI2QWgU2JGylI5zjRzxvjCKP92rZ3iWOJvm0fnwHY6KHOQ645rdhLwsXOIpb0mCNS4Rg
	f5+RwE8cmREuYnfOclXJMTbbncn7iLY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-aoatzgKLPTCY-ErDfodoEg-1; Mon, 10 Mar 2025 11:09:25 -0400
X-MC-Unique: aoatzgKLPTCY-ErDfodoEg-1
X-Mimecast-MFC-AGG-ID: aoatzgKLPTCY-ErDfodoEg_1741619365
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-523dbcdccf3so5565976e0c.1
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 08:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619364; x=1742224164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66Tnycb2VJ1AuTJOexw6mcJcSUNl2GwzWt74sY3xBWk=;
        b=igrRuoCAnCP4Jb80WFUA+kA5znriwa6dggGdsw9TCrX4cxgzZipR41RLKSuU6oQhGt
         MHj2lOQGOKY99KRkp9S4TBHWKDqp6E6ilRDJ2wU5GjWjMet+vssdEsmR4wHCYjrBmn0s
         ziNXpLWNS2KOin9l7hakY1a4dO2AA205YdAIfSkoXr7HUMWGlPgqVx3lQd+BEwXSqd/g
         lGICCp8FS7mnxoGOrtlbdphb7JL+LaKfbmurICfblxELHo7y9oQGBWOf9wUmXBF28JzM
         23SAZhv/un0toWTLDzT2LiB0boKhTIsvlg2usBBNhlYs4RYpDRM7+9rZK8E3ntEaJIJn
         k3ew==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZGIGaxpQWIk8J1SrvuDIabGGCL/aWYc7+gmnqbdP5CZT1JOPdq0MtgF9vSdhznsA5e9NReIr1WCWOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyULZM1ylQoeuRhs0G6hRakDDJdxPbJ+663oHUfPdJ0ghkbEh8f
	uX2iq+vexldWl3AYh8sAQ86ZKIDt65nc9H7ptwcRhV0yCsv5ncpuQ8WjXwiS93bR03g1IT5Fu4H
	pAQXzW4FJwmx3jwjjlvyTmKFoVnue5+vBlcrEODy2uJOCot2LnFqybrRhV3OJGN00H4AhBb6ZBX
	tfoKdZaFW2GYVRKN3yQHDH5Q3RM+jQk4tIN2xnaGT1Di0DHEQP
X-Gm-Gg: ASbGncvupgyWl9mnTM1JedJw2du2oHHGUgQPB7CguQZR3WCfSigkHyhVsfxz9gw7VxD
	Rhib/xlPT1Da28QB6laPvoybrCuCFWG1y83viPFvSQxtm9N8+UuEjBVvGmDc/6Fj900QqlUs6Pg
	==
X-Received: by 2002:a05:6122:2020:b0:51e:ffd1:67f3 with SMTP id 71dfb90a1353d-523f29ec506mr5322810e0c.7.1741619364644;
        Mon, 10 Mar 2025 08:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsZNfZWZZG/UcXU2w/Yt/K3gyjdbj2XDKa31R5eM3+BZaTWn4zow7FBOXAwfQZKEU/UZJts/Vx7HYMM0CSvKc=
X-Received: by 2002:a05:6122:2020:b0:51e:ffd1:67f3 with SMTP id
 71dfb90a1353d-523f29ec506mr5322772e0c.7.1741619364358; Mon, 10 Mar 2025
 08:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303124324.3563605-1-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Mar 2025 23:09:13 +0800
X-Gm-Features: AQ5f1JrrD_3yrfI5eA85fc3nR5aStgFbrxn_N45HzoiO9yNnKvvgPw2myehYjyM
Message-ID: <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 8:43=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Hello Jens and guys,
>
> This patchset fixes several issues(1, 2, 4) and consolidate & improve
> the tests in the following ways:
>
> - support shellcheck and fixes all warning
>
> - misc cleanup
>
> - improve cleanup code path(module load/unload, cleanup temp files)
>
> - help to reuse the same test source code and scripts for other
>   projects(liburing[1], blktest, ...)
>
> - add two stress tests for covering IO workloads vs. removing device &
> killing ublk server, given buffer lifetime is one big thing for ublk-zc
>
>
> [1] https://github.com/ming1/liburing/commits/ublk-zc
>
> - just need one line change for overriding skip_code, libring uses 77 and
>   kselftests takes 4

Hi Jens,

Can you merge this patchset if you are fine?

Thanks,

