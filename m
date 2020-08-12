Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED0C433E0
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DA8207F7
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 15:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="rtCRHR6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgHLPtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:49:13 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36020 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 11:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JB5fOu0MsTdBRZDKxt7xZr3KS/kiteVH/AdQ/UiL814=; b=rtCRHR6Ivxlawovo8w/AdWu4z0
        2fw5+gdoUftD66BDu+7UYBCD3Cnkg/2EnW7+uOrKeBLlvUbcz2wEsPCur5ZHvBQkxwqNr+GItzbjt
        39p3xQaIViONT+U+orEn7/ef6D4e1Kn6YAJ0MUVO/mntWvKcPWS5zW2/1ZLQoOuWruDslEiAbqkgU
        iIcepnocRWjw1F8qtNRjkbgGQ1L3078izwjnGt6iiIDJXhV/q43n0lFtCjL9WrYy+CKB3ry475Zbs
        +lhrRYyhfeMCMD7QjDHOTR1ygsbYNMixO3IUce+XWEatE70BqbvH9J/eg2O4T7CMPJ6MHjSKjpPYD
        R4o6DomA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k5szx-0005m3-IW; Wed, 12 Aug 2020 09:49:06 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-3-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0bd39633-b0b9-1e56-dd5e-514285842ebd@deltatee.com>
Date:   Wed, 12 Aug 2020 09:49:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811210102.194287-3-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com, hch@lst.de, kbusch@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 2/7] nvme: consolidate some nvme-cli utility functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-08-11 3:00 p.m., Sagi Grimberg wrote:
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 320aa4b2b475..6d57cf591300 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -64,7 +64,7 @@ _cleanup_nvmet() {
>  		transport="$(cat "/sys/class/nvme/${dev}/transport")"
>  		if [[ "$transport" == "loop" ]]; then
>  			echo "WARNING: Test did not clean up loop device: ${dev}"
> -			nvme disconnect -d "${dev}"
> +			_nvme_disconnect_ctrl "${dev}"
>  		fi
>  	done
>  
> @@ -97,6 +97,33 @@ _setup_nvmet() {
>  	modprobe nvme-loop
>  }
>  
> +_nvme_disconnect_ctrl() {
> +	local ctrl="$1"
> +
> +	nvme disconnect -d ${ctrl}

We're missing some quotes here and in many other places in this
patchset. Have you run shellcheck on this? I'd expect it to complain
about these.

> +}
> +
> +_nvme_disconnect_subsys() {
> +	local subsysnqn="$1"
> +
> +	nvme disconnect -n ${subsysnqn}
> +}
> +
> +_nvme_connect_subsys() {
> +	local trtype="$1"
> +	local subsysnqn="$2"
> +
> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	eval $cmd

Why eval? It makes the quoting here questionable...


Logan
