Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260726D4D4
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343621; cv=none; b=F+bsA06ip9m9xEQl4+mqbj/GSewO0TNSx7MYmbKE255xUUxqvsaRe/Sz5nZ9dAvRpF5lPLPpZdF7mjZkol6wbBWARZOYSA176FziNA2t8GL61wCtjgJTS1BTfV2SZnlecAShWNlEGB2qSAm8bB3zw6zUs81UNgnj9oRhtS2i4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343621; c=relaxed/simple;
	bh=hoGMPimUE1ZymoKj+TQf+K3m9LeCsq5PLXIzbXnOWsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIzOC3+JAFTiI4rWmqgaRUrvOLCjH7q8D+/zTHDanxXVywO0cYSsTeejpWQpLp0fdQNE2T+RsnnObcYp4tmyLnSnuyZ+sFU32qjC6J3qkYEI0VRG+/ogn6PJMQAkGumXFuGD6y76lWI9dPqM0aWwFEckZNJt8JXachyQF38W+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCfBkul8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCfBkul8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753343618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jy0Gv8WWibmzpgFTC/Tzky+NCI7ewB4EVDYOKxwIoBw=;
	b=RCfBkul8+LKRt5r5/BaizuQYn/y84NbQsFqs/yl4/TW6XQ5D2Q1NoqFGiCOhNCu49Fkjvh
	6fgPJp27inW6hwG4i+AzotG9ZTZmflpGLPusbGI4EkXAqbRYwdTdZZPF+Sal3HwSwLLksJ
	u+KglsuzIgSC8aBq+JLBEoWtSkspPvY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-n_5oVAqrP566CQPQJYvgDA-1; Thu, 24 Jul 2025 03:53:37 -0400
X-MC-Unique: n_5oVAqrP566CQPQJYvgDA-1
X-Mimecast-MFC-AGG-ID: n_5oVAqrP566CQPQJYvgDA_1753343616
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so1178642a91.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343616; x=1753948416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy0Gv8WWibmzpgFTC/Tzky+NCI7ewB4EVDYOKxwIoBw=;
        b=AOWQ0i4MmF2N6Q0qDqwXSJCAz5eCNoIFBvzc9IBQSP7MkuG4apkcqjxInesB7axnyj
         yBQyZ2h1DUaqLPXA/IO24tMkTYTf83oTV28YJJMO1W0abCbktxThtJ6aPhAxslEwTmPP
         ODw0oRFi/9g8oqDlXfT4DmyM/7/3mDiZLZdiEFrKnLWd/Qfpd76ans+FYLJhIQuX1YJ2
         FPQt6xiUe6sTlFdsZlJgvcN77b2wXczAMKj47Q2h7eE866zP3PalSG+5+YJ6FJBhJ/w1
         dsut6cpdQlimHSc/LL924/6D7LcSivrKuVF8g4I8VdP42Rdhu92djfBIAjhemL1bqT8X
         dxaA==
X-Gm-Message-State: AOJu0YzC3+h4d5TOJyok8RMNwl0szbJ5MxKfVF+rePBGFHUXqAXqOK0q
	EHhT7zNTctTWJQ/uj6hPsaI/Mr1WPL30XVcIZyfILYP535Ib6YyADGgbsroQKcnR9Zz/xN25c4t
	VkKJbR5T8rvoGA7+bJMkC/L9lAawB9Gaov9U0FebiLhzge7G0I5Jx8n/ZiEs9CwMsn8qCBrcqOh
	vp7pKWYDJwd0rEmKuKxWVCxLxQ9aSi8JGwwSWVJYrLCSOeMl8aaQ==
X-Gm-Gg: ASbGncsEIE85J8/ox7KVebSg5pAgnlunDb3cvaZE5F6YatuzK+IuWVy33nO6bdzuzse
	DK2xBMV3ZDHJCN5n+9FFXaImCXxFdc+Sq1CYf3BnYlUbYSKcz+GgEtEFX521ZmKXtVvsGHcAw0P
	YUYtMTsS4X9nusr7HFXpL4nw==
