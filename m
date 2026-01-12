Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AF2AD00
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256124; cv=pass; b=BdweB7jqRo9n1V5m1diWxh6PtaDh5umJMMILFeyTX5ATPqcFwAL2UAY6vYGm86t9n0JfzQhQ3O8l8lQy4QmRNI7alIozaNlaMPGvM30Mpv+gM8tNwNnsjnGjldAvPn9tiJy0UYCa2bZiZUyCne68+NhSN0Cw5//lS7LREAIrzMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256124; c=relaxed/simple;
	bh=jfHFkhju4eeUXuBY6BDuZZX23P8PjJpEABAi33jyoNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIEAoxXmz96gVarLN/lBBLeYp7x3rnCoGb8bi5ywDlv58lk6gAp+aLMxy5NS8Q8AWdp0XpC12v2bTfmLWboP3YtGCObS5ZW40JpFJQE4g+dUpxAkPDwUi0gblwy0j31nMDj0GTHsM+p/O9og9pj/Om+PotY6lKz4NiUMcPbx7Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aIDzssL4; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aIDzssL4"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-121a15dacd1so525101c88.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768256122; cv=none;
        d=google.com; s=arc-20240605;
        b=OKDz1gFeb9eKKiRwzAUmh2IOIEUgrxGkxUYj8awlJX00sR91AibAv2qAZwBGeEvZtf
         ubTCsTqTexeVZ8lAqO0sgTPb8ZzRpW3eprE6AfEmw9wQiqQWCT7WPLqPT72l0GGyco22
         xwGHWm2W6ZGJVo6NjE2k3rE/yRJgVz1CnsUrUAtzQ7HD+Us+8+U7W3fLBhW01sDzxQF8
         9CtwsZzTffUt0M/atQ3KbmBRB+ociMlkbW6ofZ/UqtMhZoVeMN7avneKIScPmYUaWYd0
         AIR8MR5geJtAz/oSs/wpOJTaJ166nlM5qAsBWWLDwXZIqleJTNCAh9t5cgnQVaM7Mjt1
         PMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7Fp/IS4FO5YJm/3+4AG0h0DNSil3Vdt8sw4M5JzJkc=;
        fh=tsBFLrO3QVtFrlMau1+VIPr96mABfQxy8Pusrr9dNbM=;
        b=ZVbt74/llOv/mXHRXnYN2Ic/9gdBZW5Wkoj43KBOng4qAkaoSxuyiXbxUgrhnc32Il
         2qwtCVUTOJtw2RiD6P8hia8uqiSW8PA26j4YrShSJdq4IjU3JWiCe4R/jumILoOT5rpG
         1/cJ6eR0FSxdh5e3EcuAxMcXaZVbKZTDSgz2FvmpKvok7yUKVCJbQOXfo/DXuAfRUbx4
         aRJztOXa00lDoMC7cvJG69wS4pCYuRqGv6VEfbCFi3UzgbccE6lMIRH7WynfHnQHUOoM
         R3P+HKiD2AEmkaZGeXYRRMQcBWj8nLm6ptlZ0V6+kT1/JOP2CBv84Ym5CV2JN+7se+Qz
         2OkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768256122; x=1768860922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7Fp/IS4FO5YJm/3+4AG0h0DNSil3Vdt8sw4M5JzJkc=;
        b=aIDzssL4/8rS8TPWYe1h/r7InnyhukIqAKF5Lu8MMb7FVgAdhTONRu1V5LW0KRYTZm
         ZFwEUs9EV5Xix4un+aE2c3DC7zMmCGrQKo6KSZTYqOoBfltefOx/ijJClGIwWJOic294
         WG4IAyUm8dordFU22vYzPbkBYevGZynQ08XjD1Ja/kbGYEjgAYerEbZKSi7Udrb3L3tU
         y18oXuJdiqXrgTvwEhi4WD2vwZZL4yvqCKIb4atbmXQtbwUWXTk3m1D9wZS+KS/0fR4k
         VVlrgoLsecAgJi0Ye0SexI+rVwvBYlUj+Co/8Aidgt7cAJpNrm5mGuZ3x5nuNYBBk80r
         kkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256122; x=1768860922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7Fp/IS4FO5YJm/3+4AG0h0DNSil3Vdt8sw4M5JzJkc=;
        b=bNdo5sa1wyhj5ebmD4NuZvVWs+ndzzPkna/j/yskhnKXe/D5rCS5O6gZy2YA9PtLpd
         vx8FvbSmJdmpDNQR0IQhaMyHDfET1+5eg8zu3xk9LXmGkWGLQqsxKw9wny7RqM/mCkIk
         rawuYCFIjVb7qtagM83g8R/SswwfNTicmwr4TEhYDDAmQpIt8i981xxPGIrZiSuR7ZvK
         E0XInVSijMMf8EqGcK5j69FxFfyH4TdboAbQkyMChbnaRlAir4nHO+n6l7NZWjsJ3fA9
         wzJrQ84JskqXqqJCdx82ShxzY8+4GB3lX6pvP9w195+1O8ZBPHCGWmtiSN0i+rAKSx7G
         ylwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYK/up0Ohy2c8aWwuyfp8hu/Mm3OJyUrteJ+zXnSq5ebzEDxg928yUqZa/OunXl1gzesalQmyRi5QzOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5mTkZCfO3eqSn12xCMkQRchrq5q0zZQqJcTrLSvrmE2c1Spt
	Gt3g+x5v+n5qmf5i3jWqgeURQnBtk0vLLkhhklu3A1Qwv+6Beft9K81t7tNZXEZfGIacI2pSdpc
	O8sMTxaJ2/7bHCtvsmrShZ9bNpwNSAw4/eHWOYIGJ0w==
