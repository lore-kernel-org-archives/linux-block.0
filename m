Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6B3B2FC9
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073789; cv=pass; b=tRnqIVy9Lfvj5oXtIVoLmsiamPghVFEz4J7moO9LK1u0vciED8/gnORuSbfL8slHrqjTnhAKE+Q5KYSbB7XdujUZozCiW16FXU7WlxiG+U3ZMfUE2wuLW+Y5Ej74dlFI0y6D5N2q5/y/2QCgQmFsTwdadK6+tyUt6xS/M31TN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073789; c=relaxed/simple;
	bh=8lgeElSXyvxhzH2zMFtB8aHv49U/LJwVSFrA3vaHTmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpV08Dw5XmHpaChLJODWUSONk2LBW1mYUuqhgX9pkII+ijwsN8RbsiSpeAP0YKULwQTB1wWLNxvn3YaUh/XQYYSJ4MIXwGX5Uel1G0TbqCrRNjTyPzzdAA/EFpAEKjsMqftBUhEquy5R48O2v9Pg3AczEhFXYIuY9/kFL4X3HMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dDruFq1n; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dDruFq1n"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dd9f0fdc6so39184441fa.0
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 02:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776073785; cv=none;
        d=google.com; s=arc-20240605;
        b=ADlAV2Sc9hvicMnJWqhD+zmqsOPpVjPuTKFYXYjFZNaRabEqQWWL+Fhhygg1LtNFFg
         4+TgcaJ9B0trkp6sqxrsLQAfIj6EklPfYxnkxUZbih9ED279bffOh2vujP59xrZvuZhR
         /mzhcekMUvH6IPZGywsdnw6WlUzTgcXHW/GeHtXHL56DeSqf2xjUxRZfJnZpR0kNnzki
         ONEUFXZ+E5Bsz1rsFEgDff6tEu05Ys3wA/t7aOO3+VW1tHJACKt+sZ91+GwAnqnQGvoI
         WoPExZ/pPCwoTeEhscudkyaNBEIHM8nzjuZbBErx2+jzAEM9NQG9BEj7Mzy/HOdJTVFm
         IcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d+Q9kf8IwjWobAqJl4eE+w2AI+pglZ8Z1eE/4LlJ2dU=;
        fh=J9aGrwLIDyQhEXMVPXc2XH/TCtDrLgh8d3l2wl1Hwsw=;
        b=V1eW+90VwfwtdT6TSEYUpHWBGUnD7PtU68eWXf8//DomVduX7tGzx7KOzVwWs8JlMw
         cI1ytfl+rdz3BRX2I4uLMx1bI3hPWxrMnefXvAs+jKnQDa4U6wQ9p+c87jr22Yu/qAMB
         uk1NgSPBGZqduNtf/NQrvvhlrGThodyyBrOywTpU66KMH/KMCABdbUYtvwfo22kvsFJh
         1xQSBLfcKp3hS2AW8wynEqLi6+ljwhiORqDrbUlT3o770Q1Cw8OKUjTwklOE+e03Qkhq
         UudYaEV3wv+uxwYS7nUG62+ejPFxJzBqhNPbbXLreY0bQ4H5fDaW2/votfzaO+2deIgr
         szCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1776073785; x=1776678585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+Q9kf8IwjWobAqJl4eE+w2AI+pglZ8Z1eE/4LlJ2dU=;
        b=dDruFq1nLytBzdlW1q5AR7Bt2bGpEdAD7NfKrP5fPgP31MrJL08uHm8BVTXJqpz0S2
         8IBmeWAndy35r/u0HlIijQ7HlrCvJ0sNsFitU5OG8/jMlXH/ZNJAPeIdnx9ReSJlOmQY
         TlhFo3b9p4xCHQxPmGnUvosmqA6GytUV9U8HuWJnD1mOVuwk/oPATFcFnuQO9iJi7k5O
         njuSDTh1PRMRMPN5s2I1xmVK6+0u0cKTrTiw0WXmLKWnZZwo3Xso8ExSnkatHT2wRrjC
         ZTZTb7IVJ2Sq93Suif78jfVjok6xHbPr7b4YcbZOrY5WU8uBbRJb44moTKPzymcqEHI8
         GQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073785; x=1776678585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+Q9kf8IwjWobAqJl4eE+w2AI+pglZ8Z1eE/4LlJ2dU=;
        b=Q3Yz8Q2dXDbENYO0v2xvOSZHfSaY+z953tv2M8IWXAD40El5DmIVYuvxVlq3fe/OqU
         Q14l0fqvLCS3wXrK6XIoqYWSrzaDR0m/NcX/R47IxR6ObHwTKltdtAXD635smtMcTj0A
         q81rJOwnoTPifJ8u0ZdWg39G2GPbtdGRd91Riy93L93+zYnWTfog+t5gvJwhpI7YZQQ8
         OS6vMX8qK652evJFJXb6BNNCZF2G8z6cdnYdzAZKFiKbhREwdU7aw9RTM2sbeU9fgpzv
         yaJbCIx08iNI+QgKoMFrZUJt171Wl38Mzcd/dTXJgKkpUVMTQExSmweKTbUvF81QsNoA
         Vpzw==
