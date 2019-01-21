Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3BC2F437
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968B720879
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfAUPYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:24:30 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:13199 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbfAUPY1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 10:24:27 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4F88F13F8CF;
        Mon, 21 Jan 2019 16:23:11 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
Message-ID: <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
Date:   Mon, 21 Jan 2019 16:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/01/2019 20:47, Marc Gonzalez wrote:

> On 19/01/2019 10:56, Christoph Hellwig wrote:
> 
>> On Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
>>
>>> It's UFS that totally buggy, if you look at its queuecommand, it does:
>>>
>>>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
>>>                 return SCSI_MLQUEUE_HOST_BUSY;
>>>
>>> UFS either needs to get fixed up, or we'll want a way to do something like
>>> the below.
>>
>> I think the right answer is to just revert the offending patch instead
>> of papering over it in the SCSI code.
> 
> [ Adjusting recipients list ]
> 
> Full thread, for new recipients:
> https://www.spinics.net/lists/linux-fsdevel/msg138601.html
> 
> Christoph, do you mean a3cd5ec55f6c7 ?

Well, now we know for sure that the clk_scaling_lock is a red herring.
I applied the patch below, and still the system locked up:

# dd if=/dev/sde of=/dev/null bs=1M status=progress
3892314112 bytes (3.9 GB, 3.6 GiB) copied, 50.0042 s, 77.8 MB/s

I can't seem to get the RCU stall warning anymore. How can I get
to the bottom of this issue?

Regards.



diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb14aae1..5700662ff7ca 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1085,7 +1085,6 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 
 	hba->caps |= UFSHCD_CAP_CLK_GATING | UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
