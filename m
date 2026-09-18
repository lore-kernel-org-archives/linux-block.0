Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7D515987
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749310; cv=pass; b=YDaiaW+gYaqmy8devghwnvOLr5Nk+RsWL+Yvp093ZcnGpxP9IY919AFRb2cBljJTN2nKLHi+i//tyaX9ufnUwhP5pdfKwiesMjpj38+MepA8AUWVcQ0mKb3N0mL0EAI/3vQfhVpRWkp4NKtDRzdSK9Ena4Bck9vZRfBQ+YaFfFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749310; c=relaxed/simple;
	bh=wR1qnAOPr2JlxiqwO2LvCp7/qCpIaepQf2TkTNr/c4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJH4v1j2s1e1YpVtfF8UsH7nB2yoiCi9V7vzlPtIwSVI52nHUOH1BtWP6fW6Wla3hJPxhLOlMChEjiBYwqTDF5pbEoVi+MeIqXERfynVTDr7J3vjy80/pC8ryZ6Oiewmu4ix/AMt9DU1+gBHL48IYBHEf4ruAtJO1P0f1vBVRR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NoI6xruU; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NoI6xruU"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46435ac2de3so39050fac.3
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 09:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789749306; cv=none;
        d=google.com; s=arc-20260327;
        b=UtQkDLmDH3foogepPsg/UKQVVwemDEZS4RdLE/hc5kIPC+NlvZ4NRom/6uduEZcYRr
         6ZTJFGgoQx/Df5JjIcS4BEytLKbDw+CDf3jm3EP0LSekFMq+AbVdPMCnb7Sjjw90fz9e
         oRI1xsx0tu7uZPPyYCVfxCJ4Ri4/rsw6P6/LrghLreSWax/6YJUAdzYMJYjsq3LPpSpV
         CZlUCnKswnQPReDLKx3zJkAGgkam/v1Xhahw2sooV17iig8EYHHUZstDoERR/aeyeZKv
         i+c5uqlFaBTEM343IToeSFtS/10eYW6JzjNACs82Qp99uuNc4enewzEV0AjQ7mjjsPlm
         tp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k3KPdfLP+6kHTG7FvG3EoHrOg/e4JFozgZAg52Q8hY=;
        fh=EDk1PJoSMEfSsG7e2aGtcDYLO8rk2YbQmC8ffQ/TwjU=;
        b=IzZSf4BJBSzh5Pf7/MsA2saTeNJA03vzWFy3349WKasmeoIeoR5sab+mfaCX6gyIE3
         P6UvKYTNAFmGTshXpZ66hbqzOXpDUihxwRwKR8UQ4S6EPV6tn1Yi026Ot8t25MTa6HT8
         onHpsWt7oVtogxanMhdV2u8j/+N1JOcfmplpZzJeFTJIaRAgAv0rh2oCeiS3GLP2EMyH
         +TDgnac7FQ+lnwaanRLwq6zL5C/rR/2+fktObmxKgOI1BhbCzkVGuC8J4OoChvqnt5W3
         ED9mApWJ2RjAOYdHeJq0Iy+ojMmSJkgNQbqTtzqoU8tI0CWsphN1YUVNf/1+9oJi+wWF
         /ePA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789749306; x=1790354106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7k3KPdfLP+6kHTG7FvG3EoHrOg/e4JFozgZAg52Q8hY=;
        b=NoI6xruUa3QnHyPp1HtUE3/ztU7lc0gnA93hQe2LlCNgxjPTmzbS1HQeht+btbIeOr
         dHnpEx+62w9zf1cpLlQ4/1JLaPW3qunMuJv+ZqMLp2PKLGomaRGO+ueDCc8dd/YWQEsc
         9Or3euMwfRLN6Fywonj/wrDJ4+aS1j4MAL6rCeKa7uMUFohbr+lYJ9qzwDGc+VG4vnXo
         CD4udzqslDOxHCdK3dzu3VFZMgn7S10Vc3XH+inu1VyubwDfE9IwpFOInv8MYOm6VKzX
         vlCVWxUvJ9z05LF9gQ1rpXT5bf0AAUpteoGbfS50+zIC9CjsBlRtuXR/Df2LGdSI8Rbd
         g3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789749306; x=1790354106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7k3KPdfLP+6kHTG7FvG3EoHrOg/e4JFozgZAg52Q8hY=;
        b=XTY1RqcqDCQH6ucWjm650ZPk8Au8KN8z+iMgO6I9zuPRMP6geEHNWkwj7U3ysR7Skw
         SHOelTKy620BmKKQbzTnqDcAfysMR6C/4DCof73ISO+cnX++JkJlLxPeBhPNaM1Aa469
         gqhmpRaJ7w8MwwtD6LD0stJaSMQXmbWVTJ74ebbtTD9yeTluTO7jDdfuQNKuxy+7kEQb
         z7Q/WV7Iw/qKJoyHxxi0bzufqgF70hCWxk4vc0sBfdGapmXiH4jPFV5I/8k9O+nftWjJ
         yr14ZHLy0zCkzkg34F9mPj87pg4NsJxtjwww8ac9lnZo4oHreYzsKA5+KK4CLS4RRrk6
         lVfg==
