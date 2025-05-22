Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA333CFC
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927916; cv=none; b=mvouxcye6nFpLk+iA7WiArkDSMUqZ5RoX+1SGk2Nc6lje24jF9Fr6Sf40XGuWrEkAzaK2o8pNtZbFwnzNLIUpAD/53ekpmxiiYgwdCRHGpj89T+FeytkhItYfpbQlDNve8OWehe6+2SNYtYkrPC0VrVfzwOAAeofyOP8kxg3lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927916; c=relaxed/simple;
	bh=n2itCzkdu7x63Jjs2usmNwo77pQGcDxFpYkVpIKGGyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYAH50WrEzcH5YXOfYAJF/kRmTRPZICzlkkHGyCSqF0P7DeIs2B5i7QzJh3FtuBuC7aLV8LdHp5z+QbdXc7/hyj1k3wk0gNNQlccR0iZEB/cIa+uM0N6AiDRAsQ1LLkUQN/HtWfzXVvSNAFzTKcSlAsi16qPhIz2aF9GsxJeIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WF993rIr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WF993rIr"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2700de85d0so575142a12.2
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747927914; x=1748532714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4yCtwwSExh3NU1CA2kRM3Cl8TYPmrnKX4YRo85CGLU=;
        b=WF993rIrboRbK02uSLO5m3xELsbOUOy4UmsTKoNrhL8dT+1PTykG2lii7oFiU/VvR5
         HoWFNlUWTRuhFXB1WH43mJxtn7ZEzapmnUtxsQqq2sOEYLvLIrZohTBifMQk75zvJh9t
         9D3r9C5/+3pMAxw0kHr4KCto/nKWluDZdDg/ecrctuJzLcxxBn2q8DTcMRnC/67/6j25
         fOjJ/a5plsnRvhfTZsxuwqV4GogSrjWvUfW9iLv79Qt1Rv2exIJ5zf3WYvfFNjSnp+0m
         ZBkYubsSPrO+TWNZ666XjulBZCdGhG7FiDMhyTPrUG4Xb9Dwo1lXPqMSX56l1ll0Z5rW
         15Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927914; x=1748532714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4yCtwwSExh3NU1CA2kRM3Cl8TYPmrnKX4YRo85CGLU=;
        b=PgR6FcOV/Hz1vGoY7MagFSNfO0u+WwlgmQQOukAU32fI9TZp8WWTVXhx4aAUwVKIGC
         BFOi/fmu/njw+JioHexy64nki4uVAugcxehL9OYPHCDiGMBEmypMTpOjn20vHyzCo6sT
         T/LEVtwSQJ5UZYULLyjjbZStXx2eOuKhl7e1Z/AarRJWS6hs4b4+V0Rq5S+/MScgvFrj
         oCxH9sZ2+QSzA/Zrm1HSczkaM1G4cdHnNIdhd9ds0ajtIbEU8d0EmzhllyEImaGDyZlh
         XTiemtpR0buxgmozZB9dmfi/ejXdXEgVqWoI1OK62tmQ68hKVNongHornSMD6wc+zIVs
         2Mzg==
X-Forwarded-Encrypted: i=1; AJvYcCX+9iox/WixP2+nquTGZf0/Th97xLbwn7RXbfd+sPXtIeNGpQQndZLmPzToFlX9BhjeJO3F0WvJ5z/fNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZX9sOYFyl54leXHRk2wIxbgtuEf5A40qJYfS2koj2C8AKvWK
	zInni9LRhNf7tNK6nxdsOtuYpf+2eftciZ/ypVkc7XB9vZW3H3wk+cnFb313pGE/kb+g6VGroIR
	NQ2wKWusVpHlLluVpUGTr/GIxw7EH1Bo7+UgrN3oqWA==
X-Gm-Gg: ASbGncvjRSw7rT2snLNZyW26iyQzDR12d70U8dQfLP4MWNkXxG1Gu3FxSF2YcqATqmu
	E4OSfknCmj9/pvBibwVVC/kuHbVE6zSRKRmQpim2tvP6aVx1nr7/Ul0LWavgXQafMZGQ/o8LXhp
	WEFuw1KXFmZNrwtnTFsUeROSJyddIIZWuUJxcWmytN8w==
X-Google-Smtp-Source: AGHT+IFUw6MMTfQayGVTElPtPhlDQU+FCNoQp23URlq79ACLzvRhKKXBDZcHKTH+//dXjyoLk8j0nXIRYZW8VoDcxDM=
X-Received: by 2002:a17:903:b4e:b0:224:8bf:6d83 with SMTP id
 d9443c01a7336-231d43d1938mr138342065ad.8.1747927914017; Thu, 22 May 2025
 08:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522143547.395304-1-ming.lei@redhat.com>
In-Reply-To: <20250522143547.395304-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 08:31:41 -0700
X-Gm-Features: AX0GCFsUUoyEzzgLU9YR9GemPZyHcrL0iu7esexoSXvvaZ0POrkpU8sESdRbG84
Message-ID: <CADUfDZo0D4GBEAQSTbaD4Dr-_fUq0oPg8-Tq3njPbFQwfyg7Tw@mail.gmail.com>
Subject: Re: [PATCH] loop: add fs_start_write() and fs_end_write()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 7:37=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> fs_start_write() and fs_end_write() should be added around ->write_iter()=
.

Do you mean file_start_write() and file_end_write()?

Best,
Caleb

>
> Recently we switch to ->write_iter() from vfs_iter_write(), and the
> implied fs_start_write() and fs_end_write() are lost.
>
> Also we never add them for dio code path, so add them back for covering
> both.
>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered=
 I/O")
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 46cba261075f..5107cc9a1872 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -308,11 +308,14 @@ static void lo_complete_rq(struct request *rq)
>  static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  {
>         struct request *rq =3D blk_mq_rq_from_pdu(cmd);
> +       struct loop_device *lo =3D rq->q->queuedata;
>
>         if (!atomic_dec_and_test(&cmd->ref))
>                 return;
>         kfree(cmd->bvec);
>         cmd->bvec =3D NULL;
> +       if (req_op(rq) =3D=3D REQ_OP_WRITE)
> +               file_end_write(lo->lo_backing_file);
>         if (likely(!blk_should_fake_timeout(rq->q)))
>                 blk_mq_complete_request(rq);
>  }
> @@ -387,9 +390,10 @@ static int lo_rw_aio(struct loop_device *lo, struct =
loop_cmd *cmd,
>                 cmd->iocb.ki_flags =3D 0;
>         }
>
> -       if (rw =3D=3D ITER_SOURCE)
> +       if (rw =3D=3D ITER_SOURCE) {
> +               file_start_write(lo->lo_backing_file);
>                 ret =3D file->f_op->write_iter(&cmd->iocb, &iter);
> -       else
> +       } else
>                 ret =3D file->f_op->read_iter(&cmd->iocb, &iter);
>
>         lo_rw_aio_do_completion(cmd);
> --
> 2.47.1
>
>
