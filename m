Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244559;
	b=ybzxkZlyhulI3Qf2Gwsv2i6bM79zA1v76l83orrrr/QFCmJUTbpQzkyGp7H/7RlSje4R
	 ilqdEBMuN4DMexctVUv+sYwADkbhUqQmD0+YrEsHPaGLkM8nT0IOUeinDMW003DxIoKeR
	 5BpWqHBlMOQe7BC77s12DDyrZMeSfz4T0BvUR1asA5AkmKs8SY9kE5yjDJJuc3lFgOWTP
	 M+yXejvL8t2dpQKOVMHj5HUQOOg4IRcmj2f4eQ2h5ciIAoTsfeApC8ta2zLrs0RxdSXW3
	 3Vt07wCrMGbsEi4Khdr2rk0BtpxsfcdCg9RShOzYcgdLHPdDsLK0zU6jKvVUK5bynDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=dGy8vnkQJmrEG5TrpIPtnubCMsqyJHlqpQL97808k94=;
	b=TTIZzWc5gyc2jfOZV9/GgbF5YVrQ8rVtyyTbmO6NzV6UJE5tM0BrYkE44jdV6haWvlYj
	 BZxJC8cCyVkBM45SRNFoK4Qiyy/XDZAoFPCGiGHZiZNgRG991H5DdEWD7YnXcvxCBAP42
	 0fwpnm476OQ5jHKEodKOhxuHZxswpEQ+ShFvUjefBseZgUdy464u/Sn1O3qxMDU2jUO+/
	 JWxvd70PMHvj71qA5S1FoCWjh1a0FpsE6YpHCFV49qfP0QIgKQHLS6Chh82It3bS69pmr
	 jRcwkIddfLONw+oCBRtovhdyjy+t4mRBIKyU3oRA4NS/NAFBRv5UKmQ/gK3jDDPVTvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hnwe1UCZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB170606A32A
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 17:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB170606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hnwe1UCZ
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1bfd1373so9544501fa.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 09:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794244557; cv=none;
        d=google.com; s=arc-20260327;
        b=heEG2V9RRjiEK6Ttb2ldLRy+YW6xi4WMwrQcE2JZbapEgcPxco2jMUGuI+ls1ftveD
         Ulye7CsFNbPDgPSCOwTvZYPz/8iLtHT0zEj0pXuS9SE9Up2vm2cjLl819SqQTeHzkXPK
         J4V76X85z8JDj3pUQ3DufJbhwwihda6tffO8xRqdyRx32LMbtfJQ4jF7b+mFqbIQJVCQ
         DyCPVpCtpcKJuvwG6DLEL3QSLo3Cg8v3kze/h32NHMVkgt1DMb4bUuo72urX2NsdxAAb
         IvbfulvgEfqSANi1YEByAWCUNGqU+wPe0sZL3AR6gsekYdrul/yBJ+ag7qQYbKekN7qP
         SMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dGy8vnkQJmrEG5TrpIPtnubCMsqyJHlqpQL97808k94=;
        fh=jM4Ao/D8rsLzDMjOViPHTXvRrOjVXHqDwIn6aEsPK8c=;
        b=G0VhU0mgyN3SyWYFp2w8Pqk6j8SQy6o8IBkCZTdmiKgWe2j7bLxFe6LaFHPNnbdZeT
         aXwxyY9I5cAv+uB6csHPzhVJsmSOGugxAmcpD9f5XTDC1tgbCrJt2XlUze2chE1DjxI8
         Axhyld9WfkeQrXgHmTb3k7uMoCzz6JtYH5LCUFpoFHoFx7KKdPMdQqkpx7QoIiGcDaLZ
         qiDvUal/QPsZj1zm/G9cXQ2dq+WVjk24G4oHHtYTvGvB+m+uEsITHgarOEr+vPKL+hFa
         0Wl9GsYDdGDW2QZBy2ziOz2cyDMySyAREZCGqLdNiF9u+LbQLv1cRW8+4Zu2WcIlu2vh
         ZKkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244557; x=1794849357; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGy8vnkQJmrEG5TrpIPtnubCMsqyJHlqpQL97808k94=;
        b=Hnwe1UCZxKn8GN6XGR1k1iVfjhcx8FSFO1c6tJwaiAPZMfBIjeFNw5Fv4UlevWiPs5
         TeeHJ1oZ6LKmNjVmiQJYkvwKeS5ob06rwR2Ie6nCcZ8oNpkguZky0nsIOVzXkyMU2OkY
         xBoHsU9JWpwavQjh5Q3kbJOJIurVxu4bew91MQZwGgXzw12bBtuP4+3j0YZGP10E2VTn
         tHFS/wRu8NcFhsKNY35gZ9VEJfzbReh+xys/ZoF4JZgSpn92hHYuhOfp9Pr+OtcB8W10
         74uUXuS/wjpBsevYyhAvlX4AvzCVzdHudzXQdSYyWeSpg8j0i+baAxr5EJEnOpvRlaZK
         igBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244557; x=1794849357;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dGy8vnkQJmrEG5TrpIPtnubCMsqyJHlqpQL97808k94=;
        b=f7+28CKynpcjkg4jwiPNAnrXDD9hoEIukI2CinQisYIZYarNUDZqHsnjC2Qgsl7GmS
         Exwi1F8I/Czh7TV9guYnGfrBTpyU3q88z1AeO/Ah+Qe3OBf00KkeQlUYS9LwXUXEUAjT
         6QrXkmwkmW1GuyR5qa/voNzH9ru+0/OUO782Ef5+KZBIcjEB2gMjMnITY1XyqncX/pHh
         bDmhxd6W6LLCUgM0jt3LGjDQrga60S3X8H07IpM05xkPDelUk49gMnLthI2tcTXuj00I
         FoCR8Istz3np22HwQCpeBX6CgHETQ7cn1dREF69H+zBSU6HrDjKjpN3NWaaJ1CX3KIwT
         Mp8A==
