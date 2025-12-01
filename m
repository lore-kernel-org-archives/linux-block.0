Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964191C84C0
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764569431; cv=none; b=Mr/FuH7okihtuLwvDrSaytoEAhXku4wOyUlI/MhD3lsl1llIOzpcu7s9SC+KEdVyMOXnUeBdoK0NJrWwFlRbpI/dBVb9I2Cg7d3wdpdm72yBxfVuvsun+9W3qtS8N+oTVPR+F7LvcRAm2z5jIzz79ZA3omjdmnk3lWLNOTNWh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764569431; c=relaxed/simple;
	bh=dK6LVvZXtJcO3+hTxExNGu6YS83HhsurIDNEZdxpBjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1PStbsEGZqUcWsHAG8cT8vMAIVtwFgN7EgEmefcTrpurUa28zCspCsz0ryngTGpU/V3Z5h04FtpWWTwVFNzwkS92e7u44hnTGT+eRiZulCmcCUgJimfy82CU8/VnSrfzo808hoSXt/u6DnBS3EfGbNdgBzMczyjebEHaToFSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LdKFBICK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LdKFBICK"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7672a12eb8so41664066b.3
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764569427; x=1765174227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUWCoa2TvJeZ2qLBkbaS38Pj3t7SDQQs7GmbeHyTJ7k=;
        b=LdKFBICKAo7oPWaWfoW6Zw/gIDXu1BRUWu0cuVrK+VJBfPgTWAaELajnkPCsYGZoe0
         xYi+NPOTH3ILCKMzlWGY8YdroQl8g8pk/dQ9VfyCRvkMTvkBkthfVYVwdL9INE2GblXe
         QdQPdJ9EYV9BzuHxTg9J8mTqFOLFL1c7Jm0YlSu9KCUaSbLYbooYOFNvSWqZaOWVTVs9
         e0veSCRw9vqoCtGhbCU6hYCAAa3imTjXPx+OZCkcRngpTC8BOhfNu/aIkwak2i9n8F6B
         FeEUSdY3272m8YxkYCbMUX+X/Ki4PY/VPBgKuAHN9YhZ1mTYlrb2/x2UNIbb+8nfbOUG
         U+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764569427; x=1765174227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUWCoa2TvJeZ2qLBkbaS38Pj3t7SDQQs7GmbeHyTJ7k=;
        b=ILWWoHIO6PH33mP5prWb1CaA298bKKUiqaowBoakt7U4jpxGD7XIgI475EPpglbdPH
         /ysOX6EH5C60kF3uJoeVyyq2KbqnauaybfKulzaKBOL22C7dIq4BQqps1oUTi2x75AtH
         WwK+2BwmnUeq/Zn9dCkEYAFptGzmEWiWQd6zTAm1FKFQwBfsOWPCQ+yEpk5TP1t/o6Zg
         3oI8WsFiDfqhrjIXQ+MVhUkw021BJm9SAEIdCpcRhifwzCaBtoNzkVFhwyxX6W9cUmRk
         7E+zOt1G3MjlhhrGeAFTAum7fNSVMCbiR9hLRp2xDnVYwFhPM2k+Q5u3WM5qopCpa5CU
         Ipng==
X-Forwarded-Encrypted: i=1; AJvYcCUm7nAaljC1qOefJNDSLntgDfLIeIpdOfDGFr2Xo83cGK6zaVR2Nwy5ymsymvqwdfHzwK4Mw2OwbaF0Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmSJwwcehtGSozrpMfRImFAwIELtk2wO5OKfWHY29/dP6p1fn
	oH5kKalu5+XawJgZgtJxbq4B6aezO1GIwMqt0jiwAA2+ia17FnvQwxMBH+gjxBbZMYDTHvvxQKU
	8KwpEByTfm9dE1XvQ+ZganfvOxl9vU23fNdEyFIG7mQ==
X-Gm-Gg: ASbGncte6wQ8TG2sI+vqEXqf3IjzzjanlqtrRGnkKYgr/2HGG5ZrBDA5xW3Anq5nzfp
	qZXGpcsTR9Ly9c7Olgh55P8JVkUhjSp6Gy3asF4ME1Lo2Hmh3zujuPLVEXRb8HtAfYMWXgXnd7X
	IxJVYz56lQ43Plq4xHiSc4Q8eXj1v4mWS9laAAdoOlWxnwxiF0+MwEm+fUdI4oKgBSsAG92ohgA
	YHE4ZBa9gpBfpSU/3C0WKM4Z7Z/OF5Ade1xY1A2+SmgEyJN4ur95sHsJw1W/2NzZ1TWWSK7XFp8
	kd9t07rIAgvbzUUThdgpOgD8MgEkUPaAxFsyJg==
X-Google-Smtp-Source: AGHT+IHqqqMjmc4wSiCvdPeDjLhjJjNzUr00dgfhvujlYXR3jO65w9ihcJlLxt0oK7WULfte9njzaDqdENDWu4rQyEA=
X-Received: by 2002:a17:907:3c84:b0:b76:3d45:51d9 with SMTP id
 a640c23a62f3a-b7676ce0db2mr2462621666b.0.1764569426831; Sun, 30 Nov 2025
 22:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129223542.2047020-1-rdunlap@infradead.org>
