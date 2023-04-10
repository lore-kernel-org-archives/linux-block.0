Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B391C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 03:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDKDRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKDQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 23:16:55 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C719A2
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 20:16:41 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230411031638epoutp020a654dd98277882c4a99af2c574508d0~UwwejC_d30621406214epoutp02f
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 03:16:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230411031638epoutp020a654dd98277882c4a99af2c574508d0~UwwejC_d30621406214epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681182998;
        bh=9VvpIrMSgl2UPlOXC7uo03BSpEU3+01HxJPZbPfUCkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K/KLcrfapGVcJ5abQDbatyPTEP2a5rFKtM3JDAUT/Gfpij+XBYo8N5PHG6yR9RaBJ
         l3v970Je91H0gwe+Z5f91Cdv5Us0nWz/ylu5Nr2ekJsRlTBYNUImTo43p0QLpZX79Y
         UnicrE5zR1LS8+112CReBARd0mFixY41XAXbYoZA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230411031637epcas5p4caaf771f1ec830ef3864e33ba9b73b42~UwweDEcG50107901079epcas5p40;
        Tue, 11 Apr 2023 03:16:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PwWGD2c5Zz4x9Px; Tue, 11 Apr
        2023 03:16:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.4A.09961.211D4346; Tue, 11 Apr 2023 12:16:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8~Uo--tCUv81907419074epcas5p3O;
        Mon, 10 Apr 2023 17:48:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230410174800epsmtrp15a6dceb94aaacb63f232ba31fc2b2dee~Uo--sVYWp1799517995epsmtrp1h;
        Mon, 10 Apr 2023 17:48:00 +0000 (GMT)
X-AuditID: b6c32a49-52dfd700000026e9-05-6434d112a5ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.25.08279.0DB44346; Tue, 11 Apr 2023 02:48:00 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230410174759epsmtip12a50fbe8810b037106ae83d6daf5cabc~Uo-_U5AGe0232302323epsmtip1K;
        Mon, 10 Apr 2023 17:47:58 +0000 (GMT)
