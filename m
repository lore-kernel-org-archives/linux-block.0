Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC3DC77B73
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 02:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjD1CQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbjD1CQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 22:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBD269D
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 19:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682648172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qch3McGCO32p9hg5cFGUBb6abdq/X48vj4hGusdtL/k=;
        b=i4Aq5Jp7OOKhzNzSHJGGLkbVhSYPxzt9Sda1tPTC6Rb0aB+8c5OgX3n8I/OCe3W3MKhOdt
        HMRNgAsuRORGwo0Kws8Qh5I8rMlThwLRr1KW/3zU+IEhw7b2KEFkp51Rih0rFp6IQp/hvM
        F58PZ9x+M/C6kbqkctVXm2n3WrDGv1w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-nVu2qYSgOGOcOz7_uUgPsA-1; Thu, 27 Apr 2023 22:16:08 -0400
X-MC-Unique: nVu2qYSgOGOcOz7_uUgPsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902CB29A9CA0;
        Fri, 28 Apr 2023 02:16:08 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18202C15BA0;
        Fri, 28 Apr 2023 02:16:04 +0000 (UTC)
Date:   Fri, 28 Apr 2023 10:16:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH blktests 1/2] src/miniublk: add user recovery
Message-ID: <ZEssYN8JjlbLefyj@ovpn-8-24.pek2.redhat.com>
References: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
 <20230427103242.31361-2-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427103242.31361-2-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 27, 2023 at 06:32:41PM +0800, Ziyang Zhang wrote:
