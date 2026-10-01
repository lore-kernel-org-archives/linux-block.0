Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747254A5C2A;
	Thu,  1 Oct 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844646; cv=none; b=TYqXu+mDa2Ht2hXEESFdSDSeP6tPZJeFzJ6j4znE6Hm3HGZXaDLYD/OQtFBA/GX1ly9wuNQE8i7mz+2TdquC23BvigmSDSYsRRa7EfB2lia960I4l1PwDSMTPtHeIg/Kbokcuc2PaJyeVMoEqZM24iJVjDsj3SmmXCP0MLJQPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844646; c=relaxed/simple;
	bh=zfZR96jaxuZbvQMbRDsjRIQgaDkFQPfbUzTK/fXqx2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnx6PJ/MwvAJM5ssDZPWxx5RTdDrwJAOTZUFi8DRCn9D3gnO4Z9MmDrgVZWDWtfuBBw0+QR+tNbEPYDmUesFRPcqGVHPqdqyseJhvuWtPwX246YNUqbGfBuLzIR2euhjFP2mFtRx6mmh7pX3fVesRZxSG89elPvA3vMNXOCpp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBX5LPEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBX5LPEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF81F000FF;
	Thu,  1 Oct 2026 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790844644;
	bh=phCll0AXBVA6AmnS9r4H9wbCwsImfJxjoXFsqhg5/Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CBX5LPEhj6VEjKmJZfbh5DWcUgiiEN6G0d5FpnI+Un2SWpzm6N479DwzUhQS56t2x
	 H96JdCF2ozagZcKhfey/5FeQPjQpV+KqMipdekF1HxXCKeYUNG1ZNC6TlkUTEBF01Z
	 kXuyb083LGBxH3gKjJKVK0DopizlZi8nLeK3U9HLFJ8qBQFdB0n7H1EC52JmdRH6UY
	 bqH6RtpuFajhqeHbHrytKqWM5elpcULhcEcnuoBtt8Zpw3e0KcQzKdK+Z28GMWqUm2
	 4FvlL1+l9iGFqIC5uigeInpIr8hIfpuGAbT/9aINHh5VPTQY7JrvtESPsUHMDPS+0A
	 /d5DBzvy9besw==
Date: Thu, 1 Oct 2026 10:50:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
Message-ID: <20261001-hopping-belligerent-spider-876e7b@quoll>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>

On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
> hardware block that accelerates compression and decompression of memory
> pages.
> 
> Provide the urgent command path for synchronous single-page compression and
> decompression. This exposes the low-latency operations needed by
> compressed-memory users such as zram, especially for page decompression on
> the read path.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/Kconfig          |  14 +
>  drivers/soc/qcom/Makefile         |   1 +
>  drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>  drivers/soc/qcom/qpace_internal.h |  84 ++++
>  include/linux/soc/qcom/qpace.h    | 154 ++++++
>  5 files changed, 1017 insertions(+)
>  create mode 100644 drivers/soc/qcom/qpace.c
>  create mode 100644 drivers/soc/qcom/qpace_internal.h
>  create mode 100644 include/linux/soc/qcom/qpace.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 535c8619197b..6bcb86dcd726 100644
> --- a/drivers/soc/qcom/Kconfig

Sorry, but no. Soc is not a dumping ground. This has clear function of
compression offload, so it should have some dedicated maintainers like
other offload engines.

> +++ b/drivers/soc/qcom/Kconfig
> @@ -288,6 +288,20 @@ config QCOM_PBS
>  	  This module provides the APIs to the client drivers that wants to send the
>  	  PBS trigger event to the PBS RAM.
>  
> +config QCOM_PAGE_COMPRESSION_ENGINE
> +	tristate "Qualcomm Page Compression Engine (QPaCE)"
> +	depends on ARM64

Why this can't be built on other archs? This is really odd and I do not
see any asm headers included.


> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF
> +	depends on INTERCONNECT
> +	help
> +	  Enable support for the Qualcomm Page Compression Engine (QPaCE),
> +	  a hardware accelerator that provides high-throughput page compression,
> +	  decompression, and DMA copy operations.
> +
> +	  The engine is used as a hardware backend for compressed-memory
> +	  subsystems such as zram. If unsure, say N.
> +

...


> +	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
> +out:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qpace_urgent_compress);
> +
> +int qpace_urgent_decompress(dma_addr_t input_addr,
> +			    dma_addr_t output_addr,
> +			    size_t input_size,
> +			    struct qpace_algorithm *algo)

You need kerneldoc for every export.

> +{
> +	int urg_reg_num;
> +	int stat_reg;
> +	u32 stat_reg_val;
> +	int ret;
> +
> +	ret = qpace_get();
> +	if (ret)
> +		goto out;
> +
> +	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
> +	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
> +				urg_reg_num, algo->urg_decomp_cntxt,
> +				FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, input_size));
> +	stat_reg = qpace_urgent_command_trigger(input_addr, output_addr, urg_reg_num,
> +						algo->urg_decomp_cntxt);
> +	put_cpu();
> +
> +	qpace_put();
> +
> +	if (stat_reg < 0) {
> +		ret = stat_reg;
> +		goto out;
> +	}
> +
> +	stat_reg_val = FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE, stat_reg);
> +	if (stat_reg_val != OP_OK) {
> +		pr_err("%s: register %d failed with %u\n",
> +		       __func__, urg_reg_num, stat_reg_val);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
> +out:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qpace_urgent_decompress);
> +