Date:   Mon, 10 Apr 2023 23:17:08 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, bvanassche@acm.org,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com
Subject: Re: [PATCH V2 1/1] null_blk: add moddule parameter check
Message-ID: <20230410174708.pv6xm4pwaszyabte@green5>
MIME-Version: 1.0
In-Reply-To: <20230410051352.36856-2-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmuq7QRZMUg+nn5SxW3+1ns5j24Sez
        xe+z55kt/nbdY7J4enUWk8XeW9oWhyY3M1nsm+Vp8bi7g9GB0+PyFW+Py2dLPXqb37F57Gy9
        z+rxft9VNo++LasYPT5vkvNoP9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA3SbkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        pECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+O8dpaCiyYVjd1/WRsYL+l0MXJwSAiYSHz8XN/F
        yMUhJLCbUWLl38XMEM4nRolp158yQTjfGCUWtl5n62LkBOs4cnk+C4gtJLCXUeL4xSSIoieM
        Eu+mPgIrYhFQldiwajsryAo2AW2J0/85QMIiAuoSUw/0sILUMwtcYpSY+eEZM0iNsICjxOF/
        1SA1vEDzn2/byA5hC0qcnPmEBaSEEyi+f1oVSFhUQEZixtKvYIdKCMzlkFh4dSsjxDcuEg+b
        0iDOFJZ4dXwLO4QtJfGyvw3KLpdYOWUFG0RvC6PErOuzGCES9hKtp/qZQWxmgXSJD09uQsVl
        JaaeWscEEeeT6P39hAkiziuxYx6MrSyxZv0CaPhISlz73ghle0j8/naXDRI+G4Fh9WA3ywRG
        +VlIfpuFZB+EbSXR+aGJdRbQP8wC0hLL/3FAmJoS63fpL2BkXcUomVpQnJueWmxaYJiXWg6P
        7uT83E2M4ISr5bmD8e6DD3qHGJk4GA8xSnAwK4nwfv1vnCLEm5JYWZValB9fVJqTWnyI0RQY
        VROZpUST84EpP68k3tDE0sDEzMzMxNLYzFBJnFfd9mSykEB6YklqdmpqQWoRTB8TB6dUA5PW
        32fh/x8t4Lee42Dt+POJ2KIjSn9Mb2cyhKq0h14XvPkm9KrJStFsm0sJ0zb1d4XrzKybyO6j
        Ms2C9aZJrWqrGYvClZ9iN+vrxZ7E6V47//5AxSXu27X8jq89lhxidLzyLcfR+mFejypvQNa1
        oDDDuuKK7vKjLputT3x718VhcONIyMtVtcnK3x49Wriqy+lghv6b7/zWa4zkuSbonlU9/eDQ
        uVM781OcZ0iv3SL9dnbmslP9lzexum5f5njd5mRhnUjUz9p3rLtmB6xbzes1Z2HC26NmmWuX
        FIr6Xts4MaNDoMtY9vSzOTtslsxNcvTeGyij8M3uY7WJ0dM0h/O70ztKVvRv2SNy8bCBe7sS
        S3FGoqEWc1FxIgBflZqQQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO4Fb5MUgzerRC1W3+1ns5j24Sez
        xe+z55kt/nbdY7J4enUWk8XeW9oWhyY3M1nsm+Vp8bi7g9GB0+PyFW+Py2dLPXqb37F57Gy9
        z+rxft9VNo++LasYPT5vkvNoP9DNFMARxWWTkpqTWZZapG+XwJVx79Fy5oI2o4ru+QvZGhgX
        anUxcnJICJhIHLk8n6WLkYtDSGA3o8TVOZcZIRKSEsv+HmGGsIUlVv57zg5R9IhR4tqJw6wg
        CRYBVYkNq7YD2RwcbALaEqf/c4CERQTUJaYe6GEFqWcWuMQosejzWWaQGmEBR4nD/6pBaniB
        Fj/ftpEdxBYSiJV4Pn8WO0RcUOLkzCcsIDazgJnEvM0PwVqZBaQllv/jADE5gVr3T6sCqRAV
        kJGYsfQr8wRGwVlImmchaZ6F0LyAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        pGhp7mDcvuqD3iFGJg7GQ4wSHMxKIrxf/xunCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUy
        XkggPbEkNTs1tSC1CCbLxMEp1cDUY+e559CVzqL700RXFb47qDFZ3urRYcf6VcWdbyaXd535
        qDKzS7ye0T386oytPJPa175a2J4l/yTrjcLWZf9KHvtd92V5kLTqeVzYRxWfdY1+u7p71qmc
        3yTdXnE4Xe3UncX6uatW+2iGnNvYZSDHZuXtIjRrQ8REdVnOjW/vOM4wSP1+PHjerwuhy5bF
        yH0Lr1l63XFJneGmJ1vWXClcIMi2hnHq2jW2bLHZMZq3k13ufLpl4j8zWyt1ynah7exSXZ/F
        8nmu78kxlg3KNnumwuN/Nv79PslVD9/+38Yt/i8n+5napCnhwZe2ZPyfJq0io251N1g37VfX
        Ta9+/Z1bhSRLnGRnnyuwuNnEun+BEktxRqKhFnNRcSIA/cZkTQMDAAA=
X-CMS-MailID: 20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_61fe_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8
References: <20230410051352.36856-1-kch@nvidia.com>
        <20230410051352.36856-2-kch@nvidia.com>
        <CGME20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_61fe_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/04/09 10:13PM, Chaitanya Kulkarni wrote:
>Move null_param_store_int() function to the top of the code so that
>it can be accessed by the new NULL_PARAM() macro. The macro takes
>name of the module parameter, minimum value, and maximum value as
>input, then creates specific callback functions and kernel_param
>ops for each module parameter. This macro ultimately calls the
>null_param_store_int() function, which returns an error if the
>user-provided value is out of bounds(min,max).
>
>To prevent negative values from being set by the user for following
>list of module parameters, uses NULL_PARM() macro to add user input
>validation:
>	submit_queues
>	poll_queues
>	queue_mode
>	gb
>	max_sectors
>	irqmode
>	hw_qdepth
>	bs
>
>This commit improves the organization and safety of the code, making
>it easier to maintain and preventing users from accidentally setting
>negative values for the specified parameters.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> drivers/block/null_blk/main.c | 85 +++++++++++++++++------------------
> 1 file changed, 41 insertions(+), 44 deletions(-)
>
>diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>index bc2c58724df3..fcb2ce4f9dc8 100644
>--- a/drivers/block/null_blk/main.c
>+++ b/drivers/block/null_blk/main.c
>@@ -77,6 +77,33 @@ enum {
> 	NULL_IRQ_TIMER		= 2,
> };
>
>+static int null_param_store_int(const char *str, int *val, int min, int max)
>+{
>+	int ret, new_val;
>+
>+	ret = kstrtoint(str, 10, &new_val);
>+	if (ret)
>+		return -EINVAL;
>+
>+	if (new_val < min || new_val > max)
>+		return -EINVAL;
>+
>+	*val = new_val;
>+	return 0;
>+}
>+
>+#define NULL_PARAM(_name, _min, _max)					\
>+static int null_param_##_name##_set(const char *s,			\
>+				     const struct kernel_param *kp)	\
>+{									\
>+	return null_param_store_int(s, kp->arg, _min, _max);		\
>+}									\
>+									\
>+static const struct kernel_param_ops null_##_name##_param_ops = {	\
>+	.set = null_param_##_name##_set,				\
>+	.get = param_get_int,						\
>+}
>+
> static bool g_virt_boundary = false;
> module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
> MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
>@@ -86,11 +113,13 @@ module_param_named(no_sched, g_no_sched, int, 0444);
> MODULE_PARM_DESC(no_sched, "No io scheduler");
>
> static int g_submit_queues = 1;
>-module_param_named(submit_queues, g_submit_queues, int, 0444);
>+NULL_PARAM(submit_queues, 1, INT_MAX);
>+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
> MODULE_PARM_DESC(submit_queues, "Number of submission queues");
>
> static int g_poll_queues = 1;
>-module_param_named(poll_queues, g_poll_queues, int, 0444);
>+NULL_PARAM(poll_queues, 1, num_online_cpus());
>+device_param_cb(poll_queues, &null_poll_queues_param_ops, &g_poll_queues, 0444);
> MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
>
> static int g_home_node = NUMA_NO_NODE;
>@@ -116,45 +145,23 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
> #endif
>
> static int g_queue_mode = NULL_Q_MQ;
>-
>-static int null_param_store_val(const char *str, int *val, int min, int max)
>-{
>-	int ret, new_val;
>-
>-	ret = kstrtoint(str, 10, &new_val);
>-	if (ret)
>-		return -EINVAL;
>-
>-	if (new_val < min || new_val > max)
>-		return -EINVAL;
>-
>-	*val = new_val;
>-	return 0;
>-}
>-
>-static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
>-{
>-	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
>-}
>-
>-static const struct kernel_param_ops null_queue_mode_param_ops = {
>-	.set	= null_set_queue_mode,
>-	.get	= param_get_int,
>-};
>-
>+NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ);
> device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
> MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
>
> static int g_gb = 250;
>-module_param_named(gb, g_gb, int, 0444);
>+NULL_PARAM(gb, 1, INT_MAX);

This value gets converted to mb, for dev->size calculation in
null_alloc_dev. I think either there should be a type conversion or
this module parameter max value can be reduced to smaller value.

>+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
> MODULE_PARM_DESC(gb, "Size in GB");
>
> static int g_bs = 512;
>-module_param_named(bs, g_bs, int, 0444);
>+NULL_PARAM(bs, 1, PAGE_SIZE);
>+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
> MODULE_PARM_DESC(bs, "Block size (in bytes)");
>
> static int g_max_sectors;
>-module_param_named(max_sectors, g_max_sectors, int, 0444);
>+NULL_PARAM(max_sectors, 1, INT_MAX);
>+device_param_cb(max_sectors, &null_max_sectors_param_ops, &g_max_sectors, 0444);
> MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>
> static unsigned int nr_devices = 1;
>@@ -174,18 +181,7 @@ module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
> MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submission queues for blk-mq");
>
> static int g_irqmode = NULL_IRQ_SOFTIRQ;
>-
>-static int null_set_irqmode(const char *str, const struct kernel_param *kp)
>-{
>-	return null_param_store_val(str, &g_irqmode, NULL_IRQ_NONE,
>-					NULL_IRQ_TIMER);
>-}
>-
>-static const struct kernel_param_ops null_irqmode_param_ops = {
>-	.set	= null_set_irqmode,
>-	.get	= param_get_int,
>-};
>-
>+NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER);
> device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
> MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
>
>@@ -194,7 +190,8 @@ module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
> MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
>
> static int g_hw_queue_depth = 64;
>-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
>+NULL_PARAM(hw_qdepth, 1, INT_MAX);
>+device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
> MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
>
> static bool g_use_per_node_hctx;
>-- 

Regards,
Nitesh Shetty

>2.29.0
>

------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_61fe_
Content-Type: text/plain; charset="utf-8"


------DBoZ3SwRANBUL.4oxx5P7t7PoRgN1JiEjGDoy8d5VOZGQ23m=_61fe_--