X-Gm-Message-State: APuU4Z9kYBoyybGmpAZjyfLgSF31lCa4w2J4XISTGeeE4FGQkiLrz7OG
	p4qKwuUiK4k9DOKSJashdBgy2tPuMCtCIMw4+3jycTsuhp/lv9E19CjWzSzQY0b+ANnkXea+sSQ
	yHWUU7tS/6G0f73WUth0UZogNPJ/4hik=
X-Gm-Gg: AYBFou1p50aRo0lORwFhzb16EzCRjZXoJzytLgv+v2nyMlcuUrA4EcOGJVweJaOnwv+
	KYEBFpH4ov+9zjuaUCLJC/i8yDOWT7/vgSx33+PqFE3lHYqlwLfYgmGn9zwZNjiaQ8NekMfYWGa
	w6tgPkzK/PtN0Es990F/TubhbDuMzpOtHIm2kSXRj7oG6nNaRugkCL38l4pFInpdPDA3rTV6P5Y
	eLcrCEO31f4jr2QoA9Blmzl30wcATZ9EmGvsxwbEBXwl3czBSFsE1RzhyrP+rq0vYULDYLcnpkY
	Owtw8YpyMuwQrmj5Kcajt016nL8aF+5z+fyNdiqJKlvkn/PBboB5tPm0B0mInUydLWm2f/jHL4C
	dKKjCuT0SuUYyPeglmjdX48ym2le9ZiX1OgItIJw=
X-Received: by 2002:a05:6512:3e0f:b0:5c1:4c0a:49e8 with SMTP id
 2adb3069b0e04-5c156ea634emr7210e87.45.1794244556634; Mon, 09 Nov 2026
 09:15:56 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Tue, 10 Nov 2026 01:15:43 +0800
X-Gm-Features: AclHuK9zCoDKkJMXK0TsiI95GI5FAr3ScxtzEnrCqWYRSEgp9KBzAmmvk1tACbU
Message-ID: <CAO-4RZ2EvgmSRzBtSw+TabEy+3d9kgM9u3-MNS7=pfC6f_555g@mail.gmail.com>
Subject: [BUG] ublk: hung tasks in bdev_open during partition scan (v7.4-rc2)
To: tom.leiming@gmail.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ming and Jens,

I encountered an `INFO: task hung in bdev_open()` while running
syzkaller on Linux v7.4-rc2.

Two tasks, a udev worker and a syzkaller executor, were blocked for
more than 143 seconds in `bdev_open()` (block/bdev.c:990), waiting on
the same gendisk `open_mutex` while opening block device nodes via
`openat()`.

The lock dump also identifies a ublk partition-scan workqueue
associated with the same mutex. This suggests that the prolonged wait
may be related to an unfinished ublk partition scan.

The issue was observed twice during concurrent fuzzing. A subsequent
state-primed verification run also reproduced the hung-task condition
on a freshly booted VM.

All raw logs, crash reports, reproduction programs, and kernel/fuzzing
configurations are available at:

https://github.com/Zheng-zheng-codes/bdev-open-hang-7.4-rc2

All relative paths below refer to files in this repository.

**Kernel information:**

- Kernel version: 7.4.0-rc2-kernsight-kasan #1
- Base: v7.4-rc2 (`7475ea8b5`)
- Architecture: x86_64
- Environment: QEMU Standard PC (i440FX + PIIX), KVM, systemd-based guest
- Configuration: KASAN enabled, `hung_task_panic=0`
- Fuzzing framework: syzkaller
- The full kernel configuration and QEMU/fuzzing settings are included
in the repository.

**Hung-task report (verification run):**

