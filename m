Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0E3009F2
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306948; cv=none; b=DDeQmC/C7XzajBhWanV9mkRWfEJn8rBgQ6OGwe81R7f0/1HWGUdgU6vN9XZ9RS6dtaUjHmIvGo8QPnCdZ919tgpyu73ptTzRP0oCxDmSeOU/lifj4ZDfJzz9i+tGjweVVbtDt7/goztY9tMytXigHH1WrKivhjdlbaPUna8eIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306948; c=relaxed/simple;
	bh=d8S055UBj/5wN71BcPPpjejTrrppkWE71ziPbZmIhNo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=B02y/qxpJF8jc7qI0lW6t/Wk63v13o5YnRd6MDId7t2ZCfgmJAo5twa2niKy8Lesb2KRR7m6BoGKZoU8HPjEPj2F12uBs9DWKsiWlJcDttAqYqjEE0qR/C8Rkdt0fSI7Tf1X8fopsx1a1mpyyyTNaw8ZKEg8uYhBk0RuG+OwrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=IOXpxqkv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="IOXpxqkv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53505bc6524so24584741cf.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306945; x=1791911745; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tb6m6q3lI6SI4f4aZTEHuBTNP07WEiV8+eieTwoYduY=;
        b=IOXpxqkvfhkZJDlXEkl09ZDv9f6QrHSc9XpFT6btkZ9QwfqU/yK/CvaScr9U5WwCtf
         3XI8/504BhydaVbO8DiID6lwRTuQgnQMJ1FeytLD7g3ybZAxOp2cNnErNBhzTh7YBJ1r
         Gql7gRDaBYnx3XV/N4BngNBOnrO1HogmIuFzdCsPOOfUZ+R5HK3d8cZuXQ01yxpJhDHo
         QKqQuBwsBsaaR6as+q7uOZhFDp/a9NdS/rn2AozRZUAi6pyLzzziUUYupow11m80HohJ
         fIZpeJztgwo0I97IWTmKxL8u/ipCG2IQmYAUUSmS8iUEd8HEZfk8kZk/uhcuKf2/xY2S
         W7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306945; x=1791911745;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tb6m6q3lI6SI4f4aZTEHuBTNP07WEiV8+eieTwoYduY=;
        b=PUkTcMTuZEGVJ8vRY9hutxNCzgfLT0ufN9tGkhQjzM1NNoYshBGg+MlesPpBvgMHJl
         lyox9+WfkxSwjEAyImzmustpTt+dgdXyhatMFV0HMFr0lfSWeGpDVSpaYOtJlWq1Kn0T
         ny7pAC+HVsyJqaQMM3bWuB7kbWdVfJYeeNiOzF/e+2yiOpVFZQ7msVGKouGHUShHZRwf
         Ae3+bxayN3xDkkUnlJfRZWlxzBf6vRYASo+xHkrON2BY/bolHuasL0wsdBw+apxbb2fJ
         h/H5WzoJ8au8L7YkhEeZCh6e7Lkx4BDi4SfQ3admsSrAW921Kw89tGixgjM8YG+8Q2HX
         ic2g==
X-Forwarded-Encrypted: i=1; AKwUvBy+ruUH/dlo0UbPTTjvnz6jGbMYghe6vgGvXW39738AsKkv4q4WX1NBNI4FHDxGmKOLZalqelN0g8/hxQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nCay9nZvGB/159xkWW56brT/4vgUZMVv5RLCCT9RlFl1xdkqxc
	4IFImRQV17ia1AaZDBQlLdLB+SXhJZSN5jUVrOM64fHApUeWpL6gmHQDl/yVWBy3WhE=