In-Reply-To: <20251129223542.2047020-1-rdunlap@infradead.org>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 1 Dec 2025 07:10:15 +0100
X-Gm-Features: AWmQ_bltb3w3qL1GKkSPcer9suF2lTNugSWu7BhoxL5x0gWJjXwQcdy_R-KPQMk
Message-ID: <CAMGffEkEU4obSxbtRUNaK8F03jQEaX2VDqHyWmsYSidDsf_94g@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: correct all kernel-doc complaints
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 11:35=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Fix all kernel-doc warnings in rnbd-proto.h:
> - use correct enum name in kdoc comment
> - mark several struct members as "/* private: */" so that no kdoc is
>   required for them
> - don't use "/**" for a non-kernel-doc comment
> - use the correct struct member name for "dev_name"
> - use " *" for a blank kernel-doc line
>
> Fixes these warnings:
> Warning: drivers/block/rnbd/rnbd-proto.h:41 expecting prototype for
>  enum rnbd_msg_types. Prototype was for enum rnbd_msg_type instead
> Warning: drivers/block/rnbd/rnbd-proto.h:50 struct member '__padding'
>  not described in 'rnbd_msg_hdr'
> Warning: drivers/block/rnbd/rnbd-proto.h:53 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * We allow to map RO many times and RW only once. We allow to map yet an=
other
> Warning: drivers/block/rnbd/rnbd-proto.h:81 struct member 'reserved'
>  not described in 'rnbd_msg_sess_info'
> Warning: drivers/block/rnbd/rnbd-proto.h:92 struct member 'reserved'
>  not described in 'rnbd_msg_sess_info_rsp'
> Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'resv1'
>  not described in 'rnbd_msg_open'
> Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'dev_name'
>  not described in 'rnbd_msg_open'
> Warning: drivers/block/rnbd/rnbd-proto.h:107 struct member 'reserved'
>  not described in 'rnbd_msg_open'
> Warning: drivers/block/rnbd/rnbd-proto.h:158 struct member 'reserved'
>  not described in 'rnbd_msg_open_rsp'
> Warning: drivers/block/rnbd/rnbd-proto.h:189 bad line:
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/block/rnbd/rnbd-proto.h |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> --- linux-next-20251128.orig/drivers/block/rnbd/rnbd-proto.h
> +++ linux-next-20251128/drivers/block/rnbd/rnbd-proto.h
> @@ -24,7 +24,7 @@
>  #define RTRS_PORT 1234
>
>  /**
> - * enum rnbd_msg_types - RNBD message types
> + * enum rnbd_msg_type - RNBD message types
>   * @RNBD_MSG_SESS_INFO:        initial session info from client to serve=
r
>   * @RNBD_MSG_SESS_INFO_RSP:    initial session info from server to clien=
t
>   * @RNBD_MSG_OPEN:             open (map) device request
> @@ -47,10 +47,11 @@ enum rnbd_msg_type {
>   */
>  struct rnbd_msg_hdr {
>         __le16          type;
> +       /* private: */
>         __le16          __padding;
>  };
>
> -/**
> +/*
>   * We allow to map RO many times and RW only once. We allow to map yet a=
nother
>   * time RW, if MIGRATION is provided (second RW export can be required f=
or
>   * example for VM migration)
> @@ -78,6 +79,7 @@ static const __maybe_unused struct {
>  struct rnbd_msg_sess_info {
>         struct rnbd_msg_hdr hdr;
>         u8              ver;
> +       /* private: */
>         u8              reserved[31];
>  };
>
> @@ -89,6 +91,7 @@ struct rnbd_msg_sess_info {
>  struct rnbd_msg_sess_info_rsp {
>         struct rnbd_msg_hdr hdr;
>         u8              ver;
> +       /* private: */
>         u8              reserved[31];
>  };
>
> @@ -97,13 +100,16 @@ struct rnbd_msg_sess_info_rsp {
>   * @hdr:               message header
>   * @access_mode:       the mode to open remote device, valid values see:
>   *                     enum rnbd_access_mode
> - * @device_name:       device path on remote side
> + * @dev_name:          device path on remote side
>   */
>  struct rnbd_msg_open {
>         struct rnbd_msg_hdr hdr;
>         u8              access_mode;
> +       /* private: */
>         u8              resv1;
> +       /* public: */
>         s8              dev_name[NAME_MAX];
> +       /* private: */
>         u8              reserved[3];
>  };
>
> @@ -155,6 +161,7 @@ struct rnbd_msg_open_rsp {
>         __le16                  secure_discard;
>         u8                      obsolete_rotational;
>         u8                      cache_policy;
> +       /* private: */
>         u8                      reserved[10];
>  };
>
> @@ -187,7 +194,7 @@ struct rnbd_msg_io {
>   * @RNBD_OP_DISCARD:        discard sectors
>   * @RNBD_OP_SECURE_ERASE:   securely erase sectors
>   * @RNBD_OP_WRITE_ZEROES:   write zeroes sectors
> -
> + *
>   * @RNBD_F_SYNC:            request is sync (sync write or read)
>   * @RNBD_F_FUA:             forced unit access
>   */
