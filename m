Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13824466B
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046727; cv=pass; b=SPw6kmUOCJgZa+Yguk7mgt5F3aHLjeqYNu4t4fBltxLnexy9LLqKzx+bhyhNBkXfLGgrJNY6tIiUyTyHtgsu2s5aJ0XlN+VnJxuBJNhq3LyNlwiBbVyiawoMNtE6jTvrpTEZGLOH21MEdCGE50wA0iYHwGILBJbKJNzY9m71Jqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046727; c=relaxed/simple;
	bh=jFW8HYeuUBd5XmZ/iDLYgP8vJSFGp8t5A1hYsZOcHGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeKDWcPj7aSpd31Sn4kCPVW+CkmxbDbsXMSVdqdASsZ7YWsi7hvBXHnidVObFrhszX44Sl9KRiV8VcQaPLNWPsHxaZ1afUrtPl8JxdQ3ixEvsTsW6ZCrh5CSqd28sqNgeO84d/Bxcxm9A8IHx+rrZm8LbIkR+84Ql71AgH5Yv74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CoLsZiOe; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CoLsZiOe"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64ce9d80429so384250a12.1
        for <linux-block@vger.kernel.org>; Mon, 02 Feb 2026 07:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770046724; cv=none;
        d=google.com; s=arc-20240605;
        b=eCZfYHxrg9+dCgtSBGILIX1VOOepl/dLS26h+UEoe0Hx05qQtCSJlfbJQoT9i+oKyE
         3i9TNSx1bGno7TdeT2Aqh/5I6aza5oXg6JfrVvrk2FJjSWBg8H6YwJTAd7tpjE5H90nH
         Narxz6lEdKtZxDS3FjZWezbR0pndDMbM2rJW3TK93rSpoIl+l1+lBN39qGYQqU5QPrmm
         V+ZFtTlu64e4T5Hn5Uw03HYqGxcpUe03Ck+9RJDHr7uGHM+/i+eFSaLjAa0Jk+frEP+x
         wOqN1WIwufEmTww881r6mlaMfVd/hAIe/nX2nqAy5RNMmG6653REbfqDU0/6bxlo8niD
         Gvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRoGLtAlLet8Iuw0lv/0jhbiFAd6WnO7ZqlPVGdaWmU=;
        fh=HMjlCuvCuwVPx6SKzugdsOXH6UHGPxbhsp2Fmj+UWE0=;
        b=buoZ2al0I6aT49jUXboOsGDSe0cw3kj5cW6KuA2r4CybGNg48wFf/Ip7ca+vmo13R0
         CsvkF1vEjQQfJp4exV1SbtKFOxFUddmpKPouglsdB3wzlo7l1pbWq/O7H2+J7UgNBJna
         Wfq+Du5KG45mMb5aHYNFpaOyFAeAfIHLUAozLMTU+kTuwX2b5IAN7pcZAhuhINyfbV70
         apKbME+eq6T9B7hkKzjIg2BuY7e1Xv1l23FewuS/H4e2906P8z9eiFgONZY3wETOvms5
         QIhU23oP43n1MVQk3UBuLT7ngFxHywWEy2byzaJNL2deFE2LNtQbR6icii/xerWCZ90A
         XLXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770046724; x=1770651524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRoGLtAlLet8Iuw0lv/0jhbiFAd6WnO7ZqlPVGdaWmU=;
        b=CoLsZiOeiwtKaR/aIK2WxLusk8daNoMfyBaqmaYKaG3wP60XD/rHS00eRwgqVm7N21
         KkVEOwOSi2o8hEAMj6q6U6q9GQbH7VXqXn/phXO8E/5TAZmjYLd+puDaJcc1Z12oGHOO
         fwsdvyGDnnVWBD9A3JDOVqzWZOAJMJi/fsY/8MD9Ro+/uPbHDlP8ofQ5A3ztwoxdaSD9
         MS05BibgcNOIJgmy6jKkgh8pMidnXMT0ukqtw9+C3q7p74ZF6UDCNJI5Af3hsiFHndL4
         MSktVI35o/jbRC0zQ2oUmasXgLn+kxBdk89YKXuTduyY6wewryPpnE1vU9+JxuyyF5Fk
         pLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046724; x=1770651524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRoGLtAlLet8Iuw0lv/0jhbiFAd6WnO7ZqlPVGdaWmU=;
        b=EGr1yR8PsmuJSVq+1dZkoFbl7n73s8KWFtzNCwQYZ+5jBDPWKqdmnCz0MdXP6cISa8
         0WvGBL5CYfLuxPmEXEm5w/JNfHxM8diLwm6EruM5940pJDaGMIRKyVs8K1lVv9xU7nCY
         ux9qg8SNxxBgVAm5jLnMRccf+AkmzJmaxHnCQxmkhLFOwAidhtBQ7W4+saUYPBoxUdhx
         1EDxbmQaAyIsPRSPY93sx7VpF99cjmGN71dXnZrWncgv+9hJKgyWduvkHFbJhElcL4G+
         mW22JHXTKgI+v9ceIl2urDITHssFNWmC0HwPZy6QjZnJO8EX9cYwhaIE3L1eiggTMO/W
         ZlfA==