X-Received: by 2002:a17:90b:3902:b0:314:2a2e:9da9 with SMTP id 98e67ed59e1d1-31e507daec7mr7891690a91.25.1753343615674;
        Thu, 24 Jul 2025 00:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/BIhm9GxiSB5bYwTOsiWYEHzIxBzO+Qfry7df25dubOMlCOWFJgodSqjVwlQaB54IVmFXql6It48PMZLpME4=
X-Received: by 2002:a17:90b:3902:b0:314:2a2e:9da9 with SMTP id
 98e67ed59e1d1-31e507daec7mr7891669a91.25.1753343615261; Thu, 24 Jul 2025
 00:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+X8GYS7yKkq-qxJ5hpTL=vHMBgG=wuSsNJZ0VrjQeMA6w@mail.gmail.com>
 <CALTww2-_9saPOtLC0dXUhQiK+2eV739rjwX3K3KDAz6AgbE6Ug@mail.gmail.com>
In-Reply-To: <CALTww2-_9saPOtLC0dXUhQiK+2eV739rjwX3K3KDAz6AgbE6Ug@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 24 Jul 2025 15:53:24 +0800
X-Gm-Features: Ac12FXyYa_8Wc5VW36F0rGoowMV6Y0HZXDivNxy7YLdvoBkvGeAnDQ3GHS4Isms
Message-ID: <CAGVVp+XfxgMDJ=JX6nLtieyco=PajfqhoKZBb0Qrs7bndUEk_Q@mail.gmail.com>
Subject: Re: [bug report] mdadm: Unable to initialize sysfs
To: Xiao Ni <xni@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,Xiao

yes,  succeed assemble  RAID array with the latest upstream mdadm,
# mdadm -A /dev/md0 /dev/sda /dev/sdb
mdadm: /dev/md0 has been started with 2 drives.
# mdadm -V
mdadm - v4.4-55-g787cc1b6 - 2025-07-09

if not install the latest upstream mdadm,
this issue will be hit in the upstream kernel git/axboe/linux-block.git=EF=
=BC=8C
but not triggered in git/torvalds/linux.git=EF=BC=8C

is there anything that need to be fixed in git/axboe/linux-block.git?

Thanks=EF=BC=8C

On Thu, Jul 24, 2025 at 3:18=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> Hi Changhui
>
> I guess you need to use the latest upstream mdadm. Could you have a
> try with https://github.com/md-raid-utilities/mdadm/
>
> Regards
> Xiao
>
> On Thu, Jul 24, 2025 at 3:07=E2=80=AFPM Changhui Zhong <czhong@redhat.com=
> wrote:
> >
> > Hello,
> >
> > mdadm fails to initialize the sysfs interface while attempting to
> > assemble a RAID array,
> > please help check and let me know if you need any info/test, thanks.
> >
> > repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git
> > branch: for-next
> > INFO: HEAD of cloned kernel
> > commit a8fa1731867273dd09125fd23cc1df4c33a7dcc3
> > Merge: b41d70c8f7bf 5ec9d26b78c4
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Tue Jul 22 19:10:37 2025 -0600
> >
> >     Merge branch 'for-6.17/block' into for-next
> >
> > reproducer:
> > # mdadm -CR /dev/md0 -l 1 -n 2 /dev/sdb /dev/sdc -e 1.0
> > mdadm: array /dev/md0 started.
> > # mdadm -S /dev/md0
> > mdadm: stopped /dev/md0
> > # mdadm -A /dev/md0 /dev/sdb /dev/sdc
> > mdadm: Unable to initialize sysfs
> > # rpm -qa | grep mdadm
> > mdadm-4.4-2.el10.x86_64
> >
> > and not hit this issue with upstream kernel
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> >
> > Best Regards,
> > Changhui
> >
>

