Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3893B47CE
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911735; cv=none; b=kdnNyD/7hcuA1oZtwGIg/Ch2KVyd7so2ZglM1gmO51hgYywP3zNeslVxdf0yHscgiGFnx1mgoF1tRL1LtaDRRYoaD5qflFpJVPh0F+1OZFbyZswq+zTc42xuYiuVHwP8qq8lAJVAbOz86999rheJM4/SOxRkGoHLdwSczhiIlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911735; c=relaxed/simple;
	bh=1dmeRQal/ZpVm0L/ivgF5rD0HGR4kfmAEzevbZOVQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r9r2HpErEiIIAYwkhG3f8iRNy/5yRnYYxVavCwch4q5mPd32BpKRr9aThGopLC9HZl4vXvtrUu14WUmtM5rN4c2GWzM2cZXRLbIPcVr0PAOAgSDSmwLi+8y5vC+WSx2a/95brzWWOv324fYOmn1y0N9U70IGYlwbwcxtXyF2BvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzf8yC86; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzf8yC86"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso7033425e9.3
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773911731; x=1774516531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUSCDB83co7ppHJl5GhGBtIfWncyhJhoxXMzlAxCrYI=;
        b=wzf8yC86DpJtwdWhAnDFGK/3yf2FrBYrtXmXESk/4rbB3QDQZ/6AXY+5ccQq1lJI+g
         lRFNrYEQUkUo9gf0kQRMB8GQzNVYYhHsS7rQlW3iRRRdurWMdlJMw6H1GHkTjuIkPz38
         1BRn1FDtqrLOyqqlDXGA3o4kjnGww+nZ5F1n6yrav7HxdzL13IPuHWnCvd9G0UOSam2f
         dFUw2zZ03dpucbAxV0KcW0FID7sT/8bY5dv27EDIW1xLx23/sDmMe/GkWhzb021X6YOh
         CdBJYOgVjhhfZp+oE1EOxFQkFv+qLfPirUDHcRA0aRDVHIV+41ssBmx/ChL9vMvxhpdp
         CyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773911731; x=1774516531;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUSCDB83co7ppHJl5GhGBtIfWncyhJhoxXMzlAxCrYI=;
        b=UV3O8LiqPLkm7bHf1CT8UxGca4NQKn37Ki+waNTeRAcUY/y35H5C6kyPzIdl1ZuD2Z
         qSToo511kJ6B9IUeFfiM0CW1xceh3958MmScrIsR7LyiCUyjQbw0zt0RGNcnpgBNwitO
         mBRCuT/051mIkwjxbxXy1Ko/4sXLAzZ3h2jcW4jLe5YLQbwYIDET1icAPC3Eg9jBkkx0
         vVTfkoMIcroWaEkrKOx4Jjwag6JHJiljfhpobhUrwWvZoVFQQmQcQIxq/rX2GA8rtvPr
         gqLVaSSdSdWT1zX6RghSrEQW+9a023XH0w68MeBGCyAKWvZJBDqu/7VdqRcCSeN3XUV5
         3+UA==
X-Forwarded-Encrypted: i=1; AJvYcCWJYokud55dU8IH9LMP+djhcQ3yz4HCnUxBK1elcgbeUY+Wr+kGP4ptnCXp2C1Ejxa17YMiTUJchWY5+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztg7fNbFOI/lQwFT8UpH4Ro/RXYn2aBYqHfIkc6lYWSoQEm3tv
	gtlDfNxEQ2su1afW1zNg/2muZe3DOW+6h4hiaaTI7bYfnbn1iiL/nK7sG/5ndGv+fNo=
X-Gm-Gg: ATEYQzx86J9WR2fBb3u9OIFUmltR+RlcK2clslsyAWOdGOf6NoIOdr9ZQtrSd+94YAi
	Z/3tD6LKqBfLgM18lZEpaANTqnq3jcWCIzbPkcg1maiimLD62upg5ZkSLWnaL/FKTIBeQaaO0gq
	xAiI+HIn0YN9feTk2M073kKsiLXQ3KCtEwosK3719C/WiNKuXqtfk/ojn7GrEO1OhSmdcAHaDEx
	uNZ6xUYf+qTD3YTzdserWFcuAPXFAFMS9ntcYghmxZVdjLAi3Wwsex2UQrQxhGZvmZ6STv+4f/v
	ZZc9j9qut/M56ixn/GTzMYpiCQt5oO/XOwbR5gYci3e6sZiBMc+5d1B3JUONoH57Rg+Hp2tAXIc
	vtPrZEBNxOVzwfXMZDiNV9hEe7ADz9jEy8xyMGcb4aXv7dxdhkYI5g5bVjxt8SBEZXZdHR0gkqO
	Qx0JfRGSPJ6LRxDKP0EVXiXzF53sDm1boYRM/PGnk=
