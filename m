Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D20C433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD072065E
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OeBHlS25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgICVfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:35:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:39092 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgICVfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EVlaVbtnOegqTu2KVIuXMFXBxMpEcahb/RqCwAE3iqI=; b=OeBHlS25wAUVyL/JOJiq7y6URc
        MJzRyWGvs69td6Utsn79l0x6ylLeOg+pb5OBfpiGpJ+BhZFhJlBXzInt1HIC18s6oMReF0lobYYtc
        sz52HAWrucWCrQ6tageMDkI+cizwe3tqVknKF3TmCIHYyFMt44JepHp/xw3ZqiHPLKIxB0HLIZXv5
        ZzJQlQcniBwYfysv3ED32VEVnzFxr2xGzimvZ9Klov1qIaCzVBKCXYFgQRL6RKraBhGSX2dqjpy17
        Rz++vq/iKVcz+u9+YcxAWIDlFcFGAeGBDLXRASNvCsamnFC5HcYS2wrr+a0Px9dM1d/fmyxjiJxhk
        /FY5H1Rg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kDwtP-0007wj-0D; Thu, 03 Sep 2020 15:35:40 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903212634.503227-1-sagi@grimberg.me>
 <20200903212634.503227-4-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <846fa009-5687-5532-236b-e001fd7a8200@deltatee.com>
Date:   Thu, 3 Sep 2020 15:35:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903212634.503227-4-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org, osandov@osandov.com, linux-block@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 3/7] nvme: make tests transport type agnostic
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-09-03 3:26 p.m., Sagi Grimberg wrote:
> Pass in nvme_trtype to common routines that can
> support multiple transport types.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/002 |  4 ++--
>  tests/nvme/003 |  4 ++--
>  tests/nvme/004 |  6 +++---
>  tests/nvme/005 |  8 ++++----
>  tests/nvme/006 |  2 +-
>  tests/nvme/007 |  2 +-
>  tests/nvme/008 |  8 ++++----
>  tests/nvme/009 |  8 ++++----
>  tests/nvme/010 |  8 ++++----
>  tests/nvme/011 |  8 ++++----
>  tests/nvme/012 |  8 ++++----
>  tests/nvme/013 |  8 ++++----
>  tests/nvme/014 |  8 ++++----
>  tests/nvme/015 |  8 ++++----
>  tests/nvme/016 |  2 +-
>  tests/nvme/017 |  2 +-
>  tests/nvme/018 |  8 ++++----
>  tests/nvme/019 |  8 ++++----
>  tests/nvme/020 |  8 ++++----
>  tests/nvme/021 |  8 ++++----
>  tests/nvme/022 |  8 ++++----
>  tests/nvme/023 |  8 ++++----
>  tests/nvme/024 |  8 ++++----
>  tests/nvme/025 |  8 ++++----
>  tests/nvme/026 |  8 ++++----
>  tests/nvme/027 |  8 ++++----
>  tests/nvme/028 | 10 +++++-----
>  tests/nvme/029 |  8 ++++----
>  tests/nvme/030 |  2 +-
>  tests/nvme/031 |  4 ++--
>  tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
>  31 files changed, 131 insertions(+), 106 deletions(-)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 92779e8d28ca..955f68da026a 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -21,7 +21,7 @@ test() {
>  
>  	local iterations=1000
>  	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>  
>  	local loop_dev
>  	loop_dev="$(losetup -f)"
> @@ -31,7 +31,7 @@ test() {
>  		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
>  	done
>  
> -	_nvme_discover loop | _filter_discovery
> +	_nvme_discover "${nvme_trtype}" | _filter_discovery
>  
>  	for ((i = iterations - 1; i >= 0; i--)); do
>  		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 83d1b2ff9cb0..654ff776f6f9 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -21,7 +21,7 @@ test() {
>  	_setup_nvmet
>  
>  	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>  
>  	local loop_dev
>  	loop_dev="$(losetup -f)"
> @@ -29,7 +29,7 @@ test() {
>  	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
>  	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>  
> -	_nvme_connect_subsys loop nqn.2014-08.org.nvmexpress.discovery
> +	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
>  
>  	# This is ugly but checking for the absence of error messages is ...
>  	sleep 10
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 1a3eedd634cf..0a62e3448e7b 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -22,7 +22,7 @@ test() {
>  	_setup_nvmet
>  
>  	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>  
>  	truncate -s 1G "$TMPDIR/img"
>  
> @@ -33,10 +33,10 @@ test() {
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>  	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>  
> -	_nvme_connect_subsys loop blktests-subsystem-1
> +	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
>  
>  	local nvmedev
> -	nvmedev="$(_find_nvme_loop_dev)"
> +	nvmedev="$(_find_nvme_dev)"
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> diff --git a/tests/nvme/005 b/tests/nvme/005
> index 708e37766e0e..e97287a96a4e 100755
> --- a/tests/nvme/005
> +++ b/tests/nvme/005
> @@ -22,7 +22,7 @@ test() {
>  	_setup_nvmet
>  
>  	local port
> -	port="$(_create_nvmet_port "loop")"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>  
>  	truncate -s 1G "$TMPDIR/img"
>  
> @@ -33,16 +33,16 @@ test() {
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>  	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>  
> -	_nvme_connect_subsys loop blktests-subsystem-1
> +	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
>  
>  	local nvmedev
> -	nvmedev="$(_find_nvme_loop_dev)"
> +	nvmedev="$(_find_nvme_dev)"
>  
>  	udevadm settle
>  
>  	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
>  
> -	_nvme_disconnect_ctrl ${nvmedev}
> +	_nvme_disconnect_ctrl "${nvmedev}"

Sorry... looks like you fixed the quotes in the wrong patch... The
quotes here (and in a number of other places) were removed in the
previous patch then fixed up in this one... Maybe run "make check" on
each patch individually?

Besides this nit, I don't see any other issues.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
