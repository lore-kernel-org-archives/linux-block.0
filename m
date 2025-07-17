Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C914E2E2
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762737; cv=none; b=qW5ruJwuLzelSyEJn40EgARbM0aDpGv0GdB/1UBrR8eRO1990nmYjCyHiQ0oY3EOZfYhj7aQbjlkZn1mIqm21rHsIe8x6kEscXqdmfGDlSbghNkIZHLM30ZQal4iRjUrJtYRbwS8DTR0rdVXi5fjEKpV8enyYruvdtJSts8V9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762737; c=relaxed/simple;
	bh=BpKvTGSzcGxYqR26tI4+GLZNjRei4vvrs43ux7EVVbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDoup9gZtJfC/sj056KbA65h73nnjDeOMY8C43QaXXE1ZAaTWGMTvzfGm6m1fJdUubElcBRLPTZEiuvg9HeLPOUcbqd3ezvA/RebbJ6EYnVndJJm5958T1qX02G8SE389gwr/8ZrJl5WzH7rM3C+F2mGBbmAQjwXuzZlDWMS0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MROfHUi5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MROfHUi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752762734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FA0ONGYpZe5LNmkbnmUH+TqjZUs1MQRrjuF3bYicL8=;
	b=MROfHUi5h+zs74kmT+P4QYWpMIBvUAnYlGLxB+4lG7AqPHJVKKkvlNeqA9BAy8zOemZioj
	yJVtysBAog6oiDWJxXwGlyE66f+XQ9kN3ww9LFkd8m7IupCn4iqFLQhQPEfEsg8UJ+Pz/s
	FKT9+eV/KUmPkExoYYO7rLNyQEQKMQk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-P0v3PYkDNtGgzzgcslp4cg-1; Thu, 17 Jul 2025 10:32:13 -0400
X-MC-Unique: P0v3PYkDNtGgzzgcslp4cg-1
X-Mimecast-MFC-AGG-ID: P0v3PYkDNtGgzzgcslp4cg_1752762731
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f8835f29so1512178a91.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 07:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762731; x=1753367531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FA0ONGYpZe5LNmkbnmUH+TqjZUs1MQRrjuF3bYicL8=;
        b=ObL76CYhRS9JVXAS7q0kPoJ4afgiJU8XlpRxtghx6UImSEj4d91k8T9xD7ZQJOIb4O
         zv29miimqrQw+dW+9iKAMtr87t+pUjMXf2P+jDQI9gweZzXEqVXktYf9g6CGpk1J7Gxd
         mw9TtJrUAFaMp7Ou0kS63dK0eC9qtFs4Kpf3C7BZCJlYiEiZL0dfds/IK5yzrYf4MX7I
         qIw4pUq+1ivcs1FCFqxgf39Exj3YAXYqjf1NA5oo8NzG382mGQsDv/x6BijERs0F3T4o
         vGmtfRvfPzJZR5qANHxAETtIvEMXzeXDEFALlc7IEYYotzlNQCdqa8xiO9aeZKMFi7Ek
         lb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm66CWYGdTKGGgZO8pliWPVm4r7c7dSKwdVOgmE25Sy5obRdzCGqNINQdtitzcESXDsPBhSbuYHzKEiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcrLVOuliXrSbj1CJID7vA+Gt8LfucfsHSALnzWj0u+Z4LloF
	IM545KAuMVrl/fH/Za97vbP9ZCSOlDQo8IZw3DKBxhZklCxccYzzqi55nC27juBFBoKh/0dzqDS
	cze9nkEpIWk8X1RO/CGegueZ2jKdHGnM0gxqxhnWol3/6p7Rg287MaDdP0eHGBH3B4kCnukDu9D
	KJu0VgwTBga1mhS6oXZrUHwquc+J/RUt2uPRuV740=
X-Gm-Gg: ASbGncvGKVtn31bgX4nC4jwy/WMu0FU1HL8pnpx9Sg57L3yxTsziSfsh45Rm18ZmKpq
	EDP3J6Ap3xzBYCxln2IBVqXqd1Jbyo0N0RB4s4q2d4Q0LQF93Ox7gNMHP4shOQhaROdq8p1El02
	5OCLhwda7p64fUPfgcY03MbQ==
