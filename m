Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794849420;
	b=bmyVER6amkL+nP/J/3Gzl6wMeOuyz/keqNgF+K/J/vLTSYFWYMCQx6hLL6b+hm5VsuT4
	 Cp3kHtoM0hx2ACWvaKYNcpP+//Y/7IxoRd8yRmPP8GDZIO+Yw/h6v4rWBPkQmTI+3nOI2
	 eNCml2v6dYbFrpP8f4581DKCW2rztwJaB8YOyDi5uwiq5Md4DPl8ZjLblSRfD7f5w80eY
	 YArJW3CeWS8OgZ3qCAE8ZAMSgsPKlTJwMwoGgjq+ryIYsvuPYG8xvvSF+YPs1KWoUp9e1
	 cuv33jD3MJU/SdC+nc0K/8sdWRuoa1KdKNJFOJJZKao9ZO3vs72Qb9XmKXO0sUD/N0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cvhlwTnVB5qObUR1donDWKQFcI5lhmN3ZPbArGLp5LQ=;
	b=xLBM5AZH4wqEb3D1PGpnR6423HJ6knN8xU0kjuaUn5u+eI/dchpxifXI15m+5IGDPH7+
	 U0ShEnP+EsNPbbCLmscs/2tvTigz5jorbmF2F+48FxiSSkEva4qfuGniRDCOpMYMMrAbT
	 ZycpH7n03hIOalmhiVsPylO2uLAEh0XSYEEKPlOFhj5N65q72LaWzAAVFTwEFMu4hAeqW
	 g+vmBUrkM98w75Csvp7zKCJbujdO6jr+w/ASC/s6wYS+Rnkl2xXWmpypQJAxibAzEl91n
	 GGluPMMI73Jy5junLjwJQFNLotBYfOTipxn6/Fo9nZfj31qMk5PC/0SJbc6q++NuBSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muR038w6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595B606A89C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 17:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E595B606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muR038w6
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so5448125a12.2
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 09:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794849418; cv=none;
        d=google.com; s=arc-20260327;
        b=cbhVR7ZaDr+HnmMFk4Hbm2u46FLSnRjox2JC6sPcjFG2fzdhTC2cPMv98tfoRCdslX
         wr70yFy+jv97k4xhZu4qqhQWKMu6imJCGcnNdd/ZYT0CK2qdeUCFIQWCUjIEIuKrgHRI
         A4a+VMdQQ7TrOrJkzJ3+WCHwRHfY3Cn4EvzH8YSW8gAGLRFrx/AgXLsxC6tg4+oBMDjp
         0kc9H/Mye9I1/3W8tYYAw3fHijuf9c/84nT613t4GtAM7Dn5XSqXgqpGzCirS0Sx/LAg
         D8Pe9/O23tAKQtXbF9lymQCqvI0dthRTRfQCuJ5MM1K+iTpIi9+vYo/AV9d6C1yU96MX
         4Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvhlwTnVB5qObUR1donDWKQFcI5lhmN3ZPbArGLp5LQ=;
        fh=ih5R4Cx49iraYsfpa9SpFDqriouc3Y6C1QrwqZ1W7XM=;
        b=Y9sOPbsFpFFA/WyVeQ8Jxwc+FIYwtKDCOsvscjywBdAe7hHRIfm8Zx5sdnXg6Sdyrp
         VSxbjzkbfDeFo0g0X0XGq4MoSeyWiVt/BjZVBIzhXbcUDjv06ZdnWUyH2FBOwb3n6Zfc
         jU3SBeJpG0qlgmb1F+Q/Np8iVlpAQ3LsxYj8AnaUMuWpkY5MeJwStV0GYiAzaWaRa0SO
         bR4FPvR1MoF/pVLwa8Y24tA3L9rmrRfIOfqmRkFRLyrXBl+FcM/8sRc4P5rAHN0WPjzd
         W6uQHyzZv/3o+lNul+bB2bOXqxIf9ODoBbdz6azyvtTIUme66tFg2xMxDki/Ashn783s
         MtZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794849418; x=1795454218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvhlwTnVB5qObUR1donDWKQFcI5lhmN3ZPbArGLp5LQ=;
        b=muR038w65/upa4T3A8TQUgAZPPu00HSp8IEYxLeziP5g7EOqEdvXR4kRn7l7HqC4oM
         V/H7jmVddckf4li4Y0IfO1NYwf6mTpnVcEibSiDpSUGa4rmH8J48GG/AdleQHZhCXsRY
         RKMQZVymvxJl7k97IWLEoqvjx7NjiZbQg2uAM4mR3pJQKz5WqOab8nzYhREPb/6gAZ9i
         pBA6UOQY1B36uqzP1y0SScadwu/L0Druqoe1fQdOxwb3sdGBUZ1ThrB2CqjVL4+PzHGX
         wt9TbJGmNBshQby+yMN9+pQ2Lz5tWQc68vsAD3w5jK3lYbmvcjKJb74HqwwAi+/L+rlV
         RvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849418; x=1795454218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvhlwTnVB5qObUR1donDWKQFcI5lhmN3ZPbArGLp5LQ=;
        b=xJLjNzoaUn0YLo/OMoyNyuKia41HDAQtYgph+wKFMRhRp4pQetAfFcR/urAo1E0l5R
         yjUomiHdtm3N1CHn9/LO9AWTIXmdx6V61tb3ZkxMYGw3nPvaezWxaMUxVSPY16d0171k
         GXSP5RdEpaT1S61kkj9QbcNzfX6cx+/zD3bGx0/l+ZqWj7ZJFYTdF+cWCSVBMj9WOP4G
         AmpuFpPJSeMMrmJzD7Y9oLICMMVtSmrc7ZhVBRkbBJVSBKozMW31y+uL2CtOAuFy19Yl
         knCT+dfdBSa9nMY80vX+9dK1fZppnIWctIvazaBG4JrGTZE32oMQbT3LwAUyWmdjRUY4
         wOqw==
