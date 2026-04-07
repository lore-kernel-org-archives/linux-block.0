Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5136CDE3
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591291; cv=pass; b=btB4XXGOhw3bdhJebVX6yNy6YmFK8/sP+Dh3Zuq6cdLWdVLYjWlL2IswAceFJ2hsF/4lubwxVI2X+HPYn4RVh+f4QfPZER58iCte6zs9Ag49beIaz63RI+tij+1NNtFfFuhjAxfO9yQFdreD/vaym/lZiTc5gi5AfhZaW3pEqvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591291; c=relaxed/simple;
	bh=N8rE+jtpUZ2bBE/omJowpAcdEU3vkHCwXBNbwd+CZ38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0e/ma+LszmZLulPUd9VFpNCm+1Q2y3E2GkEieJt6+x4Ik6b65KC8LN0fAQHWyFRSrrMoyxgOwey3zN7trUqnH/HVWYXpPPeNv8nRlzWc8MuYK1baAC7R/Q/aed/LNFTeeDdG92SUiOcj0nIaRw2DrfcF993q0+ZuJNIlqMI5Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ekg60qkt; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ekg60qkt"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67c1dfa27e6so238219eaf.2
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 12:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775591289; cv=none;
        d=google.com; s=arc-20240605;
        b=eqK0/ujb3Iz4W93DDIDGKWsY3qdrxJvdDVet1GcfWjDfBNnXmQlV1nOltFcEPstn58
         F53Kj6mdmxoiZtlls8mGapXL8N0vypR808vSMqVdMG3dSertX24L61ekJQr1Y7rwDAs9
         ZXzCV9r/CyQtTYZK7AE/30ipiJZCX3rrTfeuSV5WVQYqHd47kuv0hNI6f6xhDDMqmzrM
         VmkLra1VklS2gsIW1RrJF/SdkgBrvJShUKJOCqOPA4wagizNlWUYwcBf758Xmirp+NLn
         xuK+swC/Q/XYDQMlsqfRhM9MA8m1SMnI0ikya91Kq6kpS9u543olJr5UMk0qzZNeXcLe
         9RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zt69m655sqSB4W1LusZYXPZrVtJEg6e7Yo2q76/zE28=;
        fh=XqmOY2jFC0P99Yig0P3DS786ZXidr/5jbKky0PfF8B4=;
        b=WWi48+uQ9VzOELDe9Ey2qXHrMhGKqyqKr8bJjeOtQ+lqPnTQyzqVfdIWQA9ZrBQJJv
         buD1HcVSXD0Oiw5uzFOh1GqKWxs72r2cgNbtL3Z4ocynRyfsb9ccPt4FO7GKNt5ZlgAB
         2cpWYVVESFKxnqJ96y2pLJUzNee0sFKM2nzGnXw00zjlBoMT3GYF0r4evKnSEh52N8y0
         RUn2rknC7Ltfjrky8tZWsCiuTl9DZ+YLYGIfMjA+4gExDBowIeCtde1tRUolot1Hp5qO
         0+rdbpc7g8ROEm/OAOhGDuQ8GuddQXqoAr/DIeV7wh1phFrLpQZxppGN6ZbL3DQWvwzi
         bHJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775591289; x=1776196089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt69m655sqSB4W1LusZYXPZrVtJEg6e7Yo2q76/zE28=;
        b=Ekg60qktxX54HWLEILz8XogzKe9HEalfX9aJA7K8JV9OAw57sNrbDj4/ajvkmnb1Z9
         GhrahVauBczrriSfWJrfb1Nzxs34sgEwNk49DT9ajGqYKnfyID0shmvUTMHvOoak73fs
         O1xyo0sd6I9UktoRd7mKlvx3qymLQ4An/OaBPh6PGXc1le45KWaNWuK2qV/MbmU39HKa
         pMPHB6VJG+LtpOrKetJk272kCthgmzU/DH5u47FAvS9oj0o3F9RbOmmjq0h2bxahwVZ3
         PyVjIabCOv5+XqYwOCVTuzQijnQEgkOkMT7ZclDod8W5D4cLAHOtywwTKfoxD2l0/x7i
         lTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775591289; x=1776196089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zt69m655sqSB4W1LusZYXPZrVtJEg6e7Yo2q76/zE28=;
        b=YHgwL7Qk5qZSh1Y9EtXY0EzwJlNQSdaYVGquDeprGvNj4ROXu3P6xWCohKcU4H2A82
         wba1jGBrYLgns+kUfKopaoABti4WHHJUGgog0Fbor4jCn/UuvXw5XvDSHDBt4SsazUbv
         c+Gj5NjzxylYaNv3loW1/X6gCwWdvJz8rXB1aWSHAD2GjwW3VBUXqba+2kLfhJ7sPiX5
         PKv7M6vAGO9XzbIuzS4MgIj61O0UA49odHpGeiK2neioiGnSnzwqWwgagN7QI91jkSO8
         jvlR0RvlEHSQsr6B07u0ChTc967H+a5hSWSjzlHbNKDSU8XV3LWYy0QNFOcsKjA/kmC0
         aNbw==
