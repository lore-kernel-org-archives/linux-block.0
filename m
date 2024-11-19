Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53241B813
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976203; cv=none; b=buZpFV0beXkAsgYUKnoGQ5Jd29Vrw7KvZjeKbul7Yrg8yfueWQvwprVmY4OnV2o56fw4rhVC/nWwpTyGQjpPXXopKqlwW4Uf20pDCD+5LQPNagmF+dhJCJpFOktqjpIGUUhhfiDN3JtCuCh1DycMxaZKzYu+2WEgfjDgNYFsXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976203; c=relaxed/simple;
	bh=nbKybIocLaJsDERu+tKuByUmjOL7ZeBtmP+3Ia+NPvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVuTnN7HcKnqVv1Vya7Ee/fJp9F7U99gqpETL1fcCh2R3plyZbvH5h7zO6iYrFEvpRoueb1YmKH5hT+Skk2HbPJyJ1kAoOBHeT0MoDweov5VAP0n9+TkCwWluSrLn9aR/HiUYAgm/9XF4oKma8cbDVv9c8Lqdv12gvz4Ivc88hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3rUi3MA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3rUi3MA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731976200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ4QyAi1edaD+l9HnJ0KjSAONsSZ3MFU1c/LvjhfpbQ=;
	b=f3rUi3MAtCQMILFbR6ccC+NuEMN9mBR6ZyudMOTnmPO+JY0F/KGKkVuNHt1T/yceGxNNso
	iQEQa/OZopgwOWhE+sGjV+2TF4nOzSycpTmYaJTVszvTZVv74C05vfZtuEa999if4clS6V
	03RsjBiUPIBrXBNDk1fql7pvi7q9wvA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-d9rVwu8WPJqXkMcUcK9YPg-1; Mon, 18 Nov 2024 19:29:59 -0500
X-MC-Unique: d9rVwu8WPJqXkMcUcK9YPg-1
X-Mimecast-MFC-AGG-ID: d9rVwu8WPJqXkMcUcK9YPg
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fcdfdef26dso10706561fa.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 16:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731976198; x=1732580998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ4QyAi1edaD+l9HnJ0KjSAONsSZ3MFU1c/LvjhfpbQ=;
        b=Spuf/9bANAsxN4iSR2r1z6Z2bSvPfIHhuzvIR1/mKDyIdc4IoAOWriVdGtEWpLRa4h
         ZsUd+79g5cRywYJrAFUqoq85DnB4851uT9JoicfI9YbxBcUja5oZjBAUYVUNUR4BgG/0
         70YBYje8w6CL28gNhIkGjLofAlMENlz2npGo6XKz7frjzP9Wzhr5a93lUhoS8DXQtGC2
         8MsksrgwhZNiovPi10ZLhxISp3hrGd5BV+7O+pL1UX8DiMlnOW/EWjtSV7wuj9NUPLWN
         4vdQ09gAMaGYGEVbPaBFiUnkFHhr2PxOomncCN2ilVpXHF0ypEENsQVvcLIg9mcbc/qj
         zqJw==
X-Gm-Message-State: AOJu0YxwtnKUpuus1RwO8J06VQWeZ2kHR7PasFeQkhkvjbA9yAXGf857
	B1SnipS8uxLj3bGDu1jX8nxbOAqdNEp5vgLnbmwBr9Bany45Fp9wcHh4nBLOIs73VI0P9MXxlFL
	xf0faqSoRu+7VhHzzjxYDCxJcLS6urrHr3/VdeIG7d2jAmuXxQMfJODYtGjZUpGmv48bJWY9aJ8
	1mGrmgeOrLv2T2tRNUTFa7ltmYiCRcBOIyCLI=
X-Received: by 2002:a2e:a9a7:0:b0:2fb:4f0c:e40c with SMTP id 38308e7fff4ca-2ff60765548mr65603081fa.34.1731976197675;
        Mon, 18 Nov 2024 16:29:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyvrOMbusuuajE8tmnecXn/ALWrTs1c5t0rpxZ+zaTBCo/48JODmP/Z2X19JdXOne0Xpzzy1EsX5ZBZqgj4E0=
X-Received: by 2002:a2e:a9a7:0:b0:2fb:4f0c:e40c with SMTP id
 38308e7fff4ca-2ff60765548mr65602961fa.34.1731976197253; Mon, 18 Nov 2024
 16:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Nov 2024 08:29:45 +0800
Message-ID: <CAHj4cs_d2BuZn0ir_PvMgbhJigir=7Jz4b3KWp19xewnNKjytQ@mail.gmail.com>
Subject: Re: [PATCH blktests] throtl: set "io" to subtree_control only if required
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick fix.
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Fri, Nov 15, 2024 at 8:12=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> It was reported the thortl test cases fail on the systems, which already
> sets "io" in cgourp2 subtree_control files. The fail happens when
> writing "-io" to the subtree_control files at clean up.
>
> To avoid the failure, check if the system already sets "io". If so, skip
> writing "+io" at set up, and writing "-io" at clean up.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://github.com/osandov/blktests/issues/149
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/throtl/rc | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 2e26fd2..9c264bd 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -10,6 +10,8 @@
>
>  THROTL_DIR=3D$(echo "$TEST_NAME" | tr '/' '_')
>  THROTL_DEV=3Ddev_nullb
> +declare THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO
> +declare THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO
>
>  group_requires() {
>         _have_root
> @@ -31,8 +33,16 @@ _set_up_throtl() {
>                 return 1
>         fi
>
> -       echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> -       echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +       THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=3D
> +       THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=3D
> +       if ! grep -q io "$(_cgroup2_base_dir)/cgroup.subtree_control"; th=
en
> +               echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control=
"
> +               THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=3Dtrue
> +       fi
> +       if ! grep -q io "$CGROUP2_DIR/cgroup.subtree_control"; then
> +               echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +               THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=3Dtrue
> +       fi
>
>         mkdir -p "$CGROUP2_DIR/$THROTL_DIR"
>         return 0;
> @@ -40,8 +50,12 @@ _set_up_throtl() {
>
>  _clean_up_throtl() {
>         rmdir "$CGROUP2_DIR/$THROTL_DIR"
> -       echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
> -       echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> +       if [[ $THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO =3D=3D true ]]; then
> +               echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +       fi
> +       if [[ $THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO =3D=3D true ]]; then
> +               echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control=
"
> +       fi
>
>         _exit_cgroup2
>         _exit_null_blk
> --
> 2.47.0
>


--
Best Regards,
  Yi Zhang

