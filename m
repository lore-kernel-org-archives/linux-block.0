Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16C3093D8
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226253; cv=none; b=P5z/ZS+t0FdSoHQI1BivT0gjPV0TQ1kZP1M5MAnGQyDIR6nM3EnoQ0R0k+HvwEt9YKRqa6DiaN/Cd0u250htfbwDJ+IqaQ8HCl9NzUMFPnqtgdfKqUmvFw5NmguIEOcy+nfUS7koAstf5jx4zBW1xgVjriCmFauj4/o9dFQ4cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226253; c=relaxed/simple;
	bh=nyvN1OHB9IcGP7zWj7MFUTcv8md1UFswrZ+n2nVrcgY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZSy+q2gMYHg2GvhtWB+F4tUuQMarwXNvekfEjlvCwVpZKuycA6OCrBrsfqGeCC7No03UaMAu291l1bY7QTO+6JB4hubn+bYfNiZoOWaqfMrPTKvFL8hYQqtbaenUAAiE7or+S9KU85XfJh+KcKLJv+KVmDkp/0P+etApTQ/HEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=giAjdzT2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="giAjdzT2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e6eb77f0bso109466385a.3
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791226250; x=1791831050; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YCFsb7Gq/U2gwTPLiXcefSi3ZBILSVLHbw6W+P4Oq8Y=;
        b=giAjdzT2uhOwWjTyDWnNlB8ewWQvjWxw3PDvFjdvZ1KK1h8jtBp9RmNC8gDQg4puv7
         KEdAWP2kVeS6eUI+5PBc+6vPLWXOQa/BG8S6XFLEXiU41cizry3Ihyy3DkHWFoD3Ei6R
         9TFU2BC425FJ4uazhsjJl35HDr0WevhYeesSLk15KHXKcpWoZxTE8Ns3AQw5J2HA8XtK
         cgvQNGr6zK/uMYjA21UNskRBvqYHlcNzNTR3yYFT6HK2rzXNgXGfeNGXgA4/Es56jdI0
         QEv2LfM0e8lD3KPfdwo3nF/AAdA4rxZ4/Z7xL07wk1OKIPA+mXYmYlcxPRsh/E0CgKtk
         DFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226250; x=1791831050;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCFsb7Gq/U2gwTPLiXcefSi3ZBILSVLHbw6W+P4Oq8Y=;
        b=GPzuuvAjrZPyJX7UUcZY9fsU5DwqKTuVABdVsNOwXDnZIxq4nehAtZGXP+KTrRSyPV
         nIZ7DbcNLbUGDpfkDMl5Ubo52ArAFC37vQ2Ctgd7V9yQPgcO3SaigLtRsfx6IgGkFhWU
         lW7syEp0nxW59TP8HZSKIicXzR9L1YmKL23ndbJSbQsBRicmmpMy1fXn4QoHYc5wFFrs
         Wjc2hJaKNafT7gDBJ0wPBGIzYEnVQvgCjROmKcEJJjBdB/VOrh8YxARIlWzQ6Y/Q/zpU
         +ze0eo72tN+vYI3wGS2Oxliz9S/oI1/zZ/dzPeJfkdQrmKYlLb10up9xQu0ABytIGOfd
         Zjsw==
X-Gm-Message-State: AFuF++mlmVc/gIl433QUBeAJT7bXv3qI2hTtL9mWuRTxhRbAEvCu1Fu5
	o59ieN3vmn8p/r0TVRdHhfOmKh2X2hlUOXImlK3f5Z2EsNsYnRVJBvr2iQKbvUhH8BAPmAKdpem
	tKjJp
