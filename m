Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A2C433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53012078D
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="IhD1DfdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHNQNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:13:04 -0400
Received: from ale.deltatee.com ([204.191.154.188]:56818 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgHNQNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 12:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zQQYaG4FDva4Kx2gK/oIgniFA8GobjEVeS/gzgpSBqE=; b=IhD1DfdSl/ZKLJrd5qba0ksZ+z
        8lxNamv6hREYM7exVyKMMtHYw5fwjbZJHCe06qrEdrdnaCBwzhk+FGFPPPSwa/5hbVgXOs1KYVg7J
        QQ8Maen2/tc0lzqfU8kaamix6A9u1QDyOkpLHmdClYdjrMqtpnEMXyKYVIUpQ0/FZ01CBHRUJuLgU
        NoMPqqhdGoKys8gUa+1zhX0XolYpnrEPA1yBKakIrclwGldIfeyellBoH884G+gWwDx/Gdo9b2z5y
        zaBG+nY9/k/OfSZJG9zt75ZUIY11iUKOaxaBR83C8FsMw1Xev0Ad+aO4YVHKkdcdTyV2rOOn1Cds5
        g0pUERCw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k6cKA-00029q-Lk; Fri, 14 Aug 2020 10:12:59 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-3-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4523fcf6-bed3-a3b7-11b5-6246b4d63765@deltatee.com>
Date:   Fri, 14 Aug 2020 10:12:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-3-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, Chaitanya.Kulkarni@wdc.com, bvanassche@acm.org, kbusch@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/7] nvme: consolidate some nvme-cli utility functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-08-14 12:18 a.m., Sagi Grimberg wrote:
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index b841a8d4cd87..7ea539fda55e 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -33,14 +33,14 @@ test() {
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>  	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>  
> -	nvme connect -t loop -n blktests-subsystem-1
> +	_nvme_connect_subsys "loop" "blktests-subsystem-1"

A bit of a nit, but the quotes around "loop" are unnecessary here and in
a bunch of other places.

> @@ -97,6 +97,33 @@ _setup_nvmet() {
>  	modprobe nvme-loop
>  }
>  
> +_nvme_disconnect_ctrl() {
> +	local ctrl="$1"
> +
> +	nvme disconnect -d ${ctrl}> +}
> +
> +_nvme_disconnect_subsys() {
> +	local subsysnqn="$1"
> +
> +	nvme disconnect -n ${subsysnqn}
> +}

Missing quotes around ctrl and subsysnqn.

> +
> +_nvme_connect_subsys() {
> +	local trtype="$1"
> +	local subsysnqn="$2"
> +
> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	eval $cmd
> +}

I still don't understand why we are using eval here.  There are no
quotes round trtpe and subsysnqn and because of eval they need to be
doubled...
