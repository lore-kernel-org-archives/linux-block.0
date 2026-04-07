Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6D165F16
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523309; cv=pass; b=pa2IkELO5RmXLHDvkeBBHomwwuwnn5TZN9OivENmsUuDNioQEGZJTWwCK5fJbxdb+RBtFGZ30xl3SLcMe60SgQmi1YTegaIjCt/GrjVq1K18DrFYPTeUhFsRKrD8DhB4WduM6XN0hHNUUSoyvwbIeDVObZjUDI3GH5O10pso8bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523309; c=relaxed/simple;
	bh=X7u7RPo9LpkRAInDqt8AThNOTEpWL8sZh8JtSrkg41k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZIJMtwrXabYlLxKcEEVF5nGGwUnBO16ddXspNeNAL7SXD67z+uYllDl7/1zWGazRJh1i0EqbNxpvG8TFG4ZyUPiFzqRkFFa24o3TyAraWOL4NbB71ZcfwetUup7v6wTBLcnmodfPXkCnz0q3zMjB+sLESF6VQksvz6cjQrJinQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1ZhZEHj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1If48GW; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1ZhZEHj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1If48GW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775523306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDjRFzQKSCNPgB8wqqatOC6MJ60heW8kaiz5xbBtBzM=;
	b=Y1ZhZEHjEZ6ucYl4wqBCJzfV3XXFhvTQqIC14FMDlwD5TG+u1H54kKr1CRT/cBZjeKk9Vb
	dV4L0+oFG9qFWxYaPv9eJTwEIfF5FoARaluaa8SPGXPHZiTEMP3+eTWYgqiEs+ioHuDQLI
	AXHaxRhicEzXz/cc9xHHMmD1skBZKOA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-WHD4c6vnOwisSDBV2y3kdg-1; Mon, 06 Apr 2026 20:55:05 -0400
X-MC-Unique: WHD4c6vnOwisSDBV2y3kdg-1
X-Mimecast-MFC-AGG-ID: WHD4c6vnOwisSDBV2y3kdg_1775523304
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-389fef1b721so21002991fa.2
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 17:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775523304; cv=none;
        d=google.com; s=arc-20240605;
        b=d+Uh1HYtzdxwS1ZHizlnUscxRBs6MQQB5g3nz2GEi9aBzhZwsC9Cz2a4X0bCBvfKi4
         lFcB0arbUanV9mwCFpHiWt2ThKuu8VMhFbZybo0iH1Sk5VNeNm7DFAQw/gVgZoSH2xFE
         Czsa1B/watbvH5xSwyIzQvkRI/CjK8eAkXkcnjMQKxrM3gcAxNsqC9SuTUEQca85TZqO
         C+QU5H512SzV1WRHGcJoYnX7gpst4rLgr2yYiPHKZbYHauX/ueaICgzSkqMkJWBxczLX
         mBHrgvXHC7M4+swid29edIbBOCC+yIOKNmL9emO9CDq3kA4fFApXJCXNQypSBPKrKAF9
         7V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDjRFzQKSCNPgB8wqqatOC6MJ60heW8kaiz5xbBtBzM=;
        fh=kuRi+J/XgmbsAkc8kT8wNtjDb6nH7yvngZCVrvJLXCQ=;
        b=SPLGOavGeKq/R6iAeK3eDQ6Ue8Hk72RwpMSiw/0ogbOT7sZn1M62athHJdUUTMHL14
         04BOIjarLxd4h/I8opsjvPLcEC1RtBVH/YqiZpfBozi8RbgmVMagw2aNH1DB9sSc+eii
         Gd6pKtsjbWjPsrPePeQfNmwweatG9PkXACJWLy6f6cURfkmE/pv2HnyZZU/GwuIRNXBZ
         6XXQTHqJHl7A5mG6d0CvGDpBDSnbqHLviXjvNNDBkcg6nMSmzmqzG/pgCGvBlj6pxGng
         iI8G4Ymz/8PJj7CvYiabRMTbmyNKO9rjNfc5fgroOUD8bi+ajmnPBERh+Qi2M/dgYp9z
         QexA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775523304; x=1776128104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDjRFzQKSCNPgB8wqqatOC6MJ60heW8kaiz5xbBtBzM=;
        b=Z1If48GWaodVrTqacotXTziDrlZFX/d0hTp/jMrdcvZnR7EcnoBDOHWg0sNyRAhrFg
         czDF+iJvnPr50AOjnD/5REJ/jV0RFZcvEhNWEKgSqfa+SQDZUunse3Ztn0UQk9seI/Bp
         u2DZDG3gNkYi5RD/QXk3Z1UQAq/aa8toGBhtyrMT6iUXqaXGqJ/TfZ/gnqPV+qVuC1de
         VRw5ec/1muVGrGXknf1h5Kk2+T59hA56CPqnKdsVWppdItsSmS2jNO7bDKA6/atAynXt
         xVI+UO2OS6583T/3rli+gv9ChPV4Yunto9rtfhoal8JVERfyK9n+oyru32KOv1Pfe47b
         yrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775523304; x=1776128104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDjRFzQKSCNPgB8wqqatOC6MJ60heW8kaiz5xbBtBzM=;
        b=bI2sQ0Ut13i3GtpKk6Tp5LRQcLQfc5ShguTeweIMPJByIus9rZmuR/NrYo7ZnseLAW
         /O/b7OQ585qZaBOlQdrcF+TSsn+OoNmmVhwp6wVu+maZkDIO1vUJ8xQFjdHIUS6EeJXj
         TywDnB9kuP5taVJ0ZoBVes/dAZ2d+xN59HFmlXCkWeQQFZSKvApNTg+BD5BC/k1g9e1B
         T4hl2puEJpDsBKLlc/bPlLco8EDkvmVgAUYE14Jr9cPS4ciZ13TmCx9etcenDcAtsNP+
         PwU/Y8UHCG27hRU22wepH7ZPF/jMPaY3jslRBXv51E0BR3RsPWSZSEsUssFr8CAcFW5z
         jurA==
