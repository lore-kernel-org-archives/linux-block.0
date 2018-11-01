Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 1 Nov 2018 14:11:56 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/30] scsi: kill off the legacy IO path
Message-ID: <20181101211156.GE18005@vader>
References: <20181031175922.8849-1-axboe@kernel.dk>
 <20181031175922.8849-10-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181031175922.8849-10-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 31, 2018 at 11:59:01AM -0600, Jens Axboe wrote:
> Cc: linux-scsi@vger.kernel.org
> Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

A bunch of really trivial nitpicks below, only to prove that I read the
thing ;)

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  Documentation/scsi/scsi-parameters.txt |   5 -
>  drivers/scsi/Kconfig                   |  12 -
>  drivers/scsi/cxlflash/main.c           |   6 -
>  drivers/scsi/hosts.c                   |  29 +-
>  drivers/scsi/lpfc/lpfc_scsi.c          |   2 +-
>  drivers/scsi/qedi/qedi_main.c          |   3 +-
>  drivers/scsi/qla2xxx/qla_os.c          |  30 +-
>  drivers/scsi/scsi.c                    |   5 +-
>  drivers/scsi/scsi_debug.c              |   3 +-
>  drivers/scsi/scsi_error.c              |   2 +-
>  drivers/scsi/scsi_lib.c                | 603 ++-----------------------
>  drivers/scsi/scsi_priv.h               |   1 -
>  drivers/scsi/scsi_scan.c               |  10 +-
>  drivers/scsi/scsi_sysfs.c              |   8 +-
>  drivers/scsi/ufs/ufshcd.c              |   6 -
>  include/scsi/scsi_host.h               |  18 +-
>  include/scsi/scsi_tcq.h                |  14 +-
>  17 files changed, 77 insertions(+), 680 deletions(-)

> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 8794e54f43a9..3e2665c66bc4 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -857,13 +857,9 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  	}
>  
>  	if (ha->mqenable) {
> -		if (shost_use_blk_mq(vha->host)) {
> -			tag = blk_mq_unique_tag(cmd->request);
> -			hwq = blk_mq_unique_tag_to_hwq(tag);
> -			qpair = ha->queue_pair_map[hwq];
> -		} else if (vha->vp_idx && vha->qpair) {
> -			qpair = vha->qpair;
> -		}
> +		tag = blk_mq_unique_tag(cmd->request);
> +		hwq = blk_mq_unique_tag_to_hwq(tag);
> +		qpair = ha->queue_pair_map[hwq];
>  
>  		if (qpair)
>  			return qla2xxx_mqueuecommand(host, cmd, qpair);
> @@ -3153,7 +3149,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto probe_failed;
>  	}
>  
> -	if (ha->mqenable && shost_use_blk_mq(host)) {
> +	if (ha->mqenable) {
>  		/* number of hardware queues supported by blk/scsi-mq*/
>  		host->nr_hw_queues = ha->max_qpairs;
>  
> @@ -3265,25 +3261,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	    base_vha->mgmt_svr_loop_id, host->sg_tablesize);
>  
>  	if (ha->mqenable) {
> -		bool mq = false;
>  		bool startit = false;
>  
> -		if (QLA_TGT_MODE_ENABLED()) {
> -			mq = true;
> +		if (QLA_TGT_MODE_ENABLED())
>  			startit = false;
> -		}
>  
> -		if ((ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED) &&
> -		    shost_use_blk_mq(host)) {
> -			mq = true;
> +		if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
>  			startit = true;
> -		}

This could just be

		startit = (QLA_TGT_MODE_ENABLED() ||
			   (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED));

>  
> -		if (mq) {
> -			/* Create start of day qpairs for Block MQ */
> -			for (i = 0; i < ha->max_qpairs; i++)
> -				qla2xxx_create_qpair(base_vha, 5, 0, startit);
> -		}
> +		/* Create start of day qpairs for Block MQ */
> +		for (i = 0; i < ha->max_qpairs; i++)
> +			qla2xxx_create_qpair(base_vha, 5, 0, startit);
>  	}
>  
>  	if (ha->flags.running_gold_fw)
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index fc1356d101b0..99db3f4316b5 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -780,11 +780,8 @@ MODULE_LICENSE("GPL");
>  module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
>  
> -#ifdef CONFIG_SCSI_MQ_DEFAULT
> +/* Kill module parameter */

Is this a leftover todo comment for yourself, or a note for the future?
If the latter, I think it could be clearer.

>  bool scsi_use_blk_mq = true;
> -#else
> -bool scsi_use_blk_mq = false;
> -#endif
>  module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | S_IRUGO);
>  
>  static int __init init_scsi(void)
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 60bcc6df97a9..4740f1e9dd17 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -5881,8 +5881,7 @@ static int sdebug_driver_probe(struct device *dev)
>  	}
>  	/* Decide whether to tell scsi subsystem that we want mq */
>  	/* Following should give the same answer for each host */
> -	if (shost_use_blk_mq(hpnt))
> -		hpnt->nr_hw_queues = submit_queues;
> +	hpnt->nr_hw_queues = submit_queues;
>  
>  	sdbg_host->shost = hpnt;
>  	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index c736d61b1648..fff128aa9ec2 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -308,7 +308,7 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
>  		 * error handler. In that case we can return immediately as no
>  		 * further action is required.
>  		 */
> -		if (req->q->mq_ops && !blk_mq_mark_complete(req))
> +		if (!blk_mq_mark_complete(req))
>  			return rtn;
>  		if (scsi_abort_command(scmd) != SUCCESS) {
>  			set_host_byte(scmd, DID_TIME_OUT);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8b0345924a92..651be30ba96a 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c

> @@ -687,37 +601,22 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  		destroy_rcu_head(&cmd->rcu);
>  	}
>  
> -	if (req->mq_ctx) {
> -		/*
> -		 * In the MQ case the command gets freed by __blk_mq_end_request,
> -		 * so we have to do all cleanup that depends on it earlier.
> -		 *
> -		 * We also can't kick the queues from irq context, so we
> -		 * will have to defer it to a workqueue.
> -		 */
> -		scsi_mq_uninit_cmd(cmd);
> -
> -		__blk_mq_end_request(req, error);
> -
> -		if (scsi_target(sdev)->single_lun ||
> -		    !list_empty(&sdev->host->starved_list))
> -			kblockd_schedule_work(&sdev->requeue_work);
> -		else
> -			blk_mq_run_hw_queues(q, true);
> -	} else {
> -		unsigned long flags;
> -
> -		if (bidi_bytes)
> -			scsi_release_bidi_buffers(cmd);
> -		scsi_release_buffers(cmd);
> -		scsi_put_command(cmd);
> +	/*
> +	 * In the MQ case the command gets freed by __blk_mq_end_request,
> +	 * so we have to do all cleanup that depends on it earlier.
> +	 *
> +	 * We also can't kick the queues from irq context, so we
> +	 * will have to defer it to a workqueue.
> +	 */

This comment is slightly stale, since everything is the MQ case now.

> +	scsi_mq_uninit_cmd(cmd);
>  
> -		spin_lock_irqsave(q->queue_lock, flags);
> -		blk_finish_request(req, error);
> -		spin_unlock_irqrestore(q->queue_lock, flags);
> +	__blk_mq_end_request(req, error);
>  
> -		scsi_run_queue(q);
> -	}
> +	if (scsi_target(sdev)->single_lun ||
> +	    !list_empty(&sdev->host->starved_list))
> +		kblockd_schedule_work(&sdev->requeue_work);
> +	else
> +		blk_mq_run_hw_queues(q, true);
>  
>  	put_device(&sdev->sdev_gendev);
>  	return false;

> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 99f1db5e467e..5f21547b2ad2 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -92,7 +92,6 @@ extern void scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
>  extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
>  extern void scsi_run_host_queues(struct Scsi_Host *shost);
>  extern void scsi_requeue_run_queue(struct work_struct *work);
> -extern struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev);
>  extern struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev);
>  extern void scsi_start_queue(struct scsi_device *sdev);
>  extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 78ca63dfba4a..dd0d516f65e2 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -266,10 +266,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
>  	 */
>  	sdev->borken = 1;
>  
> -	if (shost_use_blk_mq(shost))
> -		sdev->request_queue = scsi_mq_alloc_queue(sdev);
> -	else
> -		sdev->request_queue = scsi_old_alloc_queue(sdev);
> +	sdev->request_queue = scsi_mq_alloc_queue(sdev);
>  	if (!sdev->request_queue) {
>  		/* release fn is set up in scsi_sysfs_device_initialise, so
>  		 * have to free and put manually here */
> @@ -280,11 +277,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
>  	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
>  	sdev->request_queue->queuedata = sdev;
>  
> -	if (!shost_use_blk_mq(sdev->host)) {
> -		blk_queue_init_tags(sdev->request_queue,
> -				    sdev->host->cmd_per_lun, shost->bqt,
> -				    shost->hostt->tag_alloc_policy);
> -	}
>  	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
>  					sdev->host->cmd_per_lun : 1);
>  
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 3aee9464a7bf..12e2c2829df2 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -367,7 +367,6 @@ store_shost_eh_deadline(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store_shost_eh_deadline);
>  
> -shost_rd_attr(use_blk_mq, "%d\n");
>  shost_rd_attr(unique_id, "%u\n");
>  shost_rd_attr(cmd_per_lun, "%hd\n");
>  shost_rd_attr(can_queue, "%hd\n");
> @@ -386,6 +385,13 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>  
> +static ssize_t
> +show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return snprintf(buf, 20, "1\n");
> +}

Looks like you forgot to change this to sprintf()
