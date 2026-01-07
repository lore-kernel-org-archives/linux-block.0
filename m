Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47249309F13
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792061; cv=none; b=tsdmZY3qKKgr4eoYEd/oBq/NiFsao3lWTNY9j03UgLeGzQbZsGeYrLNG7CKi9WqL5g2yLCqjDC/Nf8Z3FbsQWczJpW7gkmyOR3c+g90mas6mmWV58hc+2GLtmi3hMuQ5OmpTBdBDO9crTeE/mEyltBog1Z48xQPRxoykVPooEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792061; c=relaxed/simple;
	bh=I9u6uhJEkCVlDWPAWwq50eRCabGLHHyLrj1g3ffrc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWMxJOVQdzBtOFZwz8INK5EVS02pnEIW5IXgmRtvciUfFD9MlSJ8bsodl5Li2FxYy7qi7K2DzaQL3pHO7ykVvXq6pHb5X3WGFLbCmA7cZkis4dcg14i5gCW5C1Kc1Mm49XYqlcrT9tKVdmc/TfDjw9/I3Toy6YMh/4qztA/NhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SloeC6tv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SloeC6tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767792058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpSNqim9KVt1jqi29b9wk9JrPddrzLYTR+V1mj2DHN4=;
	b=SloeC6tvTKHeA4vm8BrtVpThxmOGAg5LeN4qplCThFGByZ4p7J4cKoj+i5yOq5Sq5Su/1e
	8nkDfGkpeen2EvZPnbpYQI6o0iSP7bEVAu8clMBCYv/7gEYr9UmFf+JdzR3AKUM3UQ/O7f
	1PresQ2A78e4qKDN51K15PHGU78xvSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-hJb1n06pPO-3PkC613dN-Q-1; Wed,
 07 Jan 2026 08:20:53 -0500
X-MC-Unique: hJb1n06pPO-3PkC613dN-Q-1
X-Mimecast-MFC-AGG-ID: hJb1n06pPO-3PkC613dN-Q_1767792051
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF2A81954237;
	Wed,  7 Jan 2026 13:20:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4B919560A7;
	Wed,  7 Jan 2026 13:20:47 +0000 (UTC)
Date: Wed, 7 Jan 2026 21:20:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH v4 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Message-ID: <aV5djH9ueztZm49y@fedora>
References: <20260106203333.30589-1-yoav@nvidia.com>
 <20260106203333.30589-3-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Oqghg8yZypsy5Xnj"