-	hba->caps |= UFSHCD_CAP_CLK_SCALING;
 	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
 
 	if (host->hw_ver.major >= 0x2) {
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d0d340210ccf..90be92766723 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -250,10 +250,6 @@ static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
 static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
 static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
-static void ufshcd_resume_clkscaling(struct ufs_hba *hba);
-static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
-static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
@@ -892,575 +888,6 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
 		return false;
 }
 
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
-{
-	int ret = 0;
-	struct ufs_clk_info *clki;
-	struct list_head *head = &hba->clk_list_head;
-	ktime_t start = ktime_get();
-	bool clk_state_changed = false;
-
-	if (list_empty(head))
-		goto out;
-
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, PRE_CHANGE);
-	if (ret)
-		return ret;
-
-	list_for_each_entry(clki, head, list) {
-		if (!IS_ERR_OR_NULL(clki->clk)) {
-			if (scale_up && clki->max_freq) {
-				if (clki->curr_freq == clki->max_freq)
-					continue;
-
-				clk_state_changed = true;
-				ret = clk_set_rate(clki->clk, clki->max_freq);
-				if (ret) {
-					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
-						__func__, clki->name,
-						clki->max_freq, ret);
-					break;
-				}
-				trace_ufshcd_clk_scaling(dev_name(hba->dev),
-						"scaled up", clki->name,
-						clki->curr_freq,
-						clki->max_freq);
-
-				clki->curr_freq = clki->max_freq;
-
-			} else if (!scale_up && clki->min_freq) {
-				if (clki->curr_freq == clki->min_freq)
-					continue;
-
-				clk_state_changed = true;
-				ret = clk_set_rate(clki->clk, clki->min_freq);
-				if (ret) {
-					dev_err(hba->dev, "%s: %s clk set rate(%dHz) failed, %d\n",
-						__func__, clki->name,
-						clki->min_freq, ret);
-					break;
-				}
-				trace_ufshcd_clk_scaling(dev_name(hba->dev),
-						"scaled down", clki->name,
-						clki->curr_freq,
-						clki->min_freq);
-				clki->curr_freq = clki->min_freq;
-			}
-		}
-		dev_dbg(hba->dev, "%s: clk: %s, rate: %lu\n", __func__,
-				clki->name, clk_get_rate(clki->clk));
-	}
-
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
-
-out:
-	if (clk_state_changed)
-		trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
-			(scale_up ? "up" : "down"),
-			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
-	return ret;
-}
-
-/**
- * ufshcd_is_devfreq_scaling_required - check if scaling is required or not
- * @hba: per adapter instance
- * @scale_up: True if scaling up and false if scaling down
- *
- * Returns true if scaling is required, false otherwise.
- */
-static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
-					       bool scale_up)
-{
-	struct ufs_clk_info *clki;
-	struct list_head *head = &hba->clk_list_head;
-
-	if (list_empty(head))
-		return false;
-
-	list_for_each_entry(clki, head, list) {
-		if (!IS_ERR_OR_NULL(clki->clk)) {
-			if (scale_up && clki->max_freq) {
-				if (clki->curr_freq == clki->max_freq)
-					continue;
-				return true;
-			} else if (!scale_up && clki->min_freq) {
-				if (clki->curr_freq == clki->min_freq)
-					continue;
-				return true;
-			}
-		}
-	}
-
-	return false;
-}
-
-static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
-					u64 wait_timeout_us)
-{
-	unsigned long flags;
-	int ret = 0;
-	u32 tm_doorbell;
-	u32 tr_doorbell;
-	bool timeout = false, do_last_check = false;
-	ktime_t start;
-
-	ufshcd_hold(hba, false);
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	/*
-	 * Wait for all the outstanding tasks/transfer requests.
-	 * Verify by checking the doorbell registers are clear.
-	 */
-	start = ktime_get();
-	do {
-		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
-			ret = -EBUSY;
-			goto out;
-		}
-
-		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
-		tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-		if (!tm_doorbell && !tr_doorbell) {
-			timeout = false;
-			break;
-		} else if (do_last_check) {
-			break;
-		}
-
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-		schedule();
-		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
-		    wait_timeout_us) {
-			timeout = true;
-			/*
-			 * We might have scheduled out for long time so make
-			 * sure to check if doorbells are cleared by this time
-			 * or not.
-			 */
-			do_last_check = true;
-		}
-		spin_lock_irqsave(hba->host->host_lock, flags);
-	} while (tm_doorbell || tr_doorbell);
-
-	if (timeout) {
-		dev_err(hba->dev,
-			"%s: timedout waiting for doorbell to clear (tm=0x%x, tr=0x%x)\n",
-			__func__, tm_doorbell, tr_doorbell);
-		ret = -EBUSY;
-	}
-out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ufshcd_release(hba);
-	return ret;
-}
-
-/**
- * ufshcd_scale_gear - scale up/down UFS gear
- * @hba: per adapter instance
- * @scale_up: True for scaling up gear and false for scaling down
- *
- * Returns 0 for success,
- * Returns -EBUSY if scaling can't happen at this time
- * Returns non-zero for any other errors
- */
-static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
-{
-	#define UFS_MIN_GEAR_TO_SCALE_DOWN	UFS_HS_G1
-	int ret = 0;
-	struct ufs_pa_layer_attr new_pwr_info;
-
-	if (scale_up) {
-		memcpy(&new_pwr_info, &hba->clk_scaling.saved_pwr_info.info,
-		       sizeof(struct ufs_pa_layer_attr));
-	} else {
-		memcpy(&new_pwr_info, &hba->pwr_info,
-		       sizeof(struct ufs_pa_layer_attr));
-
-		if (hba->pwr_info.gear_tx > UFS_MIN_GEAR_TO_SCALE_DOWN
-		    || hba->pwr_info.gear_rx > UFS_MIN_GEAR_TO_SCALE_DOWN) {
-			/* save the current power mode */
-			memcpy(&hba->clk_scaling.saved_pwr_info.info,
-				&hba->pwr_info,
-				sizeof(struct ufs_pa_layer_attr));
-
-			/* scale down gear */
-			new_pwr_info.gear_tx = UFS_MIN_GEAR_TO_SCALE_DOWN;
-			new_pwr_info.gear_rx = UFS_MIN_GEAR_TO_SCALE_DOWN;
-		}
-	}
-
-	/* check if the power mode needs to be changed or not? */
-	ret = ufshcd_change_power_mode(hba, &new_pwr_info);
-
-	if (ret)
-		dev_err(hba->dev, "%s: failed err %d, old gear: (tx %d rx %d), new gear: (tx %d rx %d)",
-			__func__, ret,
-			hba->pwr_info.gear_tx, hba->pwr_info.gear_rx,
-			new_pwr_info.gear_tx, new_pwr_info.gear_rx);
-
-	return ret;
-}
-
-static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
-{
-	#define DOORBELL_CLR_TOUT_US		(1000 * 1000) /* 1 sec */
-	int ret = 0;
-	/*
-	 * make sure that there are no outstanding requests when
-	 * clock scaling is in progress
-	 */
-	ufshcd_scsi_block_requests(hba);
-	down_write(&hba->clk_scaling_lock);
-	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
-		ret = -EBUSY;
-		up_write(&hba->clk_scaling_lock);
-		ufshcd_scsi_unblock_requests(hba);
-	}
-
-	return ret;
-}
-
-static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
-{
-	up_write(&hba->clk_scaling_lock);
-	ufshcd_scsi_unblock_requests(hba);
-}
-
-/**
- * ufshcd_devfreq_scale - scale up/down UFS clocks and gear
- * @hba: per adapter instance
- * @scale_up: True for scaling up and false for scalin down
- *
- * Returns 0 for success,
- * Returns -EBUSY if scaling can't happen at this time
- * Returns non-zero for any other errors
- */
-static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
-{
-	int ret = 0;
-
-	/* let's not get into low power until clock scaling is completed */
-	ufshcd_hold(hba, false);
-
-	ret = ufshcd_clock_scaling_prepare(hba);
-	if (ret)
-		return ret;
-
-	/* scale down the gear before scaling down clocks */
-	if (!scale_up) {
-		ret = ufshcd_scale_gear(hba, false);
-		if (ret)
-			goto out;
-	}
-
-	ret = ufshcd_scale_clks(hba, scale_up);
-	if (ret) {
-		if (!scale_up)
-			ufshcd_scale_gear(hba, true);
-		goto out;
-	}
-
-	/* scale up the gear after scaling up clocks */
-	if (scale_up) {
-		ret = ufshcd_scale_gear(hba, true);
-		if (ret) {
-			ufshcd_scale_clks(hba, false);
-			goto out;
-		}
-	}
-
-	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
-
-out:
-	ufshcd_clock_scaling_unprepare(hba);
-	ufshcd_release(hba);
-	return ret;
-}
-
-static void ufshcd_clk_scaling_suspend_work(struct work_struct *work)
-{
-	struct ufs_hba *hba = container_of(work, struct ufs_hba,
-					   clk_scaling.suspend_work);
-	unsigned long irq_flags;
-
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (hba->clk_scaling.active_reqs || hba->clk_scaling.is_suspended) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		return;
-	}
-	hba->clk_scaling.is_suspended = true;
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-
-	__ufshcd_suspend_clkscaling(hba);
-}
-
-static void ufshcd_clk_scaling_resume_work(struct work_struct *work)
-{
-	struct ufs_hba *hba = container_of(work, struct ufs_hba,
-					   clk_scaling.resume_work);
-	unsigned long irq_flags;
-
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (!hba->clk_scaling.is_suspended) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		return;
-	}
-	hba->clk_scaling.is_suspended = false;
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-
-	devfreq_resume_device(hba->devfreq);
-}
-
-static int ufshcd_devfreq_target(struct device *dev,
-				unsigned long *freq, u32 flags)
-{
-	int ret = 0;
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	ktime_t start;
-	bool scale_up, sched_clk_scaling_suspend_work = false;
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
-	unsigned long irq_flags;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return -EINVAL;
-
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (ufshcd_eh_in_progress(hba)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		return 0;
-	}
-
-	if (!hba->clk_scaling.active_reqs)
-		sched_clk_scaling_suspend_work = true;
-
-	if (list_empty(clk_list)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		goto out;
-	}
-
-	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
-	scale_up = (*freq == clki->max_freq) ? true : false;
-	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		ret = 0;
-		goto out; /* no state change required */
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-
-	start = ktime_get();
-	ret = ufshcd_devfreq_scale(hba, scale_up);
-
-	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
-		(scale_up ? "up" : "down"),
-		ktime_to_us(ktime_sub(ktime_get(), start)), ret);
-
-out:
-	if (sched_clk_scaling_suspend_work)
-		queue_work(hba->clk_scaling.workq,
-			   &hba->clk_scaling.suspend_work);
-
-	return ret;
-}
-
-
-static int ufshcd_devfreq_get_dev_status(struct device *dev,
-		struct devfreq_dev_status *stat)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
-	unsigned long flags;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return -EINVAL;
-
-	memset(stat, 0, sizeof(*stat));
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (!scaling->window_start_t)
-		goto start_window;
-
-	if (scaling->is_busy_started)
-		scaling->tot_busy_t += ktime_to_us(ktime_sub(ktime_get(),
-					scaling->busy_start_t));
-
-	stat->total_time = jiffies_to_usecs((long)jiffies -
-				(long)scaling->window_start_t);
-	stat->busy_time = scaling->tot_busy_t;
-start_window:
-	scaling->window_start_t = jiffies;
-	scaling->tot_busy_t = 0;
-
-	if (hba->outstanding_reqs) {
-		scaling->busy_start_t = ktime_get();
-		scaling->is_busy_started = true;
-	} else {
-		scaling->busy_start_t = 0;
-		scaling->is_busy_started = false;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	return 0;
-}
-
-static struct devfreq_dev_profile ufs_devfreq_profile = {
-	.polling_ms	= 100,
-	.target		= ufshcd_devfreq_target,
-	.get_dev_status	= ufshcd_devfreq_get_dev_status,
-};
-
-static int ufshcd_devfreq_init(struct ufs_hba *hba)
-{
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
-	struct devfreq *devfreq;
-	int ret;
-
-	/* Skip devfreq if we don't have any clocks in the list */
-	if (list_empty(clk_list))
-		return 0;
-
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
-	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
-
-	devfreq = devfreq_add_device(hba->dev,
-			&ufs_devfreq_profile,
-			DEVFREQ_GOV_SIMPLE_ONDEMAND,
-			NULL);
-	if (IS_ERR(devfreq)) {
-		ret = PTR_ERR(devfreq);
-		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
-
-		dev_pm_opp_remove(hba->dev, clki->min_freq);
-		dev_pm_opp_remove(hba->dev, clki->max_freq);
-		return ret;
-	}
-
-	hba->devfreq = devfreq;
-
-	return 0;
-}
-
-static void ufshcd_devfreq_remove(struct ufs_hba *hba)
-{
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
-
-	if (!hba->devfreq)
-		return;
-
-	devfreq_remove_device(hba->devfreq);
-	hba->devfreq = NULL;
-
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_remove(hba->dev, clki->min_freq);
-	dev_pm_opp_remove(hba->dev, clki->max_freq);
-}
-
-static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
-{
-	unsigned long flags;
-
-	devfreq_suspend_device(hba->devfreq);
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->clk_scaling.window_start_t = 0;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-}
-
-static void ufshcd_suspend_clkscaling(struct ufs_hba *hba)
-{
-	unsigned long flags;
-	bool suspend = false;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (!hba->clk_scaling.is_suspended) {
-		suspend = true;
-		hba->clk_scaling.is_suspended = true;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-	if (suspend)
-		__ufshcd_suspend_clkscaling(hba);
-}
-
-static void ufshcd_resume_clkscaling(struct ufs_hba *hba)
-{
-	unsigned long flags;
-	bool resume = false;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->clk_scaling.is_suspended) {
-		resume = true;
-		hba->clk_scaling.is_suspended = false;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
-	if (resume)
-		devfreq_resume_device(hba->devfreq);
-}
-
-static ssize_t ufshcd_clkscale_enable_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", hba->clk_scaling.is_allowed);
-}
-
-static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	u32 value;
-	int err;
-
-	if (kstrtou32(buf, 0, &value))
-		return -EINVAL;
-
-	value = !!value;
-	if (value == hba->clk_scaling.is_allowed)
-		goto out;
-
-	pm_runtime_get_sync(hba->dev);
-	ufshcd_hold(hba, false);
-
-	cancel_work_sync(&hba->clk_scaling.suspend_work);
-	cancel_work_sync(&hba->clk_scaling.resume_work);
-
-	hba->clk_scaling.is_allowed = value;
-
-	if (value) {
-		ufshcd_resume_clkscaling(hba);
-	} else {
-		ufshcd_suspend_clkscaling(hba);
-		err = ufshcd_devfreq_scale(hba, true);
-		if (err)
-			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
-					__func__, err);
-	}
-
-	ufshcd_release(hba);
-	pm_runtime_put_sync(hba->dev);
-out:
-	return count;
-}
-
-static void ufshcd_clkscaling_init_sysfs(struct ufs_hba *hba)
-{
-	hba->clk_scaling.enable_attr.show = ufshcd_clkscale_enable_show;
-	hba->clk_scaling.enable_attr.store = ufshcd_clkscale_enable_store;
-	sysfs_attr_init(&hba->clk_scaling.enable_attr.attr);
-	hba->clk_scaling.enable_attr.attr.name = "clkscale_enable";
-	hba->clk_scaling.enable_attr.attr.mode = 0644;
-	if (device_create_file(hba->dev, &hba->clk_scaling.enable_attr))
-		dev_err(hba->dev, "Failed to create sysfs for clkscale_enable\n");
-}
-
 static void ufshcd_ungate_work(struct work_struct *work)
 {
 	int ret;
@@ -1742,34 +1169,6 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 	return count;
 }
 
