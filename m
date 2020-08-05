Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C525C433E0
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9F522CAD
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJUxtQWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgHEI6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:58:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbgHEI6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 04:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596617889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knBmS+iunxzbuYmX5BZ4IC/eX147QBBLva8PZl3vxl0=;
        b=IJUxtQWn5M5w6m1PRWjYPeZrCdQkFWa8JXTfZqVnyHJQhatepqDihf8GuOcgpd57/sm7BE
        FnM5Hn8oOEqeTN4JmnqKJgK+uq3kdqAphzcs9vGHHg3NwXjXFnPrENF+hLHz6/ZVKsjhcA
        A8/SQ7f+E0c0OzE6hCfRAToZ66auCOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-qEgyeRnYNO2goT5YAXYF6w-1; Wed, 05 Aug 2020 04:58:05 -0400
X-MC-Unique: qEgyeRnYNO2goT5YAXYF6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2390E1005504;
        Wed,  5 Aug 2020 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 602785C1D2;
        Wed,  5 Aug 2020 08:57:59 +0000 (UTC)
Subject: Re: [PATCH rfc 6/6] nvme: support rdma transport type
To:     Sagi Grimberg <sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-7-sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
Date:   Wed, 5 Aug 2020 16:57:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200803064835.67927-7-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/3/20 2:48 PM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/rc | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 69ab7d2f3964..31d02fefa70e 100644
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
# nvme_trtype=rdma ./check nvme/030
nvme/030 (ensure the discovery generation counter is updated appropriately)
nvme/030 (ensure the discovery generation counter is updated 
appropriately) [passed]
     runtime  0.616s  ...  0.520s 460: unload_module: command not found

The unload_module[1] was defined in [2], how about move the definition 
to [3],

[1]
_cleanup_nvmet->stop_soft_rdma->unload_module

[2]
./tests/nvmeof-mp/rc

[3]
common/multipath-over-rdma

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