X-Forwarded-Encrypted: i=1; AKwUvBzYH7qKAGy5hARpylVCud9piwfBxNsncOn3OS4UlJCVsyr0sWaDrV0yVWWL1vbl1UGa7perk3aoWrlBpg==@vger.kernel.org
X-Gm-Message-State: AFuF++nZ1d2Mlr+SzoGHEzwvPfZQl7djijGSwal6QI2ZIb2sDDh1v4AK
	QqcPWK3TVE3vPX5mH2vNuEt5EDpAWZ3McpdMjbKH2Em1wzYlD8KyTxkxv4cTz1JiEyTZOuZcHVr
	vVWWCdPARmiw0eazbcM7DQUVxrXdJ73jPlcfUv5j9pw==
X-Gm-Gg: AYBFou1En0xagAMDdyqysvBfUa39e/DsIby0PUfelhsppLZ10XIS+gcvttDV0JIurMn
	a2virFrDOXNfAyfCammojeMPwSzf4sU+/eDXkxHbAC3RWdVG5+KYcMQchLjukmwtlWRlmkrYGu5
	1vaVdtY0/pLPURkltNWolLol9ehv5190R3C0em/k0AXqtd9xpCDnBaWLEnbu105aMIUIf7tkUpz
	BGhC0c5blANw0PJu64LQhKgAAqcmu6ZEYPooxzQlSHaTJ1XoHBJjnJ7ClGZGSbgjpQx2A8mPv6e
	opYL7GwuI96nfTpVfeIucCaM2jk9B7IXuFORUoepZ3zy4EX+ANFMOOU8
X-Received: by 2002:a05:6870:1764:b0:467:dcf4:90ec with SMTP id
 586e51a60fabf-486e2a9a3b3mr3380435fac.0.1789749306413; Fri, 18 Sep 2026
 09:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
In-Reply-To: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 18 Sep 2026 09:34:54 -0700
X-Gm-Features: AcwNN1Xhi6Kedo_6EsGig6cljqOfV2aiGbokGBGiv2ywdnLo17BYIk248JetsE0
Message-ID: <CADUfDZrjhhvKHh=7KoEvczqrRjcwnJC4p8jh5N4kpOS=Q2RTFQ@mail.gmail.com>
Subject: Re: ublk: consequences of a dead server are only failing on the last
 /dev/ublkcN release
