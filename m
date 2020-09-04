Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A817C43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4432074D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 17:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5i4BacK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgIDRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:00:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725966AbgIDRAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 13:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599238823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+34/F/wFBWk0EaC+XvS9T37vZfyDZYXKnTuAPksLxCo=;
        b=B5i4BacKq2vxGkqcQj8XvCALs3TpoZKROVRQt5HuGFDsI9E+m7yV5Bk6sqDcerYN6oND1s
        JfPYFKtM1uHTnBqRsIMj9Fx6gHpNV2Gj7nx2X8KxsztPmjXA/gejI3cRsgsUbS3n17egRu
        LJhYAjycsEtzEQHnJd6ypei1uvIxh/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-J0Jp4bjMO-SazMDGXV11BA-1; Fri, 04 Sep 2020 13:00:22 -0400
X-MC-Unique: J0Jp4bjMO-SazMDGXV11BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4784E100854A;
        Fri,  4 Sep 2020 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A66565D9E8;
        Fri,  4 Sep 2020 17:00:16 +0000 (UTC)
Subject: Re: [PATCH v7 7/7] nvme: support rdma transport type
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-8-sagi@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <cd06eee5-d0e7-8dd5-1291-545f6cc0c31f@redhat.com>
Date:   Sat, 5 Sep 2020 01:00:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-8-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/4/20 7:53 AM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/rc | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 8df00e7d15d0..4c5b2e8edf0d 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -5,6 +5,7 @@
>   # Test specific to NVMe devices
>   
>   . common/rc
> +. common/multipath-over-rdma
>   
>   def_traddr="127.0.0.1"
>   def_adrfam="ipv4"
> @@ -25,6 +26,12 @@ _nvme_requires() {
>   		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>   		_have_configfs
>   		;;
> +	rdma)
> +		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
> +		_have_configfs
> +		_have_program rdma
> +		_have_modules rdma_rxe || _have_modules siw
> +		;;
>   	*)
>   		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
>   		return 1
> @@ -115,6 +122,9 @@ _cleanup_nvmet() {
>   		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
>   	fi
>   	modprobe -r nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		stop_soft_rdma
> +	fi
>   }
>   
>   _setup_nvmet() {
> @@ -124,6 +134,16 @@ _setup_nvmet() {
>   		modprobe nvmet-"${nvme_trtype}"
>   	fi
>   	modprobe nvme-"${nvme_trtype}"
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		start_soft_rdma
> +		for i in $(rdma_network_interfaces)
> +		do
> +			ipv4_addr=$(get_ipv4_addr "$i")
> +			if [ -n "${ipv4_addr}" ]; then
> +				def_traddr=${ipv4_addr}
Do we need add break here if ipv4_addr has value?

> +			fi
> +		done
> +	fi
>   }
>   
>   _nvme_disconnect_ctrl() {