X-Gm-Gg: AYBFou2bieSdIHr5PjESfNwUIV4V8ftiK1rJX6Uqj0Z+L0flxssVZuCCBhN7Si9MGoY
	qexBc+iubBhAp8GHpa5EP77ZCySXxTx5gHI83cGMhnVEscn1p9+kGTwXfnxPvJrgEJOMdM2BqGR
	M4h7HVbXac94qhWVUSJ7PVGPS1JN4kqLO0EIRvxF/+pxrXXCGxQiXjRS2xyMoy+Ai3RyziCeMgD
	cFpeUJQkXS/RTUunbdRmI2wLO74vKIe4C5wJQS8RQoqxfhk15NpIfvE1ok62W+65aNjUVN97Mxt
	aC9N7qa/UIfGpKj0zCzPc1k/6DDBlYbIaRB2uVLi4GsuRU0kzpI47ioDrg/aG7lagLZjEsDxxIe
	HGzJppADVaCbaynAnRZsNIr/IEyvzO4B0QMbo8i/eTMAdsNWbSdAoizfjayLwUMS82SDKYtaRmG
	JEPlojv5MpIZsBe5X70uVhOJ5SnTnDcflGrHErLBbRJvkq5rJD9jqE+FxXEMse90vK6k/39gVyn
	3n9PZkivSUlS3GRxWfXOxUEjQ==
X-Received: by 2002:a05:620a:711c:b0:937:6de8:b40 with SMTP id af79cd13be357-93e50f80e78mr1614579685a.15.1791226250403;
        Mon, 05 Oct 2026 11:50:50 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a7a40sm933243985a.7.2026.10.05.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:50:49 -0700 (PDT)
Date: Mon, 05 Oct 2026 18:50:35 +0000
Message-ID: <63d8149c093169706e7478e779116b61.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 0/8] ublk: don't dispatch to canceled io commands
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 07:54:14AM -0500, Ming Lei wrote:
> Hi,
>
> Josef reported three ways in which ublk dispatches a request to a
> canceled io command, which oopses on the NULL io->cmd.

Thanks Ming. I ran 1-8 on top of for-next (d70609a2f68c) under QEMU with
KASAN and lockdep: my reproducers for the three routes plus the restart,
recovery and QUIESCE_DEV controls, the ublk selftests including your
generic_18, and my ADD vs STOP_DEV/DEL_DEV race script. No oops or
lockdep report anywhere, and generic_18 passes. A few things though.

1. kublk's batch daemon dies when PREP_IO_CMDS hits the new STOPPING
   check. With patch 6, __ublk_fetch() returns UBLK_IO_RES_ABORT while
   UB_STATE_STOPPING is set, and batch PREP goes through it, so a PREP
   racing STOP_DEV completes with -ENODEV. kublk asserts cqe->res == 0
   in ublk_batch_compl_commit_cmd(), the daemon aborts before it writes
   the start eventfd, and the parent of `kublk add` sits in
   eventfd_read() forever. My race script hangs on the first or second
   iteration with -b; the per-io servers handle the abort fine. The
   kernel side is fine, but kublk needs to fail the queue cleanly there,
   and generic_18 has no batch mode, which is why it doesn't see it.

2. Routes 2 and 3 still bring the device up. START_DEV returns 0 and
   every request on the new disk fails, and after END_USER_RECOVERY the
   device is LIVE with the reads on the dead task's queue parked forever
   with plain USER_RECOVERY (generic_18 accepts both, and turns off the
   partition scan, which is what parks under disk->open_mutex otherwise).
   I'll send a follow-up on top of your series that returns -ENODEV from
   START_DEV and END_USER_RECOVERY while ub->canceling is set; with it
   generic_18 still passes.

3. The same follow-up has ublk_start_cancel() read ub->ub_disk under
   cancel_mutex, with START_DEV publishing it in the same section. Today
   it samples the disk before taking the mutex, so a server dying during
   its own START_DEV can mark the queues without quiescing a disk that
   START_DEV published in between, with first I/O already past the
   canceling check. Narrow, and older than this series.

4. Patch 5: the release work decides there is no disk before it takes
   ub->mutex and doesn't look again, so a START_DEV that slips in with
   the exiting server's pid can go LIVE first and the work then resets
   a LIVE device. It needs START_DEV pending while the node is released,
   e.g. a separate control process, and nothing oopses (every queue is
   still canceling), but the device ends up LIVE with requests failing
   or parked until STOP_DEV/DEL_DEV.

5. Patch 6 changes STOP_DEV's contract: a server that still holds
   /dev/ublkcN after STOP_DEV gets ABORT on FETCH/PREP and -EBUSY on
   START_DEV until it closes the node, even if it had fetched nothing.
   That's fine by me, but it should go in Documentation/block/ublk.rst,
   since servers that STOP_DEV and restart on the same fd will see it.

For 1-6, with kublk fixed for 1:

Tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks,
Josef