X-Gm-Message-State: AOJu0YxF7yux6kBzDA13x6Ko2lg1V+ZAY3BFaYQbWOG7igh0c3nbwgr9
	1wHXyJwVq6tck4L4TeRUCyUYPk1iv/h7FSpd8pPojz/ChfqlceYCUDZXtwXgIk0ifrzhiMNhjlm
	i4o2fb+JOoxIuXTJgzC3VCpMFOPOjX+6s8o5f6P2eFvQ58PBJwIziuf+2zFRiYyx4P+9ZX1CSbG
	3syVxWKZXRPHu6WjwLogVF7PZvUihfw8YCioCI6n8=
X-Gm-Gg: AeBDiet/Jdibj/5Kw7YoTjhoyaSWHbR1svbw2/nUMv/AD27bHgcLc9RCKcig/2QBUcP
	S3jV/EAOuCqzc7GquGH3HqUxh3qax7uvdi8Hxvhsqe7LmHEo3tNwDDahyWxhyAjfkqEDcnTZW7R
	KVf3PZc5wA+umo9VJKsGih+4uAgJdGYsmBHs1QUnxnc52PA+GFY9elPR/ziHC5xmBSlKvbPHxxN
	Vc5yN3Nf+vvmLVb0+ojGAkLXGeN9kvZiacbu6Cy6F39OLfsfRo=
X-Received: by 2002:a2e:9346:0:b0:385:c7f0:2b1a with SMTP id 38308e7fff4ca-38d978415c4mr32942141fa.33.1775523303582;
        Mon, 06 Apr 2026 17:55:03 -0700 (PDT)
X-Received: by 2002:a2e:9346:0:b0:385:c7f0:2b1a with SMTP id
 38308e7fff4ca-38d978415c4mr32941961fa.33.1775523303018; Mon, 06 Apr 2026
 17:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com>
 <DHJEQZRGEMDX.1KX53DW8BCUPC@arkamax.eu>