X-Received: by 2002:a05:600c:6994:b0:483:79ad:f3b9 with SMTP id 5b1f17b1804b1-486f445facdmr102611195e9.28.1773911731261;
        Thu, 19 Mar 2026 02:15:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b818aasm36720405e9.16.2026.03.19.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:15:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 12:15:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [linux-next:master 6496/7246]
 drivers/block/drbd/drbd_legacy_84.c:466 drbd_conn_str_84() error: buffer
 overflow 'drbd_conn_s_names' 24 <= u32max
Message-ID: <202603190716.h5QMTLBc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f
commit: 7d6deec50773e43a5840f798ea0a730f20f74700 [6496/7246] drbd: remove BROKEN for DRBD
config: openrisc-randconfig-r072-20260319 (https://download.01.org/0day-ci/archive/20260319/202603190716.h5QMTLBc-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.3.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603190716.h5QMTLBc-lkp@intel.com/

New smatch warnings:
drivers/block/drbd/drbd_legacy_84.c:466 drbd_conn_str_84() error: buffer overflow 'drbd_conn_s_names' 24 <= u32max
drivers/block/drbd/drbd_transport_tcp.c:742 dtt_wait_for_connect() warn: variable dereferenced before check 'path' (see line 751)
drivers/block/drbd/drbd_transport_tcp.c:1297 dtt_connect() error: we previously assumed 'csocket' could be null (see line 1179)
drivers/block/drbd/drbd_transport_tcp.c:1339 dtt_connect() error: we previously assumed 'dsocket' could be null (see line 1179)
drivers/block/drbd/drbd_req.c:995 mod_rq_state() error: we previously assumed 'peer_device' could be null (see line 924)
drivers/block/drbd/drbd_req.c:1245 __req_mod() error: we previously assumed 'peer_device' could be null (see line 1155)
drivers/block/drbd/drbd_req.c:1996 drbd_unplug() warn: variable dereferenced before check 'req' (see line 1993)
drivers/block/drbd/drbd_sender.c:551 w_e_send_csum() warn: missing error code 'err'
drivers/block/drbd/drbd_sender.c:2341 w_e_end_ov_req() warn: missing error code 'err'
drivers/block/drbd/drbd_state.c:5178 change_cluster_wide_state() error: we previously assumed 'target_connection' could be null (see line 5170)
drivers/block/drbd/drbd_state.c:6305 calc_data_accessible() warn: variable dereferenced before check 'nc' (see line 6303)
drivers/block/drbd/drbd_main.c:4575 drbd_init() warn: missing error code 'err'
drivers/block/drbd/drbd_nl.c:689 drbd_khelper() warn: variable dereferenced before check 'connection' (see line 585)
drivers/block/drbd/drbd_receiver.c:280 drbd_sync_rule_str() error: buffer overflow 'sync_rule_names' 22 <= 22
drivers/block/drbd/drbd_receiver.c:289 strategy_descriptor() error: buffer overflow 'sync_descriptors' 18 <= 18

vim +/drbd_conn_s_names +466 drivers/block/drbd/drbd_legacy_84.c

a5747bff1fbd8c Christoph Böhmwalder 2025-12-16  463  static const char *drbd_conn_str_84(enum drbd_conn_state s)
a5747bff1fbd8c Christoph Böhmwalder 2025-12-16  464  {
a5747bff1fbd8c Christoph Böhmwalder 2025-12-16  465  	/* enums are unsigned... */
a5747bff1fbd8c Christoph Böhmwalder 2025-12-16 @466  	return (int)s > (int)L_BEHIND ? "TOO_LARGE" : drbd_conn_s_names[s];

We *want* them to be unsigned.  Now if someone passes a negative s
value then it will result in an out of bounds read where if we removed
the casts to (int) then we can easily verify the code is safe.

a5747bff1fbd8c Christoph Böhmwalder 2025-12-16  467  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

