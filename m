Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542A231832
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644556; cv=pass; b=s7YaJgtI0DXpUmOGdoiQJltB9IKuHPyVlD74OeVZ9cC6VbFMX1qi6073eMGK9euWWjxotarc4x4k/LY0H+s9Wp0zM8R1tLlrVfkTobSuAZ/Ue1e8DbfJqywytc0lkhgDC3qMN0Nwv0qyLiclz7HAhbuHD6YRodzPaFMZgAiPKM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644556; c=relaxed/simple;
	bh=6KsV4rDAdDxcusMqf5nBXP8iJDyqcK6OlXAetdFDhjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+PCk3g9DyN6woiZpGG2RSWSLIQPFYbAj0u2Dsuz23wZ4Mtg6rJZU+GTSndVLIfnW2Eyrx/++OHZxj7Mlhqd7mQB+TndQegN/J8bsxkmYXUYpqvaiVLPc8/J2IVhcUMM5q0vlFl4B4uIzJTX5MjeTj8EOyF/fBjkGjcrCP2apQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WLLPde6Q; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WLLPde6Q"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-801cb343a92so552082a34.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 18:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790644552; cv=none;
        d=google.com; s=arc-20260327;
        b=hdKIa+VEb0XMqbemuT7CQmyb4Jc5d6yw3RbPdDdAwZ576JnKub3gc1CeVhdmZGKdN8
         Afu6YO/tld5WcDtiBOpEfw3krZyQkJ4wNrQDcOzgq7L4vJkQ8+wCYrXAhMdvDESbH9Tj
         sELin5hCq8nW63gSOeoNNFvKMjMpyDaToHOTzXcgzHBLMtMDiPZeqKdbrnu1+2YaSnoa
         MtY4CASiwoJxZzvyca8QB+WhG758hiJXBEh1ZNXcYIx49gQREpCh3Yb5QSP5WblI+Buw
         /NVB+332spfNL7B1nEYJbFQdAgjcMAR2DfZcEwMYCQTio1KzssmAVSk0bfXg6JWRE2wM
         nbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        fh=E0zYFgWQnRTwmrgtZPUTH0KaIfXJ0qV/axiaj0Ae3hE=;
        b=nmflLLoSzFzwUUJUWOBesum9KWaLUu1x81nGZinCkNT9W38f8l8HEMwqUySa6JKbZH
         XONzpVmvEwyxPa8MVwI0LyJuhlzDBfTby4uBKXrd+MraHlPRUJ3RjeG+986AZGN76dkL
         64OWPTbexcx/bN9+BUy5xYsf67VwxZpWzIbqVaucWtTeUbQhlK5X+lznCWCgqtjpSZtP
         Nvg+Q1YIS73cVEKKta4muiQJcxxH6FRVtqMLOTS6ejQSJ1+SE/Jwwm0h4wIo4jSHrZcL
         vz3LVxuHbOPMd3KP0/zXNVk9qTzL4jAVR0COMK7gYYGUwnWdzZDHcB7r3rfMVBvOng4d
         nzPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790644552; x=1791249352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        b=WLLPde6QqrGEQ7TlZnh6GBtwyEECzYPwNnwovqyCfe1nP6Rtl6cWfxOeP3v27T7+P3
         JO0RswXenQ3JCaWZLyrCZkHn/AqJHIeWnIVkVqqK7Bh4ONqjh6AJ3ZMIxqKxOF8tTBYs
         DGVx/ZdRRA3ng/3HZmmZD/Ugj2AGjzLyF8HdvvxasSWEujXdLZ4nUmvCXCRYa3RE0yRC
         URNtGEhe5UkwBmRgEecwiBRJ1kmnjqbw95t4pkc/S9muhj+DYZzBdnsaKKtNyIfLwjLH
         1D/kEnjt7dUyOT5ifyQp6U/0PPYcmijYeqVcAiqlt9Id3+2ViYXJFnlMm7rxBisMolUG
         LaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644552; x=1791249352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pLeu4YqgZECtiedNQxbKwtzen0HMS5vwbUNTX6n4u0=;
        b=iO/oCSHbw1G6WNBxq5QHnWHmU1gnanp3XK/JeKruzNdzUe/vBrWEKObOdk7xMPKmPb
         0u9VMDsTpHjYC3dq7ETMx7zRjRrhDDS9ssl5ye9tI6WPLtZAom1hqVe4gr9LZ0nPTXUu
         0wPxtKFByn+x9QkQYPpqQkE9oPdlpWS+QEt2VD6BAH5fhKI28a+mOTxmvTcxaOwPlkmt
         sqwOAJIuOEPNlLWpK0dHzeha9FxTsJD9OfabeFO8uajsbTtrum1it8g2pLx3qhqenrvX
         q642LpANC1pMfta89+NrTwhkNm1UCFq2Oj77xqF9F2fxjL4x7+T3dvngpsXESSCUAuMj
         0NwA==
X-Forwarded-Encrypted: i=1; AKwUvBz61Yoxve5yVYELBG+lu4VsepgnJNs6x0Kuh5rZ+o0Sid+KTcKaX6Tz4JvrPhBg1Voy2cd3V2isBxwX0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfKe2UXSyrds3AS4SZquzt5VE1Dpq7IlBTUcxnP4k6pFU6/buy
	Gyqpo86y1rss3FMEURoh1EIyysHKv9JPnU0zIIm0sdXh6RJWgjPkVi94Qyd5SOMisawwWvRnVjA
	oKQGHYLaCOx83DdzKv/Q/Tk2BwwKtj3qEV/D3SiKToQ==