X-Received: by 2002:a17:90b:4d11:b0:311:f05b:869a with SMTP id 98e67ed59e1d1-31c9f3fbc53mr10281479a91.8.1752762731351;
        Thu, 17 Jul 2025 07:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQUUCc3pM4Lu5no+Q5BLA2dXohC4lCNgxZo/MbUSKCn/toalxZgxeSFOGednPIk8W8hlu7LcflGG9xEg+XeU8=
X-Received: by 2002:a17:90b:4d11:b0:311:f05b:869a with SMTP id
 98e67ed59e1d1-31c9f3fbc53mr10281048a91.8.1752762726191; Thu, 17 Jul 2025
 07:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9wqRvxxTVMYxPcaCQoedeRNn6CHJ_K5GsqS6YKMHeXiA@mail.gmail.com>
 <CALTww2_+3zTsbSxr36iscO6q0iV4VYLRE-PNKZ_aCRS5TDCwBw@mail.gmail.com>
In-Reply-To: <CALTww2_+3zTsbSxr36iscO6q0iV4VYLRE-PNKZ_aCRS5TDCwBw@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Jul 2025 22:31:51 +0800
X-Gm-Features: Ac12FXyMbln4vaRFu624g2b2ZajluZDKzvbBmLj9p1rqnqb5RfhE77c_AxsPVPA
Message-ID: <CAHj4cs-dvYWvMQ=ojvz6Chsy-tA7gogXnfVikixVyUzrG3jzVQ@mail.gmail.com>
Subject: Re: [bug report] blktests md/001 failed with "buffer overflow detected"
To: Xiao Ni <xni@redhat.com>
Cc: linux-raid@vger.kernel.org, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:33=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> Hi Yi
>
> Is it possible to use the latest mdadm
> https://github.com/md-raid-utilities/mdadm for testing? This problem
> should already be fixed.

Yes, the issue cannot be reproduced now with the latest upstream
mdadm, thanks for the update.


>
> Best Regards
> Xiao
>
>
>
> On Thu, Jul 17, 2025 at 3:21=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wr=
ote:
> >
> > Hi
> > I reproduced this failure on the latest linux-block/for-next, please
> > help check it and let me know if you need any infor/test, thanks.
> >
> > Environment:
> > mdadm-4.3-7.fc43.x86_64
> > linux-block/for-next: 522390782310 (HEAD -> for-next, origin/for-next)
> > Merge branch 'for-6.17/io_uring' into for-next
> >
> > Reproducer steps
> > # ./check md/001
> > md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
> > size) [failed]
> >     runtime  3.511s  ...  5.924s
> >     --- tests/md/001.out 2025-07-15 06:27:41.496610277 -0400
> >     +++ /root/blktests/results/nodev/md/001.out.bad 2025-07-17
> > 03:10:50.718820367 -0400
> >     @@ -1,3 +1,9 @@
> >      Running md/001
> >     ++ mdadm --quiet --create /dev/md/blktests_md --level=3D1
> > --bitmap=3Dinternal --bitmap-chunk=3D1024K --assume-clean --run
> > --raid-devices=3D2 /dev/nvme0n1 missing
> >     +*** buffer overflow detected ***: terminated
> >     +tests/md/001: line 69:  1835 Aborted                 (core
> > dumped) mdadm --quiet --create /dev/md/blktests_md --level=3D1
> > --bitmap=3Dinternal --bitmap-chunk=3D1024K --assume-clean --run
> > --raid-devices=3D2 /dev/"${ns}" missing
> >     ++ mdadm --quiet --stop /dev/md/blktests_md
> >     +mdadm: error opening /dev/md/blktests_md: No such file or director=
y
> >     ++ set +x
> >     ...
> >     (Run 'diff -u tests/md/001.out
> > /root/blktests/results/nodev/md/001.out.bad' to see the entire diff)
> >
> > --
> > Best Regards,
> >   Yi Zhang
> >
> >
>


--=20
Best Regards,
  Yi Zhang