-static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
-{
-	char wq_name[sizeof("ufs_clkscaling_00")];
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	INIT_WORK(&hba->clk_scaling.suspend_work,
-		  ufshcd_clk_scaling_suspend_work);
-	INIT_WORK(&hba->clk_scaling.resume_work,
-		  ufshcd_clk_scaling_resume_work);
-
-	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
-		 hba->host->host_no);
-	hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
-
-	ufshcd_clkscaling_init_sysfs(hba);
-}
-
-static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
-{
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	destroy_workqueue(hba->clk_scaling.workq);
-	ufshcd_devfreq_remove(hba);
-}
-
 static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 {
 	char wq_name[sizeof("ufs_clk_gating_00")];
@@ -1816,50 +1215,6 @@ static void ufshcd_exit_clk_gating(struct ufs_hba *hba)
 	destroy_workqueue(hba->clk_gating.clk_gating_workq);
 }
 
-/* Must be called with host lock acquired */
-static void ufshcd_clk_scaling_start_busy(struct ufs_hba *hba)
-{
-	bool queue_resume_work = false;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	if (!hba->clk_scaling.active_reqs++)
-		queue_resume_work = true;
-
-	if (!hba->clk_scaling.is_allowed || hba->pm_op_in_progress)
-		return;
-
-	if (queue_resume_work)
-		queue_work(hba->clk_scaling.workq,
-			   &hba->clk_scaling.resume_work);
-
-	if (!hba->clk_scaling.window_start_t) {
-		hba->clk_scaling.window_start_t = jiffies;
-		hba->clk_scaling.tot_busy_t = 0;
-		hba->clk_scaling.is_busy_started = false;
-	}
-
-	if (!hba->clk_scaling.is_busy_started) {
-		hba->clk_scaling.busy_start_t = ktime_get();
-		hba->clk_scaling.is_busy_started = true;
-	}
-}
-
-static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
-{
-	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
-
-	if (!ufshcd_is_clkscaling_supported(hba))
-		return;
-
-	if (!hba->outstanding_reqs && scaling->is_busy_started) {
-		scaling->tot_busy_t += ktime_to_us(ktime_sub(ktime_get(),
-					scaling->busy_start_t));
-		scaling->busy_start_t = 0;
-		scaling->is_busy_started = false;
-	}
-}
 /**
  * ufshcd_send_command - Send SCSI or device management commands
  * @hba: per adapter instance
@@ -1870,7 +1225,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 {
 	hba->lrb[task_tag].issue_time_stamp = ktime_get();
 	hba->lrb[task_tag].compl_time_stamp = ktime_set(0, 0);
-	ufshcd_clk_scaling_start_busy(hba);
 	__set_bit(task_tag, &hba->outstanding_reqs);
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	/* Make sure that doorbell is committed immediately */
@@ -2398,9 +1752,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		BUG();
 	}
 