X-Forwarded-Encrypted: i=1; AJvYcCXRoYegu0VkYX+Q1zDGrJc62kyD7nxiyTI+boX5B3Ki7WW6W+cGYSJDyWgWWKfyQislD17t/uwWrHJ1dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3s4wnY7dPfWMRR+53V1K0ZGFshGDIbXSo5xANq5VFPyUDlV42
	dOFP1aZQLK92rcFTJ8a6DdOoDGtSUgQBig57FYo/DpJdN3WsXcq/JoGkdk4S5OEXsMXHzahv1f/
	VQv1YIc8EH3zHHvL6K4zxy1fLaQXvfbrcbs8pmUPK0oovIHTBx9QYOfo=
X-Gm-Gg: AZuq6aLGK5yUDLWXl+uqovcnE5/+LBZWWk6cD40nkb3BGMSUaaVSwYSk4PyUV7kW/TQ
	JHbqKyq7q3mGfoHb+SLtYKeSXR+OJLKDus6hGfcd7p9KqVIH5VkxOBB88YX6xaMwpk/Xslzcc2j
	DH7nqQIDvPx8QPULj+IEiZN/Ph9pkQ4oBJbwCWBKLRa7B93ZvBkgAT3iU3TEzIR5XAuh/9fJgSM
	2mcVDrk/rERJJqgkRWgjbchUUR8oInL3Z4urYLSYz4C/59/yP77ZtD2l9NqUKApF1GVuPE=
X-Received: by 2002:a05:6402:3506:b0:64d:23ac:6cae with SMTP id
 4fb4d7f45d1cf-658de5b8639mr4068326a12.6.1770046723566; Mon, 02 Feb 2026
 07:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130171414.1376543-1-csander@purestorage.com>
 <20260130171414.1376543-3-csander@purestorage.com> <aX1kAVu7gqM4zI-D@fedora>
In-Reply-To: <aX1kAVu7gqM4zI-D@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 2 Feb 2026 07:38:32 -0800
X-Gm-Features: AZwV_QiVXaExgsPx325qx0RZTNNTuFJ-fgql68MV4h2b_iDXOPXGhE2hV9YKGuU
Message-ID: <CADUfDZrwFe+CJPXtKO8fTVU7wq8gRDcEMeCUGsbH9TTwNV7f3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Govindarajulu Varadarajan <govind.varadar@gmail.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 6:08=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 10:14:13AM -0700, Caleb Sander Mateos wrote:
> > struct ublksrv_ctrl_cmd is part of the io_uring_sqe, which may lie in
> > userspace-mapped memory. It's racy to access its fields with normal
> > loads, as userspace may write to them concurrently. Use READ_ONCE() to
> > copy the ublksrv_ctrl_cmd from the io_uring_sqe to the stack. Use the
> > local copy in place of the one in the io_uring_sqe.
> >
> > Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_=
NONBLOCK issue")
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 56 ++++++++++++++++++++++------------------
> >  1 file changed, 31 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 01088194c8d3..8122b012a7ae 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -4729,16 +4729,15 @@ static int ublk_ctrl_del_dev(struct ublk_device=
 **p_ub, bool wait)