X-Forwarded-Encrypted: i=1; AL+hErFy3k5lFKJYoyJqDdvlHbC9IjDJF9m+Au5+zhQFb5BRm1qaNDOh7Wbpm2Oaeqib/E3jpft4GmcqDprx0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iwg5fzlFjrz2SD9NsJuluIejX4NFty5F0tENCe1NzPG+xis/o
	cGmAFmTZiR6Rv4a/fDj0oKQ6JGJRcHmaBBuugU2AWDIswSrz1BGyiVLY3/KvPfedpSK3QkT7qY0
	u+rFCPZSA4rRThzlEE4l0rr7HEZjy1t0=
X-Gm-Gg: AYBFou2o656zFg2ff49oXT1wOWz2gx99TVEsgoaoXN2zgK65QfGTyYEf9EDe9UoHgsZ
	73Oo7d+YElWgrhOgQqWhGokGoOGzLBKuxhDOIYZHoPt8oN/DKWZAsX0TYKke8yZXCRKD6AIjpWM
	SmPMRdCty0Xj5sTwbTqY6mt3ZmJg4INUqoMRol1b7ITPwi4YSv81zvu0f/gy62ysJ7Usb6HW002
	wwqGJgf3rfVR14elm0Vm5w6niAAjfBqv0uDT1b+88EkLteahyTx9/6yuO43yEaRhE5nj37Nra2B
	5MJ3n2e2D5zAtH2Vo5ydZXgMBjyD1xiQISJA/RzsK33Hl4kJ671/51fYCy7u7Ut0JJTB43I9tkI
	7twe17S1khoo6dVgmsjAkQ8D6SFG0SiOFZJH7sKbGqOmVN1ZV/2Ue0jYB/mKzCDaAr8qymrGPBi
	sZydqcOLIHWUgBGQ0=
X-Received: by 2002:aa7:c258:0:b0:6b7:d69a:a3d3 with SMTP id
 4fb4d7f45d1cf-6b7d69aa8fbmr5089335a12.39.1794849418257; Mon, 16 Nov 2026
 09:16:58 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-34-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-34-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:16:46 +0100
