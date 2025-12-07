Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8735979
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765095773; cv=none; b=tR7NgWw8vsAH519/fxYziJVrewXsEWLwOJySR1oE2pNk3ex2MxxDeZUe57aoQhTnJSbuIJMgw6Q7lQrMFmOD6fc4Ne7F5yhvhJ/amNlGsqOoKgu4+noAIGF+F+Rwmd/5SOifwH15TE6ScA300+xZ360X/ybDQ4vNeDzIeinQjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765095773; c=relaxed/simple;
	bh=JIG+AmSN7dw3b+qg7/au773Kc19Ts2DERcyZuB0kR8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7t3gN/ylHBCS65BAeQoOiMjmwssSpAsxXl3xVvleg3E9HStF8/CmBDCgoRNVShZih9vprc7nUMa7Ttk2hGlONHFQ2PtyavYV6NZqzci/RHvbydc6/3cR74SH28SpOHJLNQERRSZKXwmdPRrlzfFnUQylmbZOE4lcxDAYr9q6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SCjM38HA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SCjM38HA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-299e43c1adbso6225785ad.3
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 00:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765095771; x=1765700571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mefqLeHUUC5iY2EAcGSfgTR4zJw5WSISu3FseOxe67k=;
        b=SCjM38HAy2cDZtZich1z69RkVKZtcxzd501Na8eksswCO9hHu5CHAtl+FnnwveccHR
         VGf2R4rdewgaFlQgOeEy0Vdlo7KY2ORK+x2OIoT7sT5ffnqXs4JV8SxOwzvqp+UIX/VX
         2jb7hTy+E7A2Uf9q42zggXyvlYLV+4H4xzztbjA9nPyJ8PoWyUtj6L769Z28sj4hFgqb
         6ee6uMcu8jmleYkPQsnZ4VCflvnkcduBLcJgrM0plIioW7d9DihlUYGF+agAhL6IYXfC
         EyEhzdyds2sGpqdUjpOjXvzlOrBa62+ZI95E4VN4tRtWoPtXKTyWH3tLY5s+j+fKhp4J
         Nh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765095771; x=1765700571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mefqLeHUUC5iY2EAcGSfgTR4zJw5WSISu3FseOxe67k=;
        b=CLrH53JH3Hq6c5RsDLUT+cfo7gJtQqWeQ+3mZaOwDIOOIL3Pv/S9+4bwIdIRX239Df
         57QMSEo91UiSwKrU6hkZBxq5umOwagHRPx+/ljRmXKA8paaAUTE7P3dkqoWK+wk55Tbb
         rDBum9I0miXq7hC8OA6uq1JG11ojqQm9uF+lvhL0JqRuIaJLRTdkD+opysaiJaAZtcNn
         twDF6QXtkyIP8tubgpgPLususDf6r/bxhuDKAM02TipZFDKvpG8kwX6rdKB8gXOKlzz4
         1svD8INZDQ+0RhoGvuD2XUsopUFRMyMlJjTCHbOMesgYVNeXrIv/bmeiuFaMSCyVd+7I
         gCyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnxOFIteEEIypzIO9UirR0UA3jozU02iHHVxBzCmyfrq+nfJ0dntwZgOUq5aeNy7cPSCp+YmgwLZBSDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgggJl6CCXfDP/i/r2WsAQNy47uWa2rRzA74NhBDUf/i3yzVuy
	7Fk8sbaEwXniliTglyL0AEOse9pknOXO2jeAEgfAZWeg4z+fAaAsIpYG+J1oQ3LCqr6A1g3HFCH
	rg46sdOFPmDXd2+9zuJSyyjKnNdo/JyTcnEcafr9+3g==
X-Gm-Gg: ASbGnctkRX5l2egjpG9T1tdoBD0MFpq+BeOXykgyPHUWyR4lgyMqCZkKQatI4ST8xWH
	fU9SYAhSPfc2EUXTBciZ/jr3XVSWlENp6Ek/qojwmH87OFQ4BRGah10DoJBSGSecXYAoxQFVc7e
	i8pyx2J/KOR2s8dpeKBkJpx9inZAOIpTHegxjSOxfwrl3M79kk0DSMo6uZcS8Z93s/vGqOadoji
	JVzSOQqzBhAWI8OvZIkyEVgQ9DlNBxzFEv2LdSQyr62Pj/CpFFfdaWZcnRXgJ25RY5zyLEl
X-Google-Smtp-Source: AGHT+IFMipVlCO3igs+6pDxvPil1E7TBmZUfidaPUH8CM8rYO+BRT0O32FJRigWBuC1UA5jx5MLpat+l0WRxVtE+44c=
X-Received: by 2002:a05:7022:e16:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11e03e9450bmr1553592c88.7.1765095770603; Sun, 07 Dec 2025
 00:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-12-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-12-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 7 Dec 2025 00:22:38 -0800
