Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D288BF7
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecjKHMIj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so3270033a91.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jan 2024 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704863382; x=1705468182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TXu1lgSVjLAAqP9gWPHXNyMgUpUyuzr2NqOI+V8YgE=;
        b=ecjKHMIjYfYkSV95KEgFLIUDHtuC+ZsnDZjQmHDov6l6s/v4xMeRh93uoltMzDbXQL
         F5eAjOyzwaEQ04SlfvAY62X1WBdQb6rEbmO52RnQ4EB/axOTQrG/LQBn0+mvS19220Vt
         RiEHHDCf7fhWz8UNwNcJWsmpRZuImtylwtLdK1qvlHxvHwGtbZrNAOb04TE7BIqUhLuU
         JmKtl32fIC5XJiNkAUawHUcGAuLe9uvf2lVYEPgBQvUyNwovxHJttMBeK3KJ6HUxvmt8
         5ouShmxdvNXlLWEbEVcNZP+I6USx1GWtRiUuZd5o3ZD/7ujdjzqdvie+hIhNtdQ1feEH
         1vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863382; x=1705468182;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TXu1lgSVjLAAqP9gWPHXNyMgUpUyuzr2NqOI+V8YgE=;
        b=Ruc1atGFIGuqd97fohn3rI3qSeF5MMGK/1HaGf5juSltyGhb63xI9MZxksol3mXAaX
         IjOq6Z/8nSZuaA0vSWCMw+tfWx5N8SnPkPt+ZaMXN/PisE1ucWN47CjDaZHekh9pkUjG
         GlBfSiO8G9nWi7Ao2HJPKShqpzYLFWjWSu3qfXo+Z1DulXlq3vUygY9uAvMfmuAo2jnI
         l5jDT1hqfZpSp/xj4TC7TWlg/9yn942GM8gr1viij7eefzvQy1LfympIMnes0BsiEObm
         QTDVfF53Jzv6ef9EsFIKFotKMh3SFzwpeo4uPtAG8i5lzV0XW+wR74QKuMIRUIDZ0fMm
         Iq2A==
X-Gm-Message-State: AOJu0YytWEWa+aaQULED9lBMlVLght03Rxb37MtLBH4BknXXhyMNMEqa
	cJgxFSiblZH602c88Pp3onI=
X-Google-Smtp-Source: AGHT+IGLLAQ7xOVSKsTT9b3lrN6e6c+i372O3S7iEDQbQ2yiWRutECY8jskHgXt35UkGlmv2nWoknA==
X-Received: by 2002:a17:90b:150:b0:28d:280a:2ac5 with SMTP id em16-20020a17090b015000b0028d280a2ac5mr316696pjb.11.1704863381696;
        Tue, 09 Jan 2024 21:09:41 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sf6-20020a17090b51c600b0028cb82a8da0sm439774pjb.31.2024.01.09.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 21:09:41 -0800 (PST)
Date: Wed, 10 Jan 2024 13:09:37 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: qemu-devel@nongnu.org
Cc: linux-block@vger.kernel.org, Hanna Czenczek <hreitz@redhat.com>
Subject: qcow2-rs v0.1 and rublk-qcow2
Message-ID: <ZZ4mkYSPEQQz6JcW@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

qcow2-rs[1] is one pure Rust library for reading/writing qcow2 image, it is
based on rsd's[2] internal qcow2 implementation, but with lots of change, so far:

- supports read/write on data file, backing file and compressed image

- block device like interface, minimized read/write unit is aligned with block
size of image, so that direct io can be supported

- l2 table & refcount block load & store in slice way, and the minimized
slice size is block size, and the maximized size is cluster size

- built over Rust async/await, low level IO handling is abstracted by async
traits, and multiple low level io engines can be supported, so far, verified
on tokio-uring[3], raw linux sync IO syscall and io-uring[4] with smol[5]
runtime

Attributed to excellent async/.await, any IO(include meta IO) is handled in
async way actually, but the programming looks just like writing sync code,
so this library can be well-designed & implemented, and it is easy to add
new features & run further optimization with current code base.

rublk-qcow2[6] wires qcow2-rs, libublk-rs[7], smol(LocalExecutor) and io-uring
together, and provides block device interface for qcow2 image in 500 LoC.

Inside rublk-qcow2 async implementation, io-uring future is mapped to
(waker, result) by using unique cqe.user_data as key via HashMap, this easy way
does work, even though it may slow things a bit, but performance is still not
bad. In simple 'fio/t/io_uring $DEV' test, IOPS of rublk-qcow2 is better than
vdpa-virtio-blk by 20% with same setting(cache.direct=on,aio=io_uring) when
reading from fully allocated image in my test VM.

The initial motivation is for supporting rblk-qcow2, but I can’t find any
Rust qcow2 library with read/write support & simple interfaces and efficient
AIOs support, finally it is evolved into one generic qcow2 library. Many
qcow2 test cases are added. Also one utility is included in this project,
which can dump qcow2 meta, show any meta related statistics of the image,
check image meta integrity & host cluster leak, format qcow2 image,
read & write, ...

Any comments are welcome!



[1] qcow2-rs
https://github.com/ublk-org/qcow2-rs

[2] rsd
https://gitlab.com/hreitz/rsd/-/tree/main/src/node/qcow2?ref_type=heads

[3] tokio-uring
https://docs.rs/tokio-uring

[4] io-uring
https://docs.rs/io-uring

[5] smol
https://docs.rs/smol

[6] rublk-qcow2
https://github.com/ublk-org/rublk

[7] libublk-rs
https://github.com/ublk-org/libublk-rs



Thanks, 
Ming
