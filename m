Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D313AA2D
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782539556; cv=pass; b=SN/izMXqopmddpUwqSyaZM5lMyJ2STxBpU4BBvPcZKVI6XdjURYBBUz4IUWsQwz4kDbta1wutCyei2pUeec7l9aHe/pYAs5+a6qI2u1OeWV2Kd/FEIMGElHTn+tlqnfSsy3hOXQAr1BwE8b+LeLSgvv3fawtry7zQL4UuCCS8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782539556; c=relaxed/simple;
	bh=ItErAVjyYz4WdJMxr0AbGuqjuw01gejFZJ3H6u1Timo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe6o+BNT/GtkARyd62/CUWq5IbC0CDJs4TyqC/FKK/IiCU5UPBlxEPlWEjsFKAzg9NPrRB9QBaSQ97vK4o9a6DaeYDRJIR1gML9NvPS4VcY5auo0KWKF3iIh9t9NdV6b95VnTYf51ZYS4eFrDPOXNuYOcIW1Pxb10oJXIfyWxAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xh4U8c4Z; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xh4U8c4Z"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48aa6d8da48so55414b6e.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 22:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782539554; cv=none;
        d=google.com; s=arc-20260327;
        b=iBnb3exhEobnK56SS4WAKY4mIZaLtzCDHotUtgr7eYRzZRaAngz3s+0lYtECILgaDN
         /zj9yicqAkKikydSK00dkzafbaVhSJd9Ki8itVZlhGqXzOR2WrE6KtmL4pogvFqT2KDD
         eFeIlB/p8rfEaLMZMXUdlOCv0dmfE6zg4pd7e5hVLU8Lus4a5MoEb6dBPdXyKX9Buo2D
         GDKJxU22S9xcc3lstKar4qUx9uNL6xvPk42ZNO3KQxKwJLIwOyoV++QsQQ3OsYpt/zqp
         CDa9DCdtMUrW5QCacjjOYc2xvmD9v0gKggJCUFu5giATEGP3jBlrZgWoycn0Q8rg+Exj
         dQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KxzX3q1QbqMaCsbdi0II0pLSu3CMOd24h3bCjtdC5ks=;
        fh=V3ZSxHKd2If58FCM2z42oAuEDj8pkueX0fn2PK2Sedw=;
        b=UsQf0fLWpNjB23Bqn4LRNZuHWk0ItjQJU6lNhsEMFQmG/lkr9PofDoGaDDQ5Ze6283
         8I1S5E88ZIsvzVM3TLfSF7G0j2+mFJAIARTQ0KnGxdFqUoJnmp8cLTfjExyYw+GuvsNE
         fr0sOgL1JHi5vJLptOPtP2xHS472q8Vqy5vw/W2YswROgR2K5BX5qiQGQLN28yOeDZUN
         xNhHB3gpaPJVCIw3cLtRbTOOuk0cTQlqE8lLri5hP+CMBJW2LLOsRachNruiWukuURmQ
         vQLsC/mKaCQbExH2peLptyRhJg3FOTkJciYWdFWERTyQIqz6XEQaMkYlC6dN5fMcxPeb
         v6Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782539554; x=1783144354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KxzX3q1QbqMaCsbdi0II0pLSu3CMOd24h3bCjtdC5ks=;
        b=Xh4U8c4ZgoBF7od8EqWz/xg37a+EXW6hATccRsBaEHATjIvNPoPp4advVV9VySXJ2x
         gvvoB4fUyRhQxlhlyZJRu7d2w3/XwwEnRIMap7itjGu3iq2dPJXlvavDL4pWKp4LMgwi
         pCF932DKWGpcN6tV9m8E6XiHy3ggvYub+GAIgfSPzJp21GQabyf0fKx14mtQCTYdhPVd
         WrnodWwpNovPC5MChkc3e1jaK4QJmGLZJlg6tppXE0EEfogpcqsuXiA3RtDpGG5ZbAin
         CfXIeQai5S3nKTZQjACDuAnyink0mp7klyBdXSUKA02nHqk/ZnsDdbkky9zTgksAxJ8U
         lvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782539554; x=1783144354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxzX3q1QbqMaCsbdi0II0pLSu3CMOd24h3bCjtdC5ks=;
        b=MNAZhcyQ2jfEnClm7qNUpAzo2+dOLdI2Gm9Uv4IvzPGqHclOUlG44MqdqT/EDzVWlp
         VhJEk0LuLdyRUJfVRJpLIdkKuOoCKU3HExEWHDf75kPauS9d+OqgWmAu9UOV4G9qKd5S
         O/LOnhTWNX9vr/0TRpePFO8wrDEXlvU5e2VRavy8Qhu2ztOZjP8y0fBpeUyOTHlCxEiQ
         Nkhz4lDW0bqXsB4PdIwyObM8WhXpej4znQBjT15SzavKwOlKJQijhP9BynWAEgHwRxql
         qvdE8sx6Yalc74AHPfWW+oH0xVrWihrOiWy4O8cPEosWAMh6A/Hv/CeC6h9dcAcuyLho
         2Vpg==