> >       if (wait && wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(=
idx)))
> >               return -EINTR;
> >       return 0;
> >  }
> >
> > -static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
> > +static inline void ublk_ctrl_cmd_dump(u32 cmd_op,
> > +                                   const struct ublksrv_ctrl_cmd *head=
er)
> >  {
> > -     const struct ublksrv_ctrl_cmd *header =3D io_uring_sqe_cmd(cmd->s=
qe);
> > -
> >       pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len =
%u\n",
> > -                     __func__, cmd->cmd_op, header->dev_id, header->qu=
eue_id,
> > +                     __func__, cmd_op, header->dev_id, header->queue_i=
d,
> >                       header->data[0], header->addr, header->len);
> >  }
> >
> >  static void ublk_ctrl_stop_dev(struct ublk_device *ub)
> >  {
> > @@ -5117,13 +5116,12 @@ static int ublk_char_dev_permission(struct ublk=
_device *ub,
> >       path_put(&path);
> >       return err;
> >  }
> >
> >  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> > -             struct io_uring_cmd *cmd)
> > +             u32 cmd_op, struct ublksrv_ctrl_cmd *header)
> >  {
> > -     struct ublksrv_ctrl_cmd *header =3D (struct ublksrv_ctrl_cmd *)io=
_uring_sqe_cmd(cmd->sqe);
> >       bool unprivileged =3D ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DE=
V;
> >       void __user *argp =3D (void __user *)(unsigned long)header->addr;
> >       char *dev_path =3D NULL;
> >       int ret =3D 0;
> >       int mask;
> > @@ -5135,11 +5133,11 @@ static int ublk_ctrl_uring_cmd_permission(struc=
t ublk_device *ub,
> >                * The new added command of UBLK_CMD_GET_DEV_INFO2 includ=
es
> >                * char_dev_path in payload too, since userspace may not
> >                * know if the specified device is created as unprivilege=
d
> >                * mode.
> >                */
> > -             if (_IOC_NR(cmd->cmd_op) !=3D UBLK_CMD_GET_DEV_INFO2)
> > +             if (_IOC_NR(cmd_op) !=3D UBLK_CMD_GET_DEV_INFO2)
> >                       return 0;
> >       }
> >
> >       /*
> >        * User has to provide the char device path for unprivileged ublk
> > @@ -5156,11 +5154,11 @@ static int ublk_ctrl_uring_cmd_permission(struc=
t ublk_device *ub,
> >       dev_path =3D memdup_user_nul(argp, header->dev_path_len);
> >       if (IS_ERR(dev_path))
> >               return PTR_ERR(dev_path);
> >
> >       ret =3D -EINVAL;
> > -     switch (_IOC_NR(cmd->cmd_op)) {
> > +     switch (_IOC_NR(cmd_op)) {
> >       case UBLK_CMD_GET_DEV_INFO:
> >       case UBLK_CMD_GET_DEV_INFO2:
> >       case UBLK_CMD_GET_QUEUE_AFFINITY:
> >       case UBLK_CMD_GET_PARAMS:
> >       case (_IOC_NR(UBLK_U_CMD_GET_FEATURES)):
> > @@ -5186,11 +5184,11 @@ static int ublk_ctrl_uring_cmd_permission(struc=
t ublk_device *ub,
> >       if (!ret) {
> >               header->len -=3D header->dev_path_len;
> >               header->addr +=3D header->dev_path_len;
> >       }
> >       pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n"=
,
> > -                     __func__, ub->ub_number, cmd->cmd_op,
> > +                     __func__, ub->ub_number, cmd_op,
> >                       ub->dev_info.owner_uid, ub->dev_info.owner_gid,
> >                       dev_path, ret);
> >  exit:
> >       kfree(dev_path);
> >       return ret;
> > @@ -5210,11 +5208,13 @@ static bool ublk_ctrl_uring_cmd_may_sleep(u32 c=
md_op)
> >  }
> >
> >  static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
> >               unsigned int issue_flags)
> >  {
> > -     const struct ublksrv_ctrl_cmd *header =3D io_uring_sqe_cmd(cmd->s=
qe);
> > +     /* May point to userspace-mapped memory */
> > +     const struct ublksrv_ctrl_cmd *ub_src =3D io_uring_sqe_cmd(cmd->s=
qe);
> > +     struct ublksrv_ctrl_cmd header;
>
> It is cleaner to initialize header variable here, otherwise this patch
> looks fine:

It wouldn't be correct to dereference ub_src here; see the prior patch
"ublk: Validate SQE128 flag before accessing the cmd".

Best,
Caleb