To: Christian Brauner <brauner@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:47=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Hi,
>
> Chris scanned a new series of mine for me and he reported some
> interesting behavior that I dug into.
>
> A ublk request that was handed to the server is only failed once the
> last reference to /dev/ublkcN is dropped. So holding the file open keeps
> the request alive.
>
> This causes any waiter to be stuck in D state and blocks STOP_DEV.
>
> I'm attaching two reproducers:
>
> (1) ublk_inherited_fd_test.c   the general case, no vfork involved
> (2) vfork_ublk_test.c          the holder of the reference is the waiter =
itself
>
> Re (1):
>
> A single-threaded ublk server fork()s a helper. The helper inherits the
> fdtable including /dev/ublkcN. Now another process opens /dev/ublkbN and
> writes 4 kb then fsync()s. The servers gets a WRITE and _exit()s without
> completing it - say it crashes:
>
>   - The writer sleeps in folio_wait_writeback() in D state.
>   - STOP_DEV issued from another process never returns.
>
>     The control command runs on an io-wq worker of that process, which
>     calls ublk_stop_dev() -> del_gendisk() -> bdev_mark_dead() ->
>     filemap_write_and_wait_range() and ends up waiting on the page that
>     won't be written back.
>
>     Said process can't exit and io_wq_put_and_exit() waits for the
>     worker.
>
> This can only be undone if the helper is SIGKILLed:
>
>   # ublk0 up, server 119
>   # helper 123 forked by the server, holds the inherited fds
>   # WRITER fsync
>   # server 119 died with the WRITE in hand
>   # 2s after the server died:
>   # writer pid 124, state D:
>   #   folio_wait_bit_common
>   #   folio_wait_writeback
>   #   __filemap_fdatawait_range
>   #   file_write_and_wait_range
>   #   blkdev_fsync
>   #   do_fsync
>   # STOP_DEV from pid 125 has not returned after 5s:
>   # STOP_DEV issuer thread 126:
>   #   folio_wait_bit_common
>   #   folio_wait_writeback
>   #   __filemap_fdatawait_range
>   #   filemap_write_and_wait_range
>   #   bdev_mark_dead
>   #   blk_report_disk_dead
>   #   __del_gendisk
>   #   del_gendisk
>   #   ublk_stop_dev_unlocked.part.0
>   #   ublk_ctrl_uring_cmd
>   #   io_uring_cmd
>   #   io_wq_submit_work
>   #   io_worker_handle_work
>   #   io_wq_worker
>   # killing helper 123
>   # WRITER fsync returned -1 errno 5
>   # STOP_DEV returned after the helper died
>
> What happens to a device after a server crash depends on whoever else
> holds /dev/ublkcN open: A forked helper, a process that got the fd via
> SCM_RIGHTS, or a vfork child.
>
> I'm not sure whether that's intended semantics but it surely has
> confusion potential and should probably be at least documented.
>
> I suppose failing outstanding requests on server crash is intentionally
> not done for recover reasons or whatever. But maybe STOP_DEV should be
> made to work.
>
> Re (2):
>
> vfork() makes it really ugly. Say a single-threaded ublk server vfork()s
> a child. The child opens /dev/ublkbN, writes some stuff and closes the
> fd. Since close(2) runs bdev_release() -> sync_blockdev() it waits for
> the write.
>
> The write gets dispatched to the server's task work. But the server
> sleeps in wait_for_vfork_done() until the child execs or exits.
>
> But the child cannot exec or exit because close(2) doesn't return.
>
> ublk makes this more hairy though. Even a SIGKILL sent to the server aka
> the parent won't help. The vfork()ed child hangs on the close(2).
>
> So that stays in D state forever with an undeletable device:
>
>     server, after SIGKILL: gone
>     child:
>       State:  D (disk sleep)
>       folio_wait_bit_common
>       folio_wait_writeback
>       __filemap_fdatawait_range
>       filemap_write_and_wait_range
>       bdev_release
>       blkdev_release
>       __fput
>       fput_close_sync
>       __x64_sys_close
>
> Unrelated, but also a potential issue:
>
> The commit 7fc4da6a304b ("ublk: scan partition in async way") made
> partition scans run from a workqueue that holds disk->open_mutex while
> the server serves its reads and START_DEV returns before it's finished.
>
> Any server that treats START_DEV's return as a signal that the disk is
> ready and doesn't serve requests hangs every open() of /dev/ublkbN on
> uninterruptible on open_mutex. You can combine that with (1) and (2).

Indeed, we've also encountered this issue in our ublk server that was
opening /dev/ublkb* to call ioctl(BLKROSET). (UBLK_ATTR_READ_ONLY only
works to configure the read-only status *before* a ublk device is
started, so the ioctl is needed to configure it when recovering a ublk
device.)

The open("/dev/ublkbN") blocks on performing the partition scan (or on
open_mutex while ublk_partition_scan_work() performs the partition
scan), which blocks on performing a read to the block device, which
depends on the ublk server to pick up and complete the read. If the
ublk server process is killed before it can complete the read, the
process exit will deadlock: the thread calling open("/dev/ublkbN") is
blocked on the read, so the process is unable to complete to exit and
release the /dev/ublkc* files, and so ublk_abort_queue() will never be
called to fail the outstanding read.

We worked around the issue by forking blockdev --set{ro,rw}
/dev/ublkb* subprocesses to perform the open("/dev/ublkbN") +
ioctl(BLKROSET). That way, /dev/ublkb* and /dev/ublkc* are never
opened by the same process. But it definitely seems like a footgun.
User processes ideally shouldn't be able to trigger a kernel deadlock,
though this only applies to ublk servers with CAP_SYS_ADMIN since the
partition scan is disabled for unprivileged ublk devices.

Best,
Caleb
