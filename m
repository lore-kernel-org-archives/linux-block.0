Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5621423C
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228234; cv=none; b=QvuMS/XUEKCw4CcZasH4a1guo/7Z98YYOe7w/vT9w8GDSjU3jM9vlwNvlEuYzLE9XQ/pW6H4bWk5rwtmYeabaTBmKBBDDvEHkIJv+lBdvaSR+ftErTtgCDTSU1QUSFPXwQRkqVdTXCwsu8CE9Ag4j6dUgEpvx2bLZMcyMQUeL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228234; c=relaxed/simple;
	bh=hUBPSpknxd6Fnb8XjPkFOpRoeCovjuBPVKgLmViY/ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhyHz/ugNGAPVCI3qbr9VwGgabAuB+I2eAbaA9Cg0venesDH1wekks/abwtGDr1ALmylY+WtAuqy83jzSZ6mYYMWwb6RsIT4MMRv42JyZJx263rnmWrtYIlx9nSiHwnYnhoh6k3yd/FVNHGRXkIwdZDH61U5Z6XlSLjQr6f0gL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WhTWoJ74; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WhTWoJ74"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dfb8a52dso6390735ad.0
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765228232; x=1765833032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKEEKiiguUhPkICvRBcr0ZTtMhxwysYUkVureTP5zH4=;
        b=WhTWoJ74xB4zJjlhlQoBtr1VsPBbdJ/5VGtIBAL2Rk/obJJ4XCYAYxg9G1pW7Bpb2Q
         EF0fV6+bl9yHfFjACgW1uCq25B2TiLP7XpgYQOikZESFczeXcLj6uMukg6T3jyxAWgRs
         e9MKm/8Ydb/MIyBwxAOUvQavExKRqPvFpl/EeKIw8qTPJEUapU0MeLsWnkFf3MaUsW8e
         GBaAX7mCY5ZXhq/NXNe3o2fAvFR3mxuLQV5DLPEsEdz5zM0reUe1w1Kq5/C+oBdWK3p4
         69EbpMFBoluFPjpiFGLED6dnwsB4Iy7xVSZNsMplSAxlwqo0YnoHLvnM3BApWKGoxmwo
         vQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228232; x=1765833032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKEEKiiguUhPkICvRBcr0ZTtMhxwysYUkVureTP5zH4=;
        b=R68Ma8pzN0DVYNaYJfWvtFhiZl3zjT2ETznax6sSHOFI3Drxxqk93LL+PDx9aT3ruk
         MQp29CW8NyvrS+7L2hp226rNjUrS0JJ+17p7gh4J0YYoqS7GOaScC4OHRjJvSRFdgzB/
         95laCRufIX/yuNJl68PQxfZfJ97KIpkJXtT6YfMD3YzzqDOg0jrnmIXIZ7lISWFc8c0Y
         hNlol0QQnGf4HPe4mmsyVQtxZJPIohdk3iBgAdvhENyPvuFSvOCXpD4DeQ0DrZc3Gzj3
         kE8kTXxRSw9EbsojHJrC6GCMMQonnrLOW4hA8/PeJiN/K3gjyIV2rX2aKUaY+W/MuTmE
         CyIA==
X-Forwarded-Encrypted: i=1; AJvYcCXVKVcXvAS/ShIgeG5K+VazKAftSjbkbueFs2mdR62NA78XsUU7CiytXkqvKVnncFG9V3BNajcP7JXgjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxrC+j9bhg2iwZ4Ar52DgFVX9+P/0c718UwlI1ORw8cB0F7odY
	+wkdGOdEyeKdP3uYindAY8N6dCHuILVKrSF6RUnmDdsWzSWpAMUuI1BTTsgx/+UzHKmOW5u70bT
	Ckd7IclCBYRfT8zY6O0Kd5QQzKgObje9Eis2C/YP/sQ==
X-Gm-Gg: ASbGnctnF5t4IahtvYYssTuiQpSfN/Fx8127h/acWvPlN/CXeLm8pet0ju8ns9lU3/K
	ygYBQhtkXXCw/GXtP2RJf1ltuf8JxZM4qw9PLQ5WB6X+9HrTaa4xXq/Pxj8DJi3bogi0j/G4Gxv
	gP8VgdGuCL8RgXQvWaJuIBKAX8fw5duTI5+HaE20N+f85tLf6J15bWph/Dskz483Rjq/h/LFB8/
	QvLWCvGvK9nmJGyjNpgoTTlbq4vKCGXgGSD9z7L0WIyfIpfXfCLKVOyWo6639eJJ5/AR7Wz
X-Google-Smtp-Source: AGHT+IELJXB6Vxn5RJnnZMeL+Gado+IBAHdtaM6Qy2HCdmwbDGr1UqUXyWt3Nl5lSLKzz2Qm7dnUnmUwvjqsA/6fofw=
X-Received: by 2002:a05:7022:b90:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11e031047c8mr4049834c88.0.1765228231561; Mon, 08 Dec 2025
 13:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-12-ming.lei@redhat.com>
 <CADUfDZpLrrjmxsmW-JyqLMLR_vFj0gropue9rTSns6ty+OxvCg@mail.gmail.com> <aTWXJRh9wqW4KG4g@fedora>
