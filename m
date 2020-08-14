Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ADC433E1
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8CD2074D
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS0D5lax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHNKtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:49:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727064AbgHNKtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 06:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597402156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6gO1r0QjJIKTJ+TFd84x2tinx9ptMc9O29feUY5X4s=;
        b=DS0D5laxAN5nw6VvJj2jXYVXT8C7Q2Ok/cwXKFHRt2ipZSwkMWAyPjKXla40a+h86mM5gf
        BX8iQtqOmd4wsPEYARbw7NLsVWvzSuZ2xpKN7H0J1skXXraA/CX3Vr7L1KrPakfdMrg3EM
        oF1QSyr19ctIxzkUQy4N4/drU1EYHqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-ss58aVESOdW_aZr6sKa08Q-1; Fri, 14 Aug 2020 06:49:12 -0400
X-MC-Unique: ss58aVESOdW_aZr6sKa08Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCA7E1014DEA;
        Fri, 14 Aug 2020 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E017D1014161;
        Fri, 14 Aug 2020 10:49:06 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Date:   Fri, 14 Aug 2020 18:49:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-8-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/14/20 2:18 PM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/rc | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 3e97801bbb30..675acbfa7012 100644
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
> +		_have_modules rdma_rxe siw

start_soft_rdma can use siw or rdma_rxe(default one) module, but some 
old distros may not support siw, but suppor rdma_rxe.
how about:
_have_modules rdma_rxe || _have_modules siw
> +		;;
>   	*)
>   		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
>   		return 1
> @@ -115,6 +122,9 @@ _cleanup_nvmet() {
>   		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
>   	fi
>   	modprobe -r nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		stop_soft_rdma
> +	fi
>   }
>   
>   _setup_nvmet() {
> @@ -124,6 +134,11 @@ _setup_nvmet() {
>   		modprobe nvmet-${nvme_trtype}
>   	fi
>   	modprobe nvme-${nvme_trtype}
> +	if [[ "${nvme_trtype}" == "rdma" ]]; then
> +		start_soft_rdma
> +		rdma_intfs=$(rdma_network_interfaces)
> +		def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
> +	fi
>   }
>   
>   _nvme_disconnect_ctrl() {