-	if (!down_read_trylock(&hba->clk_scaling_lock))
-		return SCSI_MLQUEUE_HOST_BUSY;
-
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	switch (hba->ufshcd_state) {
 	case UFSHCD_STATE_OPERATIONAL:
@@ -2480,7 +1831,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 out_unlock:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 out:
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -2670,8 +2020,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	struct completion wait;
 	unsigned long flags;
 
-	down_read(&hba->clk_scaling_lock);
-
 	/*
 	 * Get free slot, sleep if slots are unavailable.
 	 * Even though we use wait_event() which sleeps indefinitely,
@@ -2704,7 +2052,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 out_put_tag:
 	ufshcd_put_dev_cmd_tag(hba, tag);
 	wake_up(&hba->dev_cmd.tag_wq);
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -4786,8 +4133,6 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 				complete(hba->dev_cmd.complete);
 			}
 		}
-		if (ufshcd_is_clkscaling_supported(hba))
-			hba->clk_scaling.active_reqs--;
 
 		lrbp->compl_time_stamp = ktime_get();
 	}
@@ -4795,8 +4140,6 @@ static void __ufshcd_transfer_req_compl(struct ufs_hba *hba,
 	/* clear corresponding bits of completed commands */
 	hba->outstanding_reqs ^= completed_reqs;
 
-	ufshcd_clk_scaling_update_busy(hba);
-
 	/* we might have free'd some tags above */
 	wake_up(&hba->dev_cmd.tag_wq);
 }