X-Forwarded-Encrypted: i=1; AJvYcCWyvDuONsvn+ZTlKKB6zWXxHDihHFA4mPDSws+KkHW90zTQPhTKSMLj3AivbDYbAGdGyF44leYl9LwZ/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaI4F5qT1D4MN6Yidqmpy66UnQPxPtdaTRBBMft8hbFWYx0Kgu
	NqtVAsWS914mwjRkYotvhIS9spzyCnNe81hWgztpnoyvTP0K12n+LkMuUG9Z45/znU9jujSpps8
	LdBFLzeJtM2Bp+flZzpNzZhn4yh/CnfiOsw5ICNH1Ag==
X-Gm-Gg: AeBDievrNUKOFrBK4RgZoC2+U4hUUUhTvsslSAGdoaxNxzNtmoXdeFVhGISrsgiacTE
	/4iYB6SJVF4KhKwxBQxVCPtIb2Vd5/Vo3jbjoiANCqYpWvkuuIqYm9feC2W/z3fBL7i30UwxMrE
	n/cqYX+s+bzMKu+j3COgAwY1jsx7BqEppN31fKKGZSbih9mnkZOaoAqB4N5ozhGxM3vILm2DvG1
	29WQzODa+j2fMb7bLEnwv0cwqitSOFJK2iOXUz14fyfaXtP4Y5SCJPdWx5UC0/UgdloC+ZbaKGt
	/wJ+Avbp
X-Received: by 2002:a4a:b2cb:0:b0:682:ad5:f1d0 with SMTP id
 006d021491bc7-688fcea6a96mr296899eaf.2.1775591288938; Tue, 07 Apr 2026
 12:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-4-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 12:47:58 -0700
X-Gm-Features: AQROBzCSgtN8wp1_Q-KEU576d9i3HOmH_gOFBktZUyzufiLAkHkNlFTScnDC-l8
Message-ID: <CADUfDZrFe2jWV1SpA6opQXB_Zx7COGXEeJAFNRWdMAaaDHomWQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ublk: enable UBLK_F_SHMEM_ZC feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add UBLK_F_SHMEM_ZC (1ULL << 19) to the UAPI header and UBLK_F_ALL.
> Switch ublk_support_shmem_zc() and ublk_dev_support_shmem_zc() from
> returning false to checking the actual flag, enabling the shared
> memory zero-copy feature for devices that request it.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/ublk.rst  | 117 ++++++++++++++++++++++++++++++++++
>  drivers/block/ublk_drv.c      |   7 +-
>  include/uapi/linux/ublk_cmd.h |   7 ++
>  3 files changed, 128 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 6ad28039663d..a818e09a4b66 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -485,6 +485,123 @@ Limitations
>    in case that too many ublk devices are handled by this single io_ring_=
ctx
>    and each one has very large queue depth
>
> +Shared Memory Zero Copy (UBLK_F_SHMEM_ZC)
> +------------------------------------------
> +
> +The ``UBLK_F_SHMEM_ZC`` feature provides an alternative zero-copy path
> +that works by sharing physical memory pages between the client applicati=
on
> +and the ublk server. Unlike the io_uring fixed buffer approach above,
> +shared memory zero copy does not require io_uring buffer registration
> +per I/O =E2=80=94 instead, it relies on the kernel matching page frame n=
umbers
> +(PFNs) at I/O time. This allows the ublk server to access the shared

