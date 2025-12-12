Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BD1E1E16
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550878; cv=none; b=JiPSN4QfFdCqpHxGZW6u59NU1uyDY7dAPDN7SA0TRqekVsj6vjGCZ08fAgn7Jpqf1KbvalN17ZVi/8EYc9fPBsRPqS4DUcYIJWIE2+IwQsZSoKVqqu5AsJOmPV/WeydquRciZyGV3GsnoY8mILB9gbqBYnTHOXgObQ+v57/kbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550878; c=relaxed/simple;
	bh=dB5IQyrT+3xIBMFUDs2prkWXi7b+FXh5eXZD0YZpKcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yiun5o5s5kyWfd+f6GPAPJMhbszWdZI5LxCBy33ydpcuktlip4pjLDq+PLDAQYR3j/NSunxhj9h32BPChytI3iUghbZB3CazqXJRMddTyWnSu0+044ZgGGaI5F+iQIoUiOkDXOzEztDlz5Zf+XGteg8tLsUNjjEc7M1Nqe+uoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO4gHzNM; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO4gHzNM"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78c27dfd1c3so11435327b3.1
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765550876; x=1766155676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdqUCGtZT/YFP/y4uW/Jl7GlEKMc9TVl14ZCXeaAfkY=;
        b=HO4gHzNMDgS9YaLaxAOlK8WF6leaSiQbU8zzkJEz5YigdAVbDxZlsEeYQzaZnqgr3N
         i5NDGJuyj0Ial2aevsjntR0rRc+4wAu4ays66hW4deu937ERpM3p8muGR8a8ZLh/PV6C
         tB5VIClY7fuFTMkbKOA9jewvMSQC/SaSgbk4R2uE0d2Tp0q3jnKlICKrySmcWRVORs13
         nAyT0AUxtopLc67B7X/5H+NPiWTOUV8Hvq1meul8Pyo5nZbPB72MpsOkFSY29S34b3h8
         lKjgjSZqTz3rdGCkTZqX2RouFQ3BWSfG5odvmuECL9xQXTcl9Qmd/vbcpx3zy5T2hysV
         fkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550876; x=1766155676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdqUCGtZT/YFP/y4uW/Jl7GlEKMc9TVl14ZCXeaAfkY=;
        b=vg7nPjPjSue6QyySbbhoCh+vl+pufcJVz6JmMuZUWaK4Q/KCt4DeEeYlnDzmigmtVX
         ljn3XcA9XYpsyeYPHr9uaF2n9lU5QVQFRDTmM4+jEGTSBIycwiBAEsfjCw9lBkO0NPv4
         m1JCRRbGV4X+69/tk0tTO778LhgRYhD4jY6I0mtg6xCvfkrN7fZo7XLZ0ZxJZp/g2tuy
         5iR+3D6p9gP3K79GVojuxbPzbDF3PIPtDtB28odWhnH0KgnLXtXwlBqeQi/qh2Ctrfhm
         qJieX2cMipteW9xR+b2F5+AC9nnpHseACd4NvyjfkLOowurnkNdoUQ6r3unFVkSxlhQe
         2qwg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Eoz8ZxH6qoD57x5/cMyJAx8lN6YaB7uXNicK/U0oq0DfAmcbfdVVMZy7e4dife988kbRQjxp/BQugA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzThNbEDOc3+Z7v/sR5+oWlU8iEmRY4jLorF6NjsfyPSBJ2+WpI
	zf5j5rRfHXqz+IhDxP+qu20cjcuzmZpiVgwX9a/s2TDzBDu32GOBsgAOIMPaqAFEW+aCK5r6e3H
	Q9Foa+3i48eVFS442E433AVJkFNRX/1k=
X-Gm-Gg: AY/fxX72fmcle3rOah+Ts2bCGEgZgn0ZTRNIqY3p41MQmIszWNLKHuOKUDugj9pqKwp
	R8HlodBOI/6mpX8FThC4eEUtPookc30NiIRauI0eOojIDImKBJbP1CT2INlfX+Z5MLpOSMksWPo
	/AEfvRN5e7TNiBNB1oKDbvIdVKWt6OOu5T18S2qCavRqIPv7I1lFbW/QZrftxRPAAzuGF671L4A
	r0YNVM/OwiKec1wjQzayI91HwYX4rwEnlxyVIzz40gweODQbj/cdERY9sVSf145Ew+LzXM76mkR
	5ROhGkPjxltmTsfvMiyxkGEL3FUPS2hxjPdtxMmIxpjGmefbMUV6F5yd+XA=
X-Google-Smtp-Source: AGHT+IHaqJM+dh/f49x3QBJLBJGGKk2qSwzjX+Nyi1VlDgWLCNwIJ2L9rWg96SmQAtLR84j2oNqeiAFwUIoi7mJ08LQ=
X-Received: by 2002:a05:690e:191d:b0:643:55d:7731 with SMTP id
 956f58d0204a3-64555668108mr1325033d50.83.1765550876019; Fri, 12 Dec 2025
 06:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212013510.3576091-1-kartikey406@gmail.com> <aTuzVdo8cuxXhUxB@infradead.org>
In-Reply-To: <aTuzVdo8cuxXhUxB@infradead.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 12 Dec 2025 20:17:43 +0530
X-Gm-Features: AQt7F2pqK6VPdN4OfAta_L9aH22zoJNVbxd-_dmXENLWTeCahVnVm9bdphVZFhM
Message-ID: <CADhLXY57aFmNB1v4TG2YxhOQL1+_02KkWpB3fEsn8t1GiFqdrg@mail.gmail.com>
Subject: Re: [PATCH] block: add allocation size check in blkdev_pr_read_keys()
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, stefanha@redhat.com, martin.petersen@oracle.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:46=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> Well, bother checks for sure are redundant.  But maybe this is also
> a good chance to pick a sane arbitrary limited instead of
> KMALLOC_MAX_SIZE.  And if that is above KMALLOC_MAX_SIZE, switch to
> using kvzalloc.
>

Thanks for the feedback.

How about limiting num_keys to 64K (1u << 16)? In practice, PR keys
are used for shared storage coordination and typical deployments have
only a handful of hosts, so this should be more than enough for any
realistic use case.

With a bounded num_keys, the SIZE_MAX check becomes unnecessary, so
I've removed it. Also switched to kvzalloc/kvfree to handle larger
allocations gracefully.

Something like below:

+/* Limit the number of keys to prevent excessive memory allocation */
+#define PR_KEYS_MAX_NUM (1u << 16)
+
 static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
  struct pr_read_keys __user *arg)
 {
...

  if (copy_from_user(&read_keys, arg, sizeof(read_keys)))
  return -EFAULT;

+ if (read_keys.num_keys > PR_KEYS_MAX_NUM)
+ return -EINVAL;
+
  keys_info_len =3D struct_size(keys_info, keys, read_keys.num_keys);
- if (keys_info_len =3D=3D SIZE_MAX)
- return -EINVAL;

- keys_info =3D kzalloc(keys_info_len, GFP_KERNEL);
+ keys_info =3D kvzalloc(keys_info_len, GFP_KERNEL);
  if (!keys_info)
  return -ENOMEM;

...

 out:
- kfree(keys_info);
+ kvfree(keys_info);
  return ret;
 }
