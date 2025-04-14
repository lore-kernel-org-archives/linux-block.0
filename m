Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A73FC2
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744659891; cv=none; b=JvzEZ2XTnW9pN8FVyHIdD3MyB/eSPZ5PQfBrfxGPnfq+BTLAZQhxyy9zf/l7umiE5aQFGHsa3xrzOVLIrFdRURRLGmf2HNljDJ9vPrmSW5/xihnu/rzrqdaMmvW5ZGrfs27YMIaWRepC4DQki4OLbYzEMCNcBroWdrVj8Ru9g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744659891; c=relaxed/simple;
	bh=p/UudInTphzTPt36+seJxEDmOreOBfcTL9jZ9oLK7kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stt/vFFagw6mY95vyQEHJbIbFhV7yya+dYlMJMja1lHxWTqkBI8/52Gpeg4P2rLCoHSfpyM8bZke8W9PTSaf7gxEPvji/aGw7iDqAO6Vm59fZDapjK3rCuseXIpnSRI6Bd9/4v/tFWTteJ2gRoFmPA2B5/OjhtJxO4eGZ4VVL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bJ9IMylZ; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bJ9IMylZ"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-73972a54919so4006425b3a.3
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744659888; x=1745264688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lS9UkXaxkSSh7KuHfE8/6BuZXfxxzN+gOlCsAN+DPp8=;
        b=bJ9IMylZGrspTKbWCG64mTsUhbE5LmfmlACqUynjP/qKVVYCsmnEz1Wd0fdvrtGacA
         rB5icxiFiauXfkdj6xUk4NhzkldWbhcDfG09vs7HWSW/uTzQMhUbgpN5BPemkEMOTC6Q
         zmLnElgVVTiB0W6ihqz9Pt9oStce4IcXKO27vZUeW+7X/XVsi+wpLRxvb25dDCPqP5gz
         FzwC9Criv6TPd7Fqp3dunFDDTRbNsh/4+dcg17wPXiHg8iO5fW03ABsxJdS340zD5Yl3
         0rrlt+YCwwsUO2D7cX6a95FUM3TGROsl21+l9gtLANGOYxEv1daxnT/K7Oxo2f18q9+y
         SqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744659888; x=1745264688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS9UkXaxkSSh7KuHfE8/6BuZXfxxzN+gOlCsAN+DPp8=;
        b=tPfcjO5mn77p9Hd5OYEfaq6wAW8FUu6o4xjOwDFhbDhng4xUXUuWqlruQO5fbfx/za
         ZIn2vVrGWPUVytxKn4Frfuv94JU5ipjZm3sFYOqh6paHPBox51Ub0d3t7emcJswCUAU4
         /cqoTUytijQHVb5LJWsotK49pdQt0glf0/VyZLcQDRzqoUTDQUUpXfPFfNfNDZ5TcsDY
         AipmLumhMK3OXUo2vLyYkz+ZrfOhZeY4i5Ls7epiX3Znl3kabAgLJhMsTGt9sOT2LVHo
         ndDbQ1CpARiEyjpWReI7Mnj2a/Du0eA/venqH6l7blmf+ezWwABoB3QVaJOtw+PaHEVw
         8J9g==
X-Forwarded-Encrypted: i=1; AJvYcCUocxVf9BcBSmQ+nYzUdJBsfMUJRnX8zogk8z2LxibGkMGQWMEy9jbM12lVjkVKKP5ZICZMS2NXAzDRjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0DEFLHiYXYip2z7gPO0iCn0Io0b8kF/n5a1svyKCyeTXPg+7
	zn+uALxTffpTMRoudYlqKpg2gsYQehDS+n/EsYbZHPW1IzO1TeTixKuvtMhZnqB/eI3eAEhjd+3
	51VSh29SJrUIbxOlHvhVU4bVIFG3dapojJvTEucCGUl2ReqfN
X-Gm-Gg: ASbGncsi94riYbC3YGdJes6sHdoaZW+PrsdzVbeeTPyYuUQuhql3NxsyoazL4+ZITf1
	/gkcdUmKTwrWyKnEu1PjRT3uxjonmvniG/ixwbu2C/HW38lIZZl8BrlzvUx1L06iu/tOrfqXQDX
	E0CPKm1OHe/nXcf5y5wLMBVJD1nX04gZpfHxyPwIE13x+hSIWzbCStHL+r9QTlVXBiqW01YsEC8
	qW1fPJwQsLHKy48vn9CZKHlWHsKrIxe2ln2FiNGf5xNFrC5oool7Di339rLxET3untAQhNeMhww
	QYyuAhuY9KTw6wPQfk2DLDxh6oabOj4=
X-Google-Smtp-Source: AGHT+IGsV4AW8ry15GyISHqmu/WkwKP2iXHWbAUFvAFMhmpY1dbPB+UtMt9lJ9jBGOhCUaKFbHVFy5aA5VcS
X-Received: by 2002:a05:6a00:390a:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-73bd12a82dbmr16365343b3a.23.1744659888210;
        Mon, 14 Apr 2025 12:44:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73bd1fe4f8asm426833b3a.0.2025.04.14.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:44:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 73CB03401C3;
	Mon, 14 Apr 2025 13:44:47 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 694A6E402BD; Mon, 14 Apr 2025 13:44:47 -0600 (MDT)
Date: Mon, 14 Apr 2025 13:44:47 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 1/9] ublk: don't try to stop disk if ->ub_disk is NULL
Message-ID: <Z/1lr233+THpllVI@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-2-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:42PM +0800, Ming Lei wrote:
> In ublk_stop_dev(), if ublk device state becomes UBLK_S_DEV_DEAD, we
> will return immediately. This way is correct, but not enough, because
> ublk device may transition to other state, such UBLK_S_DEV_QUIECED,
> when it may have been stopped already. Then kernel panic is triggered.

How can this happen? If a device is stopped, it is in the
UBLK_S_DEV_DEAD state. Won't that make us fall out of this check in
ublk_nosrv_work, so we wont transition to UBLK_S_DEV_QUIESCED or other
nosrv states?

	mutex_lock(&ub->mutex);
	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
		goto unlock;