X-Gm-Features: AQt7F2paCoKfeJNqPjbQW6BBDdIyp6_6dKDSB1vEAtFe4WyNh5ocezjxoxI9YM8
Message-ID: <CADUfDZpLrrjmxsmW-JyqLMLR_vFj0gropue9rTSns6ty+OxvCg@mail.gmail.com>
Subject: Re: [PATCH V5 11/21] ublk: document feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Document feature UBLK_F_BATCH_IO.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/ublk.rst | 64 +++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 8c4030bcabb6..6ad28039663d 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -260,9 +260,12 @@ The following IO commands are communicated via io_ur=
ing passthrough command,
>  and each command is only for forwarding the IO and committing the result
>  with specified IO tag in the command data:
>
> -- ``UBLK_IO_FETCH_REQ``
> +Traditional Per-I/O Commands
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -  Sent from the server IO pthread for fetching future incoming IO reques=
ts
> +- ``UBLK_U_IO_FETCH_REQ``
> +
> +  Sent from the server I/O pthread for fetching future incoming I/O requ=
ests
>    destined to ``/dev/ublkb*``. This command is sent only once from the s=
erver
>    IO pthread for ublk driver to setup IO forward environment.
>
> @@ -278,7 +281,7 @@ with specified IO tag in the command data:
>    supported by the driver, daemons must be per-queue instead - i.e. all =
I/Os
>    associated to a single qid must be handled by the same task.
>
> -- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> +- ``UBLK_U_IO_COMMIT_AND_FETCH_REQ``
>
>    When an IO request is destined to ``/dev/ublkb*``, the driver stores
>    the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
> @@ -293,7 +296,7 @@ with specified IO tag in the command data:
>    requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ=
``
>    is reused for both fetching request and committing back IO result.
>
> -- ``UBLK_IO_NEED_GET_DATA``
> +- ``UBLK_U_IO_NEED_GET_DATA``
>
>    With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be first=
ly
>    issued to ublk server without data copy. Then, IO backend of ublk serv=
er
> @@ -322,6 +325,59 @@ with specified IO tag in the command data:
>    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
>    the server buffer (pages) read to the IO request pages.
>
> +Batch I/O Commands (UBLK_F_BATCH_IO)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``UBLK_F_BATCH_IO`` feature provides an alternative high-performance
> +I/O handling model that replaces the traditional per-I/O commands with
> +per-queue batch commands. This significantly reduces communication overh=
ead
> +and enables better load balancing across multiple server tasks.
> +
> +Key differences from traditional mode:
> +
> +- **Per-queue vs Per-I/O**: Commands operate on queues rather than indiv=
idual I/Os
> +- **Batch processing**: Multiple I/Os are handled in single operations
> +- **Multishot commands**: Use io_uring multishot for reduced submission =
overhead
> +- **Flexible task assignment**: Any task can handle any I/O (no per-I/O =
daemons)
> +- **Better load balancing**: Tasks can adjust their workload dynamically
> +
> +Batch I/O Commands:
> +
> +- ``UBLK_U_IO_PREP_IO_CMDS``
> +
> +  Prepares multiple I/O commands in batch. The server provides a buffer
> +  containing multiple I/O descriptors that will be processed together.
> +  This reduces the number of individual command submissions required.
> +
> +- ``UBLK_U_IO_COMMIT_IO_CMDS``
> +
> +  Commits results for multiple I/O operations in batch, and prepares the
> +  I/O descriptors to accept new requests. The server provides a buffer
> +  containing the results of multiple completed I/Os, allowing efficient
> +  bulk completion of requests.
> +
> +- ``UBLK_U_IO_FETCH_IO_CMDS``
> +
> +  **Multishot command** for fetching I/O commands in batch. This is the =
key
> +  command that enables high-performance batch processing:
> +
> +  * Uses io_uring multishot capability for reduced submission overhead
> +  * Single command can fetch multiple I/O requests over time
> +  * Buffer size determines maximum batch size per operation

The UBLK_U_IO_FETCH_IO_CMDS command specifies a buffer group, so is
the expectation that there would be a single buffer in the group and
each command would use a different buffer group?

Best,
Caleb

> +  * Multiple fetch commands can be submitted for load balancing
> +  * Only one fetch command is active at any time per queue
> +  * Supports dynamic load balancing across multiple server tasks
> +
> +  It is one typical multishot io_uring request with provided buffer, and=
 it
> +  won't be completed until any failure is triggered.
> +
> +  Each task can submit ``UBLK_U_IO_FETCH_IO_CMDS`` with different buffer
> +  sizes to control how much work it handles. This enables sophisticated
> +  load balancing strategies in multi-threaded servers.
> +
> +Migration: Applications using traditional commands (``UBLK_U_IO_FETCH_RE=
Q``,
> +``UBLK_U_IO_COMMIT_AND_FETCH_REQ``) cannot use batch mode simultaneously=
.
> +
>  Zero copy
>  ---------
>
> --
> 2.47.0
>