@@ -5708,8 +5051,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	unsigned long flags;
 	u32 upiu_flags;
 
-	down_read(&hba->clk_scaling_lock);
-
 	wait_event(hba->dev_cmd.tag_wq, ufshcd_get_dev_cmd_tag(hba, &tag));
 
 	init_completion(&wait);
@@ -5772,7 +5113,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	ufshcd_put_dev_cmd_tag(hba, tag);
 	wake_up(&hba->dev_cmd.tag_wq);
-	up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -6110,9 +5450,6 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	ufshcd_hba_stop(hba, false);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
-
 	err = ufshcd_hba_enable(hba);
 	if (err)
 		goto out;
@@ -6871,20 +6208,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 		if (ufshcd_scsi_add_wlus(hba))
 			goto out;
 
-		/* Initialize devfreq after UFS device is detected */
-		if (ufshcd_is_clkscaling_supported(hba)) {
-			memcpy(&hba->clk_scaling.saved_pwr_info.info,
-				&hba->pwr_info,
-				sizeof(struct ufs_pa_layer_attr));
-			hba->clk_scaling.saved_pwr_info.is_valid = true;
-			if (!hba->devfreq) {
-				ret = ufshcd_devfreq_init(hba);
-				if (ret)
-					goto out;
-			}
-			hba->clk_scaling.is_allowed = true;
-		}
-
 		ufs_bsg_probe(hba);
 
 		scsi_scan_host(hba->host);