X-Gm-Features: AclHuK_s2Kpb4OdbgPngYJl9gLHjfhlAmiJMqLtxRnpTDibz-Ni4SZJspSV9laM
Message-ID: <CAOQ4uxjJVgy-skUbbScfz=eAEATf=iMpqRHNshX=eKu3oiwnrA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 34/44] selftests/ovl: test data-only layers on
 pseudo filesystems
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
> Add tests that overlayfs refuses data-only layers on pseudo filesystems:
>
> - sysfs and procfs via the "::" separator in "lowerdir=3D"
> - sysfs and procfs via "datadir+" by path
> - sysfs and procfs via "datadir+" by file descriptor
> - tmpfs as data-only layer
> - sysfs as regular lower layer
>
> The last two must keep mounting.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../selftests/filesystems/overlayfs/.gitignore     |   1 +
>  .../selftests/filesystems/overlayfs/Makefile       |   1 +
>  .../filesystems/overlayfs/pseudo_datadir.c         | 131 +++++++++++++++=
++++++
>  3 files changed, 133 insertions(+)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/t=
ools/testing/selftests/filesystems/overlayfs/.gitignore
> index b343cc430051d..e1410fee2269d 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/.gitignore
> +++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
> @@ -3,3 +3,4 @@ dev_in_maps
>  set_layers_via_fds
>  idmapped_mounts
>  automount_in_layer
> +pseudo_datadir
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/too=
ls/testing/selftests/filesystems/overlayfs/Makefile
> index 382a59bda5e70..ace75f5627e0f 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -10,6 +10,7 @@ TEST_GEN_PROGS :=3D dev_in_maps
>  TEST_GEN_PROGS +=3D set_layers_via_fds
>  TEST_GEN_PROGS +=3D idmapped_mounts
>  TEST_GEN_PROGS +=3D automount_in_layer
> +TEST_GEN_PROGS +=3D pseudo_datadir
>
>  include ../../lib.mk
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir=
.c b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
> new file mode 100644
> index 0000000000000..3b59fd3e9f5c2
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "kselftest_harness.h"
> +#include "../wrappers.h"
> +
> +static int setup_tmp(void)
> +{
> +       if (unshare(CLONE_NEWNS))
> +               return -errno;
> +       if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
> +               return -errno;
> +       if (sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL))
> +               return -errno;
> +       if (mkdir("/tmp/lower", 0755) || mkdir("/tmp/data", 0755) ||
> +           mkdir("/tmp/merged", 0755))
> +               return -errno;
> +       return 0;
> +}
> +
> +/* Mount an overlayfs with the legacy "lowerdir=3D" option. */
> +static int mount_lowerdir(const char *lowerdir)
> +{
> +       char opts[256];
> +
> +       snprintf(opts, sizeof(opts), "lowerdir=3D%s", lowerdir);
> +       if (sys_mount("overlay", "/tmp/merged", "overlay", MS_RDONLY, opt=
s))
> +               return -errno;
> +       if (umount2("/tmp/merged", 0))
> +               return -errno;
> +       return 0;
> +}
> +
> +static int set_layer(int fd_context, const char *key, const char *path,
> +                    bool by_fd)
> +{
> +       int fd, ret =3D 0;
> +
> +       if (!by_fd) {
> +               if (sys_fsconfig(fd_context, FSCONFIG_SET_STRING, key, pa=
th, 0))
> +                       return -errno;
> +               return 0;
> +       }
> +
> +       fd =3D open(path, O_DIRECTORY | O_CLOEXEC);
> +       if (fd < 0)
> +               return -errno;
> +       if (sys_fsconfig(fd_context, FSCONFIG_SET_FD, key, NULL, fd))
> +               ret =3D -errno;
> +       close(fd);
> +       return ret;
> +}
> +
> +/* Create an overlayfs with "lowerdir+" and "datadir+" through fsconfig.=
 */
> +static int fsmount_layers(const char *lower, const char *data, bool by_f=
d)
> +{
> +       int fd_context, fd_mnt, ret;
> +
> +       fd_context =3D sys_fsopen("overlay", FSOPEN_CLOEXEC);
> +       if (fd_context < 0)
> +               return -errno;
> +
> +       ret =3D set_layer(fd_context, "lowerdir+", lower, by_fd);
> +       if (ret)
> +               goto out;
> +       ret =3D set_layer(fd_context, "datadir+", data, by_fd);
> +       if (ret)
> +               goto out;
> +
> +       if (sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0))=
 {
> +               ret =3D -errno;
> +               goto out;
> +       }
> +
> +       fd_mnt =3D sys_fsmount(fd_context, FSMOUNT_CLOEXEC, 0);
> +       if (fd_mnt < 0)
> +               ret =3D -errno;
> +       else
> +               close(fd_mnt);
> +out:
> +       close(fd_context);
> +       return ret;
> +}
> +
> +TEST(datadir_sysfs)
> +{
> +       ASSERT_EQ(setup_tmp(), 0);
> +
> +       EXPECT_EQ(mount_lowerdir("/tmp/lower::/sys/kernel"), -EINVAL);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/sys/kernel", false), -EI=
NVAL);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/sys/kernel", true), -EIN=
VAL);
> +}
> +
> +TEST(datadir_procfs)
> +{
> +       ASSERT_EQ(setup_tmp(), 0);
> +
> +       EXPECT_EQ(mount_lowerdir("/tmp/lower::/proc"), -EINVAL);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/proc", false), -EINVAL);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/proc", true), -EINVAL);
> +}
> +
> +TEST(datadir_tmpfs)
> +{
> +       ASSERT_EQ(setup_tmp(), 0);
> +
> +       EXPECT_EQ(mount_lowerdir("/tmp/lower::/tmp/data"), 0);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/tmp/data", false), 0);
> +       EXPECT_EQ(fsmount_layers("/tmp/lower", "/tmp/data", true), 0);
> +}
> +
> +TEST(lowerdir_sysfs)
> +{
> +       ASSERT_EQ(setup_tmp(), 0);
> +
> +       EXPECT_EQ(mount_lowerdir("/sys/kernel:/tmp/lower"), 0);
> +       EXPECT_EQ(mount_lowerdir("/sys/kernel::/tmp/data"), 0);
> +       EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", false), 0);
> +       EXPECT_EQ(fsmount_layers("/sys/kernel", "/tmp/data", true), 0);
> +}
> +
> +TEST_HARNESS_MAIN
>
> --
> 2.53.0
>