Content-Disposition: inline
In-Reply-To: <20260106203333.30589-3-yoav@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--Oqghg8yZypsy5Xnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 10:33:33PM +0200, Yoav Cohen wrote:
> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> device if there are no active openers for the ublk block device.
> If the device is busy, the command returns -EBUSY instead of
> disrupting active clients. This allows safe, non-destructive stopping.
> 
> Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV
> feature flag.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c             | 44 ++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h        |  9 +++++-
>  tools/testing/selftests/ublk/kublk.c |  1 +
>  3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2d5602ef05cc..fc8b87902f8f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -54,6 +54,7 @@
>  #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
>  #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> +#define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
>  
>  #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> @@ -73,7 +74,8 @@
>  		| UBLK_F_AUTO_BUF_REG \
>  		| UBLK_F_QUIESCE \
>  		| UBLK_F_PER_IO_DAEMON \
> -		| UBLK_F_BUF_REG_OFF_DAEMON)
> +		| UBLK_F_BUF_REG_OFF_DAEMON \
> +		| UBLK_F_SAFE_STOP_DEV)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
> @@ -239,6 +241,8 @@ struct ublk_device {
>  	struct delayed_work	exit_work;
>  	struct work_struct	partition_scan_work;
>  
> +	bool			block_open; /* protected by open_mutex */
> +
>  	struct ublk_queue       *queues[];
>  };
>  
> @@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
>  			return -EPERM;
>  	}
>  
> +	if (ub->block_open)
> +		return -EBUSY;
> +
>  	return 0;
>  }
>  
> @@ -3188,7 +3195,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>  	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
>  		UBLK_F_URING_CMD_COMP_IN_TASK |
>  		UBLK_F_PER_IO_DAEMON |
> -		UBLK_F_BUF_REG_OFF_DAEMON;
> +		UBLK_F_BUF_REG_OFF_DAEMON |
> +		UBLK_F_SAFE_STOP_DEV;
>  
>  	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
>  	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
> @@ -3309,6 +3317,34 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
>  	ublk_stop_dev(ub);
>  }
>  
> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> +{
> +	struct gendisk *disk;
> +	int ret = 0;
> +
> +	disk = ublk_get_disk(ub);
> +	if (!disk)
> +		return -ENODEV;
> +
> +	mutex_lock(&disk->open_mutex);
> +	if (disk_openers(disk) > 0) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +	ub->block_open = true;
> +	/* release open_mutex as del_gendisk() will reacquire it */
> +	mutex_unlock(&disk->open_mutex);
> +
> +	ublk_ctrl_stop_dev(ub);
> +	goto out;
> +
> +unlock:
> +	mutex_unlock(&disk->open_mutex);
> +out:
> +	ublk_put_disk(disk);
> +	return ret;
> +}
> +
>  static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
>  		const struct ublksrv_ctrl_cmd *header)
>  {
> @@ -3704,6 +3740,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>  	case UBLK_CMD_END_USER_RECOVERY:
>  	case UBLK_CMD_UPDATE_SIZE:
>  	case UBLK_CMD_QUIESCE_DEV:
> +	case UBLK_CMD_TRY_STOP_DEV:
>  		mask = MAY_READ | MAY_WRITE;
>  		break;
>  	default:
> @@ -3817,6 +3854,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>  	case UBLK_CMD_QUIESCE_DEV:
>  		ret = ublk_ctrl_quiesce_dev(ub, header);
>  		break;
> +	case UBLK_CMD_TRY_STOP_DEV:
> +		ret = ublk_ctrl_try_stop_dev(ub);
> +		break;
>  	default:
>  		ret = -EOPNOTSUPP;
>  		break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index ec77dabba45b..9daa8ab372f0 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -55,7 +55,8 @@
>  	_IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_QUIESCE_DEV		\
>  	_IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> -
> +#define UBLK_U_CMD_TRY_STOP_DEV		\
> +	_IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
>   * running out of feature flags
> @@ -311,6 +312,12 @@
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>  
> +/*
> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> + * allows stopping the device only if there are no openers.
> + */
> +#define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD	0
>  #define UBLK_S_DEV_LIVE	1
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 185ba553686a..6739e28c4059 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1454,6 +1454,7 @@ static int cmd_dev_get_features(void)
>  		FEAT_NAME(UBLK_F_QUIESCE),
>  		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
>  		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
> +		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),

We usually split driver and test code into different patches, and the patch
looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

But we usually separate test code from driver change, also new feature needs
selftest code for verifying, can you move `+FEAT_NAME(UBLK_F_SAFE_STOP_DEV)` into
the attached selftest patch and post all 3 in v5?



Thanks,
Ming

--Oqghg8yZypsy5Xnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-selftests-ublk-add-stop-command-with-safe-option.patch"

From 3574f73d3098dc56f63b7c2b1097c0f090c4ad3c Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 7 Jan 2026 13:01:39 +0000
Subject: [PATCH] selftests: ublk: add stop command with --safe option

Add 'stop' subcommand to kublk utility that uses the new
UBLK_CMD_TRY_STOP_DEV command when --safe option is specified.
This allows stopping a device only if it has no active openers,
returning -EBUSY otherwise.

Also add test_generic_16.sh to test the new functionality.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 52 +++++++++++++++++
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_16.sh | 57 +++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 06ba6fde098d..e9614f77b809 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -23,6 +23,7 @@ TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_15.sh
+TEST_PROGS += test_generic_16.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6739e28c4059..1a563705caa0 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -107,6 +107,15 @@ static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int ublk_ctrl_try_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_TRY_STOP_DEV,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
 static int ublk_ctrl_start_dev(struct ublk_dev *dev,
 		int daemon_pid)
 {
@@ -1392,6 +1401,42 @@ static int cmd_dev_del(struct dev_ctx *ctx)
 	return 0;
 }
 