```text
INFO: task (udev-worker):9713 blocked for more than 143 seconds.
      Not tainted 7.4.0-rc2-kernsight-kasan #1
task:(udev-worker) state:D stack:25208 pid:9713 tgid:9713 ppid:4787

Call Trace:
 <TASK>
 __schedule+0x1425/0x6840 kernel/sched/core.c:7389
 schedule+0xec/0x2d0 kernel/sched/core.c:7481
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0xe0c/0x1dd0 kernel/locking/mutex.c:821
 bdev_open+0x3fa/0xe50 block/bdev.c:990
 blkdev_open+0x355/0x500 block/fops.c:686
 do_dentry_open+0x693/0x14f0 fs/open.c:1000
 vfs_open_consume+0xd1/0x460 fs/open.c:1131
 do_open fs/namei.c:4851 [inline]
 path_openat+0x1c1b/0x2240 fs/namei.c:5016
 do_file_open+0x21b/0x470 fs/namei.c:5045
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1443
 __x64_sys_openat+0x144/0x200 fs/open.c:1460
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

INFO: task syz.2.29:12841 blocked for more than 143 seconds.
task:syz.2.29 state:D stack:27784 pid:12841 tgid:12818 ppid:10317

Call Trace:
 <TASK>
 __mutex_lock
 bdev_open        block/bdev.c:990
 blkdev_open      block/fops.c:686
 do_dentry_open
 path_openat
 __x64_sys_openat
 </TASK>
```

**Lock observations:**

In the verification report, the lock dump identifies the ublk
partition-scan worker:

```text
locks held by kworker/2:2/1815:

#1: ((work_completion)(&ub->partition_scan_work))
    at process_one_work

#2: ff1100017b50c350 (&disk->open_mutex)
    at ublk_partition_scan_work+0xdb/0x170
    drivers/block/ublk_drv.c:2478
```

The same mutex address appears in the lock records for the two blocked tasks:

```text
locks held by (udev-worker)/9713:
    ff1100017b50c350 (&disk->open_mutex)
    at bdev_open+0x3fa/0xe50

locks held by syz.2.29/12841:
    ff1100017b50c350 (&disk->open_mutex)
    at bdev_open+0x3fa/0xe50
```

A separate fuzzing occurrence shows a similar relationship:

```text
kworker/3:2/1260:
    ublk_partition_scan_work
    (&disk->open_mutex)

(udev-worker)/9505:
    bdev_open
    (&disk->open_mutex)

syz.4.2301/42546:
    bdev_open
    (&disk->open_mutex)
```

The repeated association between the blocked openers and
`ublk_partition_scan_work()` suggests that the partition scan may be
involved in the prolonged wait.

However, the current logs do not establish why the partition-scan
worker fails to complete. In particular, I have not determined whether
it is waiting for outstanding I/O from the userspace ublk backend or
encountering another condition.

**Reproduction:**

The repository contains a minimized target program together with a
recorded state-reconstruction sequence.

The minimized `repro/repro.prog` is not sufficient by itself to
reliably reproduce the hang. The state-primed reproduction uses the
recorded sequence and the target program in the same VM.

The relevant files are:

- `repro/repro.prog`: minimized target program
- `repro/repro.priming.prog`: recorded state-reconstruction sequence
- `repro/repro.kernsight.prog`: combined state-primed reproduction input
- `repro/repro.README.txt`: detailed reproduction instructions

The state-primed reproduction can be attempted using:

```bash
./syz-execprog \
    -executor=./syz-executor \
    -procs=1 \
    -repeat=1 \
    ./repro.kernsight.prog
```

The guest should be booted using the kernel configuration and QEMU
settings documented in the repository. The same syzkaller environment
should be used for the reproduction.

The verification run recorded a hung-task report, and the repository
contains the corresponding execution log and report.

One caveat is that the udev worker appears to have entered the blocked
state before the final minimized target program was executed.
Therefore, I do not claim that the minimized target program alone
causes the hang. The preceding state-reconstruction sequence may be
responsible for establishing the condition.

**Observed results:**

- Two occurrences during concurrent syzkaller fuzzing
- One recorded successful state-primed verification run
- Both the udev worker and a syzkaller executor were observed waiting
in `bdev_open()`
- The lock dumps associate the same `disk->open_mutex` with the ublk
partition-scan workqueue
- The VM remained running with `hung_task_panic=0`

**Repository contents:**

Reproduction artifacts:

- `repro/repro.prog`
- `repro/repro.kernsight.prog`
- `repro/repro.priming.prog`
- `repro/repro.README.txt`
- `repro/repro.report`
- `repro/repro.log`
- `repro/repro.state.json`
- `repro/repro.context.json`
- `repro/repro.attempts.json`
- `repro/repro.outcomes.jsonl`

Original fuzzing evidence:

- `logs/log0`, `logs/log1`
- `logs/report0`, `logs/report1`
- `logs/machineInfo0`, `logs/machineInfo1`
- `logs/pre_state0`, `logs/pre_state1`
- `logs/crash-excerpt.txt`

Environment:

- `config-7.4.0-rc2-kernsight-kasan`: full kernel configuration
- `syzkaller.cfg`: syzkaller and QEMU configuration

**Related upstream work:**

I noticed the earlier ublk fixes concerning canceled I/O commands and
partition-scan hangs, including the change titled:

"ublk: refuse to go live after an io command was canceled"

This issue was observed on v7.4-rc2, but I have not established
whether it involves the same underlying condition or a different
problem.

Could you please advise whether this corresponds to a known issue, or
whether additional diagnostics from the partition-scan worker or the
ublk I/O queues would be useful?

Thank you for your time.

Best regards,
Zheng Zheng