X-Gm-Gg: AYBFou2g816gmc6GSfhhBniIrWncirWegYQ225pRXf/dddmshXPniSSMYKnMGT0HZ+n
	ABoZX3lH2tuhevic34V3XkNVCkl6k0sHLNq5fBrr3cQuLIDe7LIvtbwD9YVKXqVxxRrc37BIRPQ
	AhStnqiHqkg75zFzIksaTDjVzTxHFeW+tkfbrcS8yeTJw8gvKPTNJULkImSf4Qt0asWudct1D/O
	OEqMniJ3nKeEBnz7I6jxUtuTEj7RbSmJbBpFwvH/3Gsht5tHh9qVm/HViND1z5y34QuvM9bVFTc
	MfmV6ZG8jvO7Xt+BsilxSSWhxsvc89+zFiil54Xe51sMREhhItBmZak=
X-Received: by 2002:a05:6870:f114:b0:47d:4630:5998 with SMTP id
 586e51a60fabf-4930a82b841mr16313646fac.4.1790644552340; Mon, 28 Sep 2026
 18:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909222836.2475352-1-csander@purestorage.com>
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Sep 2026 18:15:41 -0700
X-Gm-Features: AclHuK9y1BkUmfj2CwBKzqVvJvr4htN1Ij_BtBFRlnLw9fnPEz3avSjdBXHF6AQ
Message-ID: <CADUfDZorm3WsYxvKQkqr1DVAps=ejF7M4U5PLD4O-94GzmYt1g@mail.gmail.com>
Subject: Re: [PATCH 0/6] io_uring/nvme: support fixed buffer for metadata
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, any feedback on this series?

On a 4 KB io_uring NVMe passthru read workload with metadata, we
measure 14% of the CPU time spent under iov_iter_extract_pages()
(called from bio_integrity_map_user()) and bio_integrity_unmap_user().
Using io_uring registered buffers for the metadata avoids this
significant overhead.

Thanks,
Caleb

On Wed, Sep 9, 2026 at 3:29=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> io_uring NVMe passthrough supports using a "fixed" (registered) buffer
> for data, but not metadata. On high-IOPS workloads, the pinning and
> unpinning overhead for the metadata pages is significant and could be
> avoided if fixed metadata buffers were supported.
>
> This patch series adds the necessary plumbing to allow NVMe passthrough
> commands to use fixed buffers for their metadata. The metadata and data
> fixed buffer indices can be specified (or omitted) independently.
> Supporting separate fixed buffers is important as metadata buffers are
> often stored in separate memory from the corresponding data buffers. For
> ublk zero-copy I/Os, sharing a buffer index would be impossible as the
> data buffer is a kernel registered buffer while the metadata buffer is a
> userspace registered buffer.
>
> My main question is which layer the metadata fixed buffer should belong
> to: core io_uring, io_uring_cmd, or NVMe passthrough? In this initial
> implementation, the io_uring_cmd layer stores the metadata buffer node
> and the NVMe passthrough layer defines the UAPI.
>
> The main argument for moving the implementation to a more generic layer
> would be to reuse it for other io_uring request types. For example,
> IORING_RW_ATTR_FLAG_PI could also benefit from a fixed metadata buffer
> option, though this series doesn't implement it yet.
>
> On the other hand, core io_uring_sqe and io_kiocb space is very limited,
> so it may be undesirable to dedicate it for a somewhat niche use case.
> The metadata buffer node storage could be pushed to the NVMe passthrough
> layer after my in-flight series [1] to reclaim nvme_uring_cmd_pdu space.
> However, managing request-scoped resources from a ->uring_cmd()
> implementation is a pain, as the same request can call ->uring_cmd()
> multiple times and may or may not complete when ->uring_cmd() returns,
> depending on the ->uring_cmd() return value. io_req_uring_cleanup(), in
> contrast, provides a single cleanup path for all uring_cmds.
>
> [1]: https://lore.kernel.org/io-uring/20260909155848.2069290-1-csander@pu=
restorage.com/T/
>
> Caleb Sander Mateos (6):
>   bio-integrity: remove dead bio_integrity_copy_user() error path
>   nvme/ioctl: remove struct nvme_uring_data
>   blk-integrity: pass iov_iter to blk_rq_integrity_map_user()
>   nvme/ioctl: pass iov_iter to nvme_map_user_request()
>   io_uring/cmd: support fixed buffer for metadata
>   nvme/ioctl: support fixed buffer for metadata
>
>  block/bio-integrity.c           | 51 ++++++++++--------
>  block/blk-integrity.c           |  7 +--
>  drivers/nvme/host/ioctl.c       | 91 +++++++++++++++++++--------------
>  include/linux/bio-integrity.h   |  1 +
>  include/linux/blk-integrity.h   |  6 +--
>  include/linux/io_uring/cmd.h    | 12 ++++-
>  include/uapi/linux/nvme_ioctl.h |  5 +-
>  io_uring/rsrc.c                 | 28 ++++------
>  io_uring/rsrc.h                 | 17 ++++++
>  io_uring/uring_cmd.c            | 30 ++++++++++-
>  10 files changed, 160 insertions(+), 88 deletions(-)
>
> --
> 2.55.0
>