X-Gm-Gg: AY/fxX7aZ72Hio46VvCEPCr71h09/75FyjH+G7e11InZ5vW8Z4eaxfbg2RLRBt64H5T
	DskcuTIE7wOdZ4tCALvDjJ7K58cHjldbjZxaWIze9s3+DZFlMfM61c8GpMxgLa6HOuGp8k2qtg7
	Q7xncqT+4VWmpb8Zankvf6Q8ly4+UZEMT9pnvIZEs35Acs77W4Qv8FE1OmfoDvj4D0ccRxxJ92E
	gjNvC0c9W7L5J8tKsqsJTuDHmqjxoQI/VrRiwt2oPWIIhq2qTqtOB2psiJc1k6XIfadnSNi
X-Google-Smtp-Source: AGHT+IHU7VQWM8mJOnXIIjf6wwU9mE0HhkdSO84KD0H57s2agqx/SxVB+oyI2LkKwjKrGB47i/9XVdkBB21Ma8ZLu5o=
X-Received: by 2002:a05:7022:6293:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-121f8abea5cmr10928560c88.2.1768256121682; Mon, 12 Jan 2026
 14:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112220502.9141-1-yoav@nvidia.com> <20260112220502.9141-4-yoav@nvidia.com>
In-Reply-To: <20260112220502.9141-4-yoav@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 14:15:10 -0800
X-Gm-Features: AZwV_QgyydCbbG8KBfyE9wrU8vSQ0QZuHqxSIWIOi4J4Tq3mmG_4CRfaCmEGNDg
Message-ID: <CADUfDZqVVrUq2VpFD0s1_Z-Hg9ipvBT4sJZLXfgYeCeAnaGHBQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] selftests: ublk: add stop command with --safe option
To: Yoav Cohen <yoav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	alex@zazolabs.com, jholzman@nvidia.com, omril@nvidia.com, 
	Yoav Cohen <yoav@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:06=E2=80=AFPM Yoav Cohen <yoav@nvidia.com> wrote:
>
> From: Ming Lei <ming.lei@redhat.com>
>
> Add 'stop' subcommand to kublk utility that uses the new
> UBLK_CMD_TRY_STOP_DEV command when --safe option is specified.
> This allows stopping a device only if it has no active openers,
> returning -EBUSY otherwise.
>
> Also add test_generic_16.sh to test the new functionality.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  1 +
>  tools/testing/selftests/ublk/kublk.c          | 53 +++++++++++++++++
>  tools/testing/selftests/ublk/kublk.h          |  1 +
>  .../testing/selftests/ublk/test_generic_16.sh | 57 +++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index 036a9f01b464..3a2498089b15 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -23,6 +23,7 @@ TEST_PROGS +=3D test_generic_12.sh
>  TEST_PROGS +=3D test_generic_13.sh
>  TEST_PROGS +=3D test_generic_14.sh
>  TEST_PROGS +=3D test_generic_15.sh
> +TEST_PROGS +=3D test_generic_16.sh
>
>  TEST_PROGS +=3D test_null_01.sh
>  TEST_PROGS +=3D test_null_02.sh
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index d95937dd6167..3472ce7426ba 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -108,6 +108,15 @@ static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
>         return __ublk_ctrl_cmd(dev, &data);
>  }
>
> +static int ublk_ctrl_try_stop_dev(struct ublk_dev *dev)
> +{
> +       struct ublk_ctrl_cmd_data data =3D {
> +               .cmd_op =3D UBLK_U_CMD_TRY_STOP_DEV,
> +       };
> +
> +       return __ublk_ctrl_cmd(dev, &data);
> +}
> +
>  static int ublk_ctrl_start_dev(struct ublk_dev *dev,
>                 int daemon_pid)
>  {
> @@ -1424,6 +1433,42 @@ static int cmd_dev_del(struct dev_ctx *ctx)
>         return 0;
>  }
>
> +static int cmd_dev_stop(struct dev_ctx *ctx)
> +{
> +       int number =3D ctx->dev_id;
> +       struct ublk_dev *dev;
> +       int ret;
> +
> +       if (number < 0) {
> +               ublk_err("%s: device id is required\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       dev =3D ublk_ctrl_init();
> +       dev->dev_info.dev_id =3D number;
> +
> +       ret =3D ublk_ctrl_get_info(dev);
> +       if (ret < 0)
> +               goto fail;
> +
> +       if (ctx->safe_stop) {
> +               ret =3D ublk_ctrl_try_stop_dev(dev);
> +               if (ret < 0)
> +                       ublk_err("%s: try_stop dev %d failed ret %d\n",
> +                                       __func__, number, ret);
> +       } else {
> +               ret =3D ublk_ctrl_stop_dev(dev);
> +               if (ret < 0)
> +                       ublk_err("%s: stop dev %d failed ret %d\n",
> +                                       __func__, number, ret);
> +       }
> +
> +fail:
> +       ublk_ctrl_deinit(dev);
> +
> +       return ret;
> +}
> +
>  static int __cmd_dev_list(struct dev_ctx *ctx)
>  {
>         struct ublk_dev *dev =3D ublk_ctrl_init();
> @@ -1487,6 +1532,7 @@ static int cmd_dev_get_features(void)
>                 FEAT_NAME(UBLK_F_PER_IO_DAEMON),
>                 FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
>                 FEAT_NAME(UBLK_F_INTEGRITY),
> +               FEAT_NAME(UBLK_F_SAFE_STOP_DEV)
>         };
>         struct ublk_dev *dev;
>         __u64 features =3D 0;
> @@ -1616,6 +1662,8 @@ static int cmd_dev_help(char *exe)
>
>         printf("%s del [-n dev_id] -a \n", exe);
>         printf("\t -a delete all devices -n delete specified device\n\n")=
;
> +       printf("%s stop -n dev_id [--safe]\n", exe);
> +       printf("\t --safe only stop if device has no active openers\n\n")=
;
>         printf("%s list [-n dev_id] -a \n", exe);
>         printf("\t -a list all devices, -n list specified device, default=
 -a \n\n");
>         printf("%s features\n", exe);
> @@ -1653,6 +1701,7 @@ int main(int argc, char *argv[])
>                 { "pi_offset",          1,      NULL,  0 },
>                 { "csum_type",          1,      NULL,  0 },
>                 { "tag_size",           1,      NULL,  0 },
> +               { "safe",               0,      NULL,  0 },
>                 { 0, 0, 0, 0 }
>         };
>         const struct ublk_tgt_ops *ops =3D NULL;
> @@ -1760,6 +1809,8 @@ int main(int argc, char *argv[])
>                         }
>                         if (!strcmp(longopts[option_idx].name, "tag_size"=
))
>                                 ctx.tag_size =3D strtoul(optarg, NULL, 0)=
;
> +                       if (!strcmp(longopts[option_idx].name, "safe"))
> +                               ctx.safe_stop =3D 1;
>                         break;
>                 case '?':
>                         /*
> @@ -1842,6 +1893,8 @@ int main(int argc, char *argv[])
>                 }
>         } else if (!strcmp(cmd, "del"))
>                 ret =3D cmd_dev_del(&ctx);
> +       else if (!strcmp(cmd, "stop"))
> +               ret =3D cmd_dev_stop(&ctx);
>         else if (!strcmp(cmd, "list")) {
>                 ctx.all =3D 1;
>                 ret =3D cmd_dev_list(&ctx);
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftes=
ts/ublk/kublk.h
> index 96c66b337bc0..cb757fd9bf9d 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -83,6 +83,7 @@ struct dev_ctx {
>         __u8 pi_offset;
>         __u8 csum_type;
>         __u8 tag_size;
> +       unsigned int    safe_stop:1;

Looks like it would make more sense to put this next to the other
bitfields (logging to no_ublk_fixed_fd). Not a big deal, though.

Best,
Caleb

>
>         int _evtfd;
>         int _shmid;
> diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/test=
ing/selftests/ublk/test_generic_16.sh
> new file mode 100755
> index 000000000000..e08af7b685c9
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_16.sh
> @@ -0,0 +1,57 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID=3D"generic_16"
> +ERR_CODE=3D0
> +
> +_prep_test "null" "stop --safe command"
> +
> +# Check if SAFE_STOP_DEV feature is supported
> +if ! _have_feature "SAFE_STOP_DEV"; then
> +       _cleanup_test "null"
> +       exit "$UBLK_SKIP_CODE"
> +fi
> +
> +# Test 1: stop --safe on idle device should succeed
> +dev_id=3D$(_add_ublk_dev -t null -q 2 -d 32)
> +_check_add_dev $TID $?
> +
> +# Device is idle (no openers), stop --safe should succeed
> +if ! ${UBLK_PROG} stop -n "${dev_id}" --safe; then
> +       echo "stop --safe on idle device failed unexpectedly!"
> +       ERR_CODE=3D255
> +fi
> +
> +# Clean up device
> +${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
> +udevadm settle
> +
> +# Test 2: stop --safe on device with active opener should fail
> +dev_id=3D$(_add_ublk_dev -t null -q 2 -d 32)
> +_check_add_dev $TID $?
> +
> +# Open device in background (dd reads indefinitely)
> +dd if=3D/dev/ublkb${dev_id} of=3D/dev/null bs=3D4k iflag=3Ddirect > /dev=
/null 2>&1 &
> +dd_pid=3D$!
> +
> +# Give dd time to start
> +sleep 0.2
> +
> +# Device has active opener, stop --safe should fail with -EBUSY
> +if ${UBLK_PROG} stop -n "${dev_id}" --safe 2>/dev/null; then
> +       echo "stop --safe on busy device succeeded unexpectedly!"
> +       ERR_CODE=3D255
> +fi
> +
> +# Kill dd and clean up
> +kill $dd_pid 2>/dev/null
> +wait $dd_pid 2>/dev/null
> +
> +# Now device should be idle, regular delete should work
> +${UBLK_PROG} del -n "${dev_id}"
> +udevadm settle
> +
> +_cleanup_test "null"
> +_show_result $TID $ERR_CODE
> --
> 2.39.5 (Apple Git-154)
>