Maybe "physical pages" would be clearer than the kernel-internal
concept of "page frame numbers"?

> +buffer directly, which is unlikely for the io_uring fixed buffer
> +approach.
> +
> +Motivation
> +~~~~~~~~~~
> +
> +Shared memory zero copy takes a different approach: if the client
> +application and the ublk server both map the same physical memory, there=
 is
> +nothing to copy. The kernel detects the shared pages automatically and
> +tells the server where the data already lives.
> +
> +``UBLK_F_SHMEM_ZC`` can be thought of as a supplement for optimized clie=
nt
> +applications =E2=80=94 when the client is willing to allocate I/O buffer=
s from
> +shared memory, the entire data path becomes zero-copy without any per-I/=
O
> +overhead.

nit: The shmem buffer lookup still has some overhead. I think just
"becomes zero-copy" would be fine.

> +
> +Use Cases
> +~~~~~~~~~
> +
> +This feature is useful when the client application can be configured to
> +use a specific shared memory region for its I/O buffers:
> +
> +- **Custom storage clients** that allocate I/O buffers from shared memor=
y
> +  (memfd, hugetlbfs) and issue direct I/O to the ublk device
> +- **Database engines** that use pre-allocated buffer pools with O_DIRECT
> +
> +How It Works
> +~~~~~~~~~~~~
> +
> +1. The ublk server and client both ``mmap()`` the same file (memfd or
> +   hugetlbfs) with ``MAP_SHARED``. This gives both processes access to t=
he
> +   same physical pages.
> +
> +2. The ublk server registers its mapping with the kernel::
> +
> +     struct ublk_buf_reg buf =3D { .addr =3D mmap_va, .len =3D size };
> +     ublk_ctrl_cmd(UBLK_U_CMD_REG_BUF, .addr =3D &buf);

This doesn't look like valid C syntax. Maybe it could say something like:
struct ublksrv_ctrl_cmd cmd =3D {.dev_id =3D dev_id, .addr =3D &buf, .len =
=3D
sizeof(buf)};
io_uring_prep_uring_cmd(sqe, UBLK_U_CMD_REG_BUF, ublk_control_fd);
memcpy(sqe->cmd, &cmd, sizeof(cmd));