X-Gm-Message-State: AOJu0YyM5/9zvR1RxpbLtGW40s0Z4sHCUHumvwl/20UhRQ/hz8qQzw5X
	dTHRNtezhZLfp5LhoV/WblucAyV9wRMfIvWjTMS6qoGfJvwT/IPle7yLQlGmp6acOzRpAfgHKzt
	OPm2s43QoBWZrKfcF4aromdKGHqIs0kc8QeSg85v2Mg==
X-Gm-Gg: AeBDies6bL7Ge4BA1KUzeLGuLuGQvyC7JmPI83qBRNKFOBVKPfEf4XSN8Qo8nITz74E
	j2gCs9l9xUv17IU3J9ixqZzHYn0oDsm4482mzExmMmo5DAuPjMguQubqXZTa2V/WRVyarHaWY7t
	d3k3h0QG9mmYRot1YnzqYo+9DCrVxaWCIO882W6Db1CxI7pw3L2dCqzEztYkFK8ia6kqA3IfL4S
	ZpI0Ukz0oV4iUeNQR0AjqSzWSzl+DIOOkNjoN7EZ3c9j2PJ5zQH/KhYPIEMauFL/N4pzgfO1oDc
	B1Deq8WNFl9n2pI1DqefWusGPqoeiCNCU4cBL7NZai7ZrMGUq/5OAWQ2pbba8IGFm77x
X-Received: by 2002:a05:651c:4412:20b0:38e:7b89:7eec with SMTP id
 38308e7fff4ca-38e7b89805emr6977211fa.4.1776073784953; Mon, 13 Apr 2026
 02:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_mRpS=uqW=2NF8RdzW2jjgu+3LhmCFiSK2kahRmTS-tw@mail.gmail.com>
 <CAJpMwyjAQhL9H_5Odz3zg12D-ja3VdsbZbwE2TxuLEsaP5KQbg@mail.gmail.com>