So singleton? For what reason exactly? Random drivers will be getting
the reference to compress something? If so, aren't you duplicating
existing infrastructure/API for in-kernel hardware offloaded
compression (e.g. drivers/crypto/)?

You miss proper comments (see checkpatch --strict) explaining lock
usage.


> +static DEFINE_MUTEX(qpace_ref_lock);
> +
> +static void _get_qpace(void)
> +{
> +	lockdep_assert_held(&qpace_ref_lock);
> +	if (!qpace_priv->active_rings) {
> +		reinit_completion(&qpace_priv->no_active_refs);
> +		pm_stay_awake(qpace_priv->dev);
> +		cpu_latency_qos_update_request(&qpace_priv->qos_req, 300);
> +		program_urg_command_contexts_v2();
> +		program_decomp_core_cfg();
> +	}
> +	qpace_priv->active_rings++;
> +}
> +
> +static void _put_qpace(void)
> +{
> +	lockdep_assert_held(&qpace_ref_lock);
> +	if (!--qpace_priv->active_rings) {
> +		cpu_latency_qos_update_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
> +		pm_relax(qpace_priv->dev);
> +		complete(&qpace_priv->no_active_refs);
> +	}
> +}
> +
> +int qpace_get(void)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&qpace_ref_lock);
> +	if (qpace_priv->suspended || READ_ONCE(qpace_priv->broken))
> +		ret = -EBUSY;
> +	else
> +		_get_qpace();
> +	mutex_unlock(&qpace_ref_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qpace_get);
> +
> +void qpace_put(void)
> +{
> +	mutex_lock(&qpace_ref_lock);
> +	_put_qpace();
> +	mutex_unlock(&qpace_ref_lock);
> +}
> +EXPORT_SYMBOL_GPL(qpace_put);
> +
> +static irqreturn_t urgent_interrupt_handler(int irq, void *unused)
> +{
> +	pr_debug("Urgent interrupt handled\n");
> +	return IRQ_HANDLED;
> +}
> +
> +static int qpace_hw_init(void)
> +{
> +	u32 reg_val;
> +
> +	/* Select CPU SCID for our system cache slice. */
> +	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET);
> +	reg_val = u32_replace_bits(reg_val, 0x1, CORE_QNS4_CFG_CACHEINDEX);
> +	qpace_write_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET, reg_val);
> +
> +	/* QMB2 register configurations. */
> +	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET);
> +	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_RD_OUTST_LIMIT);
> +	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_WR_OUTST_LIMIT);
> +	qpace_write_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET, reg_val);
> +
> +	/* DECOMP_CORE_CFG init steps. */
> +	program_decomp_core_cfg();
> +
> +	/* Below settings help save power since all decomp cores are set to sync. */
> +	reg_val = qpace_read_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET);
> +	reg_val |= CORE_OPER_CFG_COMP_MEM_PWR_DWN_1;
> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET, reg_val);
> +
> +	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET);
> +	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_RD_MAX_OT);
> +	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_WR_MAX_OT);
> +	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET, reg_val);
> +
> +	/* Set all COMP engines to bulk mode. */
> +	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET);
> +	reg_val |= COMP_CORE_BULK_MODE_ALL_CORES;
> +	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET, reg_val);
> +
> +	/* URG CMD register configurations. */
> +	program_urg_command_contexts_v2();
> +
> +	return 0;
> +}
> +
> +enum qpace_interrupts {
> +	QPACE_IRQ_URGENT
> +};
> +
> +static int qpace_register_interrupts(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	irq = platform_get_irq(pdev, QPACE_IRQ_URGENT);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, urgent_interrupt_handler,
> +			       0, "qpace-urgent-irq", NULL);
> +	if (ret)
> +		dev_err(dev, "failed to request urgent interrupt\n");
> +
> +	return ret;
> +}
> +
> +static inline bool _qpace_power_on(void)
> +{
> +	u32 ready_status;
> +
> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_RUN);
> +
> +	if (readl_poll_timeout(qpace_priv->gen_core_regs +
> +			       QPACE_CORE_OPER_CORE_READY_OFFSET,
> +			       ready_status, ready_status,
> +			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
> +		pr_err("Timeout in waiting for QPaCE to turn on\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int qpace_power_on(struct device *dev)
> +{
> +	int ret, ret2;
> +
> +	qpace_priv->interconnect = devm_of_icc_get(dev, "qpace-mem");
> +	if (IS_ERR_OR_NULL(qpace_priv->interconnect)) {
> +		ret = PTR_ERR_OR_ZERO(qpace_priv->interconnect);
> +		pr_err("%s: devm_of_icc_get() failed with %d\n", __func__, ret);

use dev_err, not pr_err


> +		return qpace_priv->interconnect ? ret : -EINVAL;
> +	}
> +
> +	ret = device_init_wakeup(dev, true);
> +	if (ret) {
> +		pr_err("%s: device_init_wakeup() failed with %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	cpu_latency_qos_add_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
> +
> +	icc_set_tag(qpace_priv->interconnect, QCOM_ICC_TAG_ACTIVE_ONLY);
> +
> +	ret = icc_set_bw(qpace_priv->interconnect, 0, 1);
> +	if (ret) {
> +		pr_err("Failed to turn on QPaCE VCD: %d\n", ret);
> +		goto rm_qos;
> +	}
> +
> +	if (!_qpace_power_on()) {
> +		pr_err("Failed to start QPaCE\n");
> +		ret = -EINVAL;
> +		goto rm_bw;
> +	}
> +
> +	return 0;
> +
> +rm_bw:
> +	ret2 = icc_set_bw(qpace_priv->interconnect, 0, 0);
> +	if (ret2)
> +		pr_err("Failed to remove QPaCE VCD vote: %d\n", ret2);
> +rm_qos:
> +	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
> +	device_init_wakeup(dev, false);
> +
> +	return ret;
> +}
> +
> +static inline bool _qpace_power_off(void)
> +{
> +	u32 ready_status;
> +
> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_STOP);
> +
> +	if (readl_poll_timeout(qpace_priv->gen_core_regs +
> +			       QPACE_CORE_OPER_CORE_READY_OFFSET,
> +			       ready_status, !ready_status,
> +			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
> +		pr_err("Timeout in waiting for QPaCE to turn off\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void qpace_power_off(struct device *dev)
> +{
> +	int ret;
> +
> +	/* If this fails we can still remove our vote for the VCD to turn QPaCE off */
> +	if (!_qpace_power_off())
> +		pr_err("Failed to stop QPaCE\n");
> +
> +	ret = icc_set_bw(qpace_priv->interconnect, 0, 0);
> +	if (ret)
> +		pr_err("Failed to turn off QPaCE VCD: %d\n", ret);
> +
> +	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
> +
> +	device_init_wakeup(dev, false);
> +}
> +
> +static inline int qpace_register_ioremap(struct platform_device *pdev)
> +{
> +	qpace_priv->gen_regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(qpace_priv->gen_regs))
> +		return PTR_ERR(qpace_priv->gen_regs);
> +
> +	qpace_priv->gen_core_regs = qpace_priv->gen_regs + QPACE_GEN_CORE_REGS_OFFSET;
> +	qpace_priv->comp_core_regs = qpace_priv->gen_regs + QPACE_COMP_CORE_REGS_OFFSET;
> +	qpace_priv->decomp_core_regs = qpace_priv->gen_regs + QPACE_DECOMP_CORE_REGS_OFFSET;
> +	qpace_priv->urg_regs = qpace_priv->gen_regs + QPACE_URG_REGS_OFFSET;
> +
> +	return 0;
> +}
> +
> +bool qpace_is_dev_available(void)
> +{
> +	return static_branch_likely(&qpace_drv_probed) &&
> +	       !READ_ONCE(qpace_priv->broken);
> +}
> +EXPORT_SYMBOL_GPL(qpace_is_dev_available);
> +
> +struct device *qpace_get_dma_dev(void)
> +{
> +	return qpace_priv->dev;
> +}
> +EXPORT_SYMBOL_GPL(qpace_get_dma_dev);
> +
> +static int qpace_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qpace_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	/* Starts already complete since active_rings == 0 at init. */
> +	init_completion(&priv->no_active_refs);
> +	complete(&priv->no_active_refs);
> +	INIT_WORK(&priv->disable_work, qpace_disable_work_fn);
> +	qpace_priv = priv;
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	ret = qpace_register_ioremap(pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to map QPaCE registers\n");
> +
> +	ret = qpace_power_on(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to power on QPaCE\n");
> +
> +	/* Get QPaCE HW version. */
> +	qpace_priv->hw_version = qpace_read_gen(qpace_priv, QPACE_CORE_HW_VERSION_OFFSET);
> +	if (qpace_priv->hw_version != QPACE_HW_VERSION_V2) {
> +		dev_err(dev, "Unsupported QPaCE HW version returned: 0x%x\n",
> +			qpace_priv->hw_version);
> +		ret = -EINVAL;
> +		goto power_off;
> +	}
> +
> +	ret = qpace_hw_init();
> +	if (ret) {

How is this possible?

> +		dev_err(dev, "init failed: (%d)\n", ret);
> +		goto power_off;
> +	}
> +
> +	ret = qpace_register_interrupts(pdev);
> +	if (ret) {
> +		dev_err(dev, "failed to register interrupts\n");

Do not print same error multiple times.

> +		goto power_off;
> +	}
> +
> +	static_branch_enable(&qpace_drv_probed);
> +
> +	return ret;
> +
> +power_off:
> +	qpace_power_off(dev);
> +
> +	return ret;
> +}

Best regards,
Krzysztof

