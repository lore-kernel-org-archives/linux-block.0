Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DD2FC026
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324441; cv=none; b=KYidYSh1NX1LX+PTudwRuF5aJC1n9nYVn61h9Xt6IiJjqlD9Fgc+fIfeL4jNIjpqWayMZ2jM+xW3NKgdoXf52690SoiZ6m91KlsbtAiqxXfx/1C/qai5iKfi1TV75caQpIDoD/5fdgNMlr6e+CrZQZChrsf5hcqnRQ13sZ04rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324441; c=relaxed/simple;
	bh=t+aVCYfXA+p0hAUl+r/idM6sMNdxYBy4dFyRlU1jIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+AUHe35L8j4tt0XbHH8xSgcl308KSoHEFlKfVf/0JqHwyfUsLCli7FZrjq0i/sVKzfbhMALYYapS6lezaZkXxkaIOtQ/b0JV4oit5vHCKgU1ZIUvRSmVAjDP+wrIYP0YqI+LQQSWbBOLtdukLZZSdG8NTQCStTEBIok4nzLaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWBg62i9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWBg62i9"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b61161dd37so3787721cf.3
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757324438; x=1757929238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=sWBg62i9ztJvL0fW7U6HoDRPORu4Wi58UFJBzWV3i2hx9z39EAefe0xxGFj7bHtPcg
         r1V6F6UnpT4uegw9gjmZfMpqfSRXYNfdxaL7r+q3qYsFDA+231Wbm8DdfjWivfWfgChl
         C3q5JN7E83jkp/gHCrWOodb2OozdO+D5jyMnRYdqJKtV152dJHL232ZpMCLvDQVeozS0
         iP0KWahwy0EIAortVJuYq8C7kX33rzO17J4jb1mOApW5kOG1o+Wr7mLBER96PetiIQ0Y
         +BoCluEEY8WeagfURHUIF+CVZvWW/IZB6McgSarCMfHlfiEqywSjboVmyj/+hrFVPIl8
         STzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324438; x=1757929238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=obDuxu7evINwPr/h489yOMs+DR1j1bm3LheV2SS+bzigbhoXE2bU+rYWQIW3reXdz3
         ZhpQf2tduzUkQp3h3TDo7MJarJCRzxrUDtB5fTAdgdnCDMais735FiZSYfYGjjkSlIrj
         ofC78n19K5agknHhhDaTjyFjwsbdTJRGOUdeuJ9jFXa/u86XCVcleE53tEgW3KmpCQLd
         emgA2srI5cV5WKlgNsN7KFDXW5Jm7yg0tz4xpTvlk/gdH7bXKaBuSYl6/n3/XtHaBg6H
         +0e/hamm+sTs5GYy0nlD20v3PpiVD+WVBjRes9a/bK6SHlYfu4BFlBg0RezZ9MvxNTGQ
         SVEg==
X-Forwarded-Encrypted: i=1; AJvYcCWwKuqXnt++83+jk5WqNVnslEaEwLgdU8Iq8rzkU0mMLgy90WwBCGuUTKOXsILwFN8pk+ijyp71BJ16OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiEJBZrIONGrepRJM4w9XikN0PF7y3V8J0NA/S+ergUwsn8VW
	aNd09zZKd1My0bDKHC2nlU3MLlsBJa9/sUVU/KJdk7XCqRQM9lKAoxR57ROekY03aAzelIO+AgN
	/PEGw2oEVv2GGL9YZJQKDoeWgCknnMjhiPapcaipo
X-Gm-Gg: ASbGncuCOo6IIP7gN+yEXiuBNOhQ1ax5vS+puVkc+KK3ghIw7J4Vv/2BhwCO3siiFM3
	HGuGK9nRn6wx3EFV8djx6fItqVHVoLfjQ1MutA1DUrdT3du/eKSZDy1hulji/3ROo6obnGfEiBw
	jpzRD9JONI+KXF1jHiCQ9YVoEig7ty5yaRuN+0LE1PFTwUn0t/0jbPchbM7rd5xvpAUfGKX5/GW
	PppUNe+rJcH6NtuYxtyGFUg
X-Google-Smtp-Source: AGHT+IH1qcux165XgeTJOKRdM2g9mlniLhsoO7eTSJyAbSGCi4jHXwjx9GOnwgxGTG5T20bMMEWW7o7k2xMBN/Lj20k=
X-Received: by 2002:ac8:7dd1:0:b0:4b3:96a:fda8 with SMTP id
 d75a77b69052e-4b5f834cff6mr66658841cf.17.1757324437178; Mon, 08 Sep 2025
 02:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
 <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com> <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
 <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
In-Reply-To: <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 02:40:25 -0700
X-Gm-Features: Ac12FXwc26OpvX9zU43reFsjsweUwJNkA8yDt2oGLAvJhUo4PxXaORks-CcUgHI
Message-ID: <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2025/09/08 17:07, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Sep 8, 2025 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2025/09/06 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>>
> >>>> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> >>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Note to NBD maintainers : I held about  20 syzbot reports all pointin=
g
> >>> to NBD accepting various sockets, I  can release them if needed, if y=
ou prefer
> >>> to triage them.
> >>>
> >> I'm not NBD maintainer, just trying to understand the deadlock first.
> >>
> >> Is this deadlock only possible for some sepecific socket types? Take
> >> a look at the report here:
> >>
> >> Usually issue IO will require the order:
> >>
> >> q_usage_counter -> cmd lock -> tx lock -> sk lock
> >>
> >
> > I have not seen the deadlock being reported with normal TCP sockets.
> >
> > NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> > from __sock_xmit(), and TCP seems to respect this.
> > .
> >
>
> What aboud iscsi and nvme-tcp? and probably other drivers, where
> sk_allocation is GFP_ATOMIC, do they have similar problem?
>

AFAIK after this fix, iscsi was fine.

commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 15 17:11:11 2023 +0000

    scsi: iscsi_tcp: restrict to TCP sockets

    Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
    pointing to non TCP socket (af_unix for example).

    Return -EINVAL if this is attempted, instead of crashing the kernel.

    Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator:
Initiator code")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Lee Duncan <lduncan@suse.com>
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Mike Christie <michael.christie@oracle.com>
    Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
    Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
    Cc: open-iscsi@googlegroups.com
    Cc: linux-scsi@vger.kernel.org
    Reviewed-by: Mike Christie <michael.christie@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