> We are going to test ublk's user recovery feature so add support in
> miniublk.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> ---
>  src/miniublk.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 198 insertions(+), 9 deletions(-)
> 
> diff --git a/src/miniublk.c b/src/miniublk.c
> index fe10291..558bb7b 100644
> --- a/src/miniublk.c
> +++ b/src/miniublk.c
> @@ -74,6 +74,7 @@ struct ublk_tgt_ops {
>  	int (*queue_io)(struct ublk_queue *, int tag);
>  	void (*tgt_io_done)(struct ublk_queue *,
>  			int tag, const struct io_uring_cqe *);
> +	int (*recover_tgt)(struct ublk_dev *);
>  };
>  
>  struct ublk_tgt {
> @@ -372,6 +373,29 @@ static int ublk_ctrl_get_params(struct ublk_dev *dev,
>  	return __ublk_ctrl_cmd(dev, &data);
>  }
>  
> +static int ublk_ctrl_start_user_recover(struct ublk_dev *dev)
> +{
> +	struct ublk_ctrl_cmd_data data = {
> +		.cmd_op	= UBLK_CMD_START_USER_RECOVERY,
> +		.flags	= 0,
> +	};
> +
> +	return __ublk_ctrl_cmd(dev, &data);
> +}
> +
> +static int ublk_ctrl_end_user_recover(struct ublk_dev *dev,
> +		int daemon_pid)
> +{
> +	struct ublk_ctrl_cmd_data data = {
> +		.cmd_op	= UBLK_CMD_END_USER_RECOVERY,
> +		.flags	= CTRL_CMD_HAS_DATA,
> +	};
> +
> +	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
> +
> +	return __ublk_ctrl_cmd(dev, &data);
> +}
> +
>  static const char *ublk_dev_state_desc(struct ublk_dev *dev)
>  {
>  	switch (dev->dev_info.state) {
> @@ -379,6 +403,8 @@ static const char *ublk_dev_state_desc(struct ublk_dev *dev)
>  		return "DEAD";
>  	case UBLK_S_DEV_LIVE:
>  		return "LIVE";
> +	case UBLK_S_DEV_QUIESCED:
> +		return "QUIESCED";
>  	default:
>  		return "UNKNOWN";
>  	};
> @@ -550,9 +576,12 @@ static int ublk_dev_prep(struct ublk_dev *dev)
>  		goto fail;
>  	}
>  
> -	if (dev->tgt.ops->init_tgt)
> +	if (dev->dev_info.state != UBLK_S_DEV_QUIESCED && dev->tgt.ops->init_tgt)
>  		ret = dev->tgt.ops->init_tgt(dev);
>  
> +	else if (dev->dev_info.state == UBLK_S_DEV_QUIESCED && dev->tgt.ops->recover_tgt)
> +		ret = dev->tgt.ops->recover_tgt(dev);
> +
>  	return ret;
>  fail:
>  	close(dev->fds[0]);
> @@ -831,7 +860,7 @@ static void ublk_set_parameters(struct ublk_dev *dev)
>  				dev->dev_info.dev_id, ret);
>  }
>  
> -static int ublk_start_daemon(struct ublk_dev *dev)
> +static int ublk_start_daemon(struct ublk_dev *dev, bool recovery)
>  {
>  	int ret, i;
>  	void *thread_ret;
> @@ -853,12 +882,22 @@ static int ublk_start_daemon(struct ublk_dev *dev)
>  				&dev->q[i]);
>  	}
>  
> -	ublk_set_parameters(dev);
>  
>  	/* everything is fine now, start us */
> -	ret = ublk_ctrl_start_dev(dev, getpid());
> -	if (ret < 0)
> -		goto fail;
> +	if (recovery) {
> +		ret = ublk_ctrl_end_user_recover(dev, getpid());
> +		if (ret < 0) {
> +			ublk_err("%s: ublk_ctrl_end_user_recover failed: %d\n", __func__, ret);
> +			goto fail;
> +		}
> +	} else {
> +		ublk_set_parameters(dev);
> +		ret = ublk_ctrl_start_dev(dev, getpid());
> +		if (ret < 0) {
> +			ublk_err("%s: ublk_ctrl_start_dev failed: %d\n", __func__, ret);
> +			goto fail;
> +		}
> +	}
>  
>  	ublk_ctrl_get_info(dev);
>  	ublk_ctrl_dump(dev, true);
> @@ -880,6 +919,7 @@ static int cmd_dev_add(int argc, char *argv[])
>  		{ "number",		1,	NULL, 'n' },
>  		{ "queues",		1,	NULL, 'q' },
>  		{ "depth",		1,	NULL, 'd' },
> +		{ "recovery",		1,	NULL, 'r' },
>  		{ "debug_mask",	1,	NULL, 0},
>  		{ "quiet",	0,	NULL, 0},
>  		{ NULL }
> @@ -891,8 +931,9 @@ static int cmd_dev_add(int argc, char *argv[])
>  	const char *tgt_type = NULL;
>  	int dev_id = -1;
>  	unsigned nr_queues = 2, depth = UBLK_QUEUE_DEPTH;
> +	int user_recovery = 0;
>  
> -	while ((opt = getopt_long(argc, argv, "-:t:n:d:q:",
> +	while ((opt = getopt_long(argc, argv, "-:t:n:d:q:r:",
>  				  longopts, &option_idx)) != -1) {
>  		switch (opt) {
>  		case 'n':
> @@ -907,6 +948,9 @@ static int cmd_dev_add(int argc, char *argv[])
>  		case 'd':
>  			depth = strtol(optarg, NULL, 10);
>  			break;
> +		case 'r':
> +			user_recovery = strtol(optarg, NULL, 10);
> +			break;
>  		case 0:
>  			if (!strcmp(longopts[option_idx].name, "debug_mask"))
>  				ublk_dbg_mask = strtol(optarg, NULL, 16);
> @@ -942,6 +986,8 @@ static int cmd_dev_add(int argc, char *argv[])
>  	info->dev_id = dev_id;
>          info->nr_hw_queues = nr_queues;
>          info->queue_depth = depth;
> +	if (user_recovery)
> +		info->flags |= UBLK_F_USER_RECOVERY;
>  	dev->tgt.ops = ops;
>  	dev->tgt.argc = argc;
>  	dev->tgt.argv = argv;
> @@ -953,7 +999,95 @@ static int cmd_dev_add(int argc, char *argv[])
>  		goto fail;
>  	}
>  
> -	ret = ublk_start_daemon(dev);
> +	ret = ublk_start_daemon(dev, false);
> +	if (ret < 0) {
> +		ublk_err("%s: can't start daemon id %d, type %s\n",
> +				__func__, dev_id, tgt_type);
> +		goto fail_del;
> +	}
> +
> +fail_del:
> +	ublk_ctrl_del_dev(dev);
> +fail:
> +	ublk_ctrl_deinit(dev);
> +	return ret;
> +}
> +
> +static int cmd_dev_recover(int argc, char *argv[])
> +{
> +	static const struct option longopts[] = {
> +		{ "type",		1,	NULL, 't' },
> +		{ "number",		1,	NULL, 'n' },
> +		{ "debug_mask",	1,	NULL, 0},
> +		{ "quiet",	0,	NULL, 0},
> +		{ NULL }
> +	};
> +	const struct ublk_tgt_ops *ops;
> +	struct ublksrv_ctrl_dev_info *info;
> +	struct ublk_dev *dev;
> +	int ret, option_idx, opt;
> +	const char *tgt_type = NULL;
> +	int dev_id = -1;
> +
> +	while ((opt = getopt_long(argc, argv, "-:t:n:d:q:",
> +				  longopts, &option_idx)) != -1) {
> +		switch (opt) {
> +		case 'n':
> +			dev_id = strtol(optarg, NULL, 10);
> +			break;
> +		case 't':
> +			tgt_type = optarg;
> +			break;
> +		case 0:
> +			if (!strcmp(longopts[option_idx].name, "debug_mask"))
> +				ublk_dbg_mask = strtol(optarg, NULL, 16);
> +			if (!strcmp(longopts[option_idx].name, "quiet"))
> +				ublk_dbg_mask = 0;
> +			break;
> +		}
> +	}
> +
> +	optind = 0;
> +
> +	ops = ublk_find_tgt(tgt_type);
> +	if (!ops) {
> +		ublk_err("%s: no such tgt type, type %s\n",
> +				__func__, tgt_type);
> +		return -ENODEV;
> +	}
> +
> +	dev = ublk_ctrl_init();
> +	if (!dev) {
> +		ublk_err("%s: can't alloc dev id %d, type %s\n",
> +				__func__, dev_id, tgt_type);
> +		return -ENOMEM;
> +	}
> +
> +	info = &dev->dev_info;
> +	info->dev_id = dev_id;
> +	ret = ublk_ctrl_get_info(dev);
> +	if (ret < 0) {
> +		ublk_err("%s: can't get dev info from %d\n", __func__, dev_id);
> +		goto fail;
> +	}
> +
> +	ret = ublk_ctrl_get_params(dev, &dev->tgt.params);
> +	if (ret) {
> +		ublk_err("dev %d set basic parameter failed %d\n",
> +				dev->dev_info.dev_id, ret);
> +		goto fail;
> +	}
> +
> +	dev->tgt.ops = ops;
> +	dev->tgt.argc = argc;
> +	dev->tgt.argv = argv;
> +	ret = ublk_ctrl_start_user_recover(dev);
> +	if (ret < 0) {
> +		ublk_err("%s: can't start recovery for %d\n", __func__, dev_id);
> +		goto fail;
> +	}
> +
> +	ret = ublk_start_daemon(dev, true);
>  	if (ret < 0) {
>  		ublk_err("%s: can't start daemon id %d, type %s\n",
>  				__func__, dev_id, tgt_type);
> @@ -1125,7 +1259,10 @@ static int cmd_dev_help(int argc, char *argv[])
>  	printf("\t -a delete all devices -n delete specified device\n");
>  	printf("%s list [-n dev_id] -a \n", argv[0]);
>  	printf("\t -a list all devices, -n list specified device, default -a \n");
> -
> +	printf("%s recover -t {null|loop} [-n dev_id] \n",
> +			argv[0]);
> +	printf("\t -t loop -f backing_file \n");
> +	printf("\t -t null\n");
>  	return 0;
>  }
>  
> @@ -1150,6 +1287,12 @@ static int ublk_null_tgt_init(struct ublk_dev *dev)
>  	return 0;
>  }
>  
> +static int ublk_null_tgt_recover(struct ublk_dev *dev)
> +{
> +	dev->tgt.dev_size = dev->tgt.params.basic.dev_sectors << 9;
> +	return 0;
> +}
> +
>  static int ublk_null_queue_io(struct ublk_queue *q, int tag)
>  {
>  	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
> @@ -1313,11 +1456,54 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
>  	return 0;
>  }
>  
> +static int ublk_loop_tgt_recover(struct ublk_dev *dev)
> +{
> +	static const struct option lo_longopts[] = {
> +		{ "file",		1,	NULL, 'f' },
> +		{ NULL }
> +	};
> +	char **argv = dev->tgt.argv;
> +	int argc = dev->tgt.argc;
> +	char *file = NULL;
> +	int fd, opt;
> +
> +	while ((opt = getopt_long(argc, argv, "-:f:",
> +				  lo_longopts, NULL)) != -1) {
> +		switch (opt) {
> +		case 'f':
> +			file = strdup(optarg);
> +			break;
> +		}
> +	}
> +
> +	ublk_dbg(UBLK_DBG_DEV, "%s: file %s\n", __func__, file);
> +
> +	if (!file)
> +		return -EINVAL;
> +
> +	fd = open(file, O_RDWR);
> +	if (fd < 0) {
> +		ublk_err( "%s: backing file %s can't be opened\n",
> +				__func__, file);
> +		return -EBADF;
> +	}
> +
> +	if (fcntl(fd, F_SETFL, O_DIRECT))
> +		ublk_log("%s: ublk-loop fallback to buffered IO\n", __func__);
> +
> +	dev->tgt.dev_size = dev->tgt.params.basic.dev_sectors << 9;

miniublk doesn't support parameter serialization, so you have to pass file
to 'recover' command.

This way could cause trouble, what if size of the new file is less than
dev->tgt.params.basic.dev_sectors? what if different block size used?

From test purpose, it might be fine to allow different backing file used
for recovery, but the related parameters have to keep same, such as
device size and block size, given ublk driver doesn't support to
change these parameters after starting up.

Thanks,
Ming

