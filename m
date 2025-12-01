Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCC2877D2
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625597; cv=none; b=Cl+DJz3mMRxwLvmJ+9hJxoEotBtzYpZ+KYQaaVxaVqZcUjhPlaOSggD4HsoMgGaSxVSecdI4A9Sf4Udg8p366h3p0/ZtHYzj5DLrxkfrz0Td/krzslXSdhEM6XIGX2Hp4ccmr8MP1f67Tc+f2kf2dk99j6QhABqOy887vFX8EXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625597; c=relaxed/simple;
	bh=ZkhsYoYTTZj2bwIj7+BU0r1fHO1h+7QQM/v84LTz/14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3h1SG7ymveKFm30/V2xgqo2hgHJ9X8gRpzKzxBG+PKzs7wfP7vnZc8Q2AIyCMIjMH6oqNEx6eAU1LhzhXI3lBS3ZylpEJznW927CEEonsQRMExiuxcJKxa6IznWg3jtUZEsdWh0noXM2XxpcbIq2wRucXqowkUq4/YqWAmlnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SfEcsdox; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SfEcsdox"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb2fa942daso560888b3a.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764625595; x=1765230395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I93G5VdWwmlpA0A+emy+r9LF4uarQGNOGo/MRz4Leo8=;
        b=SfEcsdoxArFZv7cay5MpGBFwHgfsd/IQYe7QnN/txnUbQO292ppdrciX5i3bVmHpR4
         p66iwlst/LkrexUpg20osdCtPZvtZOZI0GY8RblpORt6GTYYTTS7Bo+sVNlUpYx8A3jw
         vu6RF2bsHD2ewXYVF9R3EPvmhLn28BKWxC0FSZ7oKxiBWs0A3ZM1u1Sd0sW7iH7OZ2q3
         Dy0RZqz5ksti2rBv8cUdF9TBwPCQsBR7yTDepE94As6kDA5BNcx6udLfLPnK5ON78T8E
         wLi/3cod8W860zvVfdOXeKi2REDyFvOECPyMaITZ85K72emdygfI32GZikZZ8qRuYqG9
         8ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625595; x=1765230395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I93G5VdWwmlpA0A+emy+r9LF4uarQGNOGo/MRz4Leo8=;
        b=iRanpU7K/Fz7RVKDZ3NE6ajQ6TcQc470/xlkgdIk/EBVZkumZsYSyTlAWyS83vgJw6
         0shSbugg8y89vtucUT8zUHXDKR4V4nhJbEBXo+qli11sX9brVsgq9jE+fGB4bqNqt5WS
         7olNFgfT12+OhrSXKLqqgrhEiqqeIlMSR6biHN1y8FjFMMsBVT0+r0q+GinA+UD8m6Ao
         j2Fh6JtVAzJGQj3pCrsHtMTehytqJZQYgiPMCjpXHot/ayZmDvCdErwRwICXryYfcEMn
         Y88pkGC8ZJDqWxUseOmIEN/U1A2N64gI53SXZTCM2/G3pN4leVbSH1WO61KOU7m96qz4
         I6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUKQjT2dIda2JBTebfpzt9S5RFEDqz1t6YCtoBb43SB3FHMDmeV0YMKJEt4carJ+KxMHKqnlzxXkr+1Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjDc7RobrO69dHNrUfc9l7KZqZSbOxdF2w/wPXSLRyqIN/8Dc
	FqSVprIeVrc7R+cLs9ly/dy3nPvMVLmsNDQseIRYwtImpBHLEWCPAShpwflVVej6dQJfJIgYJFY
	faFxojwG+xW6rmFWmUYPVMd7VocQBUfaFc2UdlTIynA==
X-Gm-Gg: ASbGncskPdaHxMdiSXHXTY/KReG5oO+QJZqNBWHBFWU7Oe+n8Dgp2bGsTJ1RGQ7SqOo
	X0BwTaH1QRK/eP0D/VzLg6+snCs8pwND7ZatTX0P0YNAb+pVnB2jjbCqf8EUFtr1s2pQH1DzH0Q
	0TUH60h1qQw8cSMa5sfZQNCMghYAMlX3eSNneZ8U+o+3K1LbVFuMfd+LrmbbUKI+5KahtThLM1v
	zn9vpF6hsmlpsxc8xEbWgOd3vBzkpocJRnnPVO9coCimr9OW3dq57K7vZQRQ+Cyei+bsYXJ
X-Google-Smtp-Source: AGHT+IGQFxaCwplKK6WeTRil0GfkdcuZNSqAllmqIKTSMEyZBTya2crcvluN5IyypuQ3/bNpXxrvqnFT3MfYrPkYECQ=
X-Received: by 2002:a05:7022:f902:20b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11c9f303bbdmr17585145c88.1.1764625590397; Mon, 01 Dec 2025
 13:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-18-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-18-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 13:46:19 -0800
X-Gm-Features: AWmQ_bkz_LxbGenWTFRQRtjc8pnlCWzh5ktsBlqYXOQvTCxNC1qr2G3juxsVs5E
Message-ID: <CADUfDZoDJhJqGpsYdoNUcPKOHeBAA8M+ow5ok4ySnKaU+XNQ3w@mail.gmail.com>
Subject: Re: [PATCH V4 17/27] ublk: document feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Document feature UBLK_F_BATCH_IO.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/ublk.rst | 60 +++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 8c4030bcabb6..09a5604f8e10 100644
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
> @@ -322,6 +325,55 @@ with specified IO tag in the command data:
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
> +  Commits results for multiple I/O operations in batch. The server provi=
des

And prepares the I/O descriptors to accept new requests?

> +  a buffer containing the results of multiple completed I/Os, allowing
> +  efficient bulk completion of requests.
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
> +  * Multiple fetch commands can be submitted for load balancing
> +  * Only one fetch command is active at any time per queue

Can you clarify what the lifetime of the fetch command is? It looks
like as long as the buffer selection and posting of the multishot CQE
succeeds, the same UBLK_U_IO_FETCH_IO_CMDS will continue to be used.
If additional UBLK_U_IO_FETCH_IO_CMDS commands are issued to the queue
(e.g. by other threads), they won't be used until the first one fails
to select a buffer or post the CQE? Seems like this would make it
difficult to load-balance incoming requests on a single ublk queue
between multiple threads.

Best,
Caleb

> +  * Supports dynamic load balancing across multiple server tasks
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
