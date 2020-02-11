Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994FC35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F020714
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 21:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Sds6FgZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBKV6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:58:16 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37107 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKV6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 16:58:16 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so1852240pjb.2
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HCBRdtAuyh5TE7Of87GY/FVMU/YgGmS/WGDSqJCB2dI=;
        b=Sds6FgZgSLDt9cKy+TJyJZ67vT4v5Sn/rrV3ImAbtfeloilxjyIH/0bjiISynpMLyI
         gZB2fIh8OpcXlDD1Vzqqao/hd00z0kqEd5q9VhNz56cyL6UPLGj4cxAQtwvF9+xaKxyJ
         hUwEy2UtYSz+DrcabHPrqf+yRzmYlcEdOSD53EjNjc9aNxBvT7X5EGqxKnjFKJrwflJ+
         M5ZMlTDZIX34hpNJE1nmtyPKHyySXASQs+8rEjjpurybMXnIET/DwQWCNrMSwF8yJu2n
         dTqOhqupq+WBKgzVUoRSgsaGLpJb+Oh2KAnk/NVOUsIgLqyRrd44kDkHTf9ELefJtwSO
         AVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HCBRdtAuyh5TE7Of87GY/FVMU/YgGmS/WGDSqJCB2dI=;
        b=GZOYNZsVeiHO1irYNESr0HYWG2d8lF6iEEoKSBnaQ/dw12ckhc3+U5ohzQBdmETssy
         tW3gEtFDrcNB07pwt7+0+rSozoj54RZkfptipb10qmT9yn8Z0VTL14wd0UUkyCcpv+2D
         5jLAFKE1pRMeu13aOh2/oWr69hm+BZY4dufhk5MYDVUrtmQ24lVucucNPktkePzERcQJ
         yoJPXltj/2F88qw4SCz6nPhlVGFLqOvRXo4q1xmiuEzVe7Ql3vgzPP98jGsRfCupnjKQ
         MNszUX6PwhboecJlputIQPXBJtBuP93dbgl+3iLWXtP2EPbXshcXhKOMz5bS9ei3ODTk
         VKYA==
X-Gm-Message-State: APjAAAXaUyRj+MiT656vzin2cK+Is80eh8I6naKu7roFEn2v0uBWEjDy
        wdSaEulPyVuS5gZtiX9/Mt9Egm8jn40=
X-Google-Smtp-Source: APXvYqwY9Vb5OiAy/xkxm9FJn4yCsb5+FDsY9b0jccdlVv/zgGmSE5fkhhDjmjMkxDAZRSiLY5IDDg==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr5936314pju.66.1581458294076;
        Tue, 11 Feb 2020 13:58:14 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id h62sm5269521pfg.95.2020.02.11.13.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:58:13 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:58:12 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5 blktests] nvme: test target cntlid min cntlid max
Message-ID: <20200211215812.GC100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 03:29:18PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attributes
> for NVMeOF target.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/033.out |  4 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100755 tests/nvme/033
>  create mode 100644 tests/nvme/033.out
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> new file mode 100755
> index 0000000..97eba7f
> --- /dev/null
> +++ b/tests/nvme/033
> @@ -0,0 +1,57 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
> +#
> +# Test NVMeOF target cntlid[min|max] attributes.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local port
> +	local nvmedev
> +	local loop_dev
> +	local cid_min=14
> +	local cid_max=15
> +	local file_path="$TMPDIR/img"
> +	local subsys_name="blktests-subsystem-1"
> +
> +	truncate -s 1G "${file_path}"
> +
> +	loop_dev="$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	nvme connect -t loop -n "${subsys_name}"
> +
> +	udevadm settle
> +
> +	nvmedev="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
> +
> +	nvme disconnect -n "${subsys_name}"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +
> +	losetup -d "${loop_dev}"
> +
> +	rm "${file_path}"
> +
> +	echo "Test complete"
> +}

Another shellcheck warning:

tests/nvme/033:44:20: note: Double quote to prevent globbing and word splitting. [SC2086]

Also, this fails on kernels without this feature:

nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [failed]
    runtime    ...  2.262s
    --- tests/nvme/033.out      2020-02-11 13:52:20.346831467 -0800
    +++ /home/vmuser/repos/blktests/results/nodev/nvme/033.out.bad      2020-02-11 13:52:42.006948791 -0800
    @@ -1,4 +1,4 @@
     Running nvme/033
    -cntlid : e
    +cntlid : 0x1
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

Presumably because _create_nvmet_subsystem silently does nothing if
attr_cntlid_min doesn't exist. We should skip the test if the kernel doesn't
support it rather than ignoring it in _create_nvmet_subsystem.
