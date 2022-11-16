Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB82C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiKPQAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKPQAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 11:00:52 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473D4046B
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668614450; x=1700150450;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vPMS37Q4jD6SwDXRzc5EjrUQLTNe90Er6GobZR64hmI=;
  b=ATE1GIwb3yDziYNh+5gXoFlMuzhljtYP9kbZAw5sJn1boDfwPm+rYkza
   5/ajRF6Wolj7WT9ue3raBS3duzEz3xIWZyWHA3V/NEe3wGkKvIjZyW1yR
   MTExRA27Ylcru6sDLLvx8PZJ8YL6l3F8g6CIGYq2hNELn2k2g7jb+EH+a
   af58QSz5dRvSajexIJO37kyB97ZBNomsYNrCDdL45QrxzFNptiO18HeCr
   frfyFFevEkiP9hieDTjBV7WZ1fWDR0bxG0nfsW6/Zn8tK2jBtB+ao6RlR
   RnoVoF+/uF4IBioXLr7wKpVuJI5JBeNkeJWqJmV5tyPxXarN2OmK7gWCW
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="216750098"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 00:00:49 +0800
IronPort-SDR: Ffi21Mc9VdLd+TK53YmGmPFkyn5Vtk7hKL+e3fjSOuOt3fisuf29HSDwVWrcgiZcxI4YJBzw7V
 u9XMnNzg/DLS6sWsbjR4wcSD+f/w4D1AFqTVr9W3ScI2FFggI3HggN3djYeqV5NdUITVpV+ho2
 SDmP1e/ZAVEHbsD45DdotJ38/1QQP17oBVK2gjauZ3V+OfByUvdHAB3amPMOovjBsWvRegUxQa
 Z44ApKfFCEHIEDAmODts6yZFqOfVBOcW20MwJgmG+hwlf33Jt7YH08FHCFByt2CWEU5Y56vxK0
 2jU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Nov 2022 07:19:46 -0800
IronPort-SDR: DhLWLJeiMuE33B4zrCtCiVZ7d/76tOblGDC4N0CXxTh+gbg5GsiS+hHDuX31gZSWsV1gfZ7xyh
 sq3J7I5ImzO36QnIEtyIGolkJEexX+Hkk27RvB6TTT9ESN4cYXJ3/Jai83Hz8bMHWTMeJ7NL/6
 uPV1ekiTsrtKZv+5kZeh6ExI8L+hUr+dypWBotaN5eX15SHqir/zLQyY36JnaG7hUenlZB6JAN
 G/e8/2noUThGOlBm45/soem72594Qf50ymzKLtlvjUFz/HZB2IAVfHonA5uFLJDIdTlCQHb8/O
 sG0=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Nov 2022 08:00:49 -0800
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Reordering of ublk IO requests
Date:   Wed, 16 Nov 2022 16:00:15 +0100
Message-ID: <87sfii99e7.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Ming,

I have a question regarding ublk. For context, I am working on adding
zoned storage support to ublk, and you have been very kind to help me on
Github [1].

I have a problem with ordering of requests after they are issued to the
ublk driver. Basically ublk will reverse the ordering of requests that are
batched. The behavior can be observed with the following fio workload:

> fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
> --size=4m --filename=/dev/ublkb0

For a loopback ublk target I get the following from blktrace:

> 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
> 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
> 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
> 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
> 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
> 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
> 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
> 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
> 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
> 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
> 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
> 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]

And enabling debug prints in ublk shows that the reversal happens when
ublk defers work to the io_uring context:

> kernel: ublk_queue_rq: qid 0, tag 180, sect 0
> kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
> kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
> kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
> kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
> kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
> kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
> kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
> kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0

The problem seems to be that the method used to defer work to the
io_uring context, task_work_add(), is using a stack to queue the
callbacks.

As you probably are aware, writes to zoned storage must
happen at the write pointer, so when order is lost there is a problem.
But I would assume that this behavior is also undesirable in other
circumstances.

I am not sure what is the best approach to change this behavor. Maybe
having a separate queue for the requests and then only scheduling work
if a worker is not already processing the queue?

If you like, I can try to implement a fix?

Best regards,
Andreas Hindborg

[1] https://github.com/ming1/ubdsrv/pull/28
