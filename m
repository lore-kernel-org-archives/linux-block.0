Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754465;
	b=O4o3gFaibA9aEZGSXXawVnz7aRMZrVCQ1oIBNK7RvwSHt+gW+BUa5uKpH88n781hnFZz
	 eFryqRL24c06b36khcqJfR7cNRW8mRpGWOd2dTc9PzmvWjOgYAZSFV7+6+lKurAuKPoZC
	 Vv/efXZKNIKUAF9Cjqg4FDQeVqntTLX6m70FsKkenPHSOYscsj3EU5Ff2N010wJNkV62L
	 SF0+kAPA0GxaRjZP8rl37Wo3TSJQpz6E927HRXmuS9Sugn70unlfVohfuaLAvIytRRIfk
	 Dw0q3AQpsZQcBsZKbvosJk995kfXR2v1tKinqGlO7GYQMjKJNDIIFuCObGzP8D4Vetw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
	b=O/7EDlwjB8O2417OPIg54v3syogltgFZj4+6+vi9L7YNJRb94wZKndLaL0LfurTBSg4k
	 aPTovlZnWa0OgrayVNZca0ek650Dbr9AgxgAFhZ11pnZbiI/9SD9cFtTl+H6a+AwlhO7o
	 7ngze8KTsN5+W47C97uRhdGUNgy87xt/5n4giMe68kWrqGPQVEIlTBK2uY9HubFJ0U74W
	 y8El/GeauNozPGcpLMLW6fZ9gLRckQqyRPh/Ao84zSe260/eJ77BXpapgK+JM1DW1EfR6
	 HjWcI1vpRasBWq+HpB9MAgUTFEYtmB45soaC9jTtM4vPFEmQnvC7WLOgiEglJkvcCFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x74JWfN5;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DE606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 01:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x74JWfN5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a208d93758so1173675e9.3
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 17:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754463; x=1794359263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
        b=x74JWfN5h8ikXShPfz4EZ8TGJByCm/kix2rdXXQg+GWssuw/Jmx8f+11kO1OJKvkQx
         P6ptJKKG3pnuMuTPYPcUvf1vPG25sSvkhfc4LHjL9sVd1CfzGwxcVL5dcm/LvNH2jPOL
         /AmWRtRIk6qpwVompzpiz+IrXvZnsuZmuCwNb0pk6Qy8S5ozLPrPqFYDC967eEUffyHu
         TMGNHaORHxAaDKrpKfY1cTVaY3znb8Q4iEu/WK/SdK0X2Q87qsT6/fNNLkq0dyJVJDO2
         HW1tUYmxA9m/cy3GF94xTfSR2hUQYr+M/OuLs19JAv21wQZ/wtY2qI6cL5BGRn5xqyAZ
         tVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754463; x=1794359263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkoTUr12d3aBSwhfLu9j73ajMyz1vUUn+p4JbB9hc1c=;
        b=N9N3FvGd09tPV40rbLmCSKcRGvmHk8XetfUE3SjuEdL9B/0iXfFLmpbkZg/J1F+5Zj
         JDUUe7PLoGxMaVgfTRz3Vtu53VacplO+N3Ckm/hPfcdVMRcJ/uAwewAYwuHmR0aKvR4n
         I5XbaqxBZtgYAW9gnFx+APy3bsn4JmCHVGDC8+99H7zoDo2311vFESk35Z64ntQQCv0S
         C6fHsmIKEA8H+h50SbsU9K4hKoJJfB6ALB6i4hO2r0tfowEnseMRnJBoK3Cr1QoUjIWH
         wdsDAEf0kG2DOfvZG6BfwSA2jdoZxAi07K2Vhioei8u2+IlV7oDb/m1q9eaKh9b5eg9A
         5Cgw==
X-Gm-Message-State: APuU4Z9fvc0ePSYBOby8qztZxfCrGRhlwVPN9/ncHzKsGH8yNQMzi3MX
	W1uInJsCDGIvZL4agSgEDiPhg12G2IHECbGq072YKTsAzGG1E9xsoBMLtjccAQ==
X-Gm-Gg: AYBFou1nOS+K0DvwXqVhQHMX9fo20GDWQCGiqgXB/4eAKsdC+6Eq2hnIre8dXgn5DvP
	mVNFuv5QIu5jpAX/Et0GOToUtM2dDPVSPgIaZo1v0YsUhlLdoSR4kcumtNuV7MMGYPn2tuj06sg
	kIu3dcuT9ayfLhSvhhQQPl4YnyMNofE0tkcJfSYgSPu846/v0XJWkeCXS+8CJ2VjEMHI3FkxWJE
	aSZn1C34GpzoRF7qWsLx1dKMdj8HyAIHZCVcnETKbTEsnh/esj3hZaiN6BqQyypLxFPE6KwMBla
	nTLgJiIAPROU+Yy0A8TpWEeXD8GolMBfVrTym5GX/FE/FQ4krOHfdeSfHG9iyQDR+4OpA/KmNd/
	s/sQO/vz0a+yrifuxZTPi+7/RBaIdpmV2htKp66SY+65kVELQLccv588E4EhM6d5sb3Qiv0qKvk
	eDGf+uTP6yd7Hl+Ohl0o1qOoQXdiO3ZF3BVVtRhcRotGcP63kBF/bLYX6WDwC8dgKvPAyboykLI
	tjwt8qPVdwXf28pgyzrem4EZtz/JPmN1j4qDZHnd50pdm18c3EdE9p7btmwTmVvmXl47EqHXtgq
	VoSz/YxR4rDCDlk6FP25/unf6c7kW7/M/udjxye0hsw9HOSGQYfzC6LRyB7CFuKrpJmyN9hFBS/
	XFNbD3cZSnQBHaWPY7lfLDIUyXZ5KoxWMG/2FsuJvZiYL5RdsIL8YK6DtF8HIayzVx/9ul8Iwcr
	Ua0g==
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id 5b1f17b1804b1-4b3ad9d0e48mr50657685e9.12.1793754463523;
        Tue, 03 Nov 2026 17:07:43 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm181749615e9.14.2026.11.03.17.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:07:37 -0800 (PST)
Message-ID: <50be53a4-0136-4c8e-97bc-2cdc1caf76fd@gmail.com>
Date: Wed, 4 Nov 2026 01:07:35 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] allow dma-buf-io ctx reuse across files
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 00:18, Pavel Begunkov wrote:
> Currently, dma-buf maps can only be used by the file they were
> registered with. This means that we can't open a new file, even if it
> comes from the same subsystem and point to the same block device and
> use it with an old dma-buf registration. That would be too restrictive
> for upcoming filsystem support, so lift it now and allow reusing
> contexts between files pointing to the same NVMe, even if they refer
> to different partitions.
> 
> To do that, we add a tag representing for each file, save it from
> the file passed during registration and use it to reject files
> which tags don't match it. Tags are set by subsystems creating
> files, should be unique and represent the instance of the
> subsystem.

Fwiw, sashiko raised good points, I'll need to address
them in v2.

-- 
Pavel Begunkov

