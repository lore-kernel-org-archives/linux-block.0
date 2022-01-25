Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78957C4332F
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiAYWEp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:04:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233516AbiAYWET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 17:04:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PKgGjK030390;
        Tue, 25 Jan 2022 22:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=F4JBTwyR5BGtqMhV9DMpC4VwdHN6CopKcYvy9zDs1To=;
 b=KLCEXNckUXY/Uj22j/COE8mkcFHnkYFCypDerTTOvbe89IMSFxnNx5gnWzfjmsRQqeX7
 GgfdDi8WF98JYFHSyJ4cIK1JeJE73VqLeV9kmvLD3QJ/RxwJKW7Jm7JLNbvVDomE2LJY
 IFLsKxfOflNyWdIG5hKMiqnwW4wzNb9XNSxkJQqDmY/YFk7+NfRc2zpHDNBUg8J5P6Fx
 S9b+0ckutpac6W2XkXlNs6QQgt/H13M+Ts643C5GHyb9nC9aXquhA/4yLjrIvaW/upVD
 8LZf5KfQedIERZluHJdUz41ISfh7cKZKw5LiiLVW7TncIlr43lA/81ca7R8JzUpeEMzQ 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtrfn9fe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:03:52 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PKgrZH003336;
        Tue, 25 Jan 2022 22:03:51 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtrfn9fdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:03:51 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PLvnss002588;
        Tue, 25 Jan 2022 22:03:50 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3dr9ja6g5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:03:50 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PM3ngs31457570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:03:49 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4470712405E;
        Tue, 25 Jan 2022 22:03:49 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CA0124058;
        Tue, 25 Jan 2022 22:03:48 +0000 (GMT)
Received: from [9.65.70.134] (unknown [9.65.70.134])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:03:48 +0000 (GMT)
Message-ID: <10a8fbc8-c242-af90-2a3f-d55cd27497a8@linux.vnet.ibm.com>
Date:   Tue, 25 Jan 2022 16:03:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] block: sed-opal: Add ioctl to return device status
Content-Language: en-US
To:     luca.boccassi@gmail.com, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sbauer@plzdonthack.me,
        Jonathan.Derrick@solidigmtechnology.com