X-Gm-Gg: AYBFou1PslZ6tFOCs0se2zuaIBVs2MCITZ7bNL7VKNTwVloOukDMYHGMZA1HGlalIMK
	rEQS75tonD68WaWpFitEiK/x9zdTuZrv9/SpETX4DHuljMU6jAAZjXLo2wsxhyhGtlyHSOd+rm7
	vTf9e/ExS/Yvq1ZEhbTfT4ddhS9eF1Pv2AJ+OZsxvkTe4gRcPsbTtzWpCLT7fRP+obUgqWs2Xx4
	s3C+wnxhPmtD95cPuIBo28IzMDqGQwf5iQqUgx3c/xU5BeZowWS9MQMTOiCnGirxWwg80NG32tc
	YJsBR2jxc+GAK+E4xqQ7++0B1HdEsUTfA5Mg4fn3WFEeDWN6TrwycIHRqu84WBc2onmOEB5oz5P
	VEuxT+O7mw5KvNxYjx0fXAZr7K+vGu9eTGTEZradRpN6XBB+EFFUb+m5608jxNrXhxcgC+CMeG3
	CiURjESPlv2FDPWrpqCn0qml4JcMRur9t/qltt9xXoa6bbZthMMTP+zZ6c1gG8jmrFLz4Q6BQxM
	+L2nJT40gb7sxnzkDcicGqc5Q==
X-Received: by 2002:ac8:7e93:0:b0:533:37ff:92c1 with SMTP id d75a77b69052e-535668c9ad1mr33799181cf.8.1791306945270;
        Tue, 06 Oct 2026 10:15:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53571f185d7sm675691cf.2.2026.10.06.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:15:43 -0700 (PDT)
Message-ID: <cover.1791303049.git.josef@toxicpanda.com>
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 6 Oct 2026 16:10:49 +0000
Subject: [PATCH 0/4] ublk: fix UBLK_CMD_QUIESCE_DEV leaving commands behind
To: Ming Lei <tom.leiming@gmail.com>,
    Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

UBLK_CMD_QUIESCE_DEV has two problems the fixes for STOP_DEV and the
FETCH rounds don't touch.

Sent to a device that is not LIVE, it still cancels after it returns 0.
A device whose server died is QUIESCED, and a new server may be
fetching its commands for recovery at that point, so the cancel takes
them without marking anything and END_USER_RECOVERY brings the device
up over NULL io->cmd. Patch 1 makes it cancel nothing then.

On a LIVE device it cancels in one pass, which skips every command
whose request is with the server. The server's COMMIT_AND_FETCH arms
the command again right after, nothing ever completes it, and the
server, which waits for all its commands, never exits. The device stays
LIVE. Same for the active fetch command of a UBLK_F_BATCH_IO queue. The
kublk selftest server hangs this way within a few quiesce and recover
cycles under fio, on every kind of queue.

Patch 2 drops ublk_wait_for_idle_io(), which never waited and would
hold ub->mutex against a stalled server if it did. Patch 3 has
COMMIT_AND_FETCH and NEED_GET_DATA give their new command back on a
canceling queue instead of publishing it, deciding inside an RCU read
section, so the I/O path gains no lock or barrier. Patch 4 has
QUIESCE_DEV wait for that with synchronize_rcu() and then keep taking
the armed commands until the server owes none, bounded by its timeout,
and stop once the server's FETCH round is over, so the next server's
commands are left alone.

QUIESCE_DEV now returns -EBUSY or -EINTR when its timeout or a signal
ends that wait with commands still owed, where it returned 0 after one
pass before.

This applies on top of Ming's "[PATCH 0/8] ublk: don't dispatch to
canceled io commands" [1] and my "ublk: refuse to go live after an io
command was canceled" [2].

Tested under QEMU with KASAN and lockdep. Without the series, 20
quiesce and recover cycles under fio hang in every round on getdata,
zero copy and user copy devices and in some on batch ones, and the
quiesce-twice reproducer oopses. With it, 3 rounds of 20 cycles on each
kind of device pass, the reproducer is fine, and the ublk selftests
including generic_18 pass.

[1] https://lore.kernel.org/linux-block/20261001125422.1364260-1-tom.leiming@gmail.com/
[2] https://lore.kernel.org/linux-block/9b876f2c061abc401ec4b9b3c2529eda.josef@toxicpanda.com/

Thanks,
Josef

Josef Bacik (4):
  ublk: don't cancel commands in QUIESCE_DEV on a device that isn't live
  ublk: drop QUIESCE_DEV's wait for an idle command
  ublk: give the command back from COMMIT_AND_FETCH on a canceling queue
  ublk: keep canceling in QUIESCE_DEV until the server's commands are
    taken

 drivers/block/ublk_drv.c | 286 +++++++++++++++++++++++++++++++--------
 1 file changed, 230 insertions(+), 56 deletions(-)

-- 
2.55.0

