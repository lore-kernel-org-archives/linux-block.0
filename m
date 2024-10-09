Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07288198A19;
	Wed,  9 Oct 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478595; cv=none; b=cpj7A4iYhLHTS+cry4WDbbRs25YI5KqIOYID+LCexvkMMU6CILKYk+oSnU9FUzsqnpOPJK2H8LqnQAIVpGdZ8FdJwzs0iB8b2eKSpyu1JoGlAK2Nyb31FZe3gY2nyhi5Q95ZXgbEm354dT0nmRWGFCCq3IJCYB+JOjH0oX5ldqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478595; c=relaxed/simple;
	bh=9oPri9qqasBMmB9DQz59K5YGMiMULcNaNeBLDi08+8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asCCZiuesvHlOCEvv31z+7QnzUr1iYUIJrhAdElaDaJ7Zw2YiWWlpNVf/gxUg71WfvObjrHLrt3rcXPWgYnI0M0Lwc45qh/7Yk7RxDPWrURkpcjhTOmQASJqwmIZP2G91R8DCr4O4HFx6gzQJ/KzFnrRH/u2WTBDOdwLoqTRp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=lULr2O2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RjjuVzkA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="lULr2O2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RjjuVzkA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C13DE13802E0;
	Wed,  9 Oct 2024 08:56:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 08:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728478589;
	 x=1728564989; bh=/AzJW0N5KlzFwGk56ZS/QWVVUxZznWUyJSgRHfPVWIs=; b=
	lULr2O2iRO1OFbj6r6ObkI0ABNLJjclHuTgiYorMmC9yXQsEe8LQeAeMDiUcOQsb
	r31e5qauOKL8zrg7qs5D4Xk4KmH3UQSeTtXaJ/sUEHAeZg9DFDuNnyzCKN7TYrVV
	PQnj8B5ksdzZUJtvHbGpvVx0h7TrOFYAr/uPTGCffC8mc7KpWf027cGgYFAnPG47
	cO4M5sewayP1WLHtfh9YnuHMt+B4v4dl3M8q4J2ahcNiHWUeVRgjZKXTRTVXZioa
	Jv4ZN6cfTbudRH1VaTQkEZgWjchT9UMQ9fMaM7r+1L05I+cHM1Cq7IBpRPqgDvke
	27AhnctxkEpRwW7pN0CQ4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728478589; x=
	1728564989; bh=/AzJW0N5KlzFwGk56ZS/QWVVUxZznWUyJSgRHfPVWIs=; b=R
	jjuVzkAacpX+gyzYy057yWObbkKF7JTsN8fr4sstvMXl5cJtyMcn5kK74M/3Qre3
	a3hZtul0rdZM04Cjf5ZX/5Do42MQYGzTOhS3aaQVz83bCuL8bXSYdjaQtS5jzhf5
	IfUQ/ARdADkZyzMZs4Ec3tBKsh8HxT6px2a4JR1d1d23All/xp4nNuPudsnzZqSf
	gTq8xq9fD8gXXYgG80QWmQ903Pov46Xsm9JtEYZ5P7dwppUPz0dxcnL6A2uySKDm
	skfZ7DWHB6LiEDjOwWJ2otnb2FMMa7sc19S6IBn1W4pQKyNXZvHzbfA+wDKTHDG8
	BmzioGSWxbXsjHUzOA0+w==
X-ME-Sender: <xms:fX0GZ1llMCZbH9_N2veLB2gplhiLomVR4rtoG1e0jMLZElTbBh8CXw>
    <xme:fX0GZw05q6GyQ2C4mukE0zCXM55Da1mbKve8ielUym5L0dfpTv61OSd-Wqoe8U_XF
    9h5iuWmT8DjXagwpQI>
X-ME-Received: <xmr:fX0GZ7pQhYC9dx2FFvPGUy7xO3dpYehkZDK-lxdSxNjD5quHB4RoflxRFQYxdhY15ZX6py2yGXN7ccYb5xXwkTrM5Kr9Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepleehjefftdeijedvveeigffhgfdugeduieevudeh
    jeefueffkeegjeffiefgheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hm
X-ME-Proxy: <xmx:fX0GZ1nnpXu1rct-gfyhbSgHB7IZA7ONhaJPKP60XIzMaS7ocQrSjg>
    <xmx:fX0GZz07zWNh69s0gFFlE0a4_s3PYQM-YOevdx_ksqrjzfMkb-edfg>
    <xmx:fX0GZ0ujveQY0oaLlJO5t01xYP4ZQpFmVs43y3gKx6n0nEQ1vVXKFQ>
    <xmx:fX0GZ3V6NcvneDu72cF5w0lTuYN2bIuiRAzr6OQbHmdRGKoAmhzfGw>
    <xmx:fX0GZ8LbcTilPp9YiRHz1t4rN8-BenERTb0jg7wtxVYhgjtEolQvKdMN>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 08:56:28 -0400 (EDT)
Message-ID: <45a1326c-8a36-4f23-b5e6-c89bbefc5005@bjorling.me>
Date: Wed, 9 Oct 2024 14:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add rotational support
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <ZwVMLIt4iFX9MUjV@kbusch-mbp> <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09-10-2024 00:04, Keith Busch wrote:
> On Tue, Oct 08, 2024 at 09:13:48AM -0600, Keith Busch wrote:
>> I still hope to see nvmet report this. It would be great to test this
>> with HDD backed nvme-loop target.
> 
> I took the liberty to write one up. Looks like everything is reporting
> as expected.
> 
> ---
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 954d4c0747704..e167c9a2ff995 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -685,6 +685,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
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
> @@ -729,6 +758,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   			break;
>   		}
>   		break;
> +	case NVME_ID_CNS_NS_CS_INDEP:
> +		nvmet_execute_id_cs_indep(req);
> +		return;
>   	}
>   
>   	pr_debug("unhandled identify cns %d on qid %d\n",
> --

That was quick! Nice. Would you like me to pack it up in the serie and 
resend?

