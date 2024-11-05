Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC5DF5C;
	Tue,  5 Nov 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775650; cv=none; b=G6lWt0K/FiHl7So/A4m1dT46p7lxUbHq7xkMr6P0Z6m+qa0jkkpKw4jvHaVCtPplCsFoXC+2XHJ8HQ8eZdccxQlnSThmsz9SsGd3mziEZq/+irUSoSZ4a7P0BuVAVDruZu65nTBqFCQy7XZYCXnxqo4lZRdE2lUKgw7IkhM0Ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775650; c=relaxed/simple;
	bh=J4hH2bIq0QeSNnK6wcb1FrSMqUdGkUkwZYvooy+BnoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=he/IEQsLInP12mKFQOSVd77Js/H6/fhMZcogH/2g4/9GM+6VFg+12rbcWXJbiylbqdQg6Hru7slOJtNhXJx0YHkU+IaZU34MRXPr0UDC/xizQPZQCXoIKC23hdWLYeeYORVBufoUKzJIz/ESiy6KQBlXtvfGo6JNWsarafbNNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZlsJloln; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZlsJloln"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730775644; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=55NEy9DHeGDhSrsAwciZjYZ9pkn8zq6dUKZVxyN3tD0=;
	b=ZlsJlolnOLnR2aMhmPuMJmP6jd7dBSxZLps8VmL/urhdCo5p1yaZ3oSyXAvTZw2BXLw0mwL0YRn4nW076OaObQgZjQW5QttkkrhDXqI75qJMxljrL/BbwHBZnmcY/5KWjQIFQSDtpj50wa96pgr2XNXp3pqPl0DXoaGSMwY2Xg4=
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIlHpxb_1730775643 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 11:00:44 +0800
Message-ID: <45a15c19-cc26-4015-8f86-a258026acb01@linux.alibaba.com>
Date: Tue, 5 Nov 2024 11:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 3/3 v2] nvmet: add rotational support
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, kbusch@kernel.org,
 hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
 martin.petersen@oracle.com, hare@suse.de
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-4-m@bjorling.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241010123951.1226105-4-m@bjorling.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/10 20:39, Matias Bjørling 写道:
> From: Keith Busch <kbusch@kernel.org>
>
> Rotational block devices can be detected in NVMe through the rotational
> attribute in the independent namespace identify data structure.
>
> Extend nvmet with support for the independent namespace identify data
> structure and expose the rotational support of the backend device.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f7e1156ac7ec..f08f1226c897 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -675,6 +675,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>   		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
>   }
>   
> +static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep *id;
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	id->nstat = NVME_NSTAT_NRDY;
> +	id->anagrpid = req->ns->anagrpid;

Hi Matias,

Here should use "cpu_to_le32(req->ns->anagrpid)",

And I send 3 patches to support ns's respective vwc which depends on 
your patch,

you can search "[PATCH RFC 0/3] set nvme ns's vwc respectively" to find 
my patches,

waiting for your patch applied, and I will work continue.

Best Regards,

Guixin Liu

> +	id->nmic = NVME_NS_NMIC_SHARED;
> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> +		id->nsfeat |= NVME_NS_ROTATIONAL;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -719,6 +748,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_id_cs_indep(req);
> +		return;
>   	}
>   
>   	pr_debug("unhandled identify cns %d on qid %d\n",