In-Reply-To: <DHJEQZRGEMDX.1KX53DW8BCUPC@arkamax.eu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 7 Apr 2026 08:54:50 +0800
X-Gm-Features: AQROBzCQCA5sK72k6LhuTZ8kPxaTVdRMNtT41ZnMj2ClPHut2C-aZvWE5rw1dco
Message-ID: <CAHj4cs9XrhqiVS81ceO_m70dU9xVB_aoC3HDZ-8ABeDow6eWog@mail.gmail.com>
Subject: Re: [bug report]nvmet_auth kmemleak observed during blktests
To: Maurizio Lombardi <mlombard@arkamax.eu>, Alistair Francis <alistair.francis@wdc.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	wilfred.mallawa@wdc.com, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:21=E2=80=AFPM Maurizio Lombardi <mlombard@arkamax.=
eu> wrote:
>
> On Fri Apr 3, 2026 at 10:46 AM CEST, Yi Zhang wrote:
> > Hi
> >
> > I found the following kmemleak during blktests on the
> > linux-block/for-next, please help check it and let me know if you need
> > any test/info for it, thanks.
> >
> > commit:
> > aac56c7b77fa (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-7.1/io_uring' into for-next
> >
> > reproducer:
> > nvme_trtype=3Dloop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045
> > nvme/051 nvme/052
> >
> > kmemleak:
> > unreferenced object 0xff11000305c48240 (size 32):
> >   comm "kworker/u48:3", pid 123223, jiffies 4401374163
> >   hex dump (first 32 bytes):
> >     30 1e 78 66 9b 04 e7 4a d5 d7 a3 a2 ab 1f f1 22  0.xf...J......."
> >     11 4a aa 11 b5 f7 fa f6 24 a6 17 11 e6 f8 e7 dc  .J......$.......
> >   backtrace (crc 58405ce8):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
> >     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
>
> Maybe this has been introduced by commit 2e6eb6b277f5
> ("nvmet-tcp: Don't free SQ on authentication success")
>
> If nvmet_execute_auth_receive() gets called twice and executes
> nvmet_auth_challenge(), the dhchap_c1 pointer is leaked.

Thanks Maurizio.

The kmemleak cannot be reproduced now after reverting that commit.

>
> Maurizio
>
> > unreferenced object 0xff1100027be14c00 (size 256):
> >   comm "kworker/u48:3", pid 123223, jiffies 4401374168
> >   hex dump (first 32 bytes):
> >     30 96 ec 83 33 bb fc 41 ec 81 70 14 1e ad 32 fd  0...3..A..p...2.
> >     39 b8 ca 9c 99 22 ff 28 f0 80 f3 e0 1d 82 36 a9  9....".(......6.
> >   backtrace (crc e365275d):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
> >     nvmet_auth_reply+0x436/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000305c48d40 (size 32):
> >   comm "kworker/u48:3", pid 123223, jiffies 4401374170
> >   hex dump (first 32 bytes):
> >     c0 8b 24 c4 c1 5a 37 d1 fc 49 ec 3e 44 05 7e 19  ..$..Z7..I.>D.~.
> >     70 39 6a d0 53 22 6d 23 fc b9 94 83 e3 3a 60 e2  p9j.S"m#.....:`.
> >   backtrace (crc 8284cf12):
> >     __kmalloc_node_track_caller_noprof+0x637/0x880
> >     kmemdup_noprof+0x22/0x50
> >     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff1100016dd8c7c0 (size 32):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374600
> >   hex dump (first 32 bytes):
> >     21 1e e5 a0 b9 e6 a0 6b 85 cb 62 ff 30 d6 21 0f  !......k..b.0.!.
> >     05 89 bc 6a 44 fe 2a c4 bd 35 23 59 6c 56 2b 2e  ...jD.*..5#YlV+.
> >   backtrace (crc e32fd56c):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
> >     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000255549600 (size 256):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374604
> >   hex dump (first 32 bytes):
> >     11 1a 6e 99 d1 bc ae 48 5d aa f1 74 62 30 68 c4  ..n....H]..tb0h.
> >     07 9f 31 dc 83 a4 a4 92 47 18 9c 04 1e 7d 68 c1  ..1.....G....}h.
> >   backtrace (crc db3ad817):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
> >     nvmet_auth_reply+0x436/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff1100016dd8cc00 (size 32):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374609
> >   hex dump (first 32 bytes):
> >     51 ff e9 8e 10 6b b4 b3 3f 6c 7d f2 74 eb 42 98  Q....k..?l}.t.B.
> >     6c f8 ab ec 10 d6 e8 0f 02 79 4a e4 ec b2 ce ed  l........yJ.....
> >   backtrace (crc 7099040d):
> >     __kmalloc_node_track_caller_noprof+0x637/0x880
> >     kmemdup_noprof+0x22/0x50
> >     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff1100025554a800 (size 256):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374633
> >   hex dump (first 32 bytes):
> >     eb a9 ed 0e b7 42 c6 6c 48 ee 56 29 a4 8a 99 18  .....B.lH.V)....
> >     1c 90 2a 53 22 7a ee 5a c0 6e 60 43 5b 33 a1 d2  ..*S"z.Z.n`C[3..
> >   backtrace (crc 3ce24e58):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
> >     nvmet_auth_reply+0x436/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000267237a80 (size 32):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374635
> >   hex dump (first 32 bytes):
> >     20 25 77 95 60 f2 19 5a 09 20 2c 25 8b 04 2a 4b   %w.`..Z. ,%..*K
> >     b9 53 8e 10 39 b9 07 0d e0 fc 93 3f 82 50 86 0c  .S..9......?.P..
> >   backtrace (crc 3f42440d):
> >     __kmalloc_node_track_caller_noprof+0x637/0x880
> >     kmemdup_noprof+0x22/0x50
> >     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000138f46e40 (size 32):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374654
> >   hex dump (first 32 bytes):
> >     2d da 99 66 3b e7 d6 65 aa d7 1f a6 51 b4 ab 19  -..f;..e....Q...
> >     46 d7 30 0d 12 fd 55 90 c4 6a 4a 7a b8 55 7f 4f  F.0...U..jJz.U.O
> >   backtrace (crc 3ab35d56):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
> >     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000126860400 (size 256):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374658
> >   hex dump (first 32 bytes):
> >     cb 48 8c 49 58 82 bd fd 21 5b e4 a5 5b 5e 7b 8b  .H.IX...![..[^{.
> >     48 6a 47 3e 9f b7 76 06 c8 47 6a 5f 3e b4 20 15  HjG>..v..Gj_>. .
> >   backtrace (crc b164cda1):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
> >     nvmet_auth_reply+0x436/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000138f468c0 (size 32):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374662
> >   hex dump (first 32 bytes):
> >     01 dd af 3b af a0 f8 ec 61 80 c4 aa ad 56 9a 27  ...;....a....V.'
> >     d4 f9 f9 8d 98 64 ce 5a 81 e2 14 e0 e3 5c 79 97  .....d.Z.....\y.
> >   backtrace (crc b24f43c2):
> >     __kmalloc_node_track_caller_noprof+0x637/0x880
> >     kmemdup_noprof+0x22/0x50
> >     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
> >     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
> > unreferenced object 0xff11000185c80580 (size 64):
> >   comm "kworker/u48:2", pid 139664, jiffies 4401374716
> >   hex dump (first 32 bytes):
> >     bf a4 73 5a 5c a7 d7 8e f7 6e f9 39 3a 94 66 a4  ..sZ\....n.9:.f.
> >     8e f9 bc f6 9a 23 ac dc c8 71 85 ef 09 4c ac 38  .....#...q...L.8
> >   backtrace (crc 70f5e8bf):
> >     __kmalloc_noprof+0x635/0x870
> >     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
> >     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
> >     process_one_work+0xd98/0x1390
> >     worker_thread+0x60b/0x1000
> >     kthread+0x36c/0x470
> >     ret_from_fork+0x5dc/0x8e0
> >     ret_from_fork_asm+0x1a/0x30
>


--=20
Best Regards,
  Yi Zhang