+static int cmd_dev_stop(struct dev_ctx *ctx)
+{
+	int number = ctx->dev_id;
+	struct ublk_dev *dev;
+	int ret;
+
+	if (number < 0) {
+		ublk_err("%s: device id is required\n", __func__);
+		return -EINVAL;
+	}
+
+	dev = ublk_ctrl_init();
+	dev->dev_info.dev_id = number;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0)
+		goto fail;
+
+	if (ctx->safe_stop) {
+		ret = ublk_ctrl_try_stop_dev(dev);
+		if (ret < 0)
+			ublk_err("%s: try_stop dev %d failed ret %d\n",
+					__func__, number, ret);
+	} else {
+		ret = ublk_ctrl_stop_dev(dev);
+		if (ret < 0)
+			ublk_err("%s: stop dev %d failed ret %d\n",
+					__func__, number, ret);
+	}
+
+fail:
+	ublk_ctrl_deinit(dev);
+
+	return ret;
+}
+
 static int __cmd_dev_list(struct dev_ctx *ctx)
 {
 	struct ublk_dev *dev = ublk_ctrl_init();
@@ -1582,6 +1627,8 @@ static int cmd_dev_help(char *exe)
 
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n\n");
+	printf("%s stop -n dev_id [--safe]\n", exe);
+	printf("\t --safe only stop if device has no active openers\n\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
@@ -1613,6 +1660,7 @@ int main(int argc, char *argv[])
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "safe",		0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1697,6 +1745,8 @@ int main(int argc, char *argv[])
 				ctx.per_io_tasks = 1;
 			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
 				ctx.no_ublk_fixed_fd = 1;
+			if (!strcmp(longopts[option_idx].name, "safe"))
+				ctx.safe_stop = 1;
 			break;
 		case '?':
 			/*
@@ -1764,6 +1814,8 @@ int main(int argc, char *argv[])
 		}
 	} else if (!strcmp(cmd, "del"))
 		ret = cmd_dev_del(&ctx);
+	else if (!strcmp(cmd, "stop"))
+		ret = cmd_dev_stop(&ctx);
 	else if (!strcmp(cmd, "list")) {
 		ctx.all = 1;
 		ret = cmd_dev_list(&ctx);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8a83b90ec603..4b6b4992f78e 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -78,6 +78,7 @@ struct dev_ctx {
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	unsigned int	safe_stop:1;
 
 	int _evtfd;
 	int _shmid;
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
new file mode 100755
index 000000000000..e08af7b685c9
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_16"
+ERR_CODE=0
+
+_prep_test "null" "stop --safe command"
+
+# Check if SAFE_STOP_DEV feature is supported
+if ! _have_feature "SAFE_STOP_DEV"; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# Test 1: stop --safe on idle device should succeed
+dev_id=$(_add_ublk_dev -t null -q 2 -d 32)
+_check_add_dev $TID $?
+
+# Device is idle (no openers), stop --safe should succeed
+if ! ${UBLK_PROG} stop -n "${dev_id}" --safe; then
+	echo "stop --safe on idle device failed unexpectedly!"
+	ERR_CODE=255
+fi
+
+# Clean up device
+${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+udevadm settle
+
+# Test 2: stop --safe on device with active opener should fail
+dev_id=$(_add_ublk_dev -t null -q 2 -d 32)
+_check_add_dev $TID $?
+
+# Open device in background (dd reads indefinitely)
+dd if=/dev/ublkb${dev_id} of=/dev/null bs=4k iflag=direct > /dev/null 2>&1 &
+dd_pid=$!
+
+# Give dd time to start
+sleep 0.2
+
+# Device has active opener, stop --safe should fail with -EBUSY
+if ${UBLK_PROG} stop -n "${dev_id}" --safe 2>/dev/null; then
+	echo "stop --safe on busy device succeeded unexpectedly!"
+	ERR_CODE=255
+fi
+
+# Kill dd and clean up
+kill $dd_pid 2>/dev/null
+wait $dd_pid 2>/dev/null
+
+# Now device should be idle, regular delete should work
+${UBLK_PROG} del -n "${dev_id}"
+udevadm settle
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
-- 
2.47.1


--Oqghg8yZypsy5Xnj--