In-Reply-To: <CAJpMwyjAQhL9H_5Odz3zg12D-ja3VdsbZbwE2TxuLEsaP5KQbg@mail.gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 13 Apr 2026 11:49:33 +0200
X-Gm-Features: AQROBzDsbhOGqA6zry02Q5UGCgGlutU-MHJE-WdzM7DbMKl9A7IV_mXj-lct3q0
Message-ID: <CAJpMwyh8CDzN2nOWX7LtP=9QDH2k2d=RydMe_5CP0D5NYTSy1Q@mail.gmail.com>
Subject: Re: [bug report] blktests rnbd/001 hang on s390x server
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, jinpu.wang@ionos.com, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:10=E2=80=AFAM Haris Iqbal <haris.iqbal@ionos.com=
> wrote:
>
> On Sat, Mar 21, 2026 at 2:00=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wr=
ote:
> >
> > Hi
> >
> > I found this issue when I running blktests rnbd/ on s390x server,
> > please help check it and let me know if you need any info, thanks.
>
> Thanks for reporting.
> We'll take a look and come back.
>
> >
> > dmesg:
> > [   72.319120] rdma_rxe: loaded
> > [   72.358181] rtrs_server L2371: Loading module rtrs_server, proto
> > 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) ,
> > sess_queue_depth: 512, always_invalidate: 1)
> > [   72.380277] loop: module loaded
> > [   72.399060] run blktests rnbd/001 at 2026-03-21 08:42:02
> > [   72.408570] infiniband enc600_rxe: set active
> > [   72.408573] infiniband enc600_rxe: added enc600
> > [   72.422914] rnbd_client L607: Mapping device /dev/loop0 on session
> > blktest, (access_mode: rw, nr_poll_queues: 0)
> > [   72.488056] rnbd_client L1192: [session=3Dblktest] mapped 2/2
> > default/read queues.
> > [   72.488199] rtrs_server L1058: <blktest>: Processing read request
> > failed, invalid message
> >
> > # uname -r
> > 7.0.0-0.rc4.260317g2d1373e4246d.37.fc45.s390x
> >
> > # ps aux | grep rnbd
> > root        1492  0.0  0.0   8276  4436 pts/0    S+   08:42   0:00
> > /bin/bash ./check rnbd/001
> > root        1521  0.0  0.0   8288  3292 pts/0    S+   08:42   0:00
> > /bin/bash ./check rnbd/001
> > root        1523  0.0  0.0   8424  3664 pts/0    D+   08:42   0:00
> > /bin/bash ./check rnbd/001
> >
> > # cat /proc/1523/stack
> > [<0>] send_usr_msg+0x120/0x170 [rnbd_client]
> > [<0>] send_msg_sess_info+0x1d2/0x210 [rnbd_client]
> > [<0>] find_and_get_or_create_sess+0x274/0x2f0 [rnbd_client]
> > [<0>] rnbd_clt_map_device+0xf6/0x7b0 [rnbd_client]
> > [<0>] rnbd_clt_map_device_store+0x228/0x320 [rnbd_client]
> > [<0>] kernfs_fop_write_iter+0x168/0x220
> > [<0>] vfs_write+0x282/0x450
> > [<0>] ksys_write+0x84/0x110
> > [<0>] __do_syscall+0x166/0x600
> > [<0>] system_call+0x6e/0x90
> >
> > --
> > Best Regards,
> >   Yi Zhang

Hi,

We have the following patch which fixes the crash for us. However, we
tested the changes in virtualized s390x VM, and observed a few hangs
initially, which later went away. We are not sure if it was because
the virtualization was slow or something else. Do you have s390x
hardware to test and confirm that the below change fixes the issue
cleanly without any other hangs/crashes?

From 85f8bb94b7357d50cd9daf5c5eb72a7c39cfdeba Mon Sep 17 00:00:00 2001
From: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Date: Thu, 9 Apr 2026 13:29:59 +0200
Subject: [PATCH] RDMA/rtrs-srv: Fix processing messages for Big-Endian arch=
s

Convert msg->sg_cnt from le16 to cpu endianness before processing
it. This fixes bug processing messages on Big-Endian architectures.

Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0140bfaed721..978daa69e096 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1044,7 +1044,7 @@ static void process_read(struct rtrs_srv_con *con,
        struct rtrs_srv_ctx *ctx =3D srv->ctx;
        struct rtrs_srv_op *id;

-       size_t usr_len, data_len;
+       size_t usr_len, data_len, sg_cnt;
        void *data;
        int ret;

@@ -1054,7 +1054,8 @@ static void process_read(struct rtrs_srv_con *con,
                             rtrs_srv_state_str(srv_path->state));
                return;
        }
-       if (msg->sg_cnt !=3D 1 && msg->sg_cnt !=3D 0) {
+       sg_cnt =3D le16_to_cpu(msg->sg_cnt);
+       if (sg_cnt !=3D 1 && sg_cnt !=3D 0) {
                rtrs_err_rl(s,
                            "Processing read request failed, invalid
message\n");
                return;
--=20
2.43.0

> >