References: <20220125215248.6489-1-luca.boccassi@gmail.com>
From:   Douglas Miller <dougmill@linux.vnet.ibm.com>
In-Reply-To: <20220125215248.6489-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cqS0c4y9SzugQBvRfQ_6Wo0AgrJxZsEB
X-Proofpoint-ORIG-GUID: HVtopJAENO7v3zhjWUikhpRaNWDIUUto
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_05,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201250132
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/22 15:52, luca.boccassi@gmail.com wrote:
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> 
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> ---
> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> v3: resend on request, after rebasing and testing on my machine
> 
>   block/opal_proto.h            |  5 ++
>   block/sed-opal.c              | 90 ++++++++++++++++++++++++++++++-----
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h | 12 +++++
>   4 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index b486b3ec7dc4..7152aa1f1a49 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -39,7 +39,12 @@ enum opal_response_token {
>   #define FIRST_TPER_SESSION_NUM	4096
> 
>   #define TPER_SYNC_SUPPORTED 0x01
> +/* FC_LOCKING features */
> +#define LOCKING_SUPPORTED_MASK 0x01
> +#define LOCKING_ENABLED_MASK 0x02
> +#define LOCKED_MASK 0x04
>   #define MBR_ENABLED_MASK 0x10
> +#define MBR_DONE_MASK 0x20
> 
>   #define TINY_ATOM_DATA_MASK 0x3F
>   #define TINY_ATOM_SIGNED 0x40
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index daafadbb88ca..3a9c235be323 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -74,8 +74,7 @@ struct parsed_resp {
>   };
> 
>   struct opal_dev {
> -	bool supported;
> -	bool mbr_enabled;
> +	u32 flags;
> 
>   	void *data;
>   	sec_send_recv *send_recv;
> @@ -280,6 +279,30 @@ static bool check_tper(const void *data)
>   	return true;
>   }
> 
> +static bool check_lcksuppt(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_SUPPORTED_MASK);
> +}
> +
> +static bool check_lckenabled(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_ENABLED_MASK);
> +}
> +
> +static bool check_locked(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKED_MASK);
> +}
> +
>   static bool check_mbrenabled(const void *data)
>   {
>   	const struct d0_locking_features *lfeat = data;
> @@ -288,6 +311,14 @@ static bool check_mbrenabled(const void *data)
>   	return !!(sup_feat & MBR_ENABLED_MASK);
>   }
> 
> +static bool check_mbrdone(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & MBR_DONE_MASK);
> +}
> +
>   static bool check_sum(const void *data)
>   {
>   	const struct d0_single_user_mode *sum = data;
> @@ -435,7 +466,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
>   	u32 hlen = be32_to_cpu(hdr->length);
> 
>   	print_buffer(dev->resp, hlen);
> -	dev->mbr_enabled = false;
> +	dev->flags &= OPAL_FL_SUPPORTED;
> 
>   	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
>   		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
> @@ -461,7 +492,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
>   			check_geometry(dev, body);
>   			break;
>   		case FC_LOCKING:
> -			dev->mbr_enabled = check_mbrenabled(body->features);
> +			if (check_lcksuppt(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_SUPPORTED;
> +			if (check_lckenabled(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_ENABLED;
> +			if (check_locked(body->features))
> +				dev->flags |= OPAL_FL_LOCKED;
> +			if (check_mbrenabled(body->features))
> +				dev->flags |= OPAL_FL_MBR_ENABLED;
> +			if (check_mbrdone(body->features))
> +				dev->flags |= OPAL_FL_MBR_DONE;
>   			break;
>   		case FC_ENTERPRISE:
>   		case FC_DATASTORE:
> @@ -2109,7 +2149,8 @@ static int check_opal_support(struct opal_dev *dev)
>   	mutex_lock(&dev->dev_lock);
>   	setup_opal_dev(dev);
>   	ret = opal_discovery0_step(dev);
> -	dev->supported = !ret;
> +	if (!ret)
> +		dev->flags |= OPAL_FL_SUPPORTED;
>   	mutex_unlock(&dev->dev_lock);
> 
>   	return ret;
> @@ -2148,6 +2189,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
> 
>   	INIT_LIST_HEAD(&dev->unlk_lst);
>   	mutex_init(&dev->dev_lock);
> +	dev->flags = 0;
>   	dev->data = data;
>   	dev->send_recv = send_recv;
>   	if (check_opal_support(dev) != 0) {
> @@ -2528,7 +2570,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>   	if (!dev)
>   		return false;
> 
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>   		return false;
> 
>   	mutex_lock(&dev->dev_lock);
> @@ -2546,7 +2588,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>   			was_failure = true;
>   		}
> 
> -		if (dev->mbr_enabled) {
> +		if (dev->flags & OPAL_FL_MBR_ENABLED) {
>   			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
>   			if (ret)
>   				pr_debug("Failed to set MBR Done in S3 resume\n");
> @@ -2620,6 +2662,24 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
>   	return ret;
>   }
> 
> +static int opal_get_status(struct opal_dev *dev, void __user *data)
> +{
> +	struct opal_status sts = {0};
> +
> +	/*
> +	 * check_opal_support() error is not fatal,
> +	 * !dev->supported is a valid condition
> +	 */
> +	if (!check_opal_support(dev)) {
> +		sts.flags = dev->flags;
> +	}
> +	if (copy_to_user(data, &sts, sizeof(sts))) {
> +		pr_debug("Error copying status to userspace\n");
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
>   int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   {
>   	void *p;
> @@ -2629,12 +2689,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   		return -EACCES;
>   	if (!dev)
>   		return -ENOTSUPP;
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>   		return -ENOTSUPP;
> 
> -	p = memdup_user(arg, _IOC_SIZE(cmd));
> -	if (IS_ERR(p))
> -		return PTR_ERR(p);
> +	if (cmd & IOC_IN) {
> +		p = memdup_user(arg, _IOC_SIZE(cmd));
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +	}
> 
>   	switch (cmd) {
>   	case IOC_OPAL_SAVE:
> @@ -2685,11 +2747,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   	case IOC_OPAL_GENERIC_TABLE_RW:
>   		ret = opal_generic_read_write_table(dev, p);
>   		break;
> +	case IOC_OPAL_GET_STATUS:
> +		ret = opal_get_status(dev, arg);
> +		break;
>   	default:
>   		break;
>   	}
> 
> -	kfree(p);
> +	if (cmd & IOC_IN)
> +		kfree(p);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(sed_ioctl);
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 1ac0d712a9c3..6f837bb6c715 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>   	case IOC_OPAL_MBR_DONE:
>   	case IOC_OPAL_WRITE_SHADOW_MBR:
>   	case IOC_OPAL_GENERIC_TABLE_RW:
> +	case IOC_OPAL_GET_STATUS:
>   		return true;
>   	}
>   	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 6f5af1a84213..c55bc79e3128 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -132,6 +132,17 @@ struct opal_read_write_table {
>   	__u64 priv;
>   };
> 
> +#define OPAL_FL_SUPPORTED		0x00000001
> +#define OPAL_FL_LOCKING_SUPPORTED	0x00000002
> +#define OPAL_FL_LOCKING_ENABLED		0x00000004
> +#define OPAL_FL_LOCKED			0x00000008
> +#define OPAL_FL_MBR_ENABLED		0x00000010
> +#define OPAL_FL_MBR_DONE		0x00000020
> +
> +struct opal_status {
> +	__u32 flags;
> +};
> +
>   #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>   #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>   #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -148,5 +159,6 @@ struct opal_read_write_table {
>   #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
>   #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
>   #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
> +#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
> 
>   #endif /* _UAPI_SED_OPAL_H */

I would like to withdraw this patch. We are going a different direction 
for our SED-OPAL support and will be submitting a new set of patches 
soon, which includes a different method of obtaining the discovery0 data.