@@ -6901,7 +6224,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	 */
 	if (ret && !ufshcd_eh_in_progress(hba) && !hba->pm_op_in_progress) {
 		pm_runtime_put_sync(hba->dev);
-		ufshcd_exit_clk_scaling(hba);
 		ufshcd_hba_exit(hba);
 	}
 
@@ -7446,10 +6768,6 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 	if (hba->is_powered) {
 		ufshcd_variant_hba_exit(hba);
 		ufshcd_setup_vreg(hba, false);
-		ufshcd_suspend_clkscaling(hba);
-		if (ufshcd_is_clkscaling_supported(hba))
-			if (hba->devfreq)
-				ufshcd_suspend_clkscaling(hba);
 		ufshcd_setup_clocks(hba, false);
 		ufshcd_setup_hba_vreg(hba, false);
 		hba->is_powered = false;
@@ -7725,12 +7043,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_hold(hba, false);
 	hba->clk_gating.is_suspended = true;
 
-	if (hba->clk_scaling.is_allowed) {
-		cancel_work_sync(&hba->clk_scaling.suspend_work);
-		cancel_work_sync(&hba->clk_scaling.resume_work);
-		ufshcd_suspend_clkscaling(hba);
-	}
-
 	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
 			req_link_state == UIC_LINK_ACTIVE_STATE) {
 		goto disable_clks;
@@ -7806,8 +7118,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	goto out;
 
 set_link_active:
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_resume_clkscaling(hba);
 	ufshcd_vreg_set_hpm(hba);
 	if (ufshcd_is_link_hibern8(hba) && !ufshcd_uic_hibern8_exit(hba))
 		ufshcd_set_link_active(hba);
@@ -7817,8 +7127,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
 		ufshcd_disable_auto_bkops(hba);
 enable_gating:
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_resume_clkscaling(hba);
 	hba->clk_gating.is_suspended = false;
 	ufshcd_release(hba);
 out:
@@ -7901,9 +7209,6 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	hba->clk_gating.is_suspended = false;
 
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_resume_clkscaling(hba);
-
 	/* Schedule clock gating in case of no access to UFS device yet */
 	ufshcd_release(hba);
 
@@ -7920,8 +7225,6 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ufshcd_vreg_set_lpm(hba);
 disable_irq_and_vops_clks:
 	ufshcd_disable_irq(hba);
-	if (hba->clk_scaling.is_allowed)
-		ufshcd_suspend_clkscaling(hba);
 	ufshcd_setup_clocks(hba, false);
 out:
 	hba->pm_op_in_progress = 0;
@@ -8125,10 +7428,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufshcd_disable_intr(hba, hba->intr_mask);
 	ufshcd_hba_stop(hba, true);
 
-	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
-	if (ufshcd_is_clkscaling_supported(hba))
-		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
 	ufshcd_hba_exit(hba);
 }
 EXPORT_SYMBOL_GPL(ufshcd_remove);
@@ -8284,15 +7584,11 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	/* Initialize mutex for device management commands */
 	mutex_init(&hba->dev_cmd.lock);
 
-	init_rwsem(&hba->clk_scaling_lock);
-
 	/* Initialize device management tag acquire wait queue */
 	init_waitqueue_head(&hba->dev_cmd.tag_wq);
 
 	ufshcd_init_clk_gating(hba);
 
-	ufshcd_init_clk_scaling(hba);
-
 	/*
 	 * In order to avoid any spurious interrupt immediately after
 	 * registering UFS controller interrupt handler, clear any pending UFS
@@ -8368,7 +7664,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 out_remove_scsi_host:
 	scsi_remove_host(hba->host);
 exit_gating:
-	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
 out_disable:
 	hba->is_irq_enabled = false;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 69ba7445d2b3..11c7b070861c 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -700,7 +700,6 @@ struct ufs_hba {
 	enum bkops_status urgent_bkops_lvl;
 	bool is_urgent_bkops_lvl_checked;
 
-	struct rw_semaphore clk_scaling_lock;
 	struct ufs_desc_size desc_size;
 	atomic_t scsi_block_reqs_cnt;
 
