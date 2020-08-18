Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B59C433E3
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D6720706
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="px6BOetx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHRMxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHRMxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 08:53:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922CC061342
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 05:53:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so15151253edb.3
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZNHqIo/o5PTzslTmWoWeSNX4Sf55a+mcEE0Ya1Wrqu4=;
        b=px6BOetxPov2VXZZYWCIwmQJXRiJdu2zYyppgQ4NJ0GFSaVjXYbMaWUeRKZJzvjVVK
         bQM1szrg0N5zIbrxv4Aw/tfY0Bd9U18IDyG1Znu7edZasCe6ou407EkE8OnjKZM1Z2oE
         wDUJMG6BbOdP2OKwZ7roQlXrLaCTGu+IZFjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ZNHqIo/o5PTzslTmWoWeSNX4Sf55a+mcEE0Ya1Wrqu4=;
        b=gJAXl6wsVcEEJ4bO9t0WqVS+G04BrHkxUq3P8MucN9ed+XFsUX+NrEzmuP/EYc2VH9
         vj82Heb/3h3qNbMq9KTtd2natOPZfpNtlQhIgSA9ARzq/XpbR8bOXRcQhjlX0S7actm+
         m3RiUT34JKP9t8IVdoMABZEtoAkI5Q6ats1Yloy/ixg8K6EaWz1lYIlMb+JPywuwTo+U
         77F1OaXztjjrIqdRCbASOTa+xKyrcNOizNeY6il8XyD6xEW+dbVJ9Wy8X05E96eqQBzB
         lZYsEdxB8p1y9ULiPaZwwAq+mqiTQOgYwwIyMa+kozsj4oGQR+wQjyMfTdkmuIQVXGbJ
         XBeQ==
X-Gm-Message-State: AOAM531LfmFsPRqJ5XFd7S6MhXPSU1VO7HrGaa01v4nDz+tFsNUutg4m
        93lXPZtqc62Vxkbk6992yELOByZVooq+gA==
X-Google-Smtp-Source: ABdhPJyIhdEd4dxx01MULiiDY53D0MAL/G49AynyKxTBCBWiwvdErSQptzndvDSyYLQHJa0lENC/1A==
X-Received: by 2002:a05:6402:c81:: with SMTP id cm1mr19000313edb.256.1597755224405;
        Tue, 18 Aug 2020 05:53:44 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j1sm15478983edq.58.2020.08.18.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:53:43 -0700 (PDT)
References: <20200812163305.545447-1-leah.rumancik@gmail.com> <20200812163305.545447-2-leah.rumancik@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
In-reply-to: <20200812163305.545447-2-leah.rumancik@gmail.com>
Date:   Tue, 18 Aug 2020 14:53:42 +0200
Message-ID: <87mu2sru7d.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 06:33 PM CEST, Leah Rumancik wrote:
> Introducing a new program type BPF_PROG_TYPE_IO_FILTER and a new
> attach type BPF_BIO_SUBMIT.
>
> This program type is intended to help filter and monitor IO requests.
>
> Co-developed-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Kjetil =C3=98rbekk <orbekk@google.com>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---

[...]

> diff --git a/block/blk-bpf-io-filter.c b/block/blk-bpf-io-filter.c
> new file mode 100644
> index 000000000000..453d6b156bd2
> --- /dev/null
> +++ b/block/blk-bpf-io-filter.c

[...]

> +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *p=
rog)
> +{
> +	struct gendisk *disk;
> +	struct fd f;
> +	struct bpf_prog_array *old_array;
> +	struct bpf_prog_array *new_array;
> +	int ret;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	f =3D fdget(attr->target_fd);
            ^^^^^

Missing corresponding fdput?

As per Martin's suggestion, with bpf_link this will become the
link_create callback, but the comment still stands.

> +	if (!f.file)
> +		return -EBADF;
> +
> +	disk =3D I_BDEV(f.file->f_mapping->host)->bd_disk;
> +	if (disk =3D=3D NULL)
> +		return -ENXIO;
> +
> +	ret =3D mutex_lock_interruptible(&disk->io_filter_lock);
> +	if (ret)
> +		return ret;
> +
> +	old_array =3D io_filter_rcu_dereference_progs(disk);
> +	if (old_array && bpf_prog_array_length(old_array) >=3D BPF_MAX_PROGS) {
> +		ret =3D -E2BIG;
> +		goto unlock;
> +	}
> +
> +	ret =3D bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	rcu_assign_pointer(disk->progs, new_array);
> +	bpf_prog_array_free(old_array);
> +
> +unlock:
> +	mutex_unlock(&disk->io_filter_lock);
> +	return ret;
> +}

[...]
