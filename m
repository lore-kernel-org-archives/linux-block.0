Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717D256C67
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914231; cv=none; b=Nm/g+c7HnOrqhrAv8H9jCtDmPmmolFix0CEocRSuTRxj+ZpQGe4PFil/akslFdCAxBQoR44cl1JuS2yFWcXztyuaHxJqcXlibVZnT/EEuxdc9fQLKnspfUAEaoqyZqE53tbe6UDX31R0M5Gse8pqyhA5u3tv+EPf33W84EhY+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914231; c=relaxed/simple;
	bh=7YXfrb1IMNDm10btXjzRW0/4fEd9Io/XI8pkM+XdNQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGFQc93imqREewp0YdgMpbmvNuQBlWFb/pr6emK+p2QTYYlYaBD0E+VG9vUsBHB+HNchIwm/KEyn47zcVwLsjLhl93YjnrRAtnQRR8Sn263TtdmpuMHd1whfK00OeRkx3FChWMw8HZGRa5K4VSoE6fwRdGFyDC+V2BG0iD5ANws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UmaERa8o; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UmaERa8o"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-30549dacd53so978988a91.1
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744914228; x=1745519028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jM23ivSjGcZZ90bBhh5nO3DMfT0UOaC77xgoHCZkLNA=;
        b=UmaERa8oNKgglkzso7F4i0F86/rD4uNp+CqHOjqFJdPg9M+3G8ZV+lpz669Uts0B7/
         CcE54Hlz+T4x2hmkqJ9dPNrBIGmiFgNQYB9307o3+szwcKjMvgkx4pwu9nrlBCeRkcGT
         FS3nL2MN4JVqYVoffBopcotoAa3a0/TIqpHNEFta7dQeO7208b1CzFBdzvx+259+UNYT
         lyHmvsJpjFwqUKi7gcD/n1F8Ol6xhxmdUXaoIKgio6XYUnyf+HnlSQGqUFSH6AdOYBD/
         goU7/V7FZbIhOgc7dtHNGAxzKBZwcyCiJd5iKfsUB68N4GmlOWBRlt80ROWzhX7MknW2
         K1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744914228; x=1745519028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM23ivSjGcZZ90bBhh5nO3DMfT0UOaC77xgoHCZkLNA=;
        b=gGrggtQjcGk2Y0yFSNUZ3ZmspPeljkdkDhXzbu0pWWIW77aTGkv0plpHZVr6Pc7l1u
         YpwaKvexS0NvN3itXGOGO9gssCkcXlYTeADYKDFk+nubdmYunewH/IJzKjYrfJYixgsT
         5QgPp7aB5QsojdwCX3HOERB9FViKsk0+jpY0BypXwzpbWgm+S+9C4Ip9RLE+iDUoqkNw
         iQWLNIk+sM440ADFrMjk8TKvVnYQEi4zDjs62/wTmTtDkdUAuuBin6inLrA9CGF+mm0l
         4HY8UOAE59EcIQ84Eg+3DafXW2luO9G6KKtTd3E4/rJLIasW8fTp/6iulfjI7uxx+tFQ
         bTmg==
X-Gm-Message-State: AOJu0YwSylwcMwCAT14Q4b1/L6NjdhX9AuABpy2AbUX4GVYCj+3zwYUQ
	ryFRSS90IlTs76d3rQ66FyCaoMtobyYOjc1kqSxOC+GG6krmfYNAhNJf5P75G7Iu9ifm/9VTHAb
	5j/9AU5tl/NU4tZN8ADq04Y/Ahnkz7mqBFazANnDABaziDLHN
X-Gm-Gg: ASbGncsB8Mb3W3TZZ1HB2avppTQylyph3tUVQ0I02eOBEUOeVjO/2n4M8UJQaykymgI
	qyW5bRg2TKnxN4UyTpXaBGYyqLhSJPGS5NjnxtEbYLqM+rRyNhPEeT3lXYX8UYHZKL5b0IIH3kS
	FaVFVKXdnMhBh89HIhDgVvA5PMcWZ2fbBAi4XAaQRtvSNxm8k08jDgDR6IoVbHU30G2Yo0Qt/0w
	Ux371Es4/XHOsX0zr0W/O6N9VhlPvPs5hNzu5sgROC39wmawCpPF3BfiIgqsd2UX6Yssk88anMT
	lbkwtwWPQ49XpNLdHmIPcpTCvuHYhEk=
X-Google-Smtp-Source: AGHT+IFQ8kAmfGm2QEN+u/5CLicSR+hbo3+RvTsxBPQSXFCcqxlnMXc9WXmw2BV6HcLrv2vs/A7SP8Q7ibhg
X-Received: by 2002:a17:90b:58c8:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-30879c02c19mr1149914a91.12.1744914228173;
        Thu, 17 Apr 2025 11:23:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-308613a72b8sm273363a91.11.2025.04.17.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:23:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 68CA934023F;
	Thu, 17 Apr 2025 12:23:47 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5B64AE40371; Thu, 17 Apr 2025 12:23:47 -0600 (MDT)
Date: Thu, 17 Apr 2025 12:23:47 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	csander@purestorage.com
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-ID: <aAFHMx/HopIv9DeU@dev-ushankar.dev.purestorage.com>
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>

On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
> 
> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> ublk block device to be resized on-the-fly.

Many of the other parameters in ublk_params/ublksrv_ctrl_dev_info could
also feasibly be changed after initial device creation/start. Is it
possible to design the API in a way so that we don't have to have one
command per parameter?

> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
> command.
> 
> Signed-off-by: Omri Mann <omri@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 +++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..128f094efbad 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>          | UBLK_F_CMD_IOCTL_ENCODE \
>          | UBLK_F_USER_COPY \
>          | UBLK_F_ZONED \
> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
> +        | UBLK_F_UPDATE_SIZE)
> 
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>          | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
> ublksrv_ctrl_cmd *header)
>      return 0;
>  }
> 
> +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct
> ublksrv_ctrl_cmd *header)
> +{
> +    struct ublk_param_basic *p = &ub->params.basic;
> +    u64 new_size = header->data[0];
> +
> +    mutex_lock(&ub->mutex);
> +    p->dev_sectors = new_size;
> +    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +    mutex_unlock(&ub->mutex);
> +}
>  /*
>   * All control commands are sent via /dev/ublk-control, so we have to check
>   * the destination device's permission
> @@ -3152,6 +3163,7 @@ static int ublk_ctrl_uring_cmd_permission(struct
> ublk_device *ub,
>      case UBLK_CMD_SET_PARAMS:
>      case UBLK_CMD_START_USER_RECOVERY:
>      case UBLK_CMD_END_USER_RECOVERY:
> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
>          mask = MAY_READ | MAY_WRITE;
>          break;
>      default:
> @@ -3243,6 +3255,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd
> *cmd,
>      case UBLK_CMD_END_USER_RECOVERY:
>          ret = ublk_ctrl_end_recovery(ub, header);
>          break;
> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
> +        ublk_ctrl_set_size(ub, header);
> +        ret = 0;
> +        break;
>      default:
>          ret = -EOPNOTSUPP;
>          break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 583b86681c93..587a54b3cfe1 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -51,6 +51,8 @@
>      _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_DEL_DEV_ASYNC    \
>      _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_UPDATE_SIZE        \
> +    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> 
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
> @@ -211,6 +213,11 @@
>   */
>  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
> 
> +/*
> + * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
> + */
> +#define UBLK_F_UPDATE_SIZE         (1ULL << 10)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD    0
>  #define UBLK_S_DEV_LIVE    1
> -- 
> 2.43.0
> 
> 
