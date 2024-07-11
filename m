Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614F15FA66
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721335; cv=none; b=Q4a4GKl0v9hB0JK7C8WsWwi+0jkzTwkC/RYWPrfe4oNQi3imeo6FgVXW1kgs3yELsPwktxe7YMO/UAEoEk0Pq2tLdmO7L3yoU56pGfI9sWuduVEye1lyAveG/9K6TOemdpFSviKgWzGWJf6pRq45khjeVMRtoRvYqvrl562rKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721335; c=relaxed/simple;
	bh=UJvtSa36BcXaCfZWRW7OhN0lYiioP20cRH/JJxP1jx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLbss4VWa7SnnD5CbbZiBjgxD8UixEOTK7lFpcDCFNh1cE2V2kHEvq5FsihLtATENinKHyR81oJQBpS5ZJ+W5odZVevx+yg0nKQX5lHtk2+4b9CM+2ZmcraZLf//jr4FwnJh1YopGz+9kTgp3DHdkVLd5Uuik1PO2jEtA/PoCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RwGMd9Qo; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RwGMd9Qo"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjQr4c26z6CmM6f;
	Thu, 11 Jul 2024 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721331; x=1723313332; bh=l2xdF9PB28aF0QZZtdwTCtlR
	aZIEnYfSF2hg9I5ntUM=; b=RwGMd9QoOaXHEU3HtqcK6f7r2vzdQlR+pxlZCAFf
	tsaqRMfv1l6H8IXrt5Slqq4pqoi/QJrFXfK/+XFt4H5Mfrh2x0JSJvdcbfjd0/QX
	nv9SO1Jdap1P04v1/eKcNagejA3BTRZN2hXKXoG7j4MR36ZD+XAMpq4t22hGhCbM
	DOCJYTn9ZR64Eusdt15kIeNYqjIcRl+kKLMxupjl5zms28q3nSWIYCcg9ZbHHXNp
	8UPiBPkbYUMo1PftZo5eh31q/0hcnGedAPb+vUOx8g5rxhKVOjKwBSjdT2qNNDL0
	UmriTo+fHBMPfdZ1CQ85HTT9tmVL37VhwP0al6pj/XgagQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aDbgW29roNMt; Thu, 11 Jul 2024 18:08:51 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjQp4zWyz6CmM6X;
	Thu, 11 Jul 2024 18:08:50 +0000 (UTC)
Message-ID: <b97da63e-386d-4cb0-9bf1-cfbe00154979@acm.org>
Date: Thu, 11 Jul 2024 11:08:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] block: Catch possible entries missing from
 hctx_state_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-5-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 89ba6b16fe8b..225e51698470 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -664,12 +664,14 @@ enum {
>   	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
>   	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
>   
> +	/* Keep hctx_state_name[] in sync with the definitions below */
>   	BLK_MQ_S_STOPPED	= 0,
>   	BLK_MQ_S_TAG_ACTIVE	= 1,
>   	BLK_MQ_S_SCHED_RESTART	= 2,
>   
>   	/* hw queue is inactive after all its CPUs become offline */
>   	BLK_MQ_S_INACTIVE	= 3,
> +	BLK_MQ_S_MAX,

Please create a new "enum {" section for the BLK_MQ_S_ constants.
That will make it more clear that these are unrelated to the other
constants defined above and below the BLK_MQ_S_ constants.

Thanks,

Bart.

