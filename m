Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F6ECF
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142168; cv=none; b=dAOGcWPN6qEgr02rstchhIxdzgogeN2kHiF4xRPjLEH8UocqHbTH52ckvadahBTT3rdlA/0/2psgr/D/GrqwecZKNsz+PhHiXWttT78fuSQZFf7N6wawjhzjDazZhoAqQ4tQsUVFkZ5SrzzsJi93J3MjOn6bqa6UKwSfGfQh2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142168; c=relaxed/simple;
	bh=JuKeddq/NZJ23owvLwTGs0VqCSoGb3p4DR3ZWB9DtEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLFJOSLS1HN90LePmJMvOhvC63ajArcJwrGsbrJFk7v1ucf8UlIKTL41DRnQ+T610tJrWWde73EP13lhJ0RSciWdz3cEkJdZ3eCTv0WoIOZtHl2VdcQOiMIPgS9nYza5DroNvg754ODBmRiZPnq/da+FX4XoiIhhW6npZdX2AKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1/F4s0/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1/F4s0/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206bd1c6ccdso47392365ad.3
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727142165; x=1727746965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5U5h2o+R4V+kWxS9sRe3rjMX3HGj7N0fd21X4yTr2E=;
        b=Y1/F4s0/3R9NkDtz9gGU17uO94ipyy3VcFWa9J08wR2ZnfuGnSB/+ksXnxCCqEUoNk
         jadFiPIWIiwImA8xFxqO9T5FuCakqTz2GXncNHcdQKAwHM/nfPu9r0EENcnZK2FcDa4N
         YletwK9HB1v3OKLcVKscfR498xHdmoiu7YEp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727142165; x=1727746965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5U5h2o+R4V+kWxS9sRe3rjMX3HGj7N0fd21X4yTr2E=;
        b=lhQ7bjtRuG4va+t8KWRF40ZdIcPQfAHhrOQG4CWBfotC0kMA+5SbzxNH/5nEUuWP2K
         oCg7IbaMPBV5raIIny4WbZDBFQfFbv8dLFvWyrJF0t8FGykSw81U5/g+a8FN18vNDjHL
         pct6m4WrjXEmbdN5GI94kNNewcCK4rfCsrgrxeR4FDB47ayPPAVES6HpKyVOfiQirCSW
         qnfV5zAto6yonP5bLbV8Y8FjnmqE8+O7JBSyaQlB3/DuyH7dUQiU2CZlqNeUmCe4c+aJ
         iEUuwilpY42KzDH7WifAaZRiiClZPNJYH6AH/s3Qu44KAnYlgJgFiUok7FXcG35svwiN
         LAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCViMkEiOwIRG86uJPsRaw4TKWPqx8BF30E2JpUeaWmnGVUwDU8WchOfhPJiWOQTIVkNh3ZKjk1i1cflBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9HaXN6sAP4bTP1s+nOHb1simMZuaGma48PKuMtl7Q4UsmJOY
	9yJuOE05BkWsmED8TndlswDA0CnP47pfg7tqGh8FkVhqwSjg5zc9ItoimiKKBg==
X-Google-Smtp-Source: AGHT+IHV6/dTyEZ8sZ6kQBQHcdMBqSXN3Jk7m4gAzsWcbmoTfUJtBlqGs9MnNfSG4mO65lIYYCWEmA==
X-Received: by 2002:a17:902:ea07:b0:20a:f013:ddb5 with SMTP id d9443c01a7336-20af013e29dmr12012765ad.59.1727142165567;
        Mon, 23 Sep 2024 18:42:45 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af181923fsm1596025ad.203.2024.09.23.18.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 18:42:45 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:42:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924014241.GH38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>

On (24/09/23 19:48), Andrey Skvortsov wrote:
> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> so we need to make sure that we don't attempt to kfree() the
> statically defined compressor name.
> 
> This is detected by KASAN.
> 
> ==================================================================
>   Call trace:
>    kfree+0x60/0x3a0
>    zram_destroy_comps+0x98/0x198 [zram]
>    zram_reset_device+0x22c/0x4a8 [zram]
>    reset_store+0x1bc/0x2d8 [zram]
>    dev_attr_store+0x44/0x80
>    sysfs_kf_write+0xfc/0x188
>    kernfs_fop_write_iter+0x28c/0x428
>    vfs_write+0x4dc/0x9b8
>    ksys_write+0x100/0x1f8
>    __arm64_sys_write+0x74/0xb8
>    invoke_syscall+0xd8/0x260
>    el0_svc_common.constprop.0+0xb4/0x240
>    do_el0_svc+0x48/0x68
>    el0_svc+0x40/0xc8
>    el0t_64_sync_handler+0x120/0x130
>    el0t_64_sync+0x190/0x198
> ==================================================================
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> Cc: <stable@vger.kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