> +
> +   The kernel pins the pages and builds a PFN lookup tree.
> +
> +3. When the client issues direct I/O (``O_DIRECT``) to ``/dev/ublkb*``,
> +   the kernel checks whether the I/O buffer pages match any registered
> +   pages by comparing PFNs.
> +
> +4. On a match, the kernel sets ``UBLK_IO_F_SHMEM_ZC`` in the I/O
> +   descriptor and encodes the buffer index and offset in ``addr``::
> +
> +     if (iod->op_flags & UBLK_IO_F_SHMEM_ZC) {
> +         /* Data is already in our shared mapping =E2=80=94 zero copy */
> +         index  =3D ublk_shmem_zc_index(iod->addr);
> +         offset =3D ublk_shmem_zc_offset(iod->addr);
> +         buf =3D shmem_table[index].mmap_base + offset;
> +     }
> +
> +5. If pages do not match (e.g., the client used a non-shared buffer),
> +   the I/O falls back to the normal copy path silently.
> +
> +The shared memory can be set up via two methods:
> +
> +- **Socket-based**: the client sends a memfd to the ublk server via
> +  ``SCM_RIGHTS`` on a unix socket. The server mmaps and registers it.
> +- **Hugetlbfs-based**: both processes ``mmap(MAP_SHARED)`` the same
> +  hugetlbfs file. No IPC needed =E2=80=94 same file gives same physical =
pages.
> +
> +Advantages
> +~~~~~~~~~~
> +
> +- **Simple**: no per-I/O buffer registration or unregistration commands.
> +  Once the shared buffer is registered, all matching I/O is zero-copy
> +  automatically.
> +- **Direct buffer access**: the ublk server can read and write the share=
d
> +  buffer directly via its own mmap, without going through io_uring fixed
> +  buffer operations. This is more friendly for server implementations.
> +- **Fast**: PFN matching is a single maple tree lookup per bvec. No
> +  io_uring command round-trips for buffer management.
> +- **Compatible**: non-matching I/O silently falls back to the copy path.
> +  The device works normally for any client, with zero-copy as an
> +  optimization when shared memory is available.
> +
> +Limitations
> +~~~~~~~~~~~
> +
> +- **Requires client cooperation**: the client must allocate its I/O
> +  buffers from the shared memory region. This requires a custom or
> +  configured client =E2=80=94 standard applications using their own buff=
ers
> +  will not benefit.
> +- **Direct I/O only**: buffered I/O (without ``O_DIRECT``) goes through
> +  the page cache, which allocates its own pages. These kernel-allocated
> +  pages will never match the registered shared buffer. Only ``O_DIRECT``
> +  puts the client's buffer pages directly into the block I/O.

One other limitation that might be worth mentioning is that
scatter/gather I/O can't use the SHMEM_ZC optimization, as the
request's data must be contiguous in the registered virtual address
range.

Best,
Caleb

> +
> +Control Commands
> +~~~~~~~~~~~~~~~~
> +
> +- ``UBLK_U_CMD_REG_BUF``
> +
> +  Register a shared memory buffer. ``ctrl_cmd.addr`` points to a
> +  ``struct ublk_buf_reg`` containing the buffer virtual address and size=
.
> +  Returns the assigned buffer index (>=3D 0) on success. The kernel pins
> +  pages and builds the PFN lookup tree. Queue freeze is handled
> +  internally.
> +
> +- ``UBLK_U_CMD_UNREG_BUF``
> +
> +  Unregister a previously registered buffer. ``ctrl_cmd.data[0]`` is the
> +  buffer index. Unpins pages and removes PFN entries from the lookup
> +  tree.
> +
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d53865437600..c2b9992503a4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -85,7 +85,8 @@
>                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRIT=
Y : 0) \
>                 | UBLK_F_SAFE_STOP_DEV \
>                 | UBLK_F_BATCH_IO \
> -               | UBLK_F_NO_AUTO_PART_SCAN)
> +               | UBLK_F_NO_AUTO_PART_SCAN \
> +               | UBLK_F_SHMEM_ZC)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -425,7 +426,7 @@ static inline bool ublk_dev_support_zero_copy(const s=
truct ublk_device *ub)
>
>  static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
>  {
> -       return false;
> +       return ubq->flags & UBLK_F_SHMEM_ZC;
>  }
>
>  static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
> @@ -436,7 +437,7 @@ static inline bool ublk_iod_is_shmem_zc(const struct =
ublk_queue *ubq,
>
>  static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *u=
b)
>  {
> -       return false;
> +       return ub->dev_info.flags & UBLK_F_SHMEM_ZC;
>  }
>
>  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ub=
q)
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 52bb9b843d73..ecd258847d3d 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -408,6 +408,13 @@ struct ublk_shmem_buf_reg {
>  /* Disable automatic partition scanning when device is started */
>  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
>
> +/*
> + * Enable shared memory zero copy. When enabled, the server can register
> + * shared memory buffers via UBLK_U_CMD_REG_BUF. If a block request's
> + * pages match a registered buffer, UBLK_IO_F_SHMEM_ZC is set and addr
> + * encodes the buffer index + offset instead of a userspace buffer addre=
ss.
> + */
> +#define UBLK_F_SHMEM_ZC        (1ULL << 19)
>
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
> --
> 2.53.0
>