X-Forwarded-Encrypted: i=1; AFNElJ8pjqpaWkwzbmOPgT1o70Y4wunCTdA0MeEJXtQrz8pGp3wwhR2+sUsGx7NB36q1CQW0YtmArL7jC/+YDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBc6276VqfeMNyvlH7v1l38CLChtmS1/X9xNRElMXdhJ0T+mEQ
	bK6XjDuFD9xM6MuSdCvt6bVnMMbSKB8vjtattOSzEGDWdKWg51V6jt/RycT2H6av66Q1ZV1MwXl
	B1hSmPxxlFCK3/+/QiR2+ZMDGviFkemmLHLi31xXQkg==
X-Gm-Gg: AfdE7cnFk3W31yCjZzGsjQecnzKkF5GrluPWxJoVOu/3d4EvgwwRhaePZastm0oD2V/
	zxGCmxfjaojCn+pDSiEq7hH6ZlUbU3Td6dnZ82Zjb7MhuaFU6xFnPzNBd1PhuLGCQe0ykFOKKz0
	ONVk4/Nk7czOx4SaNROFH2gyHaH+dSMV9xPduzNU8xJdA4txu4HJ33eanvyaYvAqdWCq8wKHg89
	QywVyBFutdOuk7yQht9yJWSwSDVSpGyorcXqHEUM23IH0lb2katglt4o5ZPhrYQK1jhH6GBOw==
X-Received: by 2002:a05:6808:e87:b0:48b:f341:1148 with SMTP id
 5614622812f47-4921890e790mr4419539b6e.3.1782539554073; Fri, 26 Jun 2026
 22:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627032731.2878510-1-dayou5941@163.com>
In-Reply-To: <20260627032731.2878510-1-dayou5941@163.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 26 Jun 2026 22:52:21 -0700
X-Gm-Features: AVVi8CflM0g7ri7SxdvrsEa7l5zum0RbtZJhrDk3EfuiI8kOSIAKvMV3j7XiH28
Message-ID: <CADUfDZo_tn_XCHHtp4hBnJMZ8G=7vLVYaPGKMPL_yyor4sOs4w@mail.gmail.com>
Subject: Re: [PATCH] block: assert blk_iou_cmd fits in the io_uring_cmd PDU
To: dayou5941@163.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	liyouhong <liyouhong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 8:28=E2=80=AFPM <dayou5941@163.com> wrote:
>
> From: liyouhong <liyouhong@kylinos.cn>
>
> blk_iou_cmd is stored in io_uring_cmd->pdu via io_uring_cmd_to_pdu() for
> block device io_uring commands (e.g. discard).  The PDU is only 32 bytes
> inline storage; add a static_assert matching scsi_bsg.c so that future
> struct growth cannot silently overflow it.
>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> ---
>  block/ioctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index ab2c9ed79946..3c8fd365aa9f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -856,12 +856,17 @@ long compat_blkdev_ioctl(struct file *file, unsigne=
d cmd, unsigned long arg)
>  }
>  #endif
>
> +/*
> + * Per-command block io_uring PDU stored in io_uring_cmd.pdu[32].
> + * Holds discard state between submission, completion and task work.
> + */
>  struct blk_iou_cmd {
>         u64 start;
>         u64 len;
>         int res;
>         bool nowait;
>  };
> +static_assert(sizeof(struct blk_iou_cmd) <=3D sizeof_field(struct io_uri=
ng_cmd, pdu));

Doesn't io_uring_cmd_to_pdu() already have this assertion?

static inline void io_uring_cmd_private_sz_check(size_t cmd_sz)
{
        BUILD_BUG_ON(cmd_sz > sizeof_field(struct io_uring_cmd, pdu));
}
#define io_uring_cmd_to_pdu(cmd, pdu_type) ( \
        io_uring_cmd_private_sz_check(sizeof(pdu_type)), \
        ((pdu_type *)&(cmd)->pdu) \
)

Best,
Caleb