In-Reply-To: <aTWXJRh9wqW4KG4g@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 8 Dec 2025 13:10:19 -0800
X-Gm-Features: AQt7F2qYRHniesNDH58Xlvv_TYi3_duoqoTUIEq3_tvfTg-6daU5mqkTBscUkeo
Message-ID: <CADUfDZrBxohvaZr=uE-s4gz1pAvq-ryy6tV67GDqUu8RUGEOLQ@mail.gmail.com>
Subject: Re: [PATCH V5 11/21] ublk: document feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 7:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sun, Dec 07, 2025 at 12:22:38AM -0800, Caleb Sander Mateos wrote:
> > On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Document feature UBLK_F_BATCH_IO.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  Documentation/block/ublk.rst | 64 +++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 60 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.=
rst
> > > index 8c4030bcabb6..6ad28039663d 100644
> > > --- a/Documentation/block/ublk.rst
> > > +++ b/Documentation/block/ublk.rst
> > > @@ -260,9 +260,12 @@ The following IO commands are communicated via i=
o_uring passthrough command,
> > >  and each command is only for forwarding the IO and committing the re=
sult
> > >  with specified IO tag in the command data:
> > >
> > > -- ``UBLK_IO_FETCH_REQ``
> > > +Traditional Per-I/O Commands
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > -  Sent from the server IO pthread for fetching future incoming IO re=
quests
> > > +- ``UBLK_U_IO_FETCH_REQ``
> > > +
> > > +  Sent from the server I/O pthread for fetching future incoming I/O =
requests
> > >    destined to ``/dev/ublkb*``. This command is sent only once from t=
he server
> > >    IO pthread for ublk driver to setup IO forward environment.
> > >
> > > @@ -278,7 +281,7 @@ with specified IO tag in the command data:
> > >    supported by the driver, daemons must be per-queue instead - i.e. =
all I/Os
> > >    associated to a single qid must be handled by the same task.
> > >
> > > -- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> > > +- ``UBLK_U_IO_COMMIT_AND_FETCH_REQ``
> > >
> > >    When an IO request is destined to ``/dev/ublkb*``, the driver stor=
es
> > >    the IO's ``ublksrv_io_desc`` to the specified mapped area; then th=
e
> > > @@ -293,7 +296,7 @@ with specified IO tag in the command data:
> > >    requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH=
_REQ``
> > >    is reused for both fetching request and committing back IO result.
> > >
> > > -- ``UBLK_IO_NEED_GET_DATA``
> > > +- ``UBLK_U_IO_NEED_GET_DATA``
> > >
> > >    With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be f=
irstly
> > >    issued to ublk server without data copy. Then, IO backend of ublk =
server
> > > @@ -322,6 +325,59 @@ with specified IO tag in the command data:
> > >    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to c=
opy
> > >    the server buffer (pages) read to the IO request pages.
> > >
> > > +Batch I/O Commands (UBLK_F_BATCH_IO)
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +The ``UBLK_F_BATCH_IO`` feature provides an alternative high-perform=
ance
> > > +I/O handling model that replaces the traditional per-I/O commands wi=
th
> > > +per-queue batch commands. This significantly reduces communication o=
verhead
> > > +and enables better load balancing across multiple server tasks.
> > > +
> > > +Key differences from traditional mode:
> > > +
> > > +- **Per-queue vs Per-I/O**: Commands operate on queues rather than i=
ndividual I/Os
> > > +- **Batch processing**: Multiple I/Os are handled in single operatio=
ns
> > > +- **Multishot commands**: Use io_uring multishot for reduced submiss=
ion overhead
> > > +- **Flexible task assignment**: Any task can handle any I/O (no per-=
I/O daemons)
> > > +- **Better load balancing**: Tasks can adjust their workload dynamic=
ally
> > > +
> > > +Batch I/O Commands:
> > > +
> > > +- ``UBLK_U_IO_PREP_IO_CMDS``
> > > +
> > > +  Prepares multiple I/O commands in batch. The server provides a buf=
fer
> > > +  containing multiple I/O descriptors that will be processed togethe=
r.
> > > +  This reduces the number of individual command submissions required=
.
> > > +
> > > +- ``UBLK_U_IO_COMMIT_IO_CMDS``
> > > +
> > > +  Commits results for multiple I/O operations in batch, and prepares=
 the
> > > +  I/O descriptors to accept new requests. The server provides a buff=
er
> > > +  containing the results of multiple completed I/Os, allowing effici=
ent
> > > +  bulk completion of requests.
> > > +
> > > +- ``UBLK_U_IO_FETCH_IO_CMDS``
> > > +
> > > +  **Multishot command** for fetching I/O commands in batch. This is =
the key
> > > +  command that enables high-performance batch processing:
> > > +
> > > +  * Uses io_uring multishot capability for reduced submission overhe=
ad
> > > +  * Single command can fetch multiple I/O requests over time
> > > +  * Buffer size determines maximum batch size per operation
> >
> > The UBLK_U_IO_FETCH_IO_CMDS command specifies a buffer group, so is
> > the expectation that there would be a single buffer in the group and
>
> It is same with other mulishot request with provided buffer, and the grou=
p
> can include 1 or more buffers.
>
> > each command would use a different buffer group?
>
> Yes, each command should use different buffer group like
> io_uring_prep_read_multishot(), because tag may be read into the buffer w=
hen
> the userspace is parsing/handling previous completed FETCH completion.

Thanks for explaining.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
