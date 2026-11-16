Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850650;
	b=NIrLBKRgYS9rIKJp5z4+/wTOb7g0y7YKxz5b3KvImNS11y//CTYVFkBsLRdzxva7jpbl
	 O/vX6i6fOW5csjWy/yOwzHywL6tjwsUGLgb5smHro8cnkNDjcL4C2agFQQ+J5AawQE3p3
	 qE3KZLwOpc9AALi/wau+5vfmvuF2Tz+b9n791Jp+vNqMb527AfX9Z83tM877dM06XxZke
	 bM6RIbyF25F4eYO+GznJYrrZPRv6Mxj32YkPcNtnEr0lozPDuErzMCeiUcnD2HejEeEuY
	 3s6cFoVuczei0R0KwDqce/uqdzu5f8Y6NKq/nWJTnkXbbYaXBLzW80l4gT4UMylVYYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	b=PHHDvr0ij5QMkFAjxMVhpNHGHZ/fhQ8UzD9oQWMv6i8CHD3OS6dcN7atPJN/WXpaZjUh
	 cqF0XwrWwNCOvqZtZGOorwbuJ28BB+rzmnItGvN6RJimpz9FEupeNCna7H0ZVMgSszCjI
	 OsjBRVC4Auum31lIwRC/eNScDcFsWEsK4kglGPAJK3HnXST9+m4UcvuJfz/+MdKbwMF3G
	 os8pnIDaPk6gFhxIznWXhhN/Drx430zKDP/NLkiQvXQ4enhoravTXO2nr/yNkGDHFWExs
	 S35q64HqOsuSteYqJ6kyep9IHD/g8QgZlDfpaEL85hgMP9ZKyLR7hnFGjkKw0AAjiyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064F606A88F
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5064F606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so218689a12.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=iYaNvOoaKqHtsQ5eCBkfzrixk3Y9QGLrP4AK5H1JziKi9qsM5ZRXPIhYlGBmY9UdMb
         1hRjGm2Qb0Zl5TkuxDyiSkJov81k2ABlFmbVENwNw+el3+z/IxLjfQYt8z3Y2JEk2zWT
         ceLQ71xrHiIhhNePrYKIcSKhYk/BCiO9/f9Jpxsf9CLFTneP5669tJNldwrAcOdNqKns
         4bplwylV4eIU/4CYXNsFfdO8+xv83WH19mRLUPUWPr0OnCTVNZNgONisWA+R4Ehok+Ov
         qpBXaysEic781iaVlwQ+OJEVgwykyCGMlzdGnAYBe9/5D1hyVTxgC6hzFTggt0/Q1QoH
         jNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=oyZGvqgJRqcacF/V7LHSlrrtDtbRUCwk/HCQKivanVM=;
        b=AQhTEqivArNWTbX/BxkT4yiTa+NMH5jFtOPtX9WyXLREUfgOYb1o8eKPDZxd4DEMZn
         HjFbRgmXrdpAI0BHX0750m5m5vcH5IYS8mwtkhU12zTEd1Zdvp2fjdULQBpQtzxZIwSD
         H+VoKsrnO0Day45wL+b/fqGTx7cjkuq64CEa4Wduv6aWnkFFpKF8ZfXl2pcbMEZtK59r
         zAymCzUhyS0hUVkZfuSq5S9HOZDJgCiFSdT1leU6fBHMSbBF+Bs8LqKy0dtyj+i18plW
         VGLFrdV+8SyBv8gsnPT6rRxeAVRYFIWtWYYzrW2Where3tFf3Btco2LbWkWGY6R5eAUM
         FsJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=Wda5m4T+Og74YNLartpajMnAcctT7hnb5haqi9hjLlBRa67TYcEPjf80gw45qsgIx7
         FMobW/aC2ZXQsUmoaLilVLeaESS9ODytholTX6ZkGdI39Z50BqAMQuVm0upEGdU/eTIl
         KzXBiwaEJY7eqa6p49n+ZePGE0YUDeVtz78JPQJb7w7ae3zRsyAfYOAEtJq8eS6befDe
         ANfoXo4rOnrr9cTK5CEQbvEa19yD1CMimOfBL7pxwr0U+pGpN6RB970vgsC2xV+kB6BG
         DqloDFELm5xz1LM2zdKvbUwHIwogDmvmrNVDo81Was00uh+K9TR8cjrFQWZvFUjBWrt9
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=T9eleUg9wkbDeORKOoN8F2guZ39vwbq600tSsaTsl1qJdNSSiW/J3KtcKQI+I30hvG
         nSqMdMd7o70yw1q022/drEpie1NqLsiT+j81bM2Q2qRW7GbUUTwSbvr5RjTZrkK9FLN1
         vzJiDv9Bo2/lW7qInizYqKQFCydAEmZc10ua4FgaF9KG44x4wdQK6AYGmAgQm6YIoG1Z
         TGZHhTarXhDgISUgono+8bYJoATvH0hzGRTSR2ltlZiUAjOOQhd72nM5RV4KsDhgo+Aw
         7o8e7pClJogOH6MRGoqUPAGXRS0gv+RMNrZ1fPgcuif5WsK6Nj8dDFX0XHMYF4qB/lHX
         zOXQ==
X-Forwarded-Encrypted: i=1; AL+hErG4aSF1ak9DJXJZlgwODMs6AcaIJvcHpOgfD3WK5fc9OTOyeryF7sDRRkOXQTphF8IpXN2JFL0oH/oAbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z91g8MCr+ky4D28gC6U9TRz/DGKMg1Xm0RQV+AT0eeRVzgaxmZ2
	IKN0e0E2rQi/qnHM8arDEa1m9x8bGkZ2EPngF2Ui2D+9i2Oh3iZ0jiebxwfF5y790XVLZTmu/ah
	treAnQ6/VUczZmzdm3/AD3bbRCE3/rZo=
X-Gm-Gg: AYBFou2SbWnH2EKb0WPV2K8+ft3ZRoBs6MGepV9tXm/aKnF3yCkOzpvbiZHMC51D52K
	Ckp0jNRO2g0oI/L6vr80s7JiINQWFXsxGgECWR2FGKU4Jm3ApeDJIaTTZ5tpa8uFme5+Dag3GY8
	fwkUpecDIwsMvEOk/JHWiCtLSeNgmjLuBu4Yk67bVPHdYy/zP/ydPql2RZGTQS4nNIuP+g1/ZDL
	kGOUwHfLWG4mMQJ9gpYi3Aiv3g8A37T2xhsH6TY9vK20z5waQ5xGW/AujNgvEfGsFKoFRhDL1ou
	sb9zKqWHt9CCwPurMKAKjMiWl/W+5nqLOOi/vB8YUj32m77OqH0zOAVAajHJMa3zVqg8WZ1nOC4
	dP8M9MwmGwPaO3lyJn0kvC0SHFITUPxAG+NfoaCEDiCpWsbidrO9Sz+Oh1A2Tvuzmytz34g==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.
